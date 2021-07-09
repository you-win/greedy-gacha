class_name BaseGamblingScreen
extends Node2D

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	var canvas_layer := CanvasLayer.new()
	var margin_container := MarginContainer.new()
	margin_container.anchor_right = 0.1
	margin_container.anchor_bottom = 0.1
	margin_container.margin_left = 10
	margin_container.margin_top = 10
	
	var button := Button.new()
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.size_flags_vertical = Control.SIZE_EXPAND_FILL
	button.text = "Back"
	button.name = "Back"
	button.connect("pressed", self, "_on_back_button_pressed")
	
	margin_container.add_child(button)
	
	canvas_layer.add_child(margin_container)
	
	self.call_deferred("add_child", canvas_layer)

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_back_button_pressed() -> void:
	GameManager.main.change_screen("res://gambling/gambling_hub_screen.tscn")

###############################################################################
# Private functions                                                           #
###############################################################################

func _adjust_self_position_in_viewport() -> void:
	var parent_viewport = get_parent()
	if parent_viewport is Viewport:
		var viewport_size: Vector2 = (parent_viewport as Viewport).size
		self.position = viewport_size / 2
	else:
		GameManager.log_message("Unable to adjust position in viewport", true)

###############################################################################
# Public functions                                                            #
###############################################################################


