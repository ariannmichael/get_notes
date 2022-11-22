extends Area2D
class_name Player

onready var invicibilityTimer := $InvicibilityTimer

export var life: int = 3
export var damageInvicibilityTime: float = 2
export var speed: float = 200
var velocity := Vector2.ZERO

func _ready():
	Signals.emit_signal("on_player_life_changed", life)

func _physics_process(delta):
	movement(delta)

func movement(delta):
	var dirVec := Vector2.ZERO
	
	if Input.is_action_pressed("move_left"):
		dirVec.x = -1
	elif Input.is_action_pressed("move_right"):
		dirVec.x = 1
	
	velocity = dirVec.normalized() * speed
	position += velocity * delta
	
	var viewRect := get_viewport_rect()
	position.x = clamp(position.x, viewRect.position.x, viewRect.end.x)
	position.y = clamp(position.y, viewRect.position.y, viewRect.end.y)

func damage(amount: int):
	if !invicibilityTimer.is_stopped():
		return
	
	invicibilityTimer.start(damageInvicibilityTime)
	life -= amount
	Signals.emit_signal("on_player_life_changed", life)
	
	if life <= 0:
		queue_free()


func _on_InvicibilityTimer_timeout():
	pass # Replace with function body.
