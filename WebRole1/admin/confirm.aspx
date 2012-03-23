<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeBehind="confirm.aspx.cs" Inherits="WebRole1.admin.confirm" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

<div style="margin:10px 0;">
<a href="default.aspx">管理メニュー</a>&nbsp;&gt&nbsp;<a href="upload.aspx">検査結果アップロード</a>&nbsp;&gt;&nbsp;確認
</div>

    <div>
    <p>内容を確認し、問題がなければ[公開する]ボタンをクリックします。訂正する場合は<a href="upload.aspx">アップロード</a>からやり直してください。</p>
        <asp:Button ID="Publish" runat="server" Text="公開する" onclick="Publish_Click" />
<div id="list">
    <h3 class="subtitle">■アップロードされた検査データ</h3>
    <table class="list" cellspacing="0" cellpadding="4" style="color:#333333;border-right:1px solid black;">
    <tr style="color:White;background-color:#1C5E55;font-weight:bold;">
        <td rowspan="2" scope="col">No</td>
        <td rowspan="2" scope="col">実施主体</td>
        <td colspan="2" scope="col">産地</td>
        <td rowspan="2" scope="col">採取区分</td>
        <td rowspan="2" scope="col">食品分類</td>
        <td rowspan="2" scope="col">品目</td>
        <td rowspan="2" scope="col">検査機関</td>
        <td rowspan="2" scope="col">採取日<br />(購入日)</td>
        <td rowspan="2" scope="col">結果<br />判明日</td>
        <td rowspan="2" scope="col">厚生省<br />公表日</td>
        <td colspan="3" scope="col">結果(Bq/kg)</td>
    </tr>
    <tr style="color:White;background-color:#1C5E55;font-weight:bold;">
        <td scope="col">都道府県</td>
        <td scope="col">市町村</td>
        <td scope="col">ヨウ素-131</td>
        <td scope="col">セシウム-134</td>
        <td scope="col">セシウム-137</td>
    </tr>
    <% if (list.Count == 0) { %>
    <tr>
        <td colspan="14">
            アップロードされた検査データは見つかりません。
        </td>
    </tr>
    <% } %>
    <% int counter = 0;  foreach (var item in list)
       { %>
    <tr <% if(counter++%2==0){ %> style="background-color:#E3EAEB;" <% }else{ %> style="background-color:White;"<%} %>>
        <td><% = item.No%></td>        
        <td><% = item.実施主体%></td>        
        <td><% = item.産地都道府県%></td>        
        <td><% = item.産地市町村%></td>        
        <td><% = item.農場採取流通品%>&nbsp;</td>        
        <td><% = item.食品カテゴリ%></td>        
        <td><% = item.品目%></td>        
        <td><% = item.検査機関%></td>        
        <td><% = item.採取日%>&nbsp;</td>        
        <td><% = item.結果判明日%>&nbsp;</td>        
        <td><% = item.厚生省発表日%>&nbsp;</td>        
        <td><% = item.結果ヨウ素131%></td>
        <% if (item.結果セシウム != "-")
           { %>
        <td colspan="2"><%= item.結果セシウム%></td>
         <%}
           else
           { %>     
        <td><% = item.結果セシウム134%></td>        
        <td><% = item.結果セシウム137%></td>        
        <%} %>
    </tr>   
    <% } %>
    </table>
    </div>
    </div>
</asp:Content>