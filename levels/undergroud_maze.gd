class_name UndergroundMaze
extends Level

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var player: Player = $Scene/ParallaxBackground/ParallaxLayer/Player
@onready var doors_container: Node2D = $Scene/ParallaxBackground/ParallaxLayer/Doors
@onready var doors : Array[Door] = [
	$Scene/ParallaxBackground/ParallaxLayer/Doors/Door1,
	$Scene/ParallaxBackground/ParallaxLayer/Doors/Door2,
	$Scene/ParallaxBackground/ParallaxLayer/Doors/Door3,
	$Scene/ParallaxBackground/ParallaxLayer/Doors/Door4,
	$Scene/ParallaxBackground/ParallaxLayer/Doors/Door5,
	$Scene/ParallaxBackground/ParallaxLayer/Doors/Door6,
	$Scene/ParallaxBackground/ParallaxLayer/Doors/Door7,
	$Scene/ParallaxBackground/ParallaxLayer/Doors/Door8,
	$Scene/ParallaxBackground/ParallaxLayer/Doors/Door9,
	$Scene/ParallaxBackground/ParallaxLayer/Doors/Door10
]

var player_in_transition : bool = false

func _ready() -> void:
	super._ready()
	for door in doors_container.get_children():
		if door is Door:
			door.player_entered.connect(_player_enter_door.bind(door))

func _process(_delta: float) -> void:
	if player.moving:
		player.position.x = min(1000, max(50, player.position.x))

func fade_in_over() -> void:
	anim.play("player intro")

func move_player_to_door(door_num: int) -> void:
	player.moving = false
	player_in_transition = true
	var door = doors[door_num]
	player.vanished.connect(func():
		player.position = door.position
		player.appear(),
		CONNECT_ONE_SHOT)
	player.appeared.connect(func():
		player.moving = true
		player_in_transition = false
		CONNECT_ONE_SHOT)
	player.vanish()

func _player_enter_door(door: Door) -> void:
	if door.name == "Door10":
		anim.play("player outro")
	elif player_in_transition:
		return
	else:
		move_player_to_door(get_next_door(door))

func get_next_door(door: Door) -> int:
	match door.name:
		"Door1": return 6
		"Door2": return 7
		"Door3": return 5
		"Door4": return 8
		"Door5": return 9
		"Door6": return 2
		"Door7": return 0
		"Door8": return 1
		"Door9": return 3
	return 8
