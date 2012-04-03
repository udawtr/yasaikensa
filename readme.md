食品の放射能検査データ Webシステム
----------------------------------------------

### 概要

「食品の放射能検査データ」(http://yasaikensa.cloudapp.net)
(運用期間：2011年4月11日から2012年4月30日)のソースコード一式です。

「食品の放射能検査データ」は厚労省公表の食品の放射性物質検査データからプレスリリース情報の追加を行い検索可能な状態にしたもので、(財)食品流通構造改善促進機構がボランティアで運用しました。サーバ環境はマイクロソフト社の協力により、Windows Azure Platformによって提供されました。

福島第一原発事故を受けて急ぎ作ったプログラムがほぼそのままの状態での公開になります。

全データのExcel形式ファイルは alldata.xlsx です。
https://github.com/udawtr/yasaikensa/blob/master/alldata.xlsx

###動作開発環境
- Microsoft Windows Azure (WebRole + SQL Azure)
- Micorsoft Visual Studio 2010
- ASP.NET 3.5
- C#

### DBスキーマの復元
- SQL Azure Migration Wizard を使って行います。
- データは WebRole1\App_Data\*.{sql|data} です。