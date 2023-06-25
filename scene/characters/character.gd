@tool
class_name Character
extends Node2D

signal vanished
signal appeared

@export var color : Color = Color.WHITE : set = _set_color
@export var size : float = 1.0
@export var moving: bool = false
@export var speed : float = 250.0
@onready var anim: AnimationPlayer = $AnimationPlayer

@onready var pivot: Node2D = $Pivot

func _ready() -> void:
	pivot.scale *= size

func _set_color(p_color: Color) -> void:
	modulate = p_color
	color = p_color

func vanish() -> void:
	anim.play("vanish")

func appear() -> void:
	anim.play("appear")

func randomize_character() -> void:
	randomize_size()
	modulate.v = .5 + randf() * .5
	randomize_speed(100)

func randomize_size() -> void:
	size = 0.8 + randf() * .4

func randomize_speed(p_min: int) -> void:
	speed = p_min + randi() % (200 - p_min)

func _process(delta: float) -> void:
	if moving:
		position.x += speed * delta
