extends Area2D
class_name Enemy

export var minSpeed: float = 90.0
export var maxSpeed: float = 100.0

var speed: float = 0
var playerInArea: Player = null

func _ready():
	speed = rand_range(minSpeed, maxSpeed)

func _process(_delta):
	playerCollision()

func _physics_process(delta):
	position.y += speed * delta

func speedUp():
	minSpeed += 10
	maxSpeed += 10
	speed = rand_range(minSpeed, maxSpeed)

func playerCollision():
	if playerInArea != null:
		playerInArea.damage(1)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Enemy_area_entered(area):
	if area is Player:
		playerInArea = area

func _on_Enemy_area_exited(area):
	if area is Player:
		playerInArea = area
