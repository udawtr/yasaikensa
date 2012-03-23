<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Browse.aspx.cs"  MasterPageFile="~/Site.master" Inherits="WebRole1.Browse" Title="食品の放射性物質検査データ" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h3 class="subtitle">
    都道府県別データ件数
    <div id="social">
    <a href="http://twitter.com/share?text=都道府県別の放射性物質検査結果 #yasaikensa" class="twitter-share-button" data-url="http://yasaikensa.cloudapp.net/Browse.aspx" data-count="horizontal" data-lang="ja">Tweet</a>
    <script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>
    </div>
    </h3>
<table cellspacing="0" cellpadding="0" width="590" border="0">
										<tr>
											<td class="txt03" width="151" bgcolor="#ffffff"><table cellspacing="5" cellpadding="0" width="568" border="0">
													<tr>
														<td class="txt03" valign="top" align="left" colspan="4" rowspan="2">
															<p>都道府県名をクリックすると、都道府県レベルでの検査結果が表示されます。<br />
                                                                市町村で表示することもできます。<br />
                                                                カッコ内の数字は登録されているデータ件数です。</p>
															<p></p>
														<td valign="top" align="center" width="142">
															<table cellspacing="1" cellpadding="1" width="110" bgcolor="#99ff33" border="0">
																<tr>
																	<td class="txt03" valign="bottom" align="left" bgcolor="#ffffcc">
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("北海道") %>'' >北海道</A> (<% = GetCoount("北海道") %>)
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td valign="top" align="center">
															<table cellspacing="1" cellpadding="1" width="110" bgcolor="#99ff33" border="0">
																<tr>
																	<td class="txt03" valign="bottom" align="left" bgcolor="#ffffcc">
                                                                        <A href='pref.aspx?q=<% = HttpUtility.UrlEncode("青森県") %>' >青森</A> (<% = GetCoount("青森県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("岩手県") %>' >
																			岩手</A> (<% = GetCoount("岩手県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("秋田県") %>7' >
																			秋田</A> (<% = GetCoount("秋田県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("宮城県") %>' >
																			宮城</A> (<% = GetCoount("宮城県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("山形県") %>' >
																			山形</A> (<% = GetCoount("山形県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("福島県") %>' >
																			福島</A> (<% = GetCoount("福島県") %>)
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td valign="top" align="center" width="110">
															<table cellspacing="1" cellpadding="1" width="110" bgcolor="#99ff33" border="0">
																<tr>
																	<td class="txt03" valign="bottom" align="left" bgcolor="#ffffcc">
                                                                        <A href='pref.aspx?q=<% = HttpUtility.UrlEncode("福岡県") %>' >福岡</A> (<% = GetCoount("福岡県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("佐賀県") %>' >
																			佐賀</A> (<% = GetCoount("佐賀県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("長崎県") %>' >
																			長崎</A> (<% = GetCoount("長崎県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("大分県") %>' >
																			大分</A> (<% = GetCoount("大分県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("熊本県") %>' >
																			熊本</A> (<% = GetCoount("熊本県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("宮崎県") %>' >
																			宮崎</A> (<% = GetCoount("宮崎県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("鹿児島県") %>' >
																			鹿児島</A> (<% = GetCoount("鹿児島県") %>)</td>
																</tr>
															</table>
                                                            <div style="height:5px;"></div>
															<table cellspacing="1" cellpadding="1" width="110" bgcolor="#99ff33" border="0">
																<tr>
																	<td class="txt03" valign="bottom" align="left" bgcolor="#ffffcc">
                                                                        <A href='pref.aspx?q=<% = HttpUtility.UrlEncode("沖縄県") %>' >沖縄</A> (<% = GetCoount("沖縄県") %>)
																	</td>
																</tr>
															</table>
														</td>
														<td valign="top" align="center" width="110">
															<table cellspacing="1" cellpadding="1" width="110" bgcolor="#99ff33" border="0">
																<tr>
																	<td class="txt03" valign="bottom" align="left" bgcolor="#ffffcc">
                                                                        <A href='pref.aspx?q=<% = HttpUtility.UrlEncode("鳥取県") %>' >鳥取</A> (<% = GetCoount("鳥取県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("島根県") %>' >
																			島根</A> (<% = GetCoount("島根県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("岡山県") %>' >
																			岡山</A> (<% = GetCoount("岡山県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("広島県") %>' >
																			広島</A> (<% = GetCoount("広島県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("山口県") %>' >
																			山口</A> (<% = GetCoount("山口県") %>)
																	</td>
																</tr>
															</table>
                                                            <div style="height:5px;"></div>
															<table cellspacing="1" cellpadding="1" width="110" bgcolor="#99ff33" border="0">
																<tr>
																	<td class="txt03" valign="bottom" align="left" bgcolor="#ffffcc">
                                                                        <A href='pref.aspx?q=<% = HttpUtility.UrlEncode("香川県") %>' >香川</A> (<% = GetCoount("香川県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("徳島県") %>' >
																			徳島</A> (<% = GetCoount("徳島県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("高知県") %>' >
																			高知</A> (<% = GetCoount("高知県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("愛媛県") %>' >
																			愛媛</A> (<% = GetCoount("愛媛県")%>)
																	</td>
																</tr>
															</table>
														</td>
														<td valign="top" align="center" width="110">
															<table cellspacing="1" cellpadding="1" width="110" bgcolor="#99ff33" border="0">
																<tr>
																	<td class="txt03" valign="bottom" align="left" bgcolor="#ffffcc">
                                                                        <A href='pref.aspx?q=<% = HttpUtility.UrlEncode("滋賀県") %>' >滋賀</A> (<% = GetCoount("滋賀県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("京都府") %>' >
																			京都</A> (<% = GetCoount("京都府") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("大阪府") %>' >
																			大阪</A> (<% = GetCoount("大阪府") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("兵庫県") %>' >
																			兵庫</A> (<% = GetCoount("兵庫県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("奈良県") %>' >
																			奈良</A> (<% = GetCoount("奈良県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("和歌山県") %>' >
																			和歌山</A> (<% = GetCoount("和歌山県") %>)
																	</td>
																</tr>
															</table>
														</td>
														<td valign="top" align="center" width="110">
															<table cellspacing="1" cellpadding="1" width="110" bgcolor="#99ff33" border="0">
																<tr>
																	<td class="txt03" valign="bottom" align="left" bgcolor="#ffffcc">
                                                                        <A href='pref.aspx?q=<% = HttpUtility.UrlEncode("新潟県") %>' >
                                                                            新潟</A> (<% = GetCoount("新潟県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("長野県") %>' >
																			長野</A> (<% = GetCoount("長野県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("山梨県") %>' >
																			山梨</A> (<% = GetCoount("山梨県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("富山県") %>' >
																			富山</A> (<% = GetCoount("富山県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("石川県") %>' >
																			石川</A> (<% = GetCoount("石川県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("福井県") %>' >
																			福井</A> (<% = GetCoount("福井県") %>)
																	</td>
																</tr>
															</table>
                                                            <div style="height:5px;"></div>
															<table cellspacing="1" cellpadding="1" width="110" bgcolor="#99ff33" border="0">
																<tr>
																	<td class="txt03" valign="bottom" align="left" bgcolor="#ffffcc">
                                                                        <A href='pref.aspx?q=<% = HttpUtility.UrlEncode("静岡県") %>' >
                                                                            静岡</A> (<% = GetCoount("静岡県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("愛知県") %>' >
																			愛知</A> (<% = GetCoount("愛知県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("岐阜県") %>' >
																			岐阜</A> (<% = GetCoount("岐阜県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("三重県") %>' >
																			三重</A> (<% = GetCoount("三重県") %>)
																	</td>
																</tr>
															</table>
														</td>
														<td valign="top" align="center" width="142">
															<table cellspacing="1" cellpadding="1" width="110" bgcolor="#99ff33" border="0">
																<tr>
																	<td class="txt03" valign="bottom" align="left" bgcolor="#ffffcc">
                                                                        <A href='pref.aspx?q=<% = HttpUtility.UrlEncode("茨城県") %>' >
                                                                            茨城</A> (<% = GetCoount("茨城県") %>)
																		<br />
                                                                        <A href='pref.aspx?q=<% = HttpUtility.UrlEncode("栃木県") %>' >
																			栃木</A> (<% = GetCoount("栃木県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("群馬県") %>' >
																			群馬</A> (<% = GetCoount("群馬県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("埼玉県") %>' >
																			埼玉</A> (<% = GetCoount("埼玉県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("千葉県") %>' >
																			千葉</A> (<% = GetCoount("千葉県") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("東京都") %>' >
																			東京</A> (<% = GetCoount("東京都") %>)
																		<br>
																		<A href='pref.aspx?q=<% = HttpUtility.UrlEncode("神奈川県") %>' >
																			神奈川</A> (<% = GetCoount("神奈川県") %>)
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
</asp:Content>