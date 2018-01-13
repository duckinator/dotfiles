#!/usr/bin/env ruby

require 'json'

colors = File.read('data/theme.js').split("\n").grep(/#/).map{|x| x.strip.sub(',', '').split('"')[1..2] }

str = <<EOF
<!DOCTYPE html>
<meta charset="utf-8">
<style>p{margin:0;padding: 0.25em;font: 22pt awoof;}
.ui-draggable-dragging{z-index:100;}
button { margin-top: -0.25em; vertical-align: middle; height: 22pt; }
textarea {
  position: absolute;
  display: block;
  top: 0px;
  bottom: 0px;
  right: 0px;
  width: 10em;
  height: 100%;
}

textarea:hover, textarea:focus {
  width: 50%;
}
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

function dump() {
  var str = [].slice.call(document.querySelectorAll('p')).map(function(p) {
    return ('"' + p.style.backgroundColor + '", // ' + p.innerHTML.split("// ")[1]);
  }).join("\\n  ");

  document.getElementById('colors').value = "[\\n  " + str + "\\n];";
}

setInterval(dump, 100);
</script>
EOF

colors.each_with_index.map {|x, idx|
  str += "<p id='el-#{idx}' style='background-color: #{x[0]};'><button onclick='up(#{idx})'>^</button><button onclick='up(#{idx} + 1)'>v</button> <span id='t-#{idx}'>#{x[0]}</span> #{x[1]}</p>\n"
}

str += "<textarea id='colors'></textarea>"

File.write("theme.html", str.strip)
