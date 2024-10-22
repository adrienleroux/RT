extends Node2D

@onready var team = get_parent().team
@onready var label =$Label
@onready var teamColor = get_parent().get_parent().color

@onready var numberOfTeamMates = get_child_count()-1

func _ready() -> void:
	Globals.connect('showControls', showlabel)
	Globals.connect("teamDeselect", hidelabel)
	Globals.connect('addAnimal', addAnimal)
	label.visible = false

var jaguarTSCN : PackedScene = preload("res://Player/Abilities/Jaguar.tscn")

func addAnimal():
	if team == Globals.teamSelected:
		numberOfTeamMates += 1
		label.text = str(numberOfTeamMates)
		var animal = Globals.animalSelected
		if animal == 'jaguar':
			var jaguarCard = jaguarTSCN.instantiate()
			add_child(jaguarCard)
			jaguarCard.name = 'jaguar'
		
	
	
func hidelabel():
	label.visible = false
	
func showlabel(player, teamX, mode, global_position, ap):
	if teamX == get_parent().team:
		label.visible = true
		label.text = str(numberOfTeamMates)
	else:
		label.visible = false

func tweenTeam(pos):
	var tween = create_tween()
	tween.tween_property(self, 'global_position',pos, .5)
