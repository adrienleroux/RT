extends TextureButton
var animal : String
@onready var cardHolder = get_parent().get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(animal)
	pass


func _on_pressed():
	if Globals.mode == 'addingToTeam':
		Globals.animalSelected = animal
		Globals.emit_signal("addAnimal")
		cardHolder.removeCardFromHand()
		queue_free()
		print(Globals.animalSelected)




func _on_mouse_entered() -> void:
	Globals.mouseInArea = true


func _on_mouse_exited() -> void:
	Globals.mouseInArea = false
