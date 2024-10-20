extends Node2D

var buttonTSCN = preload("res://Player/controller/button.tscn")
@onready var tileMap = %TileMapLayer
@onready var teamNode= get_parent()
@onready var teamBelongsToPlayer : int = get_parent().get_parent().get_parent().playerNumber
@onready var teamNumber = $"../..".team

var moveRange : Array = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]


func _ready() -> void:
	Globals.connect('showControls', showControls)
	#Globals.connect('moveTo', moveTo)
	#
#func moveTo(pos):
	#propagate_call()

func showControls(player,team, mode, global_position,ap):	
	for y in range( get_child_count()):
			get_child(y).queue_free()
	if Globals.teamSelected == teamNumber and player == teamBelongsToPlayer:
		var center = teamNode.global_position - Vector2(16,16)
		for x in range(len(moveRange)):
			var buttonDouble = buttonTSCN.instantiate()
			global_position = center + tileMap.map_to_local(moveRange[x]) 
			if global_position.x < 0 or global_position.y < 0 or tileMap.local_to_map(global_position).x > tileMap.boardWidth-1 or tileMap.local_to_map(global_position).y > tileMap.boardHight-1:
				pass
			else:
				add_child(buttonDouble)
				buttonDouble.global_position = global_position
				
			
	
		
		
