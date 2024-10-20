extends Node2D

@export var team : int
@export var startingPosition : Vector2i

@onready var numberOfMembersOnTeam = $"CharHolder".get_child_count()
