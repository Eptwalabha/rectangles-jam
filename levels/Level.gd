class_name Level
extends Node2D


var NPC_CHARACTER = preload("res://scene/characters/npc.tscn")

@onready var fade: Fade = $Fade
@onready var camera: Camera2D = $Camera
@onready var inputs: UIInputs = $WhiteBands/Inputs

@export_file("*.tscn") var next_level : String = ""
@export var free_camera : bool = false
@export var current_camera_mode : Level.CAMERA_MODE = CAMERA_MODE.FOLLOW_PLAYER

enum CAMERA_MODE {
	FOLLOW_PLAYER,
	STATIC,
	FREE
}

var is_level_over : bool = false

func _ready() -> void:
	randomize()
	is_level_over = false
	fade.visible = true
	inputs.position.y = 600
	fade_in()

func fade_in() -> void:
	fade.fade_in()

func fade_in_over() -> void:
	pass

func fade_out_over() -> void:
	if is_level_over:
		get_tree().change_scene_to_file(next_level)

func _on_fade_fade_in_ended() -> void:
	fade_in_over()

func _on_fade_fade_out_ended() -> void:
	fade_out_over()

func go_to_next_level() -> void:
	is_level_over = true
	fade.fade_out()

func show_controls() -> void:
	var t : Tween = get_tree().create_tween()
	t.tween_property(inputs, "position:y", 490, .2)
	inputs.reset()

func hide_controls() -> void:
	var t : Tween = get_tree().create_tween()
	t.tween_property(inputs, "position:y", 600, .2)
	inputs.reset()

func hint_control(controle_name: String) -> void:
	match controle_name:
		"action": inputs.hint_action()
		"directions": inputs.hint_directions()
