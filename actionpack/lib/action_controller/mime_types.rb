Mime::Type.register "*/*", :all
Mime::Type.register "text/plain", :text
Mime::Type.register "text/html", :html, %w( application/xhtml+xml ), %w( xhtml )
Mime::Type.register "text/javascript", :js, %w( application/javascript application/x-javascript )
Mime::Type.register "text/x-json", :json, %w( application/x-json )
Mime::Type.register "text/calendar", :ics
Mime::Type.register "text/csv", :csv
Mime::Type.register "application/xml", :xml, %w( text/xml application/x-xml )
Mime::Type.register "application/rss+xml", :rss
Mime::Type.register "application/atom+xml", :atom
Mime::Type.register "application/x-yaml", :yaml, %w( text/yaml )