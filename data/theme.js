var theme = {
  "name": "pupterm",
  "author": "Ellen Dash <me@duckie.co>",
  "color": [
    "#000000", // 
    "#00aa00", // 
    "#aa5500", // 
    "#3c3c75", // vim — constants.
    "#aa00aa", // 
    "#00aaaa", // vim — keywords.
    "#ee0e00", // 
    "#cccccc", // 

    "#222222", // vim — background.

    "#333333", // vim — background for current line, modeline, line length vertical bar.
    "#ff5555", // vim — comments, line numbers.
    "#ffff55", // vim — current line number.
    "#a2a2ff", // vim — modeline text.
    "#ff55ff", // 
    "#55ffff", // vim — default text color?
    "#ffffff", // 
  ],
};

var colors = {};

for(var i = 0; i <= 7; i++) {
  colors["accent" + i] = theme.color[i];
  colors["shade" + i]  = theme.color[8 + i];
}

exports.colors = { dark: colors };
exports.theme = theme;
