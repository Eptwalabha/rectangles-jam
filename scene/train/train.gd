class_name Train
extends Node2D

@export var interactible : bool = false
@onready var anim: AnimationPlayer = $AnimationPlayer

func open_doors() -> void:
	anim.play("open doors")

func close_doors() -> void:
	anim.play("close doors")

func get_door_position(door: int) -> int:
	match door:
		0: return $Door1.global_position.x
		1: return $Door2.global_position.x
		2: return $Door3.global_position.x
	return 0
