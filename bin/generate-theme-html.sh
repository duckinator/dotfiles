#!/bin/bash

echo "<!DOCTYPE html>" > theme.html; echo "<style>p{margin:0;}</style>" >> theme.html; cat data/theme.js | grep '#' | cut -d '"' -f 2 | sed 's/\(.*\)/<p style="background-color: \1;">\1<\/p>/' >> theme.html
