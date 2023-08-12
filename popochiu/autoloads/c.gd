@tool
extends "res://addons/popochiu/engine/interfaces/i_character.gd"

# classes ----
const PCHuman := preload('res://popochiu/characters/human/character_human.gd')
# ---- classes

# nodes ----
var Human: PCHuman : get = get_Human
# ---- nodes

# functions ----
func get_Human() -> PCHuman: return super.get_runtime_character('Human')
# ---- functions

