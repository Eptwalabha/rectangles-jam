class_name Train
extends Node2D

@export var interactible : bool = false
@onready var anim: AnimationPlayer = $AnimationPlayer

func open_doors() -> void:
	anim.play("open doors")
	
func close_doors() -> void:
	anim.play("close doors")

