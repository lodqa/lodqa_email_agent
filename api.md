# LODQA e-mail agent server


<a name="overview"></a>
## 概要
The agent server for e-mail interface of LODQA.


### バージョン情報
*バージョン* : 1.0.0


### URI スキーム
*ホスト* : e-mail.lodqa.org  
*スキーム* : HTTP


### タグ

* query : Reigster queries


### External Docs
*Description* : LODQA  
*URL* : http://lodqa.org/




<a name="paths"></a>
## パス

<a name="events-post"></a>
### Callback API for LDOQA BS
```
POST /events
```


#### 説明
Rececve notifications about progerss of the query from LODQA BS


#### パラメータ

|タイプ|名前|説明|スキーマ|
|---|---|---|---|
|**Body**|**body**  <br>*必須*|An event of query progression|[Event](#event)|


#### レスポンス

|HTTP コード|説明|スキーマ|
|---|---|---|
|**204**|OK|No Content|


#### タグ

* query


<a name="queries-post"></a>
### Reigster a new query
```
POST /queries
```


#### 説明
Register a new query to search in LODQA


#### パラメータ

|タイプ|名前|説明|スキーマ|
|---|---|---|---|
|**Body**|**body**  <br>*必須*|A new Query to register|[Query](#query)|


#### レスポンス

|HTTP コード|説明|スキーマ|
|---|---|---|
|**200**|OK|[RegisterdQuery](#registerdquery)|
|**400**|Bad request|No Content|


#### タグ

* query




<a name="definitions"></a>
## モデル定義

<a name="answer"></a>
### Answer

|名前|説明|スキーマ|
|---|---|---|
|**label**  <br>*オプション*|**例** : `"ENDOTHELIN RECEPTOR, TYPE A; EDNRA [omim:131243]"`|string|
|**uri**  <br>*オプション*|**例** : `"http://bio2rdf.org/omim:131243"`|string|


<a name="event"></a>
### Event

|名前|説明|スキーマ|
|---|---|---|
|**answers**  <br>*オプション*||< [Answer](#answer) > array|
|**elapsed_time**  <br>*オプション*|elapsed time to search the query|number|
|**event**  <br>*オプション*|**例** : `"start_search"`|string|
|**finish_at**  <br>*オプション*|date in UTC when the query finished|string (date-time)|
|**query**  <br>*オプション*|**例** : `"Which genes are associated with Endothelin receptor type B?"`|string|
|**query_id**  <br>*オプション*|**例** : `"1469caf6-efeb-4fb1-93b0-103ae91d4741"`|string|
|**start_at**  <br>*オプション*|date in UTC when the query starts|string (date-time)|


<a name="query"></a>
### Query

|名前|説明|スキーマ|
|---|---|---|
|**query**  <br>*オプション*|**例** : `"Which genes are associated with Endothelin receptor type B?"`|string|
|**reply_to**  <br>*オプション*|**例** : `"e.mail.address@example.com"`|string|


<a name="registerdquery"></a>
### RegisterdQuery

|名前|説明|スキーマ|
|---|---|---|
|**query**  <br>*オプション*|**例** : `"Which genes are associated with Endothelin receptor type B?"`|string|
|**query_id**  <br>*オプション*|**例** : `"1469caf6-efeb-4fb1-93b0-103ae91d4741"`|string|





