class_name LevelBadge
extends Level

@onready var npc_bucket: Node2D = $Scene/npc
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var title: Node2D = $Scene/Title

var state : int = 0

func _ready() -> void:
	super._ready()
	for i in range(10):
		var npc : NPC = NPC_CHARACTER.instantiate()
		npc_bucket.add_child(npc)
		npc.moving = true
		npc.target_reached.connect(_randomize_npc.bind(npc))

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("action") and state < 2:
		if state == 0:
			state = 1
			var t = get_tree().create_tween()
			t.tween_property(title, "modulate:a", 0, 1.0)
		else:
			state = 2
			anim.play("enter metro")

func _randomize_npc(npc: NPC) -> void:
	npc.randomize_character()
	if randf() < .5:
		npc.position.x = -100
		npc.move_to(700)
	else:
		npc.position.x = 700
		npc.move_to(-100)
