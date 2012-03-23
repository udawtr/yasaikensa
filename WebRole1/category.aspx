<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="category.aspx.cs" Inherits="WebRole1.category" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2><a href="BrowseByProduct.aspx">食品カテゴリ別</a> &gt; <% = Request["q"] %></h2>
    <div>
    <% if (categoryName != "野菜類")
       { %>
    <table class="list" cellspacing="0" cellpadding="4" style="color:#333333;border-right:1px solid black;border-top:1px solid black;">
    <tr>
        <%  int count = 0;
            foreach (var item in productList)
            {
                count++; %>
            <td style="width:150px;">
                <a href="product.aspx?product=<% = HttpUtility.UrlEncode(item.Key) %>&amp;category=<% = Request["q"] %>"><% = item.Key%></a> [<% = item.Value%>] </td>
               <% if (count % 5 == 0)
                  { %> </tr><tr> <% } %>
        <% } %>
                <% for (int i = count % 5; i != 0 && i < 5; i++)
                   { %><td style="width:150px;background-color:#cccccc;"></td> <%} %>
    </tr>
    </table>
    <% }
       else
       { %>
    <table  cellspacing="0" cellpadding="0" style="color:#333333;border:1px solid black;border-bottom:0px;border-right:0px;">
    <% foreach (var category in yasaiCategoryList)
       { %>
        <tr>
            <th style="border-bottom:1px solid black; background-color:lightgray; width:120px;"><% = category.Key%></td>
            <td>
                <table class="list" cellspacing="0" cellpadding="4" style="color:#333333;border-right:1px solid black;">
                <tr>
                    <%  int count = 0;
                        foreach (var item in category.Value)
                        {
                            count++; %>
                           <td style="width:150px;">
                            <a href="product.aspx?product=<% = HttpUtility.UrlEncode(item) %>&amp;category=<% = Request["q"] %>">
                            <% = item%>
                            </a> 
                            </td>
                           <% if (count % 5 == 0)
                              { %> </tr><tr> <% } %>
                    <% } %>
                    <% for (int i = count % 5; i != 0 && i < 5; i++)
                       { %><td style="width:150px;background-color:#cccccc;"></td> <%} %>
                </tr>
                </table>
            </td>
        </tr>
    <%  } %>
    </table>
    <p>
    野菜類の分類および表記名のゆれ補正は<a href="http://edicode.vips.gr.jp/">青果標準コード・データベース</a>を利用しています。
    </p>
    <p>
    ・2011/5/3 野菜類の分類を見直して、露地／施設／ハウスなどをひとまとめにしました。
    </p>
    <% } %>
    <p>
    ・同じ品目であっても別の品目として表示される場合があります。
    </p>
    </div>
</asp:Content>
