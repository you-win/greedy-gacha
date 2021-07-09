extends BaseGamblingScreen

const BasePrize: Resource = preload("res://gambling/gacha-machine/base_prize.tscn")

export var current_coin_label_path: NodePath
export var probabilities_label_path: NodePath
export var coin_input_path: NodePath
export var coin_minus_path: NodePath
export var coin_plus_path: NodePath
export var spin_button_path: NodePath

onready var current_coin_label: Label = get_node(current_coin_label_path)
onready var probabilities_label: Label = get_node(probabilities_label_path)
onready var coin_input: LineEdit = get_node(coin_input_path)
onready var coin_minus: Button = get_node(coin_minus_path)
onready var coin_plus: Button = get_node(coin_plus_path)
onready var spin_button: Button = get_node(spin_button_path)

onready var machine: Node2D = $Machine
onready var anim_player: AnimationPlayer = $AnimationPlayer

# TODO debug only, move to save file
var remaining_items: int = 10

# TODO debug only
var possible_items: Array = [
	"shoe",
	"worm",
	"some gum"
]

const MAX_SPINS: int = 1
var spin_counter: int = 0

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	_adjust_self_position_in_viewport()
	
	current_coin_label.text = str(GameManager.player_data.coins)
	
	coin_input.connect("text_changed", self, "_on_coin_input_changed")
	coin_minus.connect("pressed", self, "_on_coin_minus")
	coin_plus.connect("pressed", self, "_on_coin_plus")
	spin_button.connect("pressed", self, "_on_spin")
	
	anim_player.connect("animation_finished", self, "_on_spin_complete")
	anim_player.play("Rest")

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_coin_input_changed(text: String) -> void:
	if text.is_valid_integer():
		# TODO recalculate probability
		pass

func _on_coin_minus() -> void:
	if coin_input.text.is_valid_integer():
		var new_value := int(coin_input.text) - 1
		if new_value < 0:
			new_value = 0
		coin_input.text = str(new_value)
	else:
		coin_input.text = str(1)

func _on_coin_plus() -> void:
	if coin_input.text.is_valid_integer():
		var new_value := int(coin_input.text) + 1
		if new_value > GameManager.player_data.coins:
			new_value = GameManager.player_data.coins
		coin_input.text = str(new_value)
	else:
		coin_input.text = str(1)

func _on_spin() -> void:
	var coins_to_spend: String = coin_input.text
	if (coins_to_spend.is_valid_integer() and int(coins_to_spend) > 0
			and int(coins_to_spend) <= GameManager.player_data.coins):
		GameManager.player_data.coins -= int(coins_to_spend)
		current_coin_label.text = str(GameManager.player_data.coins)
		
		spin_button.disabled = true
		
		anim_player.play("Spin")

func _on_spin_complete(anim_name: String) -> void:
	if anim_name == "Spin":
		if spin_counter < MAX_SPINS:
			anim_player.play("Spin")
			spin_counter += 1
			return
		
		spin_button.disabled = false
		spin_counter = 0
		anim_player.play("Rest")
		
		var prize: Node2D = BasePrize.instance()
		call_deferred("add_child", prize)

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


