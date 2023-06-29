class_name LevelIntro
extends Level

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var player: Player = $Scene/ParallaxBackground/Foreground/Player
@onready var victim: Victim = $Scene/ParallaxBackground/Foreground/Victim
@onready var cut_scene_1: Area2D = $Scene/ParallaxBackground/Foreground/CutScene1
@onready var cut_scene_2: Area2D = $Scene/ParallaxBackground/Foreground/CutScene2
@onready var door_1: Node2D = $Scene/ParallaxBackground/Foreground/Doors/Door1
@onready var npc_bucket_1: Node2D = $Scene/ParallaxBackground/Foreground/npc
@onready var npc_bucket_2: Node2D = $Scene/ParallaxBackground/Background2/npc0

func _ready() -> void:
	super._ready()
	for i in range(10):
		var npc : NPC = NPC_CHARACTER.instantiate()
		npc.randomize_character()
		npc_bucket_1.add_child(npc)
		npc.position.x = 50 + randi() % 1300
		npc.random_move_from_to(50, 1300)
	for i in range(10):
		var npc : NPC = NPC_CHARACTER.instantiate()
		npc.randomize_character()
		npc_bucket_2.add_child(npc)
		npc.position.x = 50 + randi() % 1300
		npc.random_move_from_to(50, 1300)

func fade_in_over() -> void:
	anim.play("player intro")

func _process(_delta: float) -> void:
	if player.moving:
		player.position.x = min(1450, max(50, player.position.x))

	if current_camera_mode == CAMERA_MODE.FOLLOW_PLAYER:
		camera.position.x = player.position.x

func _on_cut_scene_1_area_entered(area: Area2D) -> void:
	if area.owner is Player:
		cut_scene_1.queue_free()
		var t : Tween = get_tree().create_tween()
		current_camera_mode = CAMERA_MODE.FREE
		player.moving = false
		player.surprised()
		t.tween_interval(1.5)
		t.tween_property(camera, "position:x", victim.position.x - 200, 1.5)
		t.tween_interval(1.0)
		t.tween_property(camera, "position:x", player.position.x, .8)
		t.tween_callback(func ():
			current_camera_mode = CAMERA_MODE.FOLLOW_PLAYER
			player.moving = true)

func _on_cut_scene_2_area_entered(area: Area2D) -> void:
	if area.owner is Player:
		cut_scene_2.queue_free()
		anim.play("victim escapes")

func _on_door_1_player_entered() -> void:
	player.moving = false
	player.vanished.connect(func (): go_to_next_level())
	player.vanish()
