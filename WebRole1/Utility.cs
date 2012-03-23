using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebRole1
{
    public partial class YasaiKensa
    {
        public bool Is暫定規制値Over
        {
            get
            {
                return IsセシウムOver || Isヨウ素Over;
            }
        }

        public int ヨウ素基準値
        {
            get
            {
                if (Is飲用) return 300;
                else return 2000;
            }
        }

        public decimal セシウム合計
        {
            get
            {

                if (セシウムD.HasValue) return セシウムD.Value;
                return セシウム134D.GetValueOrDefault() + セシウム137D.GetValueOrDefault();
            }
        }

        public bool Isヨウ素Over
        {
            get
            {
                Double value = 0.0;
                if (Double.TryParse(結果ヨウ素131, out value))
                {
                    if (Is飲用)
                    {
                        if (value > 300)
                        {
                            return true;
                        }
                    }
                    else
                    {
                        if (value > 2000)
                        {
                            return true;
                        }
                    }
                }
                return false;
            }
        }

        public bool Is飲用
        {
            get
            {
                if (食品カテゴリ == "乳")
                {
                    return true;
                }
                else if (食品カテゴリ == "野菜類")
                {
                    if (野菜品名 == "茶飲料") return true;
                }
                return false;
            }
        }


        public int セシウム基準値
        {
            get
            {
                if (Is飲用) return 200;
                else return 500;
            }
        }

        public bool IsセシウムOver
        {
            get
            {
                Double value1 = 0.0;
                Double value2 = 0.0;
                Double value3 = 0.0;
                double value = 0.0;
                if (Double.TryParse(結果セシウム, out value1))
                {
                    value = value1;
                }
                else
                {
                    if (Double.TryParse(結果セシウム134, out value2))
                    {
                        value = value2;
                    }
                    if (Double.TryParse(結果セシウム137, out value3))
                    {
                        value += value3;
                    }
                }

                if (value > 0.0)
                {
                    if (Is飲用)
                    {
                        if (value > 200)
                        {
                            return true;
                        }
                    }
                    else
                    {
                        if (value > 500)
                        {
                            return true;
                        }
                    }
                }
                return false;
            }
        }
    }
}