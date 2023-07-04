class_name KeyboardKey
extends Node2D

@export_color_no_alpha var hint_color : Color = Color.CADET_BLUE
@export var current_action: TYPE = TYPE.LEFT
@export var size: int = 4

@onready var key: Node2D = $Key
@onready var top: Node2D = $Key/Top
@onready var border: Node2D = $Key/Border
@onready var background: Node2D = $Background
@onready var collision_shape: CollisionShape2D = $ClickArea/CollisionShape2D

var my_action: String = "move_left"

enum TYPE {
	LEFT,
	RIGHT,
	ACTION
}

func _ready() -> void:
	_set_size()
	my_action = _get_action()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed(my_action):
		pressed(true)
	elif Input.is_action_just_released(my_action):
		pressed(false)

func pressed(is_pressed: bool) -> void:
	var t : Tween = get_tree().create_tween()
	if is_pressed:
		t.tween_property(background, "modulate", Color.WHITE, .2)
		top.position.y = -8
	else:
		t.tween_property(top, "position:y", -15, .1)

func hint() -> void:
	var t : Tween = get_tree().create_tween()
	t.tween_property(background, "modulate", hint_color, .2)

func _on_click_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			Input.action_press(my_action)
		else:
			Input.action_release(my_action)

func _get_action() -> String:
	match current_action:
		TYPE.LEFT: return "move_left"
		TYPE.RIGHT: return "move_right"
		_: return "action"

func _set_size() -> void:
	background.scale.x = size + 1
	border.scale.x = size
	top.scale.x = size
	collision_shape.shape.size.x = size * 10
