#!/bin/sh

front_app=(
            script="$PLUGIN_DIR/front_app.sh"
            icon=􀆊
            icon.color=$BAR_COLOR
            padding_left=0
            icon.padding_left=0
            label.padding_right=$PADDINGS
            label.color=$BAR_COLOR 
            label.font.style=Bold
            icon.background.image.scale=0.5
)

sketchybar                             \
--add item front_app left              \
     --set front_app "${front_app[@]}" \
     --subscribe front_app front_app_switched
