extends Node

func _on_Button_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://MainScenes/Gameplay.tscn")



func _on_Button2_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://MainScenes/Credits.tscn")
