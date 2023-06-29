class_name LevelBadge
extends Level

@onready var npc_bucket: Node2D = $Scene/npc
@onready var anim: AnimationPlayer = $AnimationPlayer

var state : int = 0

func _ready() -> void:
	super._ready()
	for i in range(10):
		var npc : NPC = NPC_CHARACTER.instantiate()
		npc_bucket.add_child(npc)
		npc.moving = true
		npc.target_reached.connect(_randomize_npc.bind(npc))
	space_bar.visible = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action") and state < 2:
		if state == 0:
			state = 1
			anim.play("start game")
		else:
			state = 2
			anim.play("enter metro")

func _randomize_npc(npc: NPC) -> void:
	npc.randomize_character()
	npc.position.x = randi() % 800 -100
	npc.move_to(700 if randf() < .5 else -100)