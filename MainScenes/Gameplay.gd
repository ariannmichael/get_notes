extends Node

var plEnemy = preload("res://Enemy/Enemy.tscn")
var plNote = preload("res://Note/Note.tscn")

export var enemyMinSpeed: float = 90.0
export var enemyMaxSpeed: float = 100.0

export var noteMinSpeed: float = 60.0
export var noteMaxSpeed: float = 80.0

var time: float = 0
var start = OS.get_ticks_msec()

func _process(delta):
	time += delta
	
	if time >= 1:
		time = 0
		var positionX = rand_range(0, get_viewport().size.x)
		var positionY = 0
		
		spwaner(positionX, positionY)
	
	if OS.get_ticks_msec() - start >= 5000:
		start = OS.get_ticks_msec()
		speedUp()

func speedUp():
	enemyMinSpeed += 10
	enemyMaxSpeed += 10
	noteMinSpeed += 10
	noteMaxSpeed += 10

func spwaner(x, y):
	var objectType = int(rand_range(0, 2))
	var object = null
	
	if objectType == 0:
		object = plEnemy.instance()
		object.minSpeed = enemyMinSpeed
		object.maxSpeed = enemyMaxSpeed
	else:
		object = plNote.instance()
		object.minSpeed = noteMinSpeed
		object.maxSpeed = noteMaxSpeed
		
	
	object.position.x = x
	object.position.y = y

	get_parent().add_child(object)
