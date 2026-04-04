extends Resource
class_name PlayerBuild

var build_name: String = "Starting Build"

# Stat Modifiers/Base Values for this specific build
var build_hp: int = 0
var build_damage: int = 0
var build_defense: int = 0
var build_heal: int = 0

var skills: Array[String] = []

func add_skill(skill: String) -> void:
	if skill not in skills:
		skills.append(skill)

# This function will act as a "Skill Library"
# It checks if the build has a specific skill
func use_skill(skill_name: String):
	if skill_name == "fireball":
		_fireball()
	elif skill_name == "negate_attack":
		_negate_attack()
	else:
		print("Skill not found in this build!")

func _fireball():
	print("Casting Fireball!")

func _negate_attack():
	print("Attack negated!")
