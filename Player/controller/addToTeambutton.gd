extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	Globals.mode = 'addingToTeam'
	Globals.emit_signal('teamDeselect')


func _on_mouse_entered() -> void:
	Globals.mouseInArea = true
func _on_mouse_exited() -> void:
	Globals.mouseInArea = false