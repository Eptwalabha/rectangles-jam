class_name LevelEnterTrain
extends Level

@onready var train: Train = $Scene/ParallaxBackground/Train/Train
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var player: Player = $Scene/ParallaxBackground/Station/Player
@onready var mouse_interact: Area2D = $Scene/ParallaxBackground/Train/MouseInteract
@onready var npc_0: Node2D = $Scene/ParallaxBackground/Train/npc0
@onready var npc_1: Node2D = $Scene/ParallaxBackground/Station/npc1
@onready var npc_2: Node2D = $Scene/ParallaxBackground/Foreground/npc2
@onready var spawner: Timer = $Spawner


const LEFT : int = 50
const RIGHT : int = 1150

var player_on_door : bool = false
var current_door : int = 0


func _ready() -> void:
	super._ready()
	player.moving = false
	init_level()

func _door_position(door_number: int) -> int:
	return 600 + (door_number - 1) * 350

func open_train_doors() -> void:
	train.open_doors()
	for npc in npc_1.get_children():
		if npc is NPC:
			npc.move_to(_door_position(current_door) + randi() % 70 - 35)
	spawner.start()

func close_train_doors() -> void:
	train.close_doors()
	for npc in npc_1.get_children():
		if npc is NPC:
			npc.random_move_from_to(LEFT, RIGHT)
	spawner.stop()

func init_level() -> void:
	for i in range(15):
		var npc : NPC = NPC_CHARACTER.instantiate()
		npc.randomize_character()
		npc_1.add_child(npc)
		npc.target_reached.connect(func (): _respawn_npc(npc))
		npc.global_position.x = LEFT + randi() % (RIGHT - LEFT)
		npc.random_move_from_to(LEFT, RIGHT)
	for i in range(5):
		var npc : NPC = NPC_CHARACTER.instantiate()
		npc.randomize_character()
		npc_2.add_child(npc)
		npc.global_position.x = LEFT + randi() % (RIGHT - LEFT)
		npc.random_move_from_to(LEFT, RIGHT)

func fade_in_over() -> void:
	anim.play("player intro")
	$Timer.start()

func _on_timer_timeout() -> void:
	current_door += randi() % 2 + 1
	current_door %= 3
	mouse_interact.position.x = _door_position(current_door)
	anim.play("train")

func _process(_delta: float) -> void:
	if not player.moving:
		return
	player.position.x = min(RIGHT, max(LEFT, player.position.x))
	camera.position.x = player.position.x
	if Input.is_action_just_pressed("action") and _player_can_interact():
		go_to_next_level()

func _player_can_interact() -> bool:
	return train.interactible and player_on_door

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.owner is Player:
		player_on_door = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.owner is Player:
		player_on_door = false

func _respawn_npc(npc: NPC) -> void:
	npc.vanish()
	npc.vanished.connect(func ():
		npc.position.x = -50 if randf() < .5 else RIGHT + 150
		npc.modulate.a = 1.0
		npc.randomize_size()
		npc.randomize_speed(180)
		npc.random_move_from_to(LEFT, RIGHT),
		CONNECT_ONE_SHOT)

func _on_spawner_timeout() -> void:
	var npc : NPC = NPC_CHARACTER.instantiate()
	npc.randomize_character()
	npc.color = Color.RED
	npc_0.add_child(npc)
	npc.position.x = _door_position((current_door + randi() % 2 + 1) % 3) + randi() % 70 - 35
	npc.appear()
	npc.appeared.connect(func ():
		npc.move_to(-50 if randf() > .5 else RIGHT + 100),
		CONNECT_ONE_SHOT)
	npc.target_reached.connect(func ():
		npc.queue_free())
