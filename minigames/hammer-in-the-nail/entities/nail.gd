extends Area2D

signal hammered_in(pos)

const EXTRA_HIT_MODULO: int = 4

onready var sprite: Sprite = $Sprite
onready var anim_player: AnimationPlayer = $AnimationPlayer

var can_hammer: bool = false

var hit_counter: int = 0
var extra_counter: int = 0

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	self.connect("mouse_entered", self, "_on_mouse_entered")
	self.connect("mouse_exited", self, "_on_mouse_exited")
	
	anim_player.play("Rest")

func _process(delta: float) -> void:
	if (can_hammer and Input.is_action_just_pressed("primary_action")):
		hit_counter += 1
		match hit_counter:
			1:
				anim_player.play("FirstHit")
			2:
				anim_player.play("SecondHit")
				emit_signal("hammered_in", self.global_position)
			_:
				sprite.flip_h = not sprite.flip_h
				extra_counter += 1
				if extra_counter % EXTRA_HIT_MODULO == 0:
					emit_signal("hammered_in", self.global_position)

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_mouse_entered() -> void:
	can_hammer = true

func _on_mouse_exited() -> void:
	can_hammer = false

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


