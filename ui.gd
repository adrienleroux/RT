extends Control
@onready var turnLabel = $MarginContainer/HBoxContainer/turnLabel
@onready var ApLabel = $MarginContainer/HBoxContainer/ApLabel
@onready var choiceTeamButton = $MarginContainer/HBoxContainer/choiceTeam
@onready var player1 = $"../../player1"
@onready var player2 = $"../../player2"
var damageDealer : Area2D


func _ready() -> void:
	Globals.connect("apChange", apChange)
	Globals.connect('dealDamageToATeam', dealDamageToATeam)
	Globals.connect('hideChoiceButton', hideChoiceButton)
	#Globals.connect('moveUndone' ,moveUndone)
	apChange(Globals.currentAp)
	adaptColor()
	
func dealDamageToATeam(dealer):
	
	choiceTeamButton.visible = true
	Globals.teamHasBeenChosenToTakeDamage = false
	damageDealer = dealer
	
	
func _on_choice_team_pressed() -> void:
	choiceTeamButton.visible = false
	Globals.teamHasBeenChosenToTakeDamage = true
	Globals.emit_signal("dealDamageToThisTeam", Globals.teamSelected, damageDealer)
	Globals.mode = 'move'
	print('team chosen')
func hideChoiceButton():
	choiceTeamButton.visible = false
	
	
	
	
func adaptColor():
	if Globals.currentPlayer == 1:
		modulate = player1.color
	if Globals.currentPlayer == 2:
		modulate = player2.color
	
	#Triggered when a move is made
func apChange(ap):
	ApLabel.text = ' A '.repeat(ap)
	if ap == 0:
		ApLabel.text = 'All AP has been used'

#listen for turn change
#emmit to player
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("click") and Globals.mouseInArea == false:
		Globals.emit_signal('teamDeselect')
		
	
	if Input.is_action_just_pressed('ui_accept'):
		if Globals.currentPlayer == 1:
			Globals.currentPlayer = 2
			Globals.emit_signal('turnChange')
		else:
			Globals.currentPlayer = 1
			Globals.emit_signal('turnChange')
		apChange(Globals.currentAp)
		adaptColor()
		
	if Input.is_action_just_pressed('yes or no'):
		var yesOrNo = randi_range(0, 1)
		if yesOrNo == 0:
			print('no')
		else:
			print('yes')
	

#emits to teamControl
func _on_button_pressed() -> void:
	Globals.undoTriggered = true
	Globals.emit_signal("undo")
	


func _on_button_mouse_entered() -> void:
	Globals.mouseInArea = true


func _on_button_mouse_exited() -> void:
	Globals.mouseInArea = false
