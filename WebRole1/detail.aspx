<%@ Page Title="詳細 | 食品の放射性物質検査データ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="detail.aspx.cs" Inherits="WebRole1.detail" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<% if (data == null)
   {%>
<p>
指定されたデータは見つかりませんでした。
</p>
<p>
<A HREF="javascript:history.back()">前のページに戻る</A>.
</p>
<%} else {%>
    <h2>詳細表示 &gt; No.<% = data.No %></h2>
    <a href="http://twitter.com/share" data-count="none" data-url="<% = Request.Url.AbsoluteUri %>" data-text=<% = data.品目 %>(<% = data.産地都道府県 %><% if (data.産地市町村 != "-"){ %><%= data.産地市町村 %><%} %>)の放射性物質検査結果No.<%=data.No %> #yasaikensa" class="twitter-share-button" data-lang="ja">Tweet</a>
    <script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>
<table class="detail" cellspacing="0" cellpadding="4" style="color:#333333;border:1px solid black;">
<tr>
    <th>No</th>
    <td colspan="4"><% = data.No %></td>
    <th rowspan="14">地図</th>
    <td rowspan="14">
    <% if( data.Place != null ) {%>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script> 
    <script type="text/javascript">
        /**
        * Called on the initial page load.
        */
        function init() {
            var mapCenter = new google.maps.LatLng(37.421467, 141.032577);
            var map = new google.maps.Map(document.getElementById('map'), {
                'zoom': 6,
                'center': mapCenter,
                'mapTypeId': google.maps.MapTypeId.TERRAIN,
                disableDefaultUI: true
            });

            // Create a draggable marker which will later on be binded to a
            // Circle overlay.
            var marker = new google.maps.Marker({
                map: map,
                position: new google.maps.LatLng(37.421467,141.032577),
                draggable: false,
                title: '福島第一原子力発電所'
            });

            // Add a Circle overlay to the map.
            var circle1 = new google.maps.Circle({
                map: map,
                radius: 30000 // 30 km
            });
            var circle2 = new google.maps.Circle({
                map: map,
                radius: 60000 // 60 km
            });

            // Since Circle and Marker both extend MVCObject, you can bind them
            // together using MVCObject's bindTo() method.  Here, we're binding
            // the Circle's center to the Marker's position.
            // http://code.google.com/apis/maps/documentation/v3/reference.html#MVCObject
            circle1.bindTo('center', marker, 'position');
            circle2.bindTo('center', marker, 'position');

            var marker2 = new google.maps.Marker({
                map: map,
                position: new google.maps.LatLng(<% = data.Place.緯度 %>,<% = data.Place.経度 %>),
                draggable: false,
            });

        }

        // Register an event listener to fire when the page finishes loading.
        google.maps.event.addDomListener(window, 'load', init);
    </script> 
    <div id="map" style="width:400px; height:300px"></div> 
        <% = data.産地都道府県 %><% if (data.産地市町村 != "-"){ %><%= data.産地市町村 %> <%} %>は
        福島第一原子力発電所から<b><% = String.Format("{0:##0}",data.Place.方位) %>度</b>方向
         <b><% = String.Format("{0:##0}", ((int)data.Place.距離.Value/10)*10) %>Km</b> に位置しています。
    <%}else{ %>
        <% = data.産地都道府県 %><% if (data.産地市町村 != "-"){ %><%= data.産地市町村 %> <%} %>の位置情報は未登録です。
    <%} %>
    <br /><br />
         <small>※位置情報の計算はMIT/産業技術総合研究所　河尻耕太郎氏にご協力頂きました。</small>
    </td>
</tr>
<tr>
    <th>実施主体</th>
    <td colspan="4"><% = data.実施主体 %></td>
</tr>
<tr>
    <th>産地</th>
    <td colspan="4">
        <% = data.産地都道府県 %>
        <% if (data.産地市町村 != "-")
           { %><%= data.産地市町村 %> <%} %>
        <% if (data.Place != null) { %>
            (<% =data.Place.経度 %>, <%= data.Place.緯度 %>)
        <%} %>
    </td>
</tr>
<tr>
    <th>採取区分</th>
    <td colspan="4"><% = data.農場採取流通品 %></td>
</tr>
<tr>
    <th>食品分類</th>
    <td colspan="4"><% = data.食品カテゴリ %></td>
</tr>
<tr>
    <th>品目</th>
    <td colspan="4"><% = data.品目 %></td>
</tr>
<tr>
    <th>検査機関</th>
    <td colspan="4"><a href="<%= GetURL() %>"><% = data.検査機関 %></a></td>
</tr>
<tr>
    <th>採取日(購入日)</th>
    <td colspan="4"><%= data.採取日 %></td>
</tr>
<tr>
    <th>結果判明日</th>
    <td colspan="4"><% = data.結果判明日 %></td>
</tr>
<tr>
    <th>厚生省公表日</th>
    <td colspan="4"><% = data.厚生省発表日%></td>
</tr>
<tr>
    <th rowspan="4">結果</th>
    <th>放射性物質</th>
    <th>濃度[Bq/Kg]</th>
    <th>暫定規制値</th>
    <th>超過</th>
</tr>
<tr <% if(data.Isヨウ素Over){ %>style="background-color:orange;"<%} %>>
    <td class="br">ヨウ素-131</td>
    <td class="br"><% = data.結果ヨウ素131%></td>
    <td class="br"><%= data.ヨウ素基準値 %></td>
    <td><% = !data.Isヨウ素Over ? "基準内" : "超過" %></td>
</tr>
<% if (data.結果セシウム != "-") { %>
<tr>
    <td rowspan="2" class="br">セシウム</td>
    <td rowspan="2" class="br"><% = data.結果セシウム%></td>
    <td rowspan="2" class="br"><%= data.セシウム基準値 %></td>
    <td rowspan="2" class=""><% = !data.IsセシウムOver ? "基準内" : "超過" %></td>
</tr>
<tr></tr>
<% }else{ %>
<tr <% if(data.IsセシウムOver){ %>style="background-color:orange;"<%} %>>
    <td class="br">セシウム-134</td>
    <td class="br"><% = data.結果セシウム134%></td>
    <td rowspan="2" class="br"><%= data.セシウム基準値 %></td>
    <td rowspan="2" class=""><% = !data.IsセシウムOver ? "基準内" : "超過" %></td>
</tr>
<tr <% if(data.IsセシウムOver){ %>style="background-color:orange;"<%} %>>
    <td class="br">セシウム-137</td>
    <td class="br"><% = data.結果セシウム137%></td>
</tr>
<% } %>
<tr>
    <th>履歴</th>
    <td class="tail" colspan="6">
        <p>同じ産地／品目の検査データ</p>
        <asp:Image ID="bqByDayImage" runat="server" />
    </td>
</tr>
</table>


<p>同じ産地／品目の検査データ一覧:</p>
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
    <% int counter = 0;  foreach (var item in list)
       { %>
    <tr <% if(counter++%2==0){ %> style="background-color:#E3EAEB;" <% }else{ %> style="background-color:White;"<%} %>>
        <td><% = item.No%></td>        
        <td><% = item.実施主体%></td>        
        <td><a href="Pref.aspx?q=<% = HttpUtility.UrlEncode(item.産地都道府県) %>"><% = item.産地都道府県%></a></td>        
        <td><a href="city.aspx?city=<% = HttpUtility.UrlEncode(item.産地市町村) %>&pref=<% = HttpUtility.UrlEncode(item.産地都道府県) %>"><% = item.産地市町村%></a></td>        
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
    </tr>   
    <% } %>
    <% if(list.Count==0){ %><td colspan="12">なし</td><%} %>
    </table>
    <br />
    不検出：ND、暫定規制値以上：黄色
<p>
<A HREF="javascript:history.back()">前のページに戻る</A>.
</p>
<% if( User.Identity.IsAuthenticated ) { %>
    <asp:Button ID="DeleteButton" runat="server" Text="削除" 
        OnClientClick="return confirm('削除します。よろしいですか？');" onclick="DeleteButton_Click"/>
<% } %>
<% }%>
</asp:Content>
