# ROR_readonly_shorturl
ReadOnlyRest kibana_access:ro bug with ElasticSearch 6.5.1

Key part in readonlyrest.xml:
```
  - name: "kib_ro"
    verbosity: error
    kibana_access: ro
    hosts: ["kib_ro"]
```

This should allow the kib_ro container (running on port 5602) to create Short Urls.  See https://github.com/beshu-tech/readonlyrest-docs/blob/master/elasticsearch.md#kibana_access.

# Usage
1. docker-compose up
1. wait ...
1. Vist <http://localhost:5601>
    1. Follow the prompts to add some sample data
1. Visit <http://localhost:5601/app/kibana#/discover>
    1. Share
    1. Permalink
    1. Toggle Short Url
        1. It works
1. Vist <http://localhost:5602/app/kibana#/discover>
    1. Share
    1. Permalink
    1. Toggle Short Url
        1. "Unable to create short URL. Error: Forbidden"
    
| container | message |
| --------- | ------- |
| elasticsearch | [2019-01-31T01:18:38,472][INFO ][t.b.r.a.ACL              ] [hhnIYVB] FORBIDDEN by default req={ ID:903541168-95461383#2499, TYP:IndexRequest, CGR:N/A, USR:[no basic auth header], BRS:false, KDX:null, ACT:indices:data/write/index, OA:172.24.0.2, DA:172.24.0.4, IDX:.kibana, MET:POST, PTH:/.kibana/doc/url%3A606be43db56e36dcdb9fa0b2a565bb66/_create?refresh=wait_for, CNT:<OMITTED, LENGTH=408>, HDR:{Connection=keep-alive, content-type=application/json, Host=elasticsearch:9200, Content-Length=408}, HIS:[kib->[hosts->false]], [kib_ro->[kibana_access->false]], [monitor->[hosts->true, actions->false]], [public->[actions->false]] } |
| kib_ro | {"type":"response","@timestamp":"2019-01-31T01:18:38Z","tags":[],"pid":1,"method":"post","statusCode":403,"req":{"url":"/api/shorten_url","method":"post","headers":{"host":"localhost:5602","connection":"keep-alive","content-length":"251","origin":"http://localhost:5602","kbn-version":"6.5.1","user-agent":"Mozilla","content-type":"application/json","accept":"*/*","referer":"http://localhost:5602/app/kibana","accept-encoding":"gzip, deflate, br","accept-language":"en-AU,en-GB;q=0.9,en-US;q=0.8,en;q=0.7"},"remoteAddress":"172.24.0.1","userAgent":"172.24.0.1","referer":"http://localhost:5602/app/kibana"},"res":{"statusCode":403,"responseTime":106,"contentLength":9},"message":"POST /api/shorten_url 403 106ms - 9.0B"} |
