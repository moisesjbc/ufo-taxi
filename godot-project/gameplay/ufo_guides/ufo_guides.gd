extends Path2D

var n_divisions_per_edge = 5

var path_vertices = []
var ufo_guide_scene = load("res://gameplay/ufo_guides/ufo_guide/ufo_guide.tscn")
var distance_between_guides = 300
var going_forwad = true

func reset():
	going_forwad = true
	for node in get_children():
		node.set_going_forward(going_forwad)

func clear():
	curve.clear_points()
	for child in get_children():
		child.queue_free()
		
func reverse():
	going_forwad = not going_forwad
	for node in get_children():
		node.set_going_forward(going_forwad)

func set_path_vertices(path_vertices):
	clear()

	self.path_vertices = path_vertices

	var total_distance = 0
	for i in range(0, len(path_vertices) - 1):
		curve.add_point(path_vertices[i])
		total_distance += path_vertices[i].distance_to(path_vertices[i+1])
	curve.add_point(path_vertices[len(path_vertices) - 1])
	total_distance += path_vertices[len(path_vertices) - 1].distance_to(path_vertices[0])
	curve.add_point(path_vertices[0])
	
	var n_divisions = total_distance / distance_between_guides
	for i in range(0, n_divisions):
		var ufo_guide = ufo_guide_scene.instance()
		ufo_guide.offset = i * distance_between_guides
		ufo_guide.set_going_forward(going_forwad)
		add_child(ufo_guide)
