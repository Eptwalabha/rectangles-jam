class_name LastScene
extends Level

@onready var doors: Node2D = $Scene/doors
@export var scene : SCENE = SCENE.EXIT_TRAIN
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var prison: Node2D = $Scene/prison
@onready var player_prison: Node2D = $Scene/prison/PlayerPrison
@onready var exit_train: Node2D = $Scene/exitTrain
@onready var steal_handbag: Node2D = $Scene/steal_handbag

enum SCENE {
	EXIT_TRAIN,
	STEAL_HANDBAG,
	HIT_DOORS,
	END_IN_PRISON
}
var flag : bool = false

func _ready() -> void:
	super._ready()
	play_next_scene()

func play_next_scene() -> void:
	match scene:
		SCENE.EXIT_TRAIN:
			camera.position = exit_train.position
			anim.play("exit train")
		SCENE.STEAL_HANDBAG:
			camera.position = steal_handbag.position
			anim.play("steal handbag")
		SCENE.HIT_DOORS:
			camera.position = doors.position
			anim.play("hit doors")
		SCENE.END_IN_PRISON:
			camera.position = prison.position

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action") and scene == SCENE.END_IN_PRISON:
		if not flag:
			flag = true
			go_to_next_level()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"exit train":
			scene = SCENE.STEAL_HANDBAG
		"steal handbag":
			scene = SCENE.HIT_DOORS
		"hit doors":
			scene = SCENE.END_IN_PRISON
	play_next_scene()
