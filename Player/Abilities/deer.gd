extends Node2D

var deerRange : Array = [Vector2i(2,0),Vector2i(0, 2), Vector2i(0, -2), Vector2i(-2, 0) ]
@onready var basicMoveRange : Array =$"../../Controller/basicMove".moveRange
@onready var teamColor = get_parent().get_parent().get_parent().color
@onready var sprite = $Sprite2D

		
func _ready() -> void:
	modulate = teamColor
	basicMoveRange.append_array(deerRange)
	z_index = 2
	
	
