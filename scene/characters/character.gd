@tool
class_name Character
extends Node2D

@export var color : Color = Color.WHITE : set = _set_color
@export var size : float = 1.0
@export var moving: bool = false
@export var speed : float = 250.0

@onready var pivot: Node2D = $Pivot

func _ready() -> void:
	pivot.scale *= size

func _set_color(p_color: Color) -> void:
	modulate = p_color
	color = p_color

func _process(delta: float) -> void:
	if moving:
		position.x += speed * delta
