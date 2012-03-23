<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeBehind="upload.aspx.cs" Inherits="WebRole1.admin.upload" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

<div style="margin:10px 0;">
<a href="default.aspx">管理メニュー</a>&nbsp;&gt&nbsp;検査結果アップロード
</div>

    <p>
    検査結果のExcelファイル(xlsxフォーマット)をアップロードしてください。
    </p>
    <fieldset>
        <legend>検査結果Excelファイル</legend>
        <asp:FileUpload ID="FileUpload1" runat="server" />
    </fieldset>
    <br />
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
        style="height: 21px" Text="アップロード" />
    </form>
</asp:Content>