extends Node2D

const COIN_SOUNDS_PATH: String = "res://assets/sfx/coin%s.tscn"

onready var anim_player: AnimationPlayer = $AnimationPlayer
onready var tween: Tween = $Tween

var coin_sound: AudioStreamPlayer

var spawn_position: Vector2

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	anim_player.connect("animation_finished", self, "_on_animation_finished")
	anim_player.play("Spin")
	
	tween.connect("tween_all_completed", self, "_on_tween_finished")
	tween.interpolate_property(self, "modulate", Color.white, Color.transparent, 0.5)
	
	self.global_position = spawn_position
	
	coin_sound = load(COIN_SOUNDS_PATH % GameManager.rng.randi_range(0, 2)).instance()
	call_deferred("add_child", coin_sound)
	
	yield(coin_sound, "ready")
	
	coin_sound.play(0)

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_animation_finished(_anim_name: String) -> void:
	tween.start()

func _on_tween_finished() -> void:
	self.queue_free()

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


