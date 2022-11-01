extends KinematicBody2D

func detect_unit():
	for i in get_slide_count():
		var collider = get_slide_collision(i)
		if collider.collider.name == 'unit_foot':
			print('Enemy')

func _physics_process(delta):
	detect_unit()
