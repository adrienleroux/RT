extends Node2D

@export var color : Color
@export var playerNumber : int
var apPerTurn : int = 3
var teamSelected : int 


func _ready() -> void:
	Globals.connect('undo', undoMove)
	Globals.connect('turnChange', turnChange)
	Globals.currentAp = apPerTurn
	Globals.emit_signal("apChange", apPerTurn)
	Globals.actionsTaken = 0
	
	#triggered by turn change
func turnChange():
	Globals.currentAp = apPerTurn
	Globals.emit_signal("apChange", apPerTurn)
	
	#Undo triggered by control > button pressed
func undoMove(playersTurn):
	if playersTurn == playerNumber:
		#actionsOnTurn.erase(Globals.actionsTaken)
		#Globals.emit_signal("undoMove", actionsOnTurn[actionsTaken])
		#Globals.actionsTaken -= 1
		pass
		
	
