<%@ Page Title="地域別 | 食品の放射能検査データ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Pref.aspx.cs" Inherits="WebRole1.Pref" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2><a href="Browse.aspx">地域別</a> &gt; <% = Request["q"] %></h2>
    <% if( cityList.Count > 0 || portList.Count > 0 ){ %>
    <table  cellspacing="0" cellpadding="0" style="color:#333333;border:1px solid black;border-bottom:0px;border-right:0px;">
    <% if(cityList.Count > 0 ){ %>
    <tr>
        <th style="border-bottom:1px solid black; background-color:lightgray; width:80px;">野菜・乳等</th>
        <td>
            <table class="list" cellspacing="0" cellpadding="4" style="color:#333333;border-right:1px solid black;">
            <tr>
                <%  int count = 0;
                    foreach (var item in cityList)
                    {
                        count++; %>
                       <td style="width:150px;"><a href="city.aspx?city=<% = HttpUtility.UrlEncode(item.Key) %>&amp;pref=<% = Request["q"] %>"><% = item.Key %></a> [<% = item.Value %>] </td>
                       <% if (count % 5 == 0) { %> </tr><tr> <% } %>
                <% } %>
                <% for(int i = count%5 ; i != 0 && i < 5 ; i++ ) { %><td style="width:150px;">-</td> <%} %>
            </tr>
            </table>
        </td>
    </tr>
    <% } %>
    <% if(portList.Count > 0 ){ %>
    <tr>
        <th style="border-bottom:1px solid black; background-color:lightgray; width:80px;">水産品</th>
        <td>
            <table class="list" cellspacing="0" cellpadding="4" style="color:#333333;border-right:1px solid black;">
            <tr>
                <%  int count = 0;
                    foreach (var item in portList)
                    {
                        count++; %>
                       <td style="width:150px;"><a href="city.aspx?city=<% = HttpUtility.UrlEncode(item.Key) %>&amp;pref=<% = Request["q"] %>"><% = item.Key %></a> [<% = item.Value %>] </td>
                       <% if (count % 5 == 0) { %> </tr><tr> <% } %>
                <% } %>
                <% for(int i = count%5 ; i != 0 && i < 5 ; i++ ) { %><td style="width:150px;">-</td> <%} %>
            </tr>
            </table>
        </td>
    </tr>
    <%} %>
    </table>
    ※括弧内の数値はデータ件数です。
    <hr />
    <%} %>
    <h3>■<% = prefName %>で市町村が不明なデータ</h3>

    <p>
    <% = String.Format("{0}で市町村が不明な検査データは<span style=\"font-size:18px;font-weight:bold;\">{1}</span>件あります。このうち暫定規制値を超えた放射性物質が検出されたものは<span style=\"font-size:18px;font-weight:bold;\">{2}</span>件です。", prefName, list.Count, list.Count(x => x.Is暫定規制値Over))%>
    <a href="http://twitter.com/share" data-count="none" data-url="<% = Request.Url.AbsoluteUri %>" data-text=<% = String.Format("{0}の放射能検査データは{1}件。暫定規制値を超えたものは{2}件。", prefName, list.Count, list.Count(x => x.Is暫定規制値Over))%> #yasaikensa" class="twitter-share-button" data-lang="ja">Tweet</a>
    <script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>
    </p>

    <asp:Image ID="bqByDayImage" runat="server" />

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
        <td rowspan="2">詳細</td>
    </tr>
    <tr style="color:White;background-color:#1C5E55;font-weight:bold;">
        <td scope="col">都道府県</td>
        <td scope="col">市町村</td>
        <td scope="col">ヨウ素-131</td>
        <td scope="col">セシウム-134</td>
        <td scope="col">セシウム-137</td>
    </tr>
    <% int counter = 0;  foreach (var item in list)
       { %>
    <tr <% if(counter++%2==0){ %> style="background-color:#E3EAEB;" <% }else{ %> style="background-color:White;"<%} %>>
        <td><% = item.No%></td>        
        <td><% = item.実施主体%></td>        
        <td><% = item.産地都道府県%></td>        
        <td><% = item.産地市町村%></td>        
        <td><% = item.農場採取流通品%></td>        
        <td><a href="category.aspx?category=<% =  HttpUtility.UrlEncode(item.食品カテゴリ) %>"><% = item.食品カテゴリ%></a></td>        
        <td><a href="product.aspx?product=<% =  HttpUtility.UrlEncode(item.品目) %>&amp;category=<% =  HttpUtility.UrlEncode(item.食品カテゴリ) %>"><% = item.品目%></a></td>        
        <td><% = item.検査機関%></td>        
        <td><% = item.採取日%></td>        
        <td><% = item.結果判明日%></td>        
        <td><% = item.厚生省発表日%></td>        
        <td <% if(item.Isヨウ素Over){ %>style="background-color:orange;"<%} %> ><% = item.結果ヨウ素131%></td>
        <% if (item.結果セシウム != "-")
           { %>
        <td colspan="2" <% if(item.IsセシウムOver){ %>style="background-color:orange;"<%} %> ><%= item.結果セシウム%></td>
         <%}
           else
           { %>     
        <td <% if(item.IsセシウムOver){ %>style="background-color:orange;"<%} %> ><% = item.結果セシウム134%></td>        
        <td <% if(item.IsセシウムOver){ %>style="background-color:orange;"<%} %> ><% = item.結果セシウム137%></td>        
        <%} %>
        <td><a href="detail.aspx?no=<% = item.No %>">詳細</a></td>           </tr>   
    </tr>   
    <% } %>
    <% if(list.Count==0){ %><td colspan="15">なし</td><%} %>
    </table>
    <p>
    不検出：ND、暫定規制値以上：黄色
    </p>
    </div>
</asp:Content>
