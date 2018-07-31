# LODQA e-mail agent server

The agent server for e-mail interface of LODQA.
This server provide e-mail interface to query to [LODQA](http://lodqa.org/).

## Architecture

This is a Ruby on Rails web application server.
Provide a web api to register queries.

### API

To registr query, send HTTP request like below:

```
curl http://e-mail.lodqa.org/queries -XPOST -d query='Which genes are associated with Endothelin receptor type B?' -d reply_to='e.mail.address@example.com'
```

Then when the query is started, an email will be sent.
And then when the query is finished, an email will be sent.

For detail, please refer to [API docmuent](api.md)

## Tools

To generate api docmuent.

```
docker run --rm -v (pwd):/opt swagger2markup/swagger2markup convert -i /opt/openapi/openapi.yml -c /opt/openapi/config.properties -f /opt/api
 ```
