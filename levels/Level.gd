class_name Level
extends Node2D

@onready var fade: Fade = $Fade
@onready var camera: Camera2D = $Camera

@export_file("*.tscn") var next_level : String = ""

var is_level_over : bool = false

func _ready() -> void:
	randomize()
	is_level_over = false
	fade.visible = true
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
