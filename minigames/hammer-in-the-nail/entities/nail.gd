extends Area2D

signal hammered_in

onready var sprite: Sprite = $Sprite

var can_hammer: bool = false

var remaining_hammers: int = 2

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	self.connect("mouse_entered", self, "_on_mouse_entered")
	self.connect("mouse_exited", self, "_on_mouse_exited")

func _process(delta: float) -> void:
	if remaining_hammers > 0:
		if (can_hammer and Input.is_action_just_pressed("primary_action")):
			remaining_hammers -= 1
			match remaining_hammers:
				1:
					self.global_position.y += 10
				0:
					sprite.frame = 1
					emit_signal("hammered_in")

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


