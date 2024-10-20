extends Node2D

var jaguarRange : Array = [Vector2i(1,1),Vector2i(1, -1), Vector2i(-1, 1), Vector2i(-1, -1) ]
@onready var basicMoveRange : Array =$"../../Controller/basicMove".moveRange
@onready var teamColor = get_parent().get_parent().get_parent().color
@onready var sprite = $Sprite2D

		
func _ready() -> void:
	modulate = teamColor
	basicMoveRange.append_array(jaguarRange)
	z_index = 2
	
	
