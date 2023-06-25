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

func randomize() -> void:
	size = 0.8 + randf() * .4
	modulate.v = .5 + randf() * .5
	speed = 0.6 + randf() * .6

func _process(delta: float) -> void:
	if moving:
		position.x += speed * delta
