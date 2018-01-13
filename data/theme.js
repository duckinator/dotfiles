var theme = {
  "name": "pupterm",
  "author": "Ellen Dash <me@duckie.co>",
  "color": [
    "#000000", // vim — ?
    "#ff5555", // vim — ?
    "#aa5500", // vim — ?
    "#aa00aa", // vim — constants.
    "#eee000", // vim — ?
    "#00aaaa", // vim — keywords.
    "#7d7dbc", // vim — preprocessor.
    "#00aa00", // vim — types.
    "#222222", // vim — background.
    "#333333", // vim — background for current line, modeline, line length vertical bar.
    "#cccccc", // vim — comments, line numbers.
    "#ffff55", // vim — current line number.
    "#a2a2ff", // vim — modeline text.
    "#ff55ff", // vim — ?
    "#fbbfff", // vim — default text color.
    "#55ffff", // vim — ?
  ],
};

var colors = {};

for(var i = 0; i <= 7; i++) {
  colors["accent" + i] = theme.color[i];
  colors["shade" + i]  = theme.color[8 + i];
}

exports.colors = { dark: colors };
exports.theme = theme;
