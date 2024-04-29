input {
  beats {
    port => 5044
  }
}


filter {
  if [log][file][path] =~ "nginx/access.log"        {
    grok {
      match => { "message" => '%{IPORHOST:clientip} %{USER:ident} %{USER:auth} \[%{HTTPDATE:timestamp}\] "(?:%{WORD:verb} %{NOTSPACE:request}(?: HTTP/%{NUMBER:httpversion})?|%{DATA:rawrequest})" %{NUMBER:response:int} %{NUMBER:bytes:int}(?: \"%{DATA:referrer}\" \"%{DATA:agent}\")?' }
    }


      mutate {
        add_field => { "[@metadata][index]" => "filebeat-response-%{+YYYY.MM.dd}" }
      }

  }
  if [log][file][path] =~ "W3SVC1/*.log" {
    grok {

        match => { "message" => '%{TIMESTAMP_ISO8601:log_timestamp}, %{WORD:computername}, %{IPORHOST:site}, %{WORD:method}, %{URIPATH:page}, %{NOTSPACE:querystring}, %{NUMBER:port}, %{NOTSPACE:username}, %{IPORHOST:c-ip}, %{NOTSPACE:useragent}, %{NOTSPACE:referrer}, %{IPORHOST:clienthost}, %{NUMBER:scstatus}, %{NUMBER:scsubstatus}, %{NUMBER:winstatus}, %{NUMBER:bytessent}, %{NUMBER:bytesreceived}, %{NUMBER:time_taken}, %{IPORHOST:x-forwarded-for}' }

}

      mutate {
        add_field => { "[@metadata][index]" => "filebeat-iisresponse-%{+YYYY.MM.dd}" }
      }

  }


}
output {
  elasticsearch {
    hosts => ["localhost:9200"]
    index => "%{[@metadata][index]}"
  }
}

