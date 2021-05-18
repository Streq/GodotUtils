extends RigidBody2D


func _physics_process(delta):
	var dir = Vector2(float(Input.is_action_pressed("ui_right")) - float(Input.is_action_pressed("ui_left")), float(Input.is_action_pressed("ui_down")) - float(Input.is_action_pressed("ui_up"))).normalized()
	apply_central_impulse(dir*1000)
