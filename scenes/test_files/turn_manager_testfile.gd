extends Control

enum Turn { PLAYER, ENEMY }

var current_turn : Turn = Turn.PLAYER
var player_hp: int
var enemy_hp: int
var battle_over := false

@export var current_enemy_data : EnemyStats

@onready var player_label = $VBoxContainer/PlayerLabel
@onready var enemy_label = $VBoxContainer/EnemyLabel
@onready var info_label = $VBoxContainer/InfoLabel
@onready var attack_button = $VBoxContainer/AttackButton

func _ready():
	setup_battle(current_enemy_data)

func setup_battle(enemy_data: EnemyStats):
	# 1. Reset State
	battle_over = false
	current_turn = Turn.PLAYER
	attack_button.disabled = false
	
	# 2. Reset Stats
	player_hp = 25
	enemy_hp = enemy_data.max_health
	
	# 3. Refresh UI
	print("Enemy " + enemy_data.enemy_name + " appears!")
	update_ui()
	attack_button.disabled = false
	
	# 4. Start
	start_turn()

func update_ui():
	player_label.text = "Player HP: %d" % player_hp
	enemy_label.text = "Enemy HP: %d" % enemy_hp


func start_turn():
	if battle_over:
		return

	match current_turn:
		Turn.PLAYER:
			info_label.text = "Your turn"
			attack_button.disabled = false
		Turn.ENEMY:
			info_label.text = "Enemy thinking..."
			attack_button.disabled = true
			enemy_turn()

# -------- PLAYER --------

func player_attack():
	if current_turn != Turn.PLAYER:
		return
		
	var dmg = randi_range(4, 8)
	enemy_hp -= dmg
	info_label.text = "You hit for %d!" % dmg
	update_ui()
	check_battle()
	end_turn()

func _on_attack_button_pressed() -> void:
	player_attack()

# -------- ENEMY --------

func enemy_turn():
	await get_tree().create_timer(1.5).timeout  # simple delay "animation"
	
	var dmg = randi_range(3, 6)
	player_hp -= dmg
	info_label.text = "Enemy hits for %d!" % dmg
	update_ui()
	check_battle()
	end_turn()

# -------- FLOW --------

func end_turn():
	if battle_over:
		return
		
	current_turn = Turn.ENEMY if current_turn == Turn.PLAYER else Turn.PLAYER
	await get_tree().create_timer(1.5).timeout
	start_turn()

func check_battle():
	if player_hp <= 0:
		info_label.text = "You Lose!"
		battle_over = true
		attack_button.disabled = true
	elif enemy_hp <= 0:
		info_label.text = "You Win!"
		battle_over = true
		attack_button.disabled = true
