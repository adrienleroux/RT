extends TileMapLayer

var boardWidth :int = 8
var boardHight :int = 8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in range(boardWidth):
		for y in range(boardHight):
			set_cell(Vector2i(x,y), 1 ,Vector2i(0,0), 0)
	


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		#print(self.local_to_map(get_global_mouse_position()))
		pass
