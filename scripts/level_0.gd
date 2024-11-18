extends Node2D


# Add this to your main game setup script or autoload
func setup_input_mapping():
	# Movement Controls
	if not InputMap.has_action("move_up"):
		InputMap.add_action("move_up")
		var ev_w = InputEventKey.new()
		ev_w.keycode = KEY_W
		InputMap.action_add_event("move_up", ev_w)
		var ev_up = InputEventKey.new()
		ev_up.keycode = KEY_UP
		InputMap.action_add_event("move_up", ev_up)
	
	if not InputMap.has_action("move_down"):
		InputMap.add_action("move_down")
		var ev_s = InputEventKey.new()
		ev_s.keycode = KEY_S
		InputMap.action_add_event("move_down", ev_s)
		var ev_down = InputEventKey.new()
		ev_down.keycode = KEY_DOWN
		InputMap.action_add_event("move_down", ev_down)
	
	if not InputMap.has_action("move_left"):
		InputMap.add_action("move_left")
		var ev_a = InputEventKey.new()
		ev_a.keycode = KEY_A
		InputMap.action_add_event("move_left", ev_a)
		var ev_left = InputEventKey.new()
		ev_left.keycode = KEY_LEFT
		InputMap.action_add_event("move_left", ev_left)
	
	if not InputMap.has_action("move_right"):
		InputMap.add_action("move_right")
		var ev_d = InputEventKey.new()
		ev_d.keycode = KEY_D
		InputMap.action_add_event("move_right", ev_d)
		var ev_right = InputEventKey.new()
		ev_right.keycode = KEY_RIGHT
		InputMap.action_add_event("move_right", ev_right)
