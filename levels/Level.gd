class_name Level
extends Node2D

@onready var fade: Fade = $Fade
@onready var camera: Camera2D = $Camera

func _ready() -> void:
	fade.visible = true
	fade_in()

func fade_in() -> void:
	fade.fade_in()

func fade_in_over() -> void:
	pass

func fade_out_over() -> void:
	pass

func _on_fade_fade_in_ended() -> void:
	fade_in_over()

func _on_fade_fade_out_ended() -> void:
	fade_out_over()
