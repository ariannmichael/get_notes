extends CanvasLayer

onready var score_label := $GameoverMenu/VBoxContainer/ScoreLabel
onready var high_score_label := $GameoverMenu/VBoxContainer/HighScoreLabel
onready var game_over_menu := $GameoverMenu

func init_game_over_menu(score, highscore):
	score_label.text = "SCORE: " + str(score)
	high_score_label.text = "BEST: " + str(highscore)
	game_over_menu.visible = true

func _on_Restart_pressed():
	var objects = get_tree().get_nodes_in_group("pickable")
	for object in objects:
		object.queue_free()
		
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
	#get_tree().change_scene("res://MainScenes/Startup.tscn")
