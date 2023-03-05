extends Area2D
class_name Player

signal died

onready var invicibilityTimer := $InvicibilityTimer
onready var animationPlayer := $AnimationPlayer

export var life: int = 3
export var damageInvicibilityTime: float = 2
export var speed: float = 200
var velocity := Vector2.ZERO
var is_dragging: bool = false
var touchpos = 0
var alive = true

func _ready():
	Signals.emit_signal("on_player_life_changed", life)

func _input(event):
	if event is InputEventMouseButton:
		is_dragging = true
	else:
		is_dragging = false
	
	if is_dragging:
		touchpos = event.position

func _physics_process(delta):
	if alive:
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
	animationPlayer.play("Blink")
	life -= amount
	Signals.emit_signal("on_player_life_changed", life)
	
	if life <= 0:
		emit_signal("died")
		alive = false


func _on_InvicibilityTimer_timeout():
	animationPlayer.stop()
