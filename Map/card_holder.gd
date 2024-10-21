extends Control
@onready var cardHolderBox : HBoxContainer = $VBoxContainer/cardHolderBox
@onready var label = $VBoxContainer/Label
var card : PackedScene = preload("res://Player/controller/card.tscn")
var addToTeamButton : PackedScene = preload("res://Player/controller/addToTeamButton.tscn")
var player1Hand : Array = []
var player2Hand : Array = []

#image preloading
@onready var deer = preload("res://Art/fronts/21.png")
@onready var ray = preload("res://Art/fronts/00.png")
@onready var jaguar = preload('res://Art/fronts/20.png')


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.connect('showCards', showCardsOnTeam)
	Globals.connect('showControls', showControls)
	Globals.connect('teamDeselect', showHand)
	Globals.connect('turnChange', showHand)
	
	player1Hand.append('ray')	
	player2Hand.append('jaguar')

func removeCardFromHand():
	if Globals.currentPlayer == 1:
		for x in len(player1Hand):
			if player1Hand[x]== Globals.animalSelected:
				player1Hand.remove_at(x)
	if Globals.currentPlayer == 2:
		for x in len(player2Hand):
			if player2Hand[x]== Globals.animalSelected:
				player2Hand.remove_at(x)
	
	
#Connects to outside click
func showHand():
	
	if Globals.currentPlayer == 1:
		showCardsOnTeam(player1Hand)
	if Globals.currentPlayer == 2:
		showCardsOnTeam(player2Hand)
	label.text = 'Hand'
		
		
func showCardsOnTeam(teamMembers):
	clearCards()
	if len(teamMembers) >= 1:
		label.text = ('Team '+ str(Globals.teamSelected) + ' '+str(teamMembers[0]) + ' has:')
		
	if teamMembers.has('Deer'):
		var cardInstance = card.instantiate()
		cardInstance.set('animal', 'deer')
		cardHolderBox.add_child(cardInstance)
		cardInstance.texture_normal = deer
	
	if teamMembers.has('jaguar'):
		var cardInstance = card.instantiate()
		cardInstance.set('animal', 'jaguar')
		cardHolderBox.add_child(cardInstance)
		cardInstance.texture_normal = jaguar
		
	if teamMembers.has('ray'):
		var cardInstance = card.instantiate()
		cardInstance.set('animal', 'ray')
		cardHolderBox.add_child(cardInstance)
		cardInstance.texture_normal = ray
		#attempting to assign an animal. 
	


	

func showControls(player, team, mode, global_position, ap):
	if player == Globals.currentPlayer:
		var addToTeamButt = addToTeamButton.instantiate()
		cardHolderBox.add_child(addToTeamButt)
	
		
func clearCards():
	var cardsToRemove = cardHolderBox.get_child_count()
	for x in cardsToRemove:
		cardHolderBox.get_child(x).queue_free()
