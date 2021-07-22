extends BaseMinigame

const Bean1: Resource = preload("res://minigames/dodge-the-beans/entities/bean1.tscn")
const Bean2: Resource = preload("res://minigames/dodge-the-beans/entities/bean2.tscn")
const Okay: Resource = preload("res://minigames/dodge-the-beans/entities/okay.tscn")

const SPAWNABLES: Array = [
	Bean1,
	Bean2,
	Okay
]

const BEAN_SPAWN_TIME: float = 0.3
const BEAN_DELAY_TIME: float = 1.0

const BEAN_GROUP: String = "Bean"
const SCORE_GROUP: String = "Score"

# Bean spawning
onready var beans: Node2D = $Beans
onready var bean_spawn_timer: Timer = $BeanSpawnTimer
onready var path_follow: PathFollow2D = $Path2D/PathFollow2D
onready var spawn_delay_timer: Timer = $BeanSpawnTimer

onready var player: Area2D = $Player

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	_adjust_self_position_in_viewport()
	_setup_timer(12.0)
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	player.connect("body_entered", self, "_on_player_collided")
	
	bean_spawn_timer.connect("timeout", self, "_on_bean_timer_timeout")
	
	spawn_delay_timer.connect("timeout", self, "_on_spawn_delay_timer")
	spawn_delay_timer.start(BEAN_DELAY_TIME)

func _exit_tree() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta: float) -> void:
	player.position = get_local_mouse_position()

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_bean_timer_timeout() -> void:
	_spawn_bean()
	
	bean_spawn_timer.start(BEAN_SPAWN_TIME)

func _on_spawn_delay_timer() -> void:
	bean_spawn_timer.start(BEAN_SPAWN_TIME)

func _on_player_collided(body: Node) -> void:
	if body.is_in_group(BEAN_GROUP):
		player.hit_bean()
	elif body.is_in_group(SCORE_GROUP):
		_spawn_coin_at(player.global_position)

###############################################################################
# Private functions                                                           #
###############################################################################

func _spawn_bean() -> void:
	var spawnee: Node2D = SPAWNABLES[GameManager.rng.randi_range(0, SPAWNABLES.size() - 1)].instance()
	
	path_follow.unit_offset = GameManager.rng.randf()
	
	var movement_vector: Vector2 = player.position - path_follow.position
	
	spawnee.movement_vector = movement_vector.normalized()
	beans.call_deferred("add_child", spawnee)
	
	yield(spawnee, "ready")
	
	spawnee.position = path_follow.position
	spawnee.scale = Vector2(0.25, 0.25)

func _teardown() -> void:
	pass

###############################################################################
# Public functions                                                            #
###############################################################################


