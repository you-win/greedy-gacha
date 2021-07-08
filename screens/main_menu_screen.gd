extends Control

onready var play: Button = $MarginContainer/MarginContainer/VBoxContainer/Play
onready var options: Button = $MarginContainer/MarginContainer/VBoxContainer/Options
onready var quit: Button = $MarginContainer/MarginContainer/VBoxContainer/Quit

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	play.connect("pressed", self, "_on_play")
	options.connect("pressed", self, "_on_options")
	quit.connect("pressed", self, "_on_quit")

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_play() -> void:
	GameManager.main.change_screen("res://screens/gambling_hub_screen.tscn")

func _on_options() -> void:
	pass

func _on_quit() -> void:
	get_tree().quit()

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


