extends Node2D

@export var color : Color
@export var playerNumber : int
var apPerTurn : int = 3
var teamSelected : int 


func _ready() -> void:
	
	Globals.connect('turnChange', turnChange)
	Globals.currentAp = apPerTurn
	Globals.emit_signal("apChange", apPerTurn)
	Globals.actionsTaken = 0
	
	#triggered by turn change
func turnChange():
	Globals.currentAp = apPerTurn
	Globals.emit_signal("apChange", apPerTurn)
	

		
	
