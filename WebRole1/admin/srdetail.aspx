<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="srdetail.aspx.cs" Inherits="WebRole1.admin.srdetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div style="margin:10px 0;">
<a href="default.aspx">管理メニュー</a>&nbsp;&gt&nbsp;<a href="SRList.aspx">出荷制限</a>&nbsp;&gt;&nbsp;<% = SR.Code %>
</div>

<table border=1>
<tbody>
<tr><th colspan="2">コード</th><td><% =  SR.Code %></td></tr>
<tr><th colspan="2">表題</th><td><% = SR.Caption%></td></tr>
<tr><th colspan="2">都道府県</th><td><% = SR.PrefName%></td></tr>
<tr><th rowspan="2">市町村</th><th>モード</th><td><% = WebRole1.Common.ToCityFilterModeString(SR)%></td></tr>
<tr><th>一覧</th><td><% = String.Join(",", SRCities.Where(x => x.ShippingRestrictionCode == SR.Code).Select(x => x.CityName).ToArray())%></td></tr>
<tr><th rowspan="2">商品</th><th>モード</th><td><% = WebRole1.Common.ToProductFilterModeString(SR)%></td></tr>
<tr><th>一覧</th><td><% = String.Join(",", SRProducts.Where(x => x.ShippingRestrictionCode == SR.Code).Select(x => x.ProductName).ToArray())%></td></tr>
<tr><th colspan="2">制限開始</th><td><% = String.Format("{0:yyyy年M月dd日}", SR.BeginDate) %></td></tr>
<tr><th colspan="2">制限解除</th><td><% = String.Format("{0:yyyy年M月dd日}", SR.EndDate) %></td></tr>
<tr><th colspan="2">コメント</th><td><% = SR.Comment%></td></tr>
<tr><th colspan="2">グラフ</th><td><img src="../SpecialChartImage.ashx?q=<% = SR.Code %>" /></td></tr>
</tbody>
</table>

<a href="sredit.aspx?code=<% = SR.Code %>">編集</a>

</asp:Content>
