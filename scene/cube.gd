@tool
extends Node2D

@export var color : Color = Color(1.0, 1.0, 1.0) : set = _set_color

func _set_color(p_color: Color) -> void:
	$Sprite.modulate = p_color
	color = p_color
