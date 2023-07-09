extends HBoxContainer

@onready var start_button = %StartButton
@onready var quit_button = %QuitButton

func _ready():
	start_button.grab_focus()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

