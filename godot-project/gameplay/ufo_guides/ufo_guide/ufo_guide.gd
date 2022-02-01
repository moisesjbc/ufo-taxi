extends PathFollow2D

var speed = 50
var going_forward = 1

func _physics_process(delta):
	var speed_multiplier = 1
	if not going_forward:
		speed_multiplier = -1
	offset = offset + speed_multiplier * speed * delta


func set_going_forward(going_forward):
	self.going_forward = going_forward
