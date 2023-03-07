extends Node

var plEnemy = preload("res://Enemy/Enemy.tscn")
var plNote = preload("res://Note/Note.tscn")

const SAVE_FILE_PATH = "user://savedata.save"

onready var gameover_layer = $Gameover
onready var HUD = $HUD/HUD
onready var death_sound = $Death

export var enemyMinSpeed: float = 100.0
export var enemyMaxSpeed: float = 120.0

export var noteMinSpeed: float = 70.0
export var noteMaxSpeed: float = 90.0

var time: float = 0
var start = OS.get_ticks_msec()
var playerAlive: bool = true
var highscore = 0

func _ready():
	randomize()
	load_highscore()

func _process(delta):
	if !playerAlive: return 
	
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


func _on_Player_died():
	death_sound.play()
	game_over()

func game_over():
	playerAlive = false
	get_tree().call_group("pickable", "set_physics_process", false)
	var score = HUD.score
	
	if score > highscore:
		highscore = score
		save_highscore()
		
	gameover_layer.init_game_over_menu(score, highscore)

func save_highscore():
	var save_data = File.new()
	save_data.open(SAVE_FILE_PATH, File.WRITE)
	save_data.store_var(highscore)
	save_data.close()

func load_highscore():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH, File.READ)
		highscore = save_data.get_var()
		save_data.close()
