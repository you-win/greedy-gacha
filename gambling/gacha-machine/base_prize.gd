extends Sprite

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("primary_action"):
		self.queue_free()

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

