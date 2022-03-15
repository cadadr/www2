#!/usr/bin/env ruby
# linkblog.rb --- add to the linkblog or generate the feed

# Copyright (C) 2022 İ. Göktuğ Kayaalp <self at gkayaalp dot com> This
# file is part of “Göktuğ’s homepage”.
#
# “Göktuğ’s homepage” is non-violent software: you can use,
# redistribute, and/or modify it under the terms of the CNPLv6+ as
# found in the LICENCE_CNPLv6.txt file in the source code root
# directory or at <https://git.pixie.town/thufie/CNPL>.
#
# “Göktuğ’s Gemini Scripts” comes with ABSOLUTELY NO WARRANTY, to the
# extent permitted by applicable law.  See the CNPL for details.

require 'fileutils'
require 'json'
require 'open3'
require 'pathname'
require 'rss'
require 'tempfile'

def data_file
  Pathname.new(__dir__) / 'links.json'
end

def load_links
  JSON.parse File.read(File.open data_file)
end

def description
  File.read File.open(Pathname.new(__dir__) / 'description.html')
end

def template name
  File.read File.open(Pathname.new(__dir__) / "#{name}")
end

def pandoc str
  out, err, ret = Open3.capture3 "pandoc -f markdown -t html -", {stdin_data: str}
  if ret == 0
    out
  else
    die "pandoc error: #{err}"
  end
end

def usage
  puts "#{$0}: usage: #{$0} add|atom|html"
end


def write_links links
  json = JSON.pretty_generate links
  f = Tempfile.new 'linkblog_json'
  begin
    f.write json
    f.fsync
    f.close
    FileUtils.mv data_file, "#{data_file}.bkp"
    FileUtils.cp f, data_file
  ensure
    f.unlink
  end
end

def die why, ret = 2
  puts "#{$0}: error: #{why}"
  exit ret
end

def add_link
  template = <<EOS
Link: 
---
Title: 
---
Comment: 
EOS
  f = Tempfile.new ['linkblog_newlink', '.markdown']
  begin
    f.write(template)
    f.flush
    ed = ENV['EDITOR']
    system "#{ed}", "#{f.path}"
    f.rewind
    s = f.read
  ensure
    f.close && f.unlink
  end
  time = Time.now.to_s
  link, title, comment = s.split(/---\n/).each do |bit|
    begin
      bit[/^(Link|Title|Comment):( +)?(\n+)?/] = ''
      bit[/\n$/] = ''
      if bit.empty?
        die "empty field"
      end
      bit
    rescue IndexError
      die "improper file or no content added"
    end
  end
  new_item = {link: link, title: title, comment: comment, time: time}
  links = load_links
  links.unshift new_item
  write_links links
end

# TODO: paginate? how will anchors work compatibly? can I do redirects
# with javascript maybe?
#
# or another possibility is to generate canonical HTML files for each
# link, with the date as the filename.
def generate_page
  links = load_links
  top = template "_head.html"
  bot = template "_foot.html"
  top.gsub! /@@LANG@@/, 'en'
  top.gsub! /@@TITLE@@/, "Göktuğ's Link Blog"

  content = description

  links[0..9].each do |l|
    content << "\n<article class='linkblog linkpost'>"
    content << "\n<a id='#{l['time']}'/>"
    content << "\n<h3><a href=#{l['link']}>#{l['title']}</a></h3>"
    content << "\n<div class='comment'>#{pandoc l['comment']}</div>"
    content << "\n<p class='date'><a href='\##{l['time']}'>#{l['time']}</a></p>"
  end

  page = "#{top}\n#{content}\n#{bot}"
  puts page
end

def generate_feed
  links = load_links
  feed = RSS::Maker.make('atom') do |f|
    f.channel.author = "Göktuğ Kayaalp"
    f.channel.updated = Time.now.to_s
    f.channel.about = "https://gkayaalp.com/linkblog.xml"
    f.channel.title = "Göktuğ's Link Blog"
    f.channel.description = description

    links[0..9].each do |l|
      f.items.new_item do |i|
        i.link    = l['link']
        i.title   = l['title']
        i.updated = l['time']
        i.summary = pandoc l['comment']
      end
    end
  end

  puts feed.to_s
end

case ARGV[0]
when "add"
  add_link
when "atom"
  generate_feed
when "html"
  generate_page
else
  usage
end
