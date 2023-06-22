class_name LevelEnterTrain
extends Level

@onready var train: Node2D = $Scene/Train/Train
@onready var anim: AnimationPlayer = $AnimationPlayer


func _on_timer_timeout() -> void:
	anim.play("train")
