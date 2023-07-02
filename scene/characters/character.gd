@tool
class_name Character
extends Node2D

signal vanished
signal appeared

@export var color : Color = Color.WHITE
@export var size : float = 1.0
@export var moving: bool = false
@export var speed : float = 250.0

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var pivot: Node2D = $Pivot
@onready var body: Node2D = $Pivot/Body
@onready var head: Node2D = $Pivot/Head

func _ready() -> void:
	pivot.scale *= size
	set_color(color)

func set_color(p_color: Color) -> void:
	color = p_color
	body.modulate = color
	head.modulate = color

func vanish() -> void:
	anim.play("vanish")

func appear() -> void:
	anim.play("appear")

func surprised() -> void:
	anim.play("surprise")

func randomize_character() -> void:
	randomize_size()
	modulate.v = .6 + randf() * .4
	randomize_speed(100)

func randomize_size() -> void:
	size = 0.8 + randf() * .4
	pivot.scale = Vector2(size, size)

func randomize_speed(p_min: int) -> void:
	speed = p_min + randi() % (200 - p_min)

func _process(delta: float) -> void:
	if moving:
		position.x += speed * delta
