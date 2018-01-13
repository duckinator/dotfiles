var theme = {
  "name": "pupterm",
  "author": "Ellen Dash <me@duckie.co>",
  "color": [
    "#000000", // rgb(  0,   0,   0)
    "#00aa00", // rgb(  0, 170,   0)
    "#aa5500", // rgb(170,  85,   0)
    "#3c3c75", // rgb( 60,  60, 117)
    "#aa00aa", // rgb(170,   0, 170)
    "#00aaaa", // rgb(  0, 170, 170)
    "#ee0e00", // rgb(238,  14,   0)
    "#cccccc", // rgb(204, 204, 204)

    "#222222", // background
//    "#55ff55", // rgb( 85, 255,  85)
    
    "#333333", // vim — background for current line, modeline, line length vertical bar.

    // ???
    "#ff5555", // rgb(255,  85,  85)
    "#ffff55", // rgb(255, 255,  85)
    "#a2a2ff", // rgb(162, 162, 255)
    "#ff55ff", // rgb(255,  85, 255)
    "#55ffff", // rgb( 85, 255, 255)
    "#ffffff", // foreground?
  ],
};

var colors = {};

for(var i = 0; i <= 7; i++) {
  colors["accent" + i] = theme.color[i];
  colors["shade" + i]  = theme.color[8 + i];
}

exports.colors = {dark: colors};
exports.theme = theme;
