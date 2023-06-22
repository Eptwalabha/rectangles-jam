class_name Fade
extends CanvasLayer

signal fade_in_ended
signal fade_out_ended

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var cube: Node2D = $Cube

func fade_in() -> void:
	anim.play("fade-in")

func fade_out() -> void:
	anim.play("fade-out")
