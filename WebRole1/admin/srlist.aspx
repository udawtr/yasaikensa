<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="srlist.aspx.cs" Inherits="WebRole1.admin.srlist" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div style="margin:10px 0;">
<a href="default.aspx">管理メニュー</a>&nbsp;&gt&nbsp;出荷制限
</div>

<table border=1>
<thead>
    <tr>
        <th>都道府県</th>
        <th>コード</th>
        <th>表題</th>
        <th></th>
    </tr>
</thead>
<tbody>
<tr>
    <td>新規</td>
    <td></td>
    <td></td>
    <td><a href="sredit.aspx?code=new">作成</a></td>
</tr>
<% foreach(var pref in SRList.GroupBy(x=>x.PrefName)){ %>
<tr>
    <td rowspan="<% = pref.Count() %>"><% = pref.Key %></td>
    <%  var list = pref.OrderBy(x=>x.BeginDate).ToList(); %>
    <td><% = list[0].Code %></td>
    <td><% = list[0].Caption %></td>
    <td><a href="srdetail.aspx?code=<% = list[0].Code %>">詳細</a></td>
</tr>
<% foreach (var item in list.Skip(1)) { %>
<tr>
    <td><% = item.Code %></td>
    <td><% = item.Caption %></td>
    <td><a href="srdetail.aspx?code=<% = item.Code %>">詳細</a></td>
</tr>
<% } %>
<% } %>
</tbody>
</table>

</asp:Content>
