extends Control

var plLifeIcon = preload("res://HUD/LifeIcon.tscn")

onready var lifeContainer := $LifeContainer
onready var scoreLabel := $Score

var score: int = 0

func _ready():
	clearLives()
	Signals.connect("on_player_life_changed", self, "_on_player_life_changed")
	Signals.connect("on_score_increment", self, "_on_score_increment")

func clearLives():
	for child in lifeContainer.get_children():
		child.queue_free()
		
func setLives(lives: int):
	clearLives()
	for _i in range(lives):
		lifeContainer.add_child(plLifeIcon.instance())

func _on_player_life_changed(life: int):
	setLives(life)

func _on_score_increment(amount: int):
	score += amount
	scoreLabel.text = str(score)
