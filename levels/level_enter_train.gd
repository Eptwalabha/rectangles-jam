class_name LevelEnterTrain
extends Level

@onready var train: Node2D = $Scene/ParallaxBackground/Train/Train
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var player: Player = $Scene/ParallaxBackground/Station/Player
@onready var mouse_interact: Area2D = $Scene/ParallaxBackground/Train/MouseInteract

const LEFT : float = 50.0
const RIGHT : float = 1150.0

var player_on_door : bool = false
var last_door : int = 0

func _ready() -> void:
	super._ready()

func fade_in_over() -> void:
	$Timer.start()

func _on_timer_timeout() -> void:
	last_door += randi() % 2 + 1
	last_door %= 3
	mouse_interact.position.x = 540 + (last_door - 1) * 350
	print("restart ", last_door - 1)
	anim.play("train")

func _process(delta: float) -> void:
	player.position.x = min(RIGHT, max(LEFT, player.position.x))
	camera.position.x = player.position.x
	if Input.is_action_just_pressed("action") and _player_can_interact():
		print("push")

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("action") and _player_can_interact():
		print("push")

func _player_can_interact() -> bool:
	return train.interactible and player_on_door

func spawn_character() -> void:
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.owner is Player:
		player_on_door = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.owner is Player:
		player_on_door = false
