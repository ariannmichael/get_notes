extends Area2D
class_name Note

onready var point_sound = $Point

export var minSpeed: float = 60.0
export var maxSpeed: float = 80.0

var speed: float = 0
var playerInArea: Player = null
var time: float = 0

func _ready():
	speed = rand_range(minSpeed, maxSpeed)

func _process(delta):
	playerCollision()
	time += delta
	
	if time >= 60:
		time = 0
		speedUp()

func _physics_process(delta):
	position.y += speed * delta

func speedUp():
	minSpeed += 10
	maxSpeed += 10
	speed = rand_range(minSpeed, maxSpeed)

func playerCollision():
	if playerInArea != null:
		Signals.emit_signal("on_score_increment", 1)
		point_sound.play()
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Area2D_area_entered(area):
	if area is Player:
		playerInArea = area

func _on_Area2D_area_exited(area):
	if area is Player:
		playerInArea = area
