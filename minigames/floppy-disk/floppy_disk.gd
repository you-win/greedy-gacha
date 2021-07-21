extends BaseMinigame

const PipePair: Resource = preload("res://minigames/floppy-disk/pipe_pair.tscn")

const PIPE_SPAWN_TIME: float = 1.5
const GRAVITY_DELAY_TIME: float = 1.0

var initial_player_position: Vector2
onready var floppy_character: KinematicBody2D = $FloppyCharacter

onready var gravity_delay_timer: Timer = $GravityDelayTimer

onready var pipes: Node2D = $Pipes
onready var pipe_spawn_position: Position2D = $PipeSpawnPosition
onready var pipe_timer: Timer = $PipeTimer

var screen_extents: Vector2

var current_score_combo: float = 1.0

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	_adjust_self_position_in_viewport()
	_setup_timer(10.0)
	
	_spawn_pipe()
	
	screen_extents.x = GameManager.main.viewport.size.x / 2
	screen_extents.y = (GameManager.main.viewport.size.y / 2)
	
	initial_player_position = floppy_character.position
	floppy_character.set_physics_process(false)
	
	floppy_character.connect("killed", self, "_on_killed")
	pipe_timer.connect("timeout", self, "_on_pipe_timer_timeout")
	gravity_delay_timer.connect("timeout", self, "_on_gravity_delay_timer_timeout")
	
	pipe_timer.start(PIPE_SPAWN_TIME)
	gravity_delay_timer.start(GRAVITY_DELAY_TIME)

func _physics_process(delta) -> void:
	for i in pipes.get_children():
		i.position.x -= 500 * delta
		
		# Despawn if offscreen
		if i.position.x < -screen_extents.x - 750:
			i.queue_free()
	
	# Check if character is below ground
	if floppy_character.position.y > screen_extents.y + 500:
		_on_killed()
	
	floppy_character.position.y = clamp(floppy_character.position.y, -screen_extents.y, screen_extents.y + 1000)

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_killed() -> void:
	_teardown_game()
	_spawn_pipe()

func _on_pipe_timer_timeout() -> void:
	_spawn_pipe()
	
	pipe_timer.start(PIPE_SPAWN_TIME)

func _on_gravity_delay_timer_timeout() -> void:
	floppy_character.set_physics_process(true)

func _on_scored(pos: Vector2) -> void:
	GameManager.player_data.coins += current_score_combo
	
	for i in current_score_combo:
		yield(get_tree().create_timer(0.1), "timeout")
		_spawn_coin_at(pos)
	
	current_score_combo += 1

###############################################################################
# Private functions                                                           #
###############################################################################

func _spawn_pipe() -> void:
	var pipe_pair = PipePair.instance()
	
	pipes.add_child(pipe_pair)
	
	pipe_pair.position.x = screen_extents.x + 750
	pipe_pair.position.y = GameManager.rng.randf_range(-screen_extents.y * 0.6, screen_extents.y * 0.6)
	
	pipe_pair.connect("scored", self, "_on_scored")

func _teardown_game() -> void:
	for pipe in pipes.get_children():
		pipe.queue_free()
	
	floppy_character.position = initial_player_position
	
	current_score_combo = 1

###############################################################################
# Public functions                                                            #
###############################################################################


