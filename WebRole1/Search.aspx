<%@ Page Title="食品の放射能検査データ" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Search.aspx.cs" Inherits="WebRole1.Search" EnableEventValidation="false" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <link href="Styles/search.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <fieldset id="search-fieldset">
        <legend>検索条件</legend>
            <p>検索条件を選択して、「検索」ボタンをクリックします。検査結果データの一覧とグラフが表示されます。</p>
            <div id="search-condition">
            <div class="field">
                <div class="field-header">産地</div>
                <div class="field-body">
                    <asp:ListBox ID="prefFilterList" runat="server" Rows="1" AutoPostBack="true" Width="120px" onselectedindexchanged="prefFilterList_SelectedIndexChanged"></asp:ListBox>
                    <asp:ListBox ID="cityFilterList" runat="server" Rows="1" AutoPostBack="true" Width="120px" onselectedindexchanged="cityFilterList_SelectedIndexChanged"></asp:ListBox>
                </div>
            </div>
            <div class="field">
                <div class="field-header">品目</div>
                <div class="field-body">
                    <asp:ListBox ID="categoryFilterList" runat="server" Rows="1" AutoPostBack="true" Width="120px" DataValueField="Value" DataTextField="Text" onselectedindexchanged="categoryFilterList_SelectedIndexChanged"></asp:ListBox>
                    <asp:ListBox ID="productFilterList" runat="server" Rows="1" AutoPostBack="true" Width="160px" DataValueField="Value" DataTextField="Text" onselectedindexchanged="productFilterList_SelectedIndexChanged"></asp:ListBox>
                </div>
            </div>
            <br />
            <div class="field">
                <div class="field-header">採取日</div>
                <div class="field-body">
                     <asp:ListBox ID="pickDayFilterList" runat="server" Rows="1">
                        <asp:ListItem Text="全て" Value="all" Selected="True"/>
                        <asp:ListItem Text="3週間以内" Value="3w"/>
                    </asp:ListBox>
                </div>
            </div>
            <div class="field">
                <div class="field-header">公開日</div>
                <div class="field-body">
                    <asp:ListBox ID="publishDayFilerList" runat="server" Rows="1"></asp:ListBox>
                </div>
            </div>
            <div class="field">
                <div class="field-header">表示順</div>
                <div class="field-body">
                    <asp:RadioButtonList ID="sortItem" RepeatLayout="flow" RepeatDirection="Horizontal" runat="server">
                        <asp:ListItem Value="1" Selected="True">採取日</asp:ListItem>
                        <asp:ListItem Value="2">厚生省公表順</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
            </div>
        </div>
        <div id="search-command">
            <asp:Button ID="UpdateButton" Text="検索" runat="server" onclick="UpdateButton_Click" Height="40px" Width="80px" />
        </div>
    </fieldset>

    <asp:Panel ID="UpdatePanel2" runat="server" Visible="false">
<div id="abstract">
    <h3 class="subtitle">■概要</h3>
    <div id="message">
        <% = String.Format("<span style=\"font-size:18px;font-weight:bold;\">{0}</span>件の検査データが見つかりました。このうち暫定規制値を超えた放射性物質が検出されたものは<span style=\"font-size:18px;font-weight:bold;\">{1}</span>件です。", list.Count, list.Count(x => x.Is暫定規制値Over))%>
        <div id="social">
            <a href="http://twitter.com/share?count=none&text=<% = TweetMessage%> #yasaikensa" class="twitter-share-button" data-count="horizontal" data-lang="ja">Tweet</a>
            <script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>
        </div>
    </div>
    <div id="chart">
        <div id="chart-left">
            <div id="time-series-chart">
                <asp:Image ID="bqByDayImage" runat="server" />
                <div class="chart-caption">
                グラフは震災発生日からの経過日数毎の放射性ヨウ素、放射性セシウムの検出量(Bq/kg)の最大値、最小値、中央値(=(最大値+最小値)/2)を表しています。
                </div>
            </div>
            <div id="chart-description">
                <div class="caption">時系列</div>
                <div class="content">
                    <ul>
                    <li>(0)3月11日 東日本大震災発生</li>
                    <li>(1)3月12日 福島第一原発1号機 水素爆発</li>
                    <li>(3)3月14日 福島第一原発3号機 水素爆発</li>
                    <li>(21)4月1日 高濃度汚染水流出確認</li>
                    <li>(26)4月6日 高濃度汚染水止水確認</li>
                    </ul>
                    <p>※括弧内は震災発生からの経過日数</p>
                </div>
                <div style="clear:both"></div>
            </div>
        </div>
        <div id="chart-right">
            <div id="area-list" class="list">
                <div class="caption">産地</div>
                <div class="content">
                    <ul>
                    <% if (prefFilterList.SelectedIndex > 0)
                       { %>
                    <% foreach (var item in list.GroupBy(x => x.産地市町村).OrderByDescending(x => x.Count()))
                       { %>
                        <li><% = item.Key%>(<% = item.Count()%>)</li>
                    <% } %>
                    <% }
                       else
                       { %>
                    <% foreach (var item in list.GroupBy(x => x.産地都道府県).OrderByDescending(x => x.Count()))
                       { %>
                        <li><% = item.Key%>(<% = item.Count()%>)</li>
                    <% } %><br />
                    <% } %>
                    </ul>
                    <div id="pref-chart">
                        <asp:Image ID="prefImage" runat="server" />
                    </div>
                </div>
                <div style="clear:both"></div>
            </div>
            <div id="implementingbody-list" class="list">
                <div class="caption">実施主体</div>
                <div class="content">
                    <ul>
                    <% foreach (var item in list.GroupBy(x => x.実施主体).OrderByDescending(x=>x.Count())) { %>
                        <li><% = item.Key %>(<% = item.Count() %>)</li>
                    <% } %>
                    </ul>
                </div>
                <div style="clear:both"></div>
            </div>
        </div>
        <div style="clear:both"></div>
    </div>
</div>
<div id="list">
    <h3 class="subtitle">■検査結果一覧表</h3>
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
    <% if (list.Count == 0) { %>
    <tr>
        <td colspan="14">
            検索条件を設定して「検索」ボタンをクリックしてください。
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
    </table>
    </div>
    </asp:Panel>
<p>
不検出：ND、暫定規制値以上：黄色
</p>
</asp:Content>
