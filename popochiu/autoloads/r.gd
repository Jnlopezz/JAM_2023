@tool
extends "res://addons/popochiu/engine/interfaces/i_room.gd"

# classes ----
const PRRoom_Lab := preload('res://popochiu/rooms/room_lab/room_room_lab.gd')
const PRIntro := preload('res://popochiu/rooms/intro/room_intro.gd')
# ---- classes

# nodes ----
var Room_Lab: PRRoom_Lab : get = get_Room_Lab
var Intro: PRIntro : get = get_Intro
# ---- nodes

# functions ----
func get_Room_Lab() -> PRRoom_Lab: return super.get_runtime_room('Room_Lab')
func get_Intro() -> PRIntro: return super.get_runtime_room('Intro')
# ---- functions

