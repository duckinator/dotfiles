#!/usr/bin/env ruby

to_html = -> (x) { "<p style='background-color: #{x[0]};'>#{x[1]}</p>" }

doctype = "<!doctype html>"
css = "<style>p{margin: 0;padding: 0.25em;font: 20pt Monospace;}</style>"
colors =
  File.read('data/color-scheme.txt') \
    .split("\n")    \
    .grep(/#/)      \
    .map(&:split)   \
    .map(&to_html)  \
    .join("\n")

File.write("theme.html", "<!doctype html>\n#{css}\n#{colors}")
