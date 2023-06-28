class_name Door
extends Node2D

signal player_entered
signal player_exited

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.owner is Player:
		emit_signal("player_entered")

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.owner is Player:
		emit_signal("player_exited")
