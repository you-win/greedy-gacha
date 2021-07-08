extends Node2D

onready var anchor: Node2D = $Anchor

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("primary_action"):
		anchor.rotation_degrees = 90
		anchor.z_index = 100
	elif Input.is_action_just_released("primary_action"):
		anchor.rotation_degrees = 0
		anchor.z_index = 0

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

