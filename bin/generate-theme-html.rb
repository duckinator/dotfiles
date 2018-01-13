#!/usr/bin/env ruby

require 'json'

colors = File.read('data/theme.js').split("\n").grep(/#/).map{|x| x.strip.split('"')[1..2] }

str = <<EOF
<!DOCTYPE html>
<style>p{margin:0;padding: 0.25em;font: 22pt awoof;}
.ui-draggable-dragging{z-index:100;}
button { margin-top: -0.25em; vertical-align: middle; height: 22pt; }
</style>
<script>
var colors = #{colors.map(&:first).to_json};
function up(idx) {
  var a = document.getElementById('el-' + idx);
  var b = document.getElementById('el-' + (idx - 1));
  var aT = document.getElementById('t-' + idx);
  var bT = document.getElementById('t-' + (idx - 1));

  var aBg = a.style.backgroundColor;
  var bBg = b.style.backgroundColor;
  var aH = aT.innerHTML;
  var bH = bT.innerHTML;

  a.style.backgroundColor = bBg;
  b.style.backgroundColor = aBg;
  aT.innerHTML = bH;
  bT.innerHTML = aH;
}
</script>
EOF

colors.each_with_index.map {|x, idx|
  str += "<p id='el-#{idx}' style='background-color: #{x[0]};'><button onclick='up(#{idx})'>^</button><button onclick='up(#{idx} + 1)'>v</button> <span id='t-#{idx}'>#{x[0]} #{x[1]}</span></p>\n"
}

File.write("theme.html", str.strip)
