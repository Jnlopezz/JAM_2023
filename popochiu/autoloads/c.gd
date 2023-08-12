@tool
extends "res://addons/popochiu/engine/interfaces/i_character.gd"

# classes ----
const PCHuman := preload('res://popochiu/characters/human/character_human.gd')
const PCHumanNPC1 := preload('res://popochiu/characters/human_npc_1/character_human_npc_1.gd')
const PCHumanNPC2 := preload('res://popochiu/characters/human_npc_2/character_human_npc_2.gd')
# ---- classes

# nodes ----
var Human: PCHuman : get = get_Human
var HumanNPC1: PCHumanNPC1 : get = get_HumanNPC1
var HumanNPC2: PCHumanNPC2 : get = get_HumanNPC2
# ---- nodes

# functions ----
func get_Human() -> PCHuman: return super.get_runtime_character('Human')
func get_HumanNPC1() -> PCHumanNPC1: return super.get_runtime_character('HumanNPC1')
func get_HumanNPC2() -> PCHumanNPC2: return super.get_runtime_character('HumanNPC2')
# ---- functions

