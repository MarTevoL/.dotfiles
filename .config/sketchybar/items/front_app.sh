#!/bin/sh

front_app=(
            script="$PLUGIN_DIR/front_app.sh"
            icon=􀆊
            icon.color=$HIGHLIGHT
            padding_left=0
            icon.padding_left=0
            label.padding_right=$PADDINGS
            label.padding_left=$PADDINGS
            label.color=$HIGHLIGHT 
            label.font.style=Bold
            label.font.size=14
            label.background.drawing=true
            label.background.color=$BAR_COLOR
            label.background.height=28
            label.background.corner_radius=8
            icon.background.image.scale=0.5
)

sketchybar                             \
--add item front_app left              \
     --set front_app "${front_app[@]}" \
     --subscribe front_app front_app_switched
