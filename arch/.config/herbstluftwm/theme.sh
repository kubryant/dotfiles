# get color from ~/.Xresources
get_x_color() {
    xresources=$(cat ~/.Xresources)
    color=$(echo $xresources | sed "s/.*\*color$1: \(#[0-9A-Fa-f]*\).*/\1/")
    echo $color
}

# Add alpha channel to a hexadecimal color
add_alpha_channel() {
    echo "$1" | \
    sed "s/.*#\([0-9a-fA-F]*\).*/#ff\1/"
}

# Padding
bar_x_p=0;
bar_y_p=0
window_p=10

# Panel
panel_h=40
font="DejaVu Sans Mono:style=Book"
font_sec=""

# Colors
color_bg=$(get_x_color 0)
color_fg=$(get_x_color 15)
color_accent=$(get_x_color 5)
color_empty=$(get_x_color 16)

# Alpha Colors for use with bar
acolor_fg=$(add_alpha_channel $color_fg)
acolor_accent=$(add_alpha_channel $color_accent)
acolor_bg=$(add_alpha_channel $color_bg)
acolor_empty=$(add_alpha_channel $color_empty)
