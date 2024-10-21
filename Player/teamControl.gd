extends Area2D

@onready var team : int = get_parent().team
@onready var startingPosition : Vector2i = get_parent().startingPosition

@onready var playerNumber = $"../..".playerNumber
@onready var basicMoveSpawner = $basicMove
@onready var tileMap = %TileMapLayer
@onready var currentTile = tileMap.local_to_map(Vector2i(position))

@onready var sprite = $Sprite2D
@onready var collisionShape = $CollisionShape2D
const spaceBetweenSpritesWhenShared : int = 8

var actionsOnTurn : Dictionary = {}
var actionsTakenByThisTeam : int = 0
var mode = 'move'
var apUsedToMove = 1
var tweenSpeed = .3
@onready var charHolder = $"../CharHolder"

#connects and sets starting position of teams
func _ready() -> void:
	Globals.connect("moveTo", moveTo)
	Globals.connect('undo', undo)
	Globals.connect('turnChange', turnChange)
	Globals.connect('addAnimal', showMoveOptionsAndCards)
	Globals.connect('dealDamageToThisTeam', dealDamageToThisTeam)
	global_position = tileMap.map_to_local(startingPosition)
	charHolder.global_position = self.global_position
	#initial log for each team
	if Globals.currentPlayer == playerNumber:
		addToLog(team, 'start', global_position, 0)
	
	#triggered by a movement button
	#sets position of the team
func moveTo(globalPos):
	Globals.stackAssigner = 0
	if team == Globals.teamSelected and playerNumber == Globals.currentPlayer and Globals.currentAp > 0:
		actionsTakenByThisTeam += 1
		Globals.stackAssigner =0
		global_position = globalPos
		Globals.actionsTaken += 1
		# connects to buttons to hide
		Globals.emit_signal("hideButtons", team)
		Globals.currentAp -= apUsedToMove
		Globals.emit_signal("apChange", Globals.currentAp)
		addToLog(team, 'move', global_position, 1)#add to log
		showMoveOptionsAndCards()
		
		resituate()
		
		
		
func addToLog(team, mode, globalPos, apUsedToMove):		
	var cards : Array
	for x in range(1, charHolder.get_child_count()):
		cards.append(charHolder.get_child(x).name) 
	actionsOnTurn[Globals.actionsTaken] = [team, mode, globalPos, apUsedToMove, cards]
	print(str(Globals.actionsTaken) + str(actionsOnTurn[Globals.actionsTaken]))
	
		

		
		
	#triggered by control undo button
func undo():
	Globals.stackAssigner = 0
	var actionToUndoTo :int 
	if actionsOnTurn.has(Globals.actionsTaken) and actionsTakenByThisTeam > 0 and Globals.undoTriggered == true:
		Globals.teamSelected = team
		rivalsInSpace = 0
		actionsOnTurn.erase(Globals.actionsTaken)
		for i in range(Globals.actionsTaken):
			if actionsOnTurn.has(i):
				actionToUndoTo = i
		Globals.actionsTaken -= 1
		actionsTakenByThisTeam -= 1
		Globals.currentAp += 1
		Globals.emit_signal("apChange", Globals.currentAp)
		global_position = actionsOnTurn[actionToUndoTo][2]
		#insert show of cards and controls
		showMoveOptionsAndCards()
		#end of insert
		#print('global actions taken: ' + str(Globals.actionsTaken))
		Globals.undoTriggered = false
		
		var tween = create_tween()
		tween.tween_property(charHolder, 'global_position', sprite.global_position, .5)
		
func turnChange():
	actionsOnTurn.clear()
	actionsTakenByThisTeam = 0
	if playerNumber == Globals.currentPlayer:
		addToLog(team, 'start', global_position, 0)
#triggered by clicking self
#triggers basic move to show move buttons
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and collisionShape.visible == true:
		Globals.mouseInArea = true
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true:
			Globals.teamSelected = team
			showMoveOptionsAndCards()
			#print('team ' +str(Globals.teamSelected)+ str(team)+' clicked')
			#Globals.emit_signal("hideButtons", team)
func showMoveOptionsAndCards():
	var teamMembers : Array = []
	for x in (charHolder.get_child_count()):
		teamMembers.append(charHolder.get_child(x).name)
	teamMembers.remove_at(0)
	Globals.emit_signal('showCards', teamMembers)
	Globals.emit_signal("showControls",playerNumber, team, mode, global_position, Globals.currentAp)
			
			
			
func hideColisionBox():
	collisionShape.visible = false
func showColisionBox():
	collisionShape.visible = true


var sharingWithX : int = 0
var stackIndex : int = 0
var space = 7
var spaceDictionary : Dictionary = {
	0: [Vector2i(0,0)],
	1: [Vector2i(space, 0), Vector2i(-space, 0)],
	2: [Vector2i(space, space), Vector2i(-space, space), Vector2i(0, -space)],
	3: [Vector2i(space, space), Vector2i(-space, space), Vector2i(-space, -space), Vector2i(space, -space)]
}

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("checkLibrary"):
		print(str(actionsTakenByThisTeam) + str(actionsOnTurn))
		
	if Input.is_action_just_pressed('up'):
		print('team ' + str(team)+ ' is sharing with ' + str(sharingWithX) +". "+ str(rivalsInSpace)+' of which are rivals. and a stack index of: ' + str(stackIndex))
		#print(newStackIndex)
	if Input.is_action_just_pressed("down"):
		print(len(spaceDictionary[sharingWithX]))
		
	if Input.is_action_just_pressed('CountRivals'):
		countNumberOfRivalsInSpace()
	

func dealDamageToThisTeam(dealer):
	#team must be marked
	if Globals.teamSelected == team and markedToPossiblyTakeDamage == true:
		#print('take damage')
		takeDamage(dealer)


var finalCallMade = false
var rivalsInSpace : int	= 0
var markedToPossiblyTakeDamage = false
var status = 'alive'
			
func _on_area_entered(area: Area2D) -> void:
	if team != Globals.teamSelected:
		#print(str(team) +' shifted over')
		sharingWithX += 1
		resituate()
	
	if team == Globals.teamSelected:
		sharingWithX = len(get_overlapping_areas())
		stackIndex = sharingWithX
		if area.playerNumber != playerNumber:
			area.markedToPossiblyTakeDamage = true
		finalCallMade = false
		call_deferred('finalCount')
		#print('sharing with ' + str(sharingWithX) + '. ' + str(rivalsInSpace)+ ' of which are rivals')
func finalCount():
	if finalCallMade == false:
		finalCallMade = true
		print('this fires only once when entering')
		resituate()
		#DAMAGE
		if rivalsInSpace > 1:
			print('a choice of who to do damage to needs to be made')
			Globals.teamHasBeenChosenToTakeDamage = false
			Globals.emit_signal('dealDamageToATeam', self)
			if rivalsInSpace == 1:
				print('one team is taking damage')

func takeDamage(dealer):
		if charHolder.get_child_count() == 2:
			get_parent().visible = false
			collision_layer = 2
			dealer.stackIndex = 0
			status = 'dead'
			sharingWithX = 0
			stackIndex = 0
			#global_position.x = -100
			addToLog(team, 'takeDamage', global_position, 0)
			if dealer.has_method('reduceRivalsInSpace'):
				dealer.reduceRivalsInSpace()
		else:
			print('card is removed')
			var lastChild = charHolder.get_child_count()-1
			print(lastChild)
			charHolder.get_child(lastChild).queue_free()			
			
func reduceRivalsInSpace():
	rivalsInSpace -= 1
	sharingWithX -= 1
	resituate()
			
func shiftOver():
	print(str(team) +' shifted over')
	if team != Globals.teamSelected:
		
		sharingWithX += 1
		resituate()
			



var newStackIndex : float = 0


func _on_area_exited(area: Area2D) -> void:
	if team == Globals.teamSelected:
		if len(get_overlapping_areas()) == 0:
			print('this printe once when team exits')
			stackIndex = 0
			sharingWithX = 0
			resituate()
	if team != Globals.teamSelected:
		stackIndex = Globals.stackAssigner 
		Globals.stackAssigner += 1
		sharingWithX -= 1
		resituate()


func countNumberOfRivalsInSpace():
	rivalsInSpace = 0
	var areas : Array
	areas = get_overlapping_areas()
	for i in range(len(get_overlapping_areas())):
		if areas[i].playerNumber != playerNumber:
			rivalsInSpace += 1
func resituate():
	countNumberOfRivalsInSpace()
	sprite.position = spaceDictionary[sharingWithX][stackIndex]
	collisionShape.position = spaceDictionary[sharingWithX][stackIndex]
	var tween = create_tween()
	tween.tween_property(charHolder, 'global_position', sprite.global_position, .5)

func _on_mouse_entered() -> void:
	Globals.mouseInArea = true
func _on_mouse_exited() -> void:
	Globals.mouseInArea = false
	
