<%@ Page Title="食品の放射能検査データ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebRole1.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h1 style="color:red; font-weight:bold;">食品の放射能検査データの閲覧について</h1>
<div style="font-size:14px;background-color:#ffcccc; border:1px solid black;">
<ul>
<li>
厚労省の定めた暫定規制値は、以下のとおりです。<br />
<table cellpadding="1" cellspacing="1" style="background:white;">
<tr>
<th style="background:gray;color:White;">放射性物質</th>
<th style="background:gray;color:White;">対象となる食品</th>
<th style="background:gray;color:White;">暫定規制値(Bq/kg)</th>
</tr>
<tr>
<th rowspan="2" style="background:lightblue;">放射性ヨウ素</th>
<td>飲料水、牛乳、乳製品</td>
<td>300</td>
</tr>
<tr>
<td>野菜類(根菜、芋類を除く)、魚介類</td>
<td>2000</td>
</tr>
<tr>
<th rowspan="2" style="background:lightblue;">放射性セシウム</th>
<td>飲料水、牛乳、乳製品</td>
<td>200</td>
</tr>
<tr>
<td>野菜類、穀類、肉、卵、魚、その他</td>
<td>500</td>
</tr>
</table>
</li>
<li>上記における「ベクレル(Bq/kg)」は、放射性物質そのものが放射線を出す能力（放射能）の強さを表す単位です。<br />放射性物質をたき火にたとえると、火の強さに相当します。
</li>
<li>暫定規制値は、放射線から身を守るためのひとつとして、飲食を控えた方がよいと判断される目安として示されたものです。
<br />（詳細、<a href="http://www.nsc.go.jp/shinsashishin/pdf/history/59-15.pdf">原子力安全委員会の指標　「原子力施設等の防災対策について」</a>のP.108、<a href="http://www.fsc.go.jp/fsciis/meetingMaterial/show/kai20110325sfc">資料6</a>、<a href="http://www.aist-riss.jp/main/modules/column/atsuo-kishimoto009.html">参考</a>）
</li>
<li>暫定規制値を超えた食品は販売できないことが法律で決まっています（食品衛生法第６条第２号）。
<br />暫定規制値を超えた場合は、出荷制限が行われ、当該農作物等については、現在、市場に流通しておりません。(原子力災害対策特別措置法)
</li>
<li>出荷制限対象となった農産物については、<a href="http://www.kantei.go.jp/saigai/genpatsu_houshanou.html#syoku_anzen">首相官邸 東電福島原発・放射能関連情報「食の安全・出荷や摂取情報」</a>をご覧ください。
</li>
<li>
NDとは、Not Detected (不検出) を表します。
</li>
</ul>
</div>
<h2 style="color:Blue">以上をご理解の上、メニューをクリックしてご利用下さい。</h2>
<div>
メニュー:<br />
<a href="special.aspx" class="button3d"><span>出荷制限があった地域と品目のデータを見る</span></a><div style="clear:both"></div>
<a href="search.aspx" class="button3d"><span>条件を絞ってデータを検索する</span></a><div style="clear:both"></div>
<a href="browse.aspx" class="button3d"><span>都道府県／市町村を選択してデータを見る</span></a><div style="clear:both"></div>
<a href="browsebyproduct.aspx" class="button3d"><span>品目を選択してデータを見る</span></a>
</div>
<div style="clear:both; height:20px;"></div>

<h2>お知らせ</h2>
    <div id="updates">
    <ul>
    <li>お知らせ(20xx.mm.dd)</li>
    </ul>
    </div>

<div style="clear:both; height:20px;"></div>
<script src="http://widgets.twimg.com/j/2/widget.js"></script>
<script>
    new TWTR.Widget({
        version: 2,
        type: 'search',
        search: 'yasaikensa',
        interval: 6000,
        title: '食品の放射能検査データ つぶやき',
        subject: '',
        width: 'auto',
        height: 250,
        theme: {
            shell: {
                background: '#0d668f',
                color: '#ffffff'
            },
            tweets: {
                background: '#ffffff',
                color: '#444444',
                links: '#1985b5'
            }
        },
        features: {
            scrollbar: false,
            loop: true,
            live: true,
            hashtags: true,
            timestamp: true,
            avatars: true,
            toptweets: true,
            behavior: 'default'
        }
    }).render().start();
</script>

</asp:Content>
