extends Area2D

onready var collision_shape: CollisionShape2D = $CollisionShape2D
onready var anim_player: AnimationPlayer = $AnimationPlayer

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	anim_player.connect("animation_finished", self, "_anim_finished")

###############################################################################
# Connections                                                                 #
###############################################################################

func _anim_finished(anim_name: String) -> void:
	if anim_name == "Flash":
		set_deferred("monitoring", true)

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func hit_bean() -> void:
	anim_player.play("Flash")
	set_deferred("monitoring", false)
