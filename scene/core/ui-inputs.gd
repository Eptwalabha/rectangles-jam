class_name UIInputs
extends Node2D

func set_visibility(is_visible: bool) -> void:
	pass

func _process(delta):
	if Input.is_action_pressed("move_left"):
		print("left")
	elif Input.is_action_pressed("move_right"):
		print("right")
	elif Input.is_action_just_pressed("action"):
		print("action")

func _trigger_if_clicked(event: InputEvent, action: String) -> void:
	if event is InputEventMouseButton and event.pressed:
		Input.action_press(action)

func _on_space_area_input_event(_viewport, event, _shape_idx):
	_trigger_if_clicked(event, "action")

func _on_right_area_input_event(viewport, event, shape_idx):
	_trigger_if_clicked(event, "move_right")

func _on_left_area_input_event(viewport, event, shape_idx):
	_trigger_if_clicked(event, "move_left")
