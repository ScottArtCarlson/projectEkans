extends CenterContainer

@onready var start_game_button = %StartGameButton
@onready var quit_button = %QuitButton

func _ready():
	start_game_button.grab_focus()

func _on_start_game_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
