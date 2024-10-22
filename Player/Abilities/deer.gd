extends Node2D

var deerRange : Array = [Vector2i(2,0),Vector2i(0, 2), Vector2i(0, -2), Vector2i(-2, 0) ]
@onready var basicMoveRange : Array =$"../../Controller/basicMove".moveRange
@onready var teamColor = get_parent().get_parent().get_parent().color
@onready var sprite = $Sprite2D
@onready var team = get_parent().get_parent().team
@onready var charHolder = get_parent()

		
func _ready() -> void:
	Globals.connect("dealDamageToThisTeam", dealDamageToThisTeam)
	Globals.connect('turnChange', turnChange)
	modulate = teamColor
	basicMoveRange.append_array(deerRange)
	z_index = 2
	
func dealDamageToThisTeam(taker, _dealer):
	if taker == team and charHolder.get_child(-1)== self:
		for i in range(len(deerRange)):
			basicMoveRange.erase(deerRange[i])
		print(basicMoveRange)
		
func turnChange():
	if visible == false:
		queue_free()
	
