<%@ Page Title="分布 | 食品の放射能検査データ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="map.aspx.cs" Inherits="WebRole1.map" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="Styles/map.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script> 
    <script type="text/javascript" src="Scripts/gmaputil.js"></script>
    <script type="text/javascript">
        var map;
        var infowindow;
        var image = [    new google.maps.MarkerImage('images/ng.png', new google.maps.Size(8, 8)),
                         new google.maps.MarkerImage('images/base.png', new google.maps.Size(8, 8)),
                         new google.maps.MarkerImage('images/25.png', new google.maps.Size(8, 8)),
                         new google.maps.MarkerImage('images/50.png', new google.maps.Size(8, 8)),
                         new google.maps.MarkerImage('images/100.png', new google.maps.Size(8, 8)),
                         new google.maps.MarkerImage('images/200.png', new google.maps.Size(8, 8)),
                         new google.maps.MarkerImage('images/300.png', new google.maps.Size(8, 8)),
                         new google.maps.MarkerImage('images/500.png', new google.maps.Size(8, 8)),
                         new google.maps.MarkerImage('images/2000.png', new google.maps.Size(8, 8)),
                         new google.maps.MarkerImage('images/10000.png', new google.maps.Size(8, 8))];

        /**
        * Called on the initial page load.
        */
        function init() {

            var mapCenter = new google.maps.LatLng(37.421467, 141.032577);
            map = new google.maps.Map(document.getElementById('map'), {
                'zoom': 7,
                'center': mapCenter,
                'mapTypeId': google.maps.MapTypeId.TERRAIN,
                disableDefaultUI: false
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

            var url = "<% = MapDataURL %>";
            downloadUrl(url, function (data) {
                var markers = data.documentElement.getElementsByTagName("marker");
                for (var i = 0; i < markers.length; i++) {
                    var latlng = new google.maps.LatLng(parseFloat(markers[i].getAttribute("lat")),
                    parseFloat(markers[i].getAttribute("lng")));
                    var bq = parseFloat(markers[i].getAttribute("bq"));
                    var pref = markers[i].getAttribute("pref");
                    var city = markers[i].getAttribute("city");
                    var marker = createMarker(pref, city, latlng, bq);
                }
            });
        }

        function getImageIndex(bq) {
            if (bq == 0) return 0;
            if (bq < 25) return 1;
            if (bq < 50) return 2;
            if (bq < 100) return 3;
            if (bq < 200) return 4;
            if (bq < 300) return 5;
            if (bq < 5000) return 6;
            if (bq < 2000) return 7;
            if (bq < 10000) return 8;
            if (bq >= 10000) return 9;
            return 0;
        }

        function createMarker(pref, city, latlng, bq) {
            var marker = new google.maps.Marker({ position: latlng, map: map, icon: image[getImageIndex(bq)] });
            google.maps.event.addListener(marker, "click", function () {
                //                if (infowindow) infowindow.close();
                //                infowindow = new google.maps.InfoWindow({ content: name + bq });
                //                infowindow.open(map, marker);

                var garea = document.getElementById('graph-area');
                garea.style.visibility = "visible";

                var preflabel = document.getElementById('pref-label');
                var citylabel = document.getElementById('city-label');
                var linka = document.getElementById('link');
                preflabel.innerHTML = pref;
                citylabel.innerHTML = city;
                linka.href = "city.aspx?pref=" + pref + "&city=" + city;

                var img = document.getElementById('graph');
                img.src = "SearchChartImage.ashx?width=700&height=250&pref=" + pref + "&city=" + city;
            });
            return marker;
        }

        // Register an event listener to fire when the page finishes loading.
        google.maps.event.addDomListener(window, 'load', init);
    </script> 
    <p>地方自治体の所在地に2011/3/11以降に検出された放射性ヨウ素または放射性セシウム[Bq/kg]の最大値をプロットした図です。
    <a href="http://twitter.com/share" data-count="none" data-url="<% = Request.Url.AbsoluteUri %>" data-text="放射能検査分布図 #yasaikensa" class="twitter-share-button" data-lang="ja">Tweet</a>
    <script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>
    <br />
    ※市区町村レベルの産地が不明な情報は表示されません。<br /> ※位置情報の計算はMIT/産業技術総合研究所　河尻耕太郎氏にご協力頂きました。
    </p>
<div class="field">
<div class="field-header">
集計期間(厚生表公表日基準)</div>
<div class="field-body">
<asp:RadioButtonList 
            ID="dateFilter" runat="server" AutoPostBack="True" 
            onselectedindexchanged="dateFilter_SelectedIndexChanged" 
            RepeatDirection="Horizontal" RepeatLayout="Flow">
            <asp:ListItem Value="ALL">全期間</asp:ListItem>
            <asp:ListItem Selected="True" Value="3W">3週間以内</asp:ListItem>
        </asp:RadioButtonList>
</div></div>
<div class="field">
<div class="field-header">
        表示物質</div>
        <div class="field-body">
        <asp:RadioButtonList ID="valueFilter" runat="server" AutoPostBack="True" 
            onselectedindexchanged="valueFilter_SelectedIndexChanged" 
            RepeatDirection="Horizontal" RepeatLayout="Flow">
            <asp:ListItem Value="I">放射性ヨウ素[Bq]</asp:ListItem>
            <asp:ListItem Selected="True" Value="Cs">放射性セシウム[Bq]</asp:ListItem>
        </asp:RadioButtonList>
</div></div>
<div style="clear:both"></div>
   <div id="map" style="width:700px; height:300px"></div>
<br />
    地図上のマーカーをクリックすると検査データが時系列でグラフ表示されます。
    <Br /><img src="images/ng.png" border="1" />ND(不検出)
    <img src="images/base.png" />25Bq未満
    <img src="images/25.png" />25Bq以上50Bq未満
    <img src="images/50.png" />50Bq以上100Bq未満
    <img src="images/100.png" />100Bq以上200Bq未満
    <img src="images/200.png" />200Bq以上300Bq未満<br />
    <img src="images/300.png" />300Bq以上500Bq未満
    <img src="images/500.png" />500Bq以上2000Bq未満
    <img src="images/2000.png" />2000Bq以上10000Bq未満
    <img src="images/10000.png" />10000Bq以上
       </p>    <div id="graph-area" style="visibility:hidden">
    <p>
    <span id="pref-label"></span><span id="city-label"></span>: [<a id="link" href="">データの一覧</a>]
    </p>
    <img id="graph" src="#" alt="地図上のマーカーをクリックするとここにデータがプロットされます" width="700" height="250" />
        <div class="chart-caption">
        グラフは震災発生日からの経過日数毎の放射性ヨウ素、放射性セシウムの検出量(Bq/kg)の最大値、最小値、中央値(=(最大値+最小値)/2)を表しています。
        </div>
    </div>
</asp:Content>
