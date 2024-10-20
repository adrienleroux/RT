extends Camera2D

var dimensions:float = 2049
var tileDimensions: float= 32
var targetSize = tileDimensions*8
var translation = targetSize /2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	position.x = translation
	position.y = translation
	visible = false
