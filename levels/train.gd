class_name Train
extends Node2D

@export var interactible : bool = false
@onready var anim: AnimationPlayer = $AnimationPlayer

func open_doors() -> void:
	anim.play("open doors")
	
func close_doors() -> void:
	anim.play("close doors")

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if not interactible:
		return
	if event is InputEventMouseButton and event.is_pressed():
		print("click")
