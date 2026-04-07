class_name Player

var player_name: String = "Player 1"

# Base Stats
var player_hp: int = 50 # max player hp
var player_damage: int = 0
var player_defense: int = 0
var player_heal: int = 0

# Current player Equipments
var equipment: Array[String] = []

# Current Build
var current_build: PlayerBuild = null:
	set(value):
		current_build = value
		apply_build_stats() # Automatically update stats when build changes

func _ready() -> void:
	if current_build:
		apply_build_stats()

func apply_build_stats() -> void:
	if not current_build:
		push_error("Current build is null!")
		return
	
	player_hp += current_build.build_hp
	player_damage += current_build.build_damage
	player_defense += current_build.build_defense
	player_heal += current_build.build_heal
	
	print("Build Updated: ", current_build.build_name, " HP: ", player_hp)
	
func get_player_build() -> PlayerBuild:
	return current_build
	
## Assigns a new build to the player's current build
func set_player_build(new_build: PlayerBuild) -> void:
	if new_build:
		current_build = new_build
		print("Build changed to: ", current_build.build_name)
	else:
		push_error("Failed to change build: New build is null!")

func get_player_hp() -> int:
	return player_hp

func add_item(item: String) -> void:
	equipment.append(item)
	
func take_damage(amount: int) -> void:
	player_hp -= amount
	
# TODO: For testing purposes, delete later
func print_player_stats():
	print('\n')
	print("hp: ", player_hp)
	print("damage: ", player_damage)
	print("defense: ", player_defense)
	print("heal: ", player_heal)

func _to_string() -> String:
	return player_name
