extends Control

# Player info
export var name_label_path: NodePath
export var points_label_path: NodePath
export var minigames_unlocked_label_path: NodePath

onready var name_label: Label = get_node(name_label_path)
onready var points_label: Label = get_node(points_label_path)
onready var minigames_unlocked_label: Label = get_node(minigames_unlocked_label_path)

# Gambling games
export var gacha_machine_button_path: NodePath

onready var gacha_machine_button: Button = get_node(gacha_machine_button_path)

onready var play_games: Button = $PlayGamesContainer/PlayGames

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	play_games.connect("pressed", self, "_on_play_games")
	
	name_label.text = GameManager.player_data.player_name
	points_label.text = str(GameManager.player_data.coins)
	minigames_unlocked_label.text = str(GameManager.player_data.minigames_unlocked)
	
	gacha_machine_button.connect("pressed", self, "_on_gacha_machine_button")

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_play_games() -> void:
	MinigameManager.generate_possible_minigames()
	MinigameManager.load_next_minigame()

func _on_gacha_machine_button() -> void:
	GameManager.main.change_screen("res://gambling/gacha-machine/gacha_machine.tscn")

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


