#!/bin/bash

echo "<!DOCTYPE html>" > theme.html
echo "<style>p{margin:0;font: 22pt awoof;}</style>" >> theme.html
grep '#' data/theme.js | sed 's/ \+\(.*\): "\(.*\)",/<p style="background-color: \2;">\1 \2<\/p>/' >> theme.html
