@tool
extends "res://addons/popochiu/engine/interfaces/i_room.gd"

# classes ----
const PRRoom_Lab := preload('res://popochiu/rooms/room_lab/room_room_lab.gd')
# ---- classes

# nodes ----
var Room_Lab: PRRoom_Lab : get = get_Room_Lab
# ---- nodes

# functions ----
func get_Room_Lab() -> PRRoom_Lab: return super.get_runtime_room('Room_Lab')
# ---- functions

