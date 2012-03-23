using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;  
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;

namespace ExcelUtility
{
    struct ExcelReference
    {
        private int rowIndex;
        private int colIndex;

        public int RowIndex { get { return rowIndex; } set { rowIndex = value; } }
        public int ColIndex { get { return colIndex; } set { colIndex = value; } }

        private const string colBase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

        public ExcelReference(string r)
        {
            if (char.IsNumber(r[1]))
            {
                // ex.) A100
                rowIndex = Convert.ToInt32(r.Substring(1));
                colIndex = (byte)r[0] - (byte)'A' + 1;
            }
            else
            {
                // ex.) AA90
                rowIndex = Convert.ToInt32(r.Substring(2));
                colIndex = ((byte)r[0] - (byte)'A' + 1)*26 + ((byte)r[1] - (byte)'A'+1);
            }
        }

        private string GetColIndexString()
        {
            int n2 = (colIndex - 1) / 26;
            int n1 = colIndex % 26-1;
            if (n2 > 0)
            {
                return colBase[n2].ToString() + colBase[n1];
            }
            else
            {
                return colBase[n1].ToString();
            }
        }

        public override string ToString()
        {
            return String.Format("{0}{1}",GetColIndexString(), rowIndex);
        }
    }

    struct ExcelRange
    {
        public ExcelReference Begin;
        public ExcelReference End;

        public ExcelRange(string r)
        {
            int index = r.IndexOf(':');
            Begin = new ExcelReference(r.Substring(0, index));
            End = new ExcelReference(r.Substring(index+1));
        }

        public override string ToString()
        {
            return String.Format("{0}:{1}", Begin.ToString(), End.ToString());
        }
    }

    class ExcelUtil
    {
        public static System.Data.DataTable GetTable(SpreadsheetDocument doc, string sheetName)
        {
            var book = doc.WorkbookPart;
            var sheet = book.Workbook.Descendants<Sheet>().First<Sheet>(s => s.Name == sheetName);
            if (sheet != null)
            {
                var sp = book.GetPartById(sheet.Id.Value) as WorksheetPart;
                if (sp != null)
                {
                    ////データ範囲の確認
                    //ExcelRange dim =
                    //    new ExcelRange(sp.Worksheet.Descendants<SheetDimension>().First<SheetDimension>().Reference.Value);

                    //保存用テーブル
                    DataTable dt = new DataTable();

                    ////仮のカラム
                    //for (int i = 1; i <= dim.End.ColIndex; i++)
                    //{
                    //    dt.Columns.Add(String.Format("Column{0}", i));
                    //}

                    //共有文字取得
                    var ss = book.SharedStringTablePart.SharedStringTable.ChildElements;
                    string[] s_string = new string[ss.Count];
                    var t_ss = ss[0];
                    for (int i = 0; i < s_string.Length; i++)
                    {
                        s_string[i] = t_ss.InnerText;
                        t_ss = t_ss.NextSibling();
                    }

                    //データ取得
                    var sd = sp.Worksheet.Descendants<SheetData>().First<SheetData>();
                    var rows = sd.ChildElements;
                    var row = rows[0] as Row;
                    while (row != null)
                    {
                        if (row.RowIndex.Value == 1)
                        {
                            //1行目はカラム名
                            #region カラム設定
                            for (int i = 0; i < row.ChildElements.Count; i++)
                            {
                                var c = row.ChildElements[i] as Cell;
                                if (c.DataType != null && c.DataType.Value == CellValues.SharedString)
                                {
                                    int sst_index = Convert.ToInt32(c.CellValue.InnerText);
                                    dt.Columns.Add(s_string[sst_index]);
                                }
                                else if(c.CellValue != null )
                                {
                                    dt.Columns.Add(c.CellValue.InnerText);
                                }
                            }
                            #endregion
                        }
                        else
                        {
                            //2行目以降はデータ
                            #region データ設定
                            var dr = dt.NewRow();
                            Cell c = row.FirstChild as Cell;
                            while (c != null )
                            {
                                ExcelReference celRef = new ExcelReference(c.CellReference.Value);
                                int i = celRef.ColIndex - 1;
                                if( i < dt.Columns.Count)
                                {
                                    if (c.DataType != null && c.DataType.Value == CellValues.SharedString)
                                    {
                                        int sst_index = Convert.ToInt32(c.CellValue.InnerText);
                                        dr[i] = s_string[sst_index];
                                    }
                                    else if (c.CellValue == null)
                                    {
                                        dr[i] = null;
                                    }
                                    else
                                    {
                                        dr[i] = c.CellValue.InnerText;
                                    }
                                }
                                c = c.NextSibling<Cell>();
                            }
                            dt.Rows.Add(dr);
                            //System.Diagnostics.Debug.WriteLine(dr[0]);
                            #endregion
                        }

                        row = row.NextSibling<Row>();
                    }

                    return dt;
                }
            }

            return null;
        }
       
        public static object[,] GetMap(SpreadsheetDocument doc, string sheetName)
        {
            var book = doc.WorkbookPart;
            var sheet = book.Workbook.Descendants<Sheet>().First<Sheet>(s => s.Name == sheetName);
            if (sheet != null)
            {
                var sp = book.GetPartById(sheet.Id.Value) as WorksheetPart;
                if (sp != null)
                {
                    ////データ範囲の確認
                    ExcelRange dim =
                        new ExcelRange(sp.Worksheet.Descendants<SheetDimension>().First<SheetDimension>().Reference.Value);

                    //保存用マップ
                    object[,] map = new object[dim.End.ColIndex, dim.End.RowIndex];

                    //共有文字取得
                    var ss = book.SharedStringTablePart.SharedStringTable.ChildElements;
                    string[] s_string = new string[ss.Count];
                    var t_ss = ss[0];
                    for (int i = 0; i < s_string.Length; i++)
                    {
                        var txel = t_ss.Descendants<Text>().Where( s => !(s.Parent is PhoneticRun));
                        var texts = String.Join("", txel.Select( s => s.Text).ToArray());
                        s_string[i] = texts;
                        //if (texts != t_ss.FirstChild.InnerText)
                        //{
                        //    System.Diagnostics.Debug.WriteLine(String.Format("Warn: {0} != {1}", texts, t_ss.FirstChild.InnerText));
                        //}
                        t_ss = t_ss.NextSibling();
                    }

                    //データ取得
                    var sd = sp.Worksheet.Descendants<SheetData>().First<SheetData>();
                    var rows = sd.ChildElements;
                    var row = rows[0] as Row;
                    while (row != null)
                    {
                        #region データ設定
                        Cell c = row.FirstChild as Cell;
                        while (c != null)
                        {
                            ExcelReference celRef = new ExcelReference(c.CellReference.Value);
                            int i = celRef.ColIndex - 1;
                            int j = celRef.RowIndex - 1;
                            if (i < map.GetLength(0) && j < map.GetLength(1))
                            {
                                if (c.DataType != null && c.DataType.Value == CellValues.SharedString)
                                {
                                    int sst_index = Convert.ToInt32(c.CellValue.InnerText);
                                    map[i,j] = s_string[sst_index];
                                }
                                else if (c.CellValue == null)
                                {
                                    map[i,j] = null;
                                }
                                else
                                {
                                    map[i, j] = c.CellValue.InnerText;
                                }
                            }
                            c = c.NextSibling<Cell>();
                        }

                        #endregion

                        row = row.NextSibling<Row>();
                    }

                    return map;
                }
            }

            return null;
        }
    }
}
