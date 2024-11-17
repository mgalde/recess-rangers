extends Node2D

# Reference to buttons using onready variables
@onready var play_button = $MenuContainer/PlayButton
@onready var options_button = $MenuContainer/OptionsButton
@onready var quit_button = $MenuContainer/QuitButton

func _ready():
	# Connect button signals
	play_button.pressed.connect(_on_play_button_pressed)
	options_button.pressed.connect(_on_options_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	
	# Optional: Add hover effects
	play_button.mouse_entered.connect(_on_button_hover.bind(play_button))
	play_button.mouse_exited.connect(_on_button_normal.bind(play_button))
	options_button.mouse_entered.connect(_on_button_hover.bind(options_button))
	options_button.mouse_exited.connect(_on_button_normal.bind(options_button))
	quit_button.mouse_entered.connect(_on_button_hover.bind(quit_button))
	quit_button.mouse_exited.connect(_on_button_normal.bind(quit_button))

func _on_play_button_pressed():
	print("Play button pressed")
	get_tree().change_scene_to_file("res://scenes/level0.tscn")

func _on_options_button_pressed():
	print("Options button pressed")
	# Will implement options menu later

func _on_quit_button_pressed():
	show_quit_confirmation()

func show_quit_confirmation():
	var confirm = ConfirmationDialog.new()
	add_child(confirm)
	
	# Set up dialog properties
	confirm.title = "Quit Game"
	confirm.dialog_text = "Are you sure you want to exit?"
	confirm.get_ok_button().text = "Yes"
	confirm.get_cancel_button().text = "No"
	
	# Connect the confirmation signal BEFORE showing the dialog
	confirm.confirmed.connect(func(): _on_quit_confirmed(confirm))
	# Connect cancel signal to cleanup
	confirm.canceled.connect(func(): _on_quit_canceled(confirm))
	
	# Center and show the dialog
	confirm.popup_centered()

func _on_quit_confirmed(dialog: ConfirmationDialog):
	# Create fade out effect
	var tween = create_tween()
	tween.tween_property($MenuContainer, "modulate", Color(1, 1, 1, 0), 0.5)
	tween.finished.connect(func(): _finish_quit(dialog))

func _on_quit_canceled(dialog: ConfirmationDialog):
	# Clean up the dialog
	dialog.queue_free()

func _finish_quit(dialog: ConfirmationDialog):
	# Clean up and quit
	dialog.queue_free()
	get_tree().quit()

# Optional hover effects
func _on_button_hover(button: Button):
	var tween = create_tween()
	tween.tween_property(button, "scale", Vector2(1.1, 1.1), 0.1)
	
func _on_button_normal(button: Button):
	var tween = create_tween()
	tween.tween_property(button, "scale", Vector2(1.0, 1.0), 0.1)

# Optional: Add keyboard shortcut for quitting
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):  # ESC key
		show_quit_confirmation()
