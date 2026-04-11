extends Resource
class_name CharacterAction

# the types of actions and status effects based on 5 archetypes
enum ActionType { ATTACK, DEFEND, HEAL, BUFF, DEBUFF, MULTI_ATTACK }
enum StatusEffect { NONE, BURN, STUN, WEAKEN, FOCUS }

@export_group("Action Details")
@export var action_name: String = "Basic Attack"
@export var type: ActionType = ActionType.ATTACK

@export_group("Values")
@export var damage: int = 0
@export var defense: int = 0
@export var heal: int = 0
## For the War Machine's Gatling Sweep (Default is 1)
@export var multi_hit_count: int = 1 

@export_group("Status Effects (Optional)")
## choose from: burn, stun, weaken, or focus
@export var status_type: StatusEffect = StatusEffect.NONE
## stacks of the status to apply (e.g. 2 stacks of Burn)
@export var status_amount: int = 0
