extends Node

signal teamDeselect
signal showControls (player, team, mode, global_position, ap)
signal moveTo (global_position)
signal apChange (ap)
signal undo 
signal turnChange ()
signal hideButtons (team)
signal moveUndone
signal teamTween (globalPos)
signal showCards (teamMembers)



signal hideChoiceButton
signal dealDamageToThisTeam(taker, dealer)
var teamHasBeenChosenToTakeDamage = false
var areasMarkedForDamage : Array = []
var teamTakingDamage : int
signal dealDamageToATeam(dealer)


signal addAnimal
var animalSelected : String
var mode = 'move'

var stackAssigner : int = 0
var currentPlayer : int = 1
var teamSelected : int
var actionsTaken : int = 0
var currentAp : int
var undoTriggered : bool
var teamsLeftBehind : int
var mouseInArea : bool

func _ready() -> void:
	pass
