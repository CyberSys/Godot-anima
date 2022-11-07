tool
extends Button

var PROPERTIES_TO_COPY = ["rect_size", "rect_min_size", "button_label", "button_icon", "align", "clip_text", "icon_align", "expand_icon", "__meta__", "modulate"]

enum STATE {
	NORMAL,
	PRESSED
	HOVERED,
	DISABLED,
	DRAW_HOVER_PRESSED,
}

enum STYLE {
	PRIMARY,
	SECONDARY,
	REMOVE
}

export (STYLE) var style = STYLE.PRIMARY setget set_button_style
export (Texture) var button_icon setget set_button_icon
export (String) var button_label setget set_button_label
export (float, 0.0, 1.0) var default_opacity := 1.0 setget set_default_opacity
export (bool) var zoom_on_hover := true

const COLORS := {
	STYLE.PRIMARY: "#05445E",
	STYLE.SECONDARY: "#374140",
	STYLE.REMOVE: "#450003",
}

var _button_bg: Color = COLORS[0] setget _set_button_bg
var _old_draw_mode
var _force_default_zoom := true

func _ready():
	$Inner.rect_min_size = rect_min_size
	$Inner.rect_size = rect_size

	_refresh_button(get_draw_mode())
	icon = null

func _draw():
	draw_rect(Rect2(Vector2.ZERO, rect_size), _button_bg, true)

	if not flat:
		draw_rect(Rect2(Vector2.ZERO, rect_size), _button_bg.lightened(0.3), false, 1.0)

func _input(_event):
	var draw_mode = get_draw_mode()

	_refresh_button(draw_mode)

	_old_draw_mode = draw_mode

func _refresh_button(draw_mode: int) -> void:
	if draw_mode != _old_draw_mode:

		var color: Color = COLORS[style]
		var final_color = color
		var final_opacity := default_opacity
		var final_zoom := 1.0

		if draw_mode == STATE.HOVERED:
			final_color = color.lightened(0.1)
			final_opacity = 1.0
			final_zoom = 1.1
		elif draw_mode == STATE.PRESSED:
			final_color = color.darkened(0.2)
			final_opacity = 1.0
			final_zoom = 1.1

		if not zoom_on_hover:
			final_zoom = 1.0

		Anima.begin_single_shot(self) \
			.with(
				Anima.Node(self).anima_animation_frames({
					to = {
						_button_bg = final_color,
						opacity = final_opacity,
						scale = Vector2.ONE * final_zoom,
						easing = ANIMA.EASING.EASE_IN_OUT_BACK
					}
				}, 0.15)
			) \
			.play()

func _set(property, value):
	if PROPERTIES_TO_COPY.find(property) >= 0:
		$Inner.set(property, value)

		if property.begins_with("button_"):
			var inner_property = property.replace("button_", "")
			$Inner[inner_property] = value

func set_button_style(new_style: int) -> void:
	style = new_style
	
	_set_button_bg(COLORS[new_style])

	update()

func _set_button_bg(new_bg: Color) -> void:
	_button_bg = new_bg

	update()

func _on_Button_button_down():
	_refresh_button(get_draw_mode())

func _on_Button_button_up():
	_refresh_button(get_draw_mode())

func set_text(new_text: String) -> void:
	text = new_text

	$Inner.set_text(new_text)

func set_default_opacity(new_opacity: float) -> void:
	default_opacity = new_opacity

	modulate.a = default_opacity

func set_button_icon(texture: Texture) -> void:
	button_icon = texture

	$Inner.icon = button_icon

func set_button_label(label: String) -> void:
	button_label = label

	$Inner.text = button_label