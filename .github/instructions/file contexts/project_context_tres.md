# [Doodle Tank] Project Context File: .tres

## res://

**default_bus_layout.tres**
```ini
[gd_resource type="AudioBusLayout" format=3 uid="uid://by1qd6epe24jl"]

[resource]
bus/1/name = &"Music"
bus/1/solo = false
bus/1/mute = false
bus/1/bypass_fx = false
bus/1/volume_db = 0.0
bus/1/send = &"Master"
bus/2/name = &"SFX"
bus/2/solo = false
bus/2/mute = false
bus/2/bypass_fx = false
bus/2/volume_db = 0.0
bus/2/send = &"Master"

```

### resources

#### themes

**expedition.tres**
```ini
[gd_resource type="Theme" format=3 uid="uid://43v1grkhejdu"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_g0sbc"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.823636, 0.744991, 0.659007, 1)
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.662913, 0.549096, 0.478248, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_krvwn"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.662913, 0.549096, 0.478248, 1)
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.466529, 0.360525, 0.333165, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_gfyr3"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.466529, 0.360525, 0.333165, 1)
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.282353, 0.231067, 0.227161, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_tytr8"]
bg_color = Color(0.282353, 0.231067, 0.227161, 1)
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.133364, 0.133364, 0.133364, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_wsakr"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.823636, 0.744991, 0.659007, 1)
border_width_right = 2
border_color = Color(0.662913, 0.549096, 0.478248, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_1ngrn"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.662913, 0.549096, 0.478248, 1)
border_width_right = 2
border_color = Color(0.466529, 0.360525, 0.333165, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_q0g5m"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.466529, 0.360525, 0.333165, 1)
border_width_top = 2
border_width_right = 2
border_color = Color(0.282353, 0.231067, 0.227161, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4

[resource]
Button/styles/hover = SubResource("StyleBoxFlat_g0sbc")
Button/styles/normal = SubResource("StyleBoxFlat_krvwn")
Button/styles/pressed = SubResource("StyleBoxFlat_gfyr3")
Panel/styles/panel = SubResource("StyleBoxFlat_tytr8")
PanelContainer/styles/panel = SubResource("StyleBoxFlat_tytr8")
TabContainer/styles/panel = SubResource("StyleBoxFlat_tytr8")
TabContainer/styles/tab_hovered = SubResource("StyleBoxFlat_wsakr")
TabContainer/styles/tab_selected = SubResource("StyleBoxFlat_1ngrn")
TabContainer/styles/tab_unselected = SubResource("StyleBoxFlat_q0g5m")

```

**gravity.tres**
```ini
[gd_resource type="Theme" format=3 uid="uid://dxbsjua8k2j5p"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_w50h3"]
content_margin_left = 16.0
content_margin_top = 4.0
content_margin_right = 16.0
content_margin_bottom = 4.0
bg_color = Color(0.125911, 0.125911, 0.125911, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.95, 0.95, 0.95, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8
corner_detail = 1

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_6tkof"]
content_margin_left = 16.0
content_margin_top = 4.0
content_margin_right = 16.0
content_margin_bottom = 4.0
bg_color = Color(0, 0, 0, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.95, 0.95, 0.95, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8
corner_detail = 1

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_ftays"]
content_margin_left = 16.0
content_margin_top = 4.0
content_margin_right = 16.0
content_margin_bottom = 4.0
bg_color = Color(0.95, 0.95, 0.95, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.125911, 0.125911, 0.125911, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8
corner_detail = 1

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_sucf2"]
bg_color = Color(0.0619267, 0.0619267, 0.0619266, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4
corner_detail = 1

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_u30hj"]
content_margin_left = 8.0
content_margin_right = 8.0
bg_color = Color(0.125536, 0.125536, 0.125536, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_color = Color(0.945281, 0.945281, 0.945281, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_detail = 1

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_h5y6c"]
content_margin_left = 8.0
content_margin_right = 8.0
bg_color = Color(0.945281, 0.945281, 0.945281, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_color = Color(0.0195315, 0.0195315, 0.0195315, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_detail = 1

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_g0qsc"]
content_margin_left = 8.0
content_margin_right = 8.0
bg_color = Color(0, 0, 0, 0.933333)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_color = Color(0.945281, 0.945281, 0.945281, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_detail = 1

[resource]
Button/colors/font_color = Color(0.95, 0.95, 0.95, 1)
Button/colors/font_focus_color = Color(0.95, 0.95, 0.95, 1)
Button/colors/font_hover_color = Color(0.95, 0.95, 0.95, 1)
Button/colors/font_pressed_color = Color(0.125911, 0.125911, 0.125911, 1)
Button/styles/disabled = null
Button/styles/focus = null
Button/styles/hover = SubResource("StyleBoxFlat_w50h3")
Button/styles/normal = SubResource("StyleBoxFlat_6tkof")
Button/styles/pressed = SubResource("StyleBoxFlat_ftays")
Panel/styles/panel = SubResource("StyleBoxFlat_sucf2")
PanelContainer/styles/panel = SubResource("StyleBoxFlat_sucf2")
TabContainer/colors/font_hovered_color = Color(0.945281, 0.945281, 0.945281, 1)
TabContainer/colors/font_selected_color = Color(0.0195315, 0.0195315, 0.0195315, 1)
TabContainer/colors/font_unselected_color = Color(0.945281, 0.945281, 0.945281, 1)
TabContainer/styles/panel = SubResource("StyleBoxFlat_sucf2")
TabContainer/styles/tab_hovered = SubResource("StyleBoxFlat_u30hj")
TabContainer/styles/tab_selected = SubResource("StyleBoxFlat_h5y6c")
TabContainer/styles/tab_unselected = SubResource("StyleBoxFlat_g0qsc")

```

**grow.tres**
```ini
[gd_resource type="Theme" format=3 uid="uid://bsi26ebew2qbg"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_g0sbc"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.428961, 0.730226, 0.50528, 1)
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.298858, 0.546296, 0.363635, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_krvwn"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.298858, 0.546296, 0.363635, 1)
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.234842, 0.443383, 0.289887, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_gfyr3"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.234842, 0.443383, 0.289887, 1)
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.234842, 0.443383, 0.289887, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_tytr8"]
bg_color = Color(0.191138, 0.370484, 0.238651, 1)
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.115392, 0.241196, 0.148848, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_wsakr"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.428961, 0.730226, 0.50528, 1)
border_width_right = 2
border_color = Color(0.298858, 0.546296, 0.363635, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_1ngrn"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.298858, 0.546296, 0.363635, 1)
border_width_right = 2
border_color = Color(0.234842, 0.443383, 0.289887, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_q0g5m"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.234842, 0.443383, 0.289887, 1)
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.234842, 0.443383, 0.289887, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4

[resource]
Button/styles/hover = SubResource("StyleBoxFlat_g0sbc")
Button/styles/normal = SubResource("StyleBoxFlat_krvwn")
Button/styles/pressed = SubResource("StyleBoxFlat_gfyr3")
Panel/styles/panel = SubResource("StyleBoxFlat_tytr8")
PanelContainer/styles/panel = SubResource("StyleBoxFlat_tytr8")
TabContainer/styles/panel = SubResource("StyleBoxFlat_tytr8")
TabContainer/styles/tab_hovered = SubResource("StyleBoxFlat_wsakr")
TabContainer/styles/tab_selected = SubResource("StyleBoxFlat_1ngrn")
TabContainer/styles/tab_unselected = SubResource("StyleBoxFlat_q0g5m")

```

**lab.tres**
```ini
[gd_resource type="Theme" format=3 uid="uid://daapx07xisuw0"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_4b4gg"]
content_margin_left = 12.0
content_margin_right = 12.0
content_margin_bottom = 14.0
bg_color = Color(0.305882, 0.454902, 0.6, 1)
border_width_left = 4
border_width_top = 4
border_width_right = 4
border_width_bottom = 12
border_color = Color(0.141176, 0.321569, 0.45098, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_l51yu"]
content_margin_left = 12.0
content_margin_right = 12.0
content_margin_bottom = 14.0
bg_color = Color(0.243137, 0.25098, 0.333333, 1)
border_width_left = 4
border_width_top = 4
border_width_right = 4
border_width_bottom = 12
border_color = Color(0.219608, 0.176471, 0.207843, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_e7ejt"]
content_margin_left = 12.0
content_margin_right = 12.0
content_margin_bottom = 14.0
bg_color = Color(0.121569, 0.176471, 0.211765, 1)
border_width_left = 4
border_width_top = 4
border_width_right = 4
border_width_bottom = 12
border_color = Color(0.0784314, 0.121569, 0.145098, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_ywrjj"]
bg_color = Color(0.6, 0.6, 0.6, 0)
border_width_left = 3
border_width_top = 3
border_width_bottom = 3
corner_radius_top_left = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_tyerd"]
bg_color = Color(0.8, 0.8, 0.8, 1)
border_width_left = 2
border_width_top = 3
border_width_bottom = 3
border_color = Color(0.8, 0.8, 0.8, 0)
corner_radius_top_left = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_ulcur"]
content_margin_left = 8.0
content_margin_top = 8.0
content_margin_right = 8.0
content_margin_bottom = 8.0
bg_color = Color(0.0784314, 0.121569, 0.145098, 1)
border_width_left = 4
border_width_top = 4
border_width_right = 4
border_width_bottom = 4
border_color = Color(0.0431373, 0.0627451, 0.0862745, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_aliwb"]
bg_color = Color(0.6, 0.6, 0.6, 0)
border_width_top = 3
border_width_right = 3
border_width_bottom = 3
corner_radius_top_right = 4
corner_radius_bottom_right = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_tnl2j"]
content_margin_bottom = 3.0
bg_color = Color(0.8, 0.8, 0.8, 1)
border_width_top = 3
border_width_right = 3
border_width_bottom = 3
border_color = Color(0.8, 0.8, 0.8, 0)
corner_radius_top_right = 4
corner_radius_bottom_right = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_k5faf"]
bg_color = Color(0.6, 0.6, 0.6, 0)
border_width_left = 3
border_width_top = 3
border_width_right = 3
border_width_bottom = 3
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_5j0a2"]
bg_color = Color(0.8, 0.8, 0.8, 1)

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_odiue"]
content_margin_left = 8.0
content_margin_top = 8.0
content_margin_right = 8.0
content_margin_bottom = 8.0
bg_color = Color(0.0784314, 0.121569, 0.145098, 1)
border_width_left = 4
border_width_top = 4
border_width_right = 4
border_width_bottom = 4
border_color = Color(0.219608, 0.176471, 0.207843, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8
corner_radius_bottom_right = 8
corner_radius_bottom_left = 8

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_ghjya"]
content_margin_left = 12.0
content_margin_right = 12.0
bg_color = Color(0.305882, 0.454902, 0.6, 1)
border_width_left = 4
border_width_top = 4
border_width_right = 4
border_color = Color(0.141176, 0.321569, 0.45098, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_m6y06"]
content_margin_left = 12.0
content_margin_right = 12.0
bg_color = Color(0.243137, 0.25098, 0.333333, 1)
border_width_left = 4
border_width_top = 4
border_width_right = 4
border_color = Color(0.219608, 0.176471, 0.207843, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_5icga"]
content_margin_left = 12.0
content_margin_right = 12.0
bg_color = Color(0.0784314, 0.121569, 0.145098, 1)
border_width_left = 4
border_width_top = 4
border_width_right = 4
border_color = Color(0.121569, 0.176471, 0.211765, 1)
corner_radius_top_left = 8
corner_radius_top_right = 8

[sub_resource type="FontVariation" id="FontVariation_i860b"]
spacing_top = 4
spacing_bottom = 2

[resource]
default_font = SubResource("FontVariation_i860b")
Button/styles/hover = SubResource("StyleBoxFlat_4b4gg")
Button/styles/normal = SubResource("StyleBoxFlat_l51yu")
Button/styles/pressed = SubResource("StyleBoxFlat_e7ejt")
LeftStaminaBar/base_type = &"ProgressBar"
LeftStaminaBar/styles/background = SubResource("StyleBoxFlat_ywrjj")
LeftStaminaBar/styles/fill = SubResource("StyleBoxFlat_tyerd")
Panel/styles/panel = SubResource("StyleBoxFlat_ulcur")
PanelContainer/styles/panel = SubResource("StyleBoxFlat_ulcur")
RightStaminaBar/base_type = &"ProgressBar"
RightStaminaBar/styles/background = SubResource("StyleBoxFlat_aliwb")
RightStaminaBar/styles/fill = SubResource("StyleBoxFlat_tnl2j")
StaminaBar/base_type = &"ProgressBar"
StaminaBar/styles/background = SubResource("StyleBoxFlat_k5faf")
StaminaBar/styles/fill = SubResource("StyleBoxFlat_5j0a2")
TabContainer/styles/panel = SubResource("StyleBoxFlat_odiue")
TabContainer/styles/tab_hovered = SubResource("StyleBoxFlat_ghjya")
TabContainer/styles/tab_selected = SubResource("StyleBoxFlat_m6y06")
TabContainer/styles/tab_unselected = SubResource("StyleBoxFlat_5icga")

```

**lore.tres**
```ini
[gd_resource type="Theme" format=3 uid="uid://dxfvk0p6dc1wv"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_8hxc2"]
content_margin_left = 8.0
content_margin_top = 8.0
content_margin_right = 8.0
content_margin_bottom = 8.0
bg_color = Color(0.631373, 0.52549, 0.619608, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.192157, 0.239216, 0.352941, 1)

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_daw1f"]
content_margin_left = 8.0
content_margin_top = 8.0
content_margin_right = 8.0
content_margin_bottom = 8.0
bg_color = Color(0.00392157, 0.0862745, 0.152941, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.839216, 0.933333, 1, 1)

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_r1yu6"]
content_margin_left = 8.0
content_margin_top = 8.0
content_margin_right = 8.0
content_margin_bottom = 8.0
bg_color = Color(0.00392157, 0.0862745, 0.152941, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.00392157, 0.0862745, 0.152941, 1)

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_wnp2l"]
content_margin_left = 8.0
content_margin_top = 8.0
content_margin_right = 8.0
content_margin_bottom = 8.0
bg_color = Color(0.192157, 0.239216, 0.352941, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.00392157, 0.0862745, 0.152941, 1)

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_2ymfe"]
bg_color = Color(0.00392157, 0.0862745, 0.152941, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.8, 0.8, 0.8, 0)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_pq3iw"]
bg_color = Color(0.00392157, 0.0862745, 0.152941, 1)

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_hvab5"]
bg_color = Color(0.192157, 0.239216, 0.352941, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.00392157, 0.0862745, 0.152941, 1)

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_f05by"]
bg_color = Color(0.192157, 0.239216, 0.352941, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.00392157, 0.0862745, 0.152941, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_t1x62"]
bg_color = Color(0.929412, 0.921569, 0.627451, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.8, 0.8, 0.8, 0)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_w2bse"]
content_margin_left = 8.0
content_margin_top = 8.0
content_margin_right = 8.0
content_margin_bottom = 4.0
bg_color = Color(0.00392157, 0.0862745, 0.152941, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_color = Color(0.839216, 0.933333, 1, 1)

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_7eahf"]
content_margin_left = 8.0
content_margin_top = 8.0
content_margin_right = 8.0
content_margin_bottom = 4.0
bg_color = Color(0.192157, 0.239216, 0.352941, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_color = Color(0.00392157, 0.0862745, 0.152941, 1)

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_5sk2t"]
content_margin_left = 8.0
content_margin_top = 8.0
content_margin_right = 8.0
content_margin_bottom = 4.0
bg_color = Color(0.00392157, 0.0862745, 0.152941, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_color = Color(0.00392157, 0.0862745, 0.152941, 1)

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_00w47"]
bg_color = Color(0.839216, 0.933333, 1, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.8, 0.8, 0.8, 0)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_gh53c"]
bg_color = Color(0.631373, 0.52549, 0.619608, 1)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.8, 0.8, 0.8, 0)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[resource]
Button/colors/font_color = Color(0.839216, 0.933333, 1, 1)
Button/colors/font_disabled_color = Color(0.192157, 0.239216, 0.352941, 1)
Button/colors/font_focus_color = Color(0.839216, 0.933333, 1, 1)
Button/colors/font_hover_color = Color(0.839216, 0.933333, 1, 1)
Button/colors/font_hover_pressed_color = Color(0.839216, 0.933333, 1, 1)
Button/colors/font_pressed_color = Color(0.00392157, 0.0862745, 0.152941, 1)
Button/styles/disabled = SubResource("StyleBoxFlat_8hxc2")
Button/styles/hover = SubResource("StyleBoxFlat_daw1f")
Button/styles/normal = SubResource("StyleBoxFlat_r1yu6")
Button/styles/pressed = SubResource("StyleBoxFlat_wnp2l")
DelayProgressBar/base_type = &"ProgressBar"
DelayProgressBar/styles/fill = SubResource("StyleBoxFlat_2ymfe")
Label/colors/font_color = Color(0.839216, 0.933333, 1, 1)
Label/colors/font_outline_color = Color(0.00392157, 0.0862745, 0.152941, 1)
Label/constants/outline_size = 8
LineEdit/colors/caret_color = Color(0.839216, 0.933333, 1, 1)
LineEdit/colors/font_color = Color(0.929412, 0.921569, 0.627451, 1)
LineEdit/colors/font_uneditable_color = Color(0.192157, 0.239216, 0.352941, 1)
LineEdit/styles/normal = SubResource("StyleBoxFlat_pq3iw")
LineEdit/styles/read_only = SubResource("StyleBoxFlat_pq3iw")
Panel/styles/panel = SubResource("StyleBoxFlat_hvab5")
PanelContainer/styles/panel = SubResource("StyleBoxFlat_hvab5")
ProgressBar/styles/background = SubResource("StyleBoxFlat_f05by")
ProgressBar/styles/fill = SubResource("StyleBoxFlat_t1x62")
RichTextLabel/colors/default_color = Color(0.839216, 0.933333, 1, 1)
RichTextLabel/colors/font_outline_color = Color(0.00392157, 0.0862745, 0.152941, 1)
RichTextLabel/constants/outline_size = 8
TabContainer/styles/panel = SubResource("StyleBoxFlat_hvab5")
TabContainer/styles/tab_hovered = SubResource("StyleBoxFlat_w2bse")
TabContainer/styles/tab_selected = SubResource("StyleBoxFlat_7eahf")
TabContainer/styles/tab_unselected = SubResource("StyleBoxFlat_5sk2t")
TimerProgressBar/base_type = &"ProgressBar"
TimerProgressBar/styles/fill = SubResource("StyleBoxFlat_00w47")
WarningProgressBar/base_type = &"ProgressBar"
WarningProgressBar/styles/fill = SubResource("StyleBoxFlat_gh53c")

```

**steal_this_theme.tres**
```ini
[gd_resource type="Theme" format=3 uid="uid://dwv2f8ajpbwsv"]

[ext_resource type="FontFile" uid="uid://8vko1t8dx5so" path="res://assets/fonts/Xolonium-Regular.ttf" id="1_npx5i"]
[ext_resource type="FontFile" uid="uid://cqcafv8uronk1" path="res://assets/fonts/Custom Fonts/kenney_kenney-fonts/Fonts/Kenney Mini Square.ttf" id="2_nykvh"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_7rtxy"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0, 0, 0, 1)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.698039, 0.133333, 0.203922, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_hofdy"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0, 0, 0, 0)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.235294, 0.231373, 0.431373, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4
expand_margin_left = 2.0
expand_margin_top = 2.0
expand_margin_right = 2.0
expand_margin_bottom = 2.0

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_0ahyh"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0, 0, 0, 1)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.973535, 0.973535, 0.973535, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_83bj2"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.973535, 0.973535, 0.973535, 1)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0, 0, 0, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_bjb6u"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0, 0, 0, 1)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.235294, 0.231373, 0.431373, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_wv8md"]
bg_color = Color(0.698039, 0.133333, 0.203922, 1)

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_s1fdf"]
bg_color = Color(0.973535, 0.973535, 0.973535, 1)
corner_radius_top_left = 2
corner_radius_top_right = 2
corner_radius_bottom_right = 2
corner_radius_bottom_left = 2

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_tieq2"]
bg_color = Color(0, 0, 0, 1)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.973535, 0.973535, 0.973535, 1)
corner_radius_top_left = 2
corner_radius_top_right = 2
corner_radius_bottom_right = 2
corner_radius_bottom_left = 2

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_rrxf3"]
bg_color = Color(0, 0, 0, 1)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.235294, 0.231373, 0.431373, 1)
corner_radius_top_left = 2
corner_radius_top_right = 2
corner_radius_bottom_right = 2
corner_radius_bottom_left = 2

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_2e0dr"]
content_margin_top = 3.0
content_margin_bottom = 3.0
bg_color = Color(0.0392157, 0.0392157, 0.0392157, 1)
corner_radius_top_left = 2
corner_radius_top_right = 2
corner_radius_bottom_right = 2
corner_radius_bottom_left = 2

[sub_resource type="StyleBoxEmpty" id="StyleBoxEmpty_fgisk"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_fgisk"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0, 0, 0, 1)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.973535, 0.973535, 0.973535, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_5e2ta"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.0383972, 0.0383972, 0.0383972, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_7e08u"]
bg_color = Color(0, 0, 0, 1)
border_color = Color(0.973535, 0.973535, 0.973535, 1)
corner_radius_top_left = 2
corner_radius_top_right = 2
corner_radius_bottom_right = 2
corner_radius_bottom_left = 2

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_whago"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.235294, 0.231373, 0.431373, 1)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0, 0, 0, 1)
corner_radius_top_left = 2
corner_radius_top_right = 2
corner_radius_bottom_right = 2
corner_radius_bottom_left = 2

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_d8x3d"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.698039, 0.133333, 0.203922, 1)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0, 0, 0, 1)
corner_radius_top_left = 2
corner_radius_top_right = 2
corner_radius_bottom_right = 2
corner_radius_bottom_left = 2

[sub_resource type="StyleBoxEmpty" id="StyleBoxEmpty_hofdy"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_lmfyq"]
bg_color = Color(0.698039, 0.133333, 0.203922, 1)
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0, 0, 0, 0)
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxEmpty" id="StyleBoxEmpty_wv8md"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_c4ulf"]
bg_color = Color(0, 0, 0, 1)
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0, 0, 0, 0)
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_8723n"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.235294, 0.231373, 0.431373, 1)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0, 0, 0, 1)
corner_radius_top_left = 2
corner_radius_top_right = 2
corner_radius_bottom_right = 2
corner_radius_bottom_left = 2

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_opsya"]
bg_color = Color(0.235294, 0.231373, 0.431373, 1)

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_8g14u"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.0383972, 0.0383972, 0.0383972, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_qnvbk"]
content_margin_left = 8.0
content_margin_top = 4.0
content_margin_right = 8.0
content_margin_bottom = 4.0
bg_color = Color(0, 0, 0, 1)
border_width_top = 2
border_color = Color(0.698039, 0.133333, 0.203922, 1)
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxEmpty" id="StyleBoxEmpty_d8x3d"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_4bfjk"]
content_margin_left = 8.0
content_margin_top = 4.0
content_margin_right = 8.0
content_margin_bottom = 4.0
bg_color = Color(0, 0, 0, 1)
border_width_top = 2
border_color = Color(0.235294, 0.231373, 0.431373, 1)
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_ojvr3"]
content_margin_left = 8.0
content_margin_top = 4.0
content_margin_right = 8.0
content_margin_bottom = 4.0
bg_color = Color(0.0392157, 0.0392157, 0.0392157, 1)
border_width_top = 2
border_color = Color(0.973535, 0.973535, 0.973535, 1)
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_lop2v"]
content_margin_left = 8.0
content_margin_top = 4.0
content_margin_right = 8.0
content_margin_bottom = 4.0
bg_color = Color(0, 0, 0, 1)
border_width_top = 2
border_color = Color(0.0392157, 0.0392157, 0.0392157, 1)
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxEmpty" id="StyleBoxEmpty_0ahyh"]

[sub_resource type="StyleBoxEmpty" id="StyleBoxEmpty_83bj2"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_rr4b1"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0, 0, 0, 0)
border_width_left = 2
border_width_top = 2
border_width_right = 2
border_width_bottom = 2
border_color = Color(0.235294, 0.231373, 0.431373, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4
expand_margin_left = 2.0
expand_margin_top = 2.0
expand_margin_right = 2.0
expand_margin_bottom = 2.0

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_bcw1c"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.0383972, 0.0383972, 0.0383972, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_xi1kj"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0, 0, 0, 1)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.973535, 0.973535, 0.973535, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_rrcvo"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.235294, 0.231373, 0.431373, 1)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.973535, 0.973535, 0.973535, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_wvge0"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.235294, 0.231373, 0.431373, 1)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.973535, 0.973535, 0.973535, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_v0ggg"]
bg_color = Color(0.973535, 0.973535, 0.973535, 1)
corner_radius_top_left = 2
corner_radius_top_right = 2
corner_radius_bottom_right = 2
corner_radius_bottom_left = 2

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_kvvmu"]
bg_color = Color(0, 0, 0, 1)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.973535, 0.973535, 0.973535, 1)
corner_radius_top_left = 2
corner_radius_top_right = 2
corner_radius_bottom_right = 2
corner_radius_bottom_left = 2

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_rum38"]
bg_color = Color(0, 0, 0, 1)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.235294, 0.231373, 0.431373, 1)
corner_radius_top_left = 2
corner_radius_top_right = 2
corner_radius_bottom_right = 2
corner_radius_bottom_left = 2

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_5wbgk"]
content_margin_left = 3.0
content_margin_right = 3.0
bg_color = Color(0.0392157, 0.0392157, 0.0392157, 1)
corner_radius_top_left = 2
corner_radius_top_right = 2
corner_radius_bottom_right = 2
corner_radius_bottom_left = 2

[sub_resource type="StyleBoxEmpty" id="StyleBoxEmpty_s1fdf"]

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_x127s"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0.698039, 0.133333, 0.203922, 1)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0, 0, 0, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_qjhx0"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0, 0, 0, 1)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.698039, 0.133333, 0.203922, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[sub_resource type="StyleBoxFlat" id="StyleBoxFlat_u427p"]
content_margin_left = 4.0
content_margin_top = 4.0
content_margin_right = 4.0
content_margin_bottom = 4.0
bg_color = Color(0, 0, 0, 1)
border_width_left = 1
border_width_top = 1
border_width_right = 1
border_width_bottom = 1
border_color = Color(0.698039, 0.133333, 0.203922, 1)
corner_radius_top_left = 4
corner_radius_top_right = 4
corner_radius_bottom_right = 4
corner_radius_bottom_left = 4

[resource]
default_font = ExtResource("2_nykvh")
BoldLabel/base_type = &"Label"
BoldLabel/fonts/font = ExtResource("1_npx5i")
Button/colors/font_color = Color(0, 0, 0, 1)
Button/colors/font_disabled_color = Color(0.698039, 0.133333, 0.203922, 1)
Button/colors/font_focus_color = Color(0, 0, 0, 1)
Button/colors/font_hover_color = Color(0.973535, 0.973535, 0.973535, 1)
Button/colors/font_hover_pressed_color = Color(0.973535, 0.973535, 0.973535, 1)
Button/colors/font_pressed_color = Color(0.235294, 0.231373, 0.431373, 1)
Button/styles/disabled = SubResource("StyleBoxFlat_7rtxy")
Button/styles/focus = SubResource("StyleBoxFlat_hofdy")
Button/styles/hover = SubResource("StyleBoxFlat_0ahyh")
Button/styles/normal = SubResource("StyleBoxFlat_83bj2")
Button/styles/pressed = SubResource("StyleBoxFlat_bjb6u")
DisabledLabel/base_type = &"Label"
DisabledLabel/colors/font_color = Color(0, 0, 0, 1)
DisabledLabel/font_sizes/font_size = 24
DisabledLabel/fonts/font = ExtResource("1_npx5i")
DisabledLabel/styles/normal = SubResource("StyleBoxFlat_wv8md")
HScrollBar/styles/grabber = SubResource("StyleBoxFlat_s1fdf")
HScrollBar/styles/grabber_highlight = SubResource("StyleBoxFlat_tieq2")
HScrollBar/styles/grabber_pressed = SubResource("StyleBoxFlat_rrxf3")
HScrollBar/styles/scroll = SubResource("StyleBoxFlat_2e0dr")
HScrollBar/styles/scroll_focus = SubResource("StyleBoxEmpty_fgisk")
LocationName/base_type = &"Label"
LocationName/colors/font_color = Color(0.973535, 0.973535, 0.973535, 1)
LocationName/font_sizes/font_size = 22
LocationName/fonts/font = ExtResource("1_npx5i")
LocationType/base_type = &"Label"
LocationType/colors/font_color = Color(0.235294, 0.231373, 0.431373, 1)
LocationType/fonts/font = ExtResource("1_npx5i")
Panel/styles/panel = SubResource("StyleBoxFlat_fgisk")
PanelContainer/styles/panel = SubResource("StyleBoxFlat_5e2ta")
ProgressBar/styles/background = SubResource("StyleBoxFlat_7e08u")
ProgressBar/styles/fill = SubResource("StyleBoxFlat_whago")
ProgressBarBad/base_type = &"ProgressBar"
ProgressBarBad/styles/fill = SubResource("StyleBoxFlat_d8x3d")
ProgressBarDelay/base_type = &"ProgressBar"
ProgressBarDelay/styles/background = SubResource("StyleBoxEmpty_hofdy")
ProgressBarDelay/styles/fill = SubResource("StyleBoxFlat_lmfyq")
ProgressBarDelayHovered/base_type = &"ProgressBar"
ProgressBarDelayHovered/styles/background = SubResource("StyleBoxEmpty_wv8md")
ProgressBarDelayHovered/styles/fill = SubResource("StyleBoxFlat_c4ulf")
ProgressBarGood/base_type = &"ProgressBar"
ProgressBarGood/styles/fill = SubResource("StyleBoxFlat_8723n")
RichTextLabel/fonts/bold_font = ExtResource("1_npx5i")
RichTextLabel/fonts/bold_italics_font = ExtResource("1_npx5i")
RichTextLabel/fonts/italics_font = ExtResource("1_npx5i")
SelectedLabel/base_type = &"Label"
SelectedLabel/colors/font_color = Color(0.973535, 0.973535, 0.973535, 1)
SelectedLabel/font_sizes/font_size = 24
SelectedLabel/fonts/font = ExtResource("1_npx5i")
SelectedLabel/styles/normal = SubResource("StyleBoxFlat_opsya")
TabContainer/colors/font_disabled_color = Color(0.698039, 0.133333, 0.203922, 1)
TabContainer/colors/font_hovered_color = Color(0.235294, 0.231373, 0.431373, 1)
TabContainer/colors/font_selected_color = Color(0.973535, 0.973535, 0.973535, 1)
TabContainer/colors/font_unselected_color = Color(0.973535, 0.973535, 0.973535, 1)
TabContainer/styles/panel = SubResource("StyleBoxFlat_8g14u")
TabContainer/styles/tab_disabled = SubResource("StyleBoxFlat_qnvbk")
TabContainer/styles/tab_focus = SubResource("StyleBoxEmpty_d8x3d")
TabContainer/styles/tab_hovered = SubResource("StyleBoxFlat_4bfjk")
TabContainer/styles/tab_selected = SubResource("StyleBoxFlat_ojvr3")
TabContainer/styles/tab_unselected = SubResource("StyleBoxFlat_lop2v")
Tree/colors/children_hl_line_color = Color(0.0392157, 0.0392157, 0.0392157, 1)
Tree/colors/font_color = Color(0.973535, 0.973535, 0.973535, 1)
Tree/colors/font_disabled_color = Color(0.698039, 0.133333, 0.203922, 1)
Tree/colors/font_hovered_color = Color(0.235294, 0.231373, 0.431373, 1)
Tree/colors/font_selected_color = Color(0.973535, 0.973535, 0.973535, 1)
Tree/colors/guide_color = Color(0, 0, 0, 0)
Tree/colors/parent_hl_line_color = Color(0.0392157, 0.0392157, 0.0392157, 1)
Tree/colors/relationship_line_color = Color(0.0392157, 0.0392157, 0.0392157, 1)
Tree/constants/inner_item_margin_left = 4
Tree/constants/inner_item_margin_right = 4
Tree/constants/item_margin = 0
Tree/styles/button_hover = SubResource("StyleBoxEmpty_0ahyh")
Tree/styles/button_pressed = SubResource("StyleBoxEmpty_83bj2")
Tree/styles/focus = SubResource("StyleBoxFlat_rr4b1")
Tree/styles/hovered = SubResource("StyleBoxFlat_bcw1c")
Tree/styles/panel = SubResource("StyleBoxFlat_xi1kj")
Tree/styles/selected = SubResource("StyleBoxFlat_rrcvo")
Tree/styles/selected_focus = SubResource("StyleBoxFlat_wvge0")
VScrollBar/styles/grabber = SubResource("StyleBoxFlat_v0ggg")
VScrollBar/styles/grabber_highlight = SubResource("StyleBoxFlat_kvvmu")
VScrollBar/styles/grabber_pressed = SubResource("StyleBoxFlat_rum38")
VScrollBar/styles/scroll = SubResource("StyleBoxFlat_5wbgk")
VScrollBar/styles/scroll_focus = SubResource("StyleBoxEmpty_s1fdf")
WaitingButton/base_type = &"Button"
WaitingButton/colors/font_color = Color(0.698039, 0.133333, 0.203922, 1)
WaitingButton/colors/font_focus_color = Color(0.698039, 0.133333, 0.203922, 1)
WaitingButton/colors/font_hover_color = Color(0, 0, 0, 1)
WaitingButton/colors/font_hover_pressed_color = Color(0.698039, 0.133333, 0.203922, 1)
WaitingButton/colors/font_pressed_color = Color(0.698039, 0.133333, 0.203922, 1)
WaitingButton/styles/hover = SubResource("StyleBoxFlat_x127s")
WaitingButton/styles/normal = SubResource("StyleBoxFlat_qjhx0")
WaitingButton/styles/pressed = SubResource("StyleBoxFlat_u427p")

```

