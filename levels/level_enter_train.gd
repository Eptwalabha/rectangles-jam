class_name LevelEnterTrain
extends Level

@onready var train: Node2D = $Scene/ParallaxBackground/Train/Train
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var player: Player = $Scene/ParallaxBackground/Station/Player
@onready var mouse_interact: Area2D = $Scene/ParallaxBackground/Train/MouseInteract
@onready var npc_1: Node2D = $Scene/ParallaxBackground/Station/npc1
@onready var npc_2: Node2D = $Scene/ParallaxBackground/Foreground/npc2

var NPC = preload("res://scene/characters/npc.tscn")

const LEFT : int = 50.0
const RIGHT : int = 1150.0

var player_on_door : bool = false
var last_door : int = 0

func _ready() -> void:
	super._ready()
	player.moving = false
	init_level()

func init_level() -> void:
	for i in range(5):
		var npc : NPC = NPC.instantiate()
		npc.randomize()
		npc_1.add_child(npc)
		npc.global_position.x = LEFT + randi() % (RIGHT - LEFT)
	for i in range(5):
		var npc : NPC = NPC.instantiate()
		npc.randomize()
		npc_2.add_child(npc)
		npc.global_position.x = LEFT + randi() % (RIGHT - LEFT)

func fade_in_over() -> void:
	anim.play("player intro")
	$Timer.start()

func _on_timer_timeout() -> void:
	last_door += randi() % 2 + 1
	last_door %= 3
	mouse_interact.position.x = 540 + (last_door - 1) * 350
	anim.play("train")

func _process(delta: float) -> void:
	if not player.moving:
		return
	player.position.x = min(RIGHT, max(LEFT, player.position.x))
	camera.position.x = player.position.x
	if Input.is_action_just_pressed("action") and _player_can_interact():
		go_to_next_level()

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
