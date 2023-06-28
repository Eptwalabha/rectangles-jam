extends Node

signal space_displayed
signal space_hidden

func display_space() -> void:
	emit_signal("space_displayed")

func hide_space() -> void:
	emit_signal("space_hidden")
