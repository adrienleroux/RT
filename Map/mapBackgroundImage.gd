extends Sprite2D
var dimensions:float = 2049
var tileDimensions: float= 32
var targetSize = tileDimensions*8
var translation = targetSize /2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale.x = targetSize/dimensions
	scale.y = targetSize/dimensions
	position.x = translation
	position.y = translation
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_team_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
