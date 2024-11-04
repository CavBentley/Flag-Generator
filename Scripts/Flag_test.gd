extends Node2D

# Hi!

var rng = RandomNumberGenerator.new()

var arraytofill = []

var size_x = 384 #Make this changable by the user!!! AND SHOW THE RATIO
var size_y = 216
var region = Rect2(0, 0, size_x, size_y)
var firm_region = Rect2(0, 0, size_x, size_y)
var center = Vector2(size_x/2,size_y/2)
var circle_radius = 100

var icon1 #Polygon2D

var current_array = []
var full_array = []
var string_full_array=""
var flag_count = 0 #IDK why it doesn't reassign, its stupid that i have to do this
# Called when the node enters the scene tree for the first time.

func rfloats():
	var r = rng.randf_range(0, 1)
	return r
func gfloats():
	var g = rng.randf_range(0, 1)
	return g
func bfloats():
	var b = rng.randf_range(0, 1)
	return b
	
func String_to_Array(stupid_string):
	#stupid_string.replace(/\[|\]/g,'').split(',')
	#Use str2var or .split()
	var smart_array = []
	smart_array = str_to_var(stupid_string)
	return smart_array

func gcd(a: int, b: int) -> int:
	return a if b == 0 else gcd(b, a % b)


func ratio(a: int, b:int):
	var silly_array = []
	if a != 0 && b != 0:
		var GCF = gcd(a, b)
		var new_a = a/GCF
		silly_array.append(new_a)
		var new_b = b/GCF
		silly_array.append(new_b)
	return silly_array

@export var texture : Texture2D:
	set(value):
		texture = value
		queue_redraw()


func background(r,g,b):
	var bkrnd=ColorRect.new()
	bkrnd.position=Vector2(0,0)
	bkrnd.size=Vector2(size_x,size_y)
	bkrnd.color=Color(r, g, b, 1)
	add_child(bkrnd)
	
func horizontal_cuts(x, r, g, b, r1, g1, b1, r2 =0.0, g2 = 0.0, b2 =0.0, r3 =0.0, g3 = 0.0, b3 =0.0):
	# Where x is the amount of horz_stripes (up to 4)
	var horz_strip1
	var horz_strip2
	var horz_strip3
	var horz_strip4 
	if x >= 2 and x<=4:
		if x == 2:
			horz_strip1=ColorRect.new()
			horz_strip1.position=Vector2(0, 0)
			horz_strip1.size=Vector2(size_x,size_y/2)
			horz_strip1.color=Color(r, g, b, 1)
			horz_strip2=ColorRect.new()
			horz_strip2.position=Vector2(0,size_y/2)
			horz_strip2.size=Vector2(size_x,size_y/2)
			horz_strip2.color=Color(r1, g1, b1, 1)
		if x == 3:
			horz_strip1=ColorRect.new()
			horz_strip1.position=Vector2(0, 0)
			horz_strip1.size=Vector2(size_x,size_y/3)
			horz_strip1.color=Color(r, g, b, 1)
			horz_strip2=ColorRect.new()
			horz_strip2.position=Vector2(0,size_y/3)
			horz_strip2.size=Vector2(size_x,size_y/3)
			horz_strip2.color=Color(r1, g1, b1, 1)
			horz_strip3=ColorRect.new()
			horz_strip3.position=Vector2(0,2*size_y/3)
			horz_strip3.size=Vector2(size_x,size_y/3)
			horz_strip3.color=Color(r2, g2, b2, 1)
		if x == 4:
			horz_strip1=ColorRect.new()
			horz_strip1.position=Vector2(0, 0)
			horz_strip1.size=Vector2(size_x,size_y/4)
			horz_strip1.color=Color(r, g, b, 1)
			horz_strip2=ColorRect.new()
			horz_strip2.position=Vector2(0,size_y/4)
			horz_strip2.size=Vector2(size_x,size_y/4)
			horz_strip2.color=Color(r1, g1, b1, 1)
			horz_strip3=ColorRect.new()
			horz_strip3.position=Vector2(0,2*size_y/4)
			horz_strip3.size=Vector2(size_x,size_y/4)
			horz_strip3.color=Color(r2, g2, b2, 1)
			horz_strip4=ColorRect.new()
			horz_strip4.position=Vector2(0,3*size_y/4)
			horz_strip4.size=Vector2(size_x,size_y/4)
			horz_strip4.color=Color(r3, g3, b3, 1)
	add_child(horz_strip1)
	add_child(horz_strip2)
	add_child(horz_strip3)
	add_child(horz_strip4)
	
func vertical_cuts(x, r, g, b, r1, g1, b1, r2 =0.0, g2 = 0.0, b2 =0.0, r3 =0.0, g3 = 0.0, b3 =0.0):
	# Where x is the amount of horz_stripes (up to 4)
	var vert_strip1
	var vert_strip2
	var vert_strip3
	var vert_strip4 #Idk about this one I don't want to get rid of it but also not 100% on keeping it
	if x >= 2 and x<=4:
		if x == 2:
			vert_strip1=ColorRect.new()
			vert_strip1.position=Vector2(0, 0)
			vert_strip1.size=Vector2(size_x/2,size_y)
			vert_strip1.color=Color(r, g, b, 1)
			vert_strip2=ColorRect.new()
			vert_strip2.position=Vector2(size_x/2,0)
			vert_strip2.size=Vector2(size_x/2,size_y)
			vert_strip2.color=Color(r1, g1, b1, 1)
		if x == 3:
			vert_strip1=ColorRect.new()
			vert_strip1.position=Vector2(0, 0)
			vert_strip1.size=Vector2(size_x/3,size_y)
			vert_strip1.color=Color(r, g, b, 1)
			vert_strip2=ColorRect.new()
			vert_strip2.position=Vector2(size_x/3,0)
			vert_strip2.size=Vector2(size_x/3,size_y)
			vert_strip2.color=Color(r1, g1, b1, 1)
			vert_strip3=ColorRect.new()
			vert_strip3.position=Vector2(2*size_x/3,0)
			vert_strip3.size=Vector2(size_x/3,size_y)
			vert_strip3.color=Color(r2, g2, b2, 1)
		if x == 4:
			vert_strip1=ColorRect.new()
			vert_strip1.position=Vector2(0, 0)
			vert_strip1.size=Vector2(size_x/4,size_y)
			vert_strip1.color=Color(r, g, b, 1)
			vert_strip2=ColorRect.new()
			vert_strip2.position=Vector2(size_x/4,0)
			vert_strip2.size=Vector2(size_x/4,size_y)
			vert_strip2.color=Color(r1, g1, b1, 1)
			vert_strip3=ColorRect.new()
			vert_strip3.position=Vector2(2*size_x/4,0)
			vert_strip3.size=Vector2(size_x/4,size_y)
			vert_strip3.color=Color(r2, g2, b2, 1)
			vert_strip4=ColorRect.new()
			vert_strip4.position=Vector2(3*size_x/4,0)
			vert_strip4.size=Vector2(size_x/4,size_y)
			vert_strip4.color=Color(r3, g3, b3, 1)
	add_child(vert_strip1)
	add_child(vert_strip2)
	add_child(vert_strip3)
	add_child(vert_strip4)

func diagonal_cuts(pos, r, g, b):
	# pos = right (1)  or left (0)
	var poly = Polygon2D.new()
	if pos == 1:
		poly.set_polygon(PackedVector2Array([Vector2(size_x, 0),
									  Vector2(size_x, size_y),
									  Vector2(0, 0),
									]))
	if pos == 0:
		poly.set_polygon(PackedVector2Array([Vector2(0, 0),
									  Vector2(0, size_y),
									  Vector2(size_x, size_y),
									]))
	if pos == 2:
		poly.set_polygon(PackedVector2Array([Vector2(size_x, 0),
									  Vector2(0, size_y),
									  Vector2(size_x, size_y),
									]))
	if pos == 3:
		poly.set_polygon(PackedVector2Array([Vector2(size_x, 0),
									  Vector2(0, size_y),
									  Vector2(0, 0),
									]))
	poly.color = Color(r,g,b,1)
	add_child(poly)

func diagonal_stripes(size, r, g, b):
	#this is ONE COLOR
	# make a size argument? 
	var polyl = Polygon2D.new()
	var polyr = Polygon2D.new()
	polyl.set_polygon(PackedVector2Array([Vector2(0, 0),
								Vector2(size, 0),
								Vector2(size_x, size_y-size),
								Vector2(size_x, size_y),
								Vector2(size_x-size, size_y),
								Vector2(0, size),
								]))
	polyr.set_polygon(PackedVector2Array([Vector2(size_x, 0),
								Vector2(size_x-size, 0),
								Vector2(0, size_y-size),
								Vector2(0, size_y),
								Vector2(size, size_y),
								Vector2(size_x, size),
								]))
	polyl.color = Color(r,g,b,1)
	polyr.color = Color(r,g,b,1)
	add_child(polyl)
	add_child(polyr)

func center_triangle(pos, r, g, b):
	# pos = right (1)  or left (0) top (2) down (3)
	var poly = Polygon2D.new()
	if pos == 1:
		poly.set_polygon(PackedVector2Array([Vector2(size_x, 0),
									  Vector2(size_x, size_y),
									  Vector2(size_x/2, size_y/2),
									]))
	if pos == 0:
		poly.set_polygon(PackedVector2Array([Vector2(0, 0),
									  Vector2(0, size_y),
									  Vector2(size_x/2, size_y/2),
									]))
	if pos == 2:
		poly.set_polygon(PackedVector2Array([Vector2(0, 0),
									  Vector2(size_x, 0),
									  Vector2(size_x/2, size_y/2),
									]))
	if pos == 3:
		poly.set_polygon(PackedVector2Array([Vector2(0, size_y),
									  Vector2(size_x, size_y),
									  Vector2(size_x/2, size_y/2),
									]))
	poly.color = Color(r,g,b,1)
	add_child(poly)

func equil_triangle(pos, r, g, b):
	# pos = right (1)  or left (0) top (2) down (3)
	var poly = Polygon2D.new()
	if pos == 1:
		poly.set_polygon(PackedVector2Array([Vector2(size_x, 0),
									  Vector2(size_x, size_y),
									  Vector2((size_y), size_y/2),
									]))
	if pos == 0:
		poly.set_polygon(PackedVector2Array([Vector2(0, 0),
									  Vector2(0, size_y),
									  Vector2(size_x-size_y, size_y/2),
									]))
	poly.color = Color(r,g,b,1)
	add_child(poly)

func end_triangle(pos, r, g, b):
	# pos = right (1)  or left (0) top (2) down (3)
	var poly = Polygon2D.new()
	if pos == 1:
		poly.set_polygon(PackedVector2Array([Vector2(size_x, 0),
									  Vector2(size_x, size_y),
									  Vector2(0, size_y/2),
									]))
	if pos == 0:
		poly.set_polygon(PackedVector2Array([Vector2(0, 0),
									  Vector2(0, size_y),
									  Vector2(size_x, size_y/2),
									]))
	if pos == 2:
		poly.set_polygon(PackedVector2Array([Vector2(0, 0),
									  Vector2(size_x, 0),
									  Vector2(size_x/2, size_y),
									]))
	if pos == 3:
		poly.set_polygon(PackedVector2Array([Vector2(0, size_y),
									  Vector2(size_x, size_y),
									  Vector2(size_x/2, 0),
									]))
	poly.color = Color(r,g,b,1)
	add_child(poly)

func plus_stripes(size, r, g, b):
	#this is ONE COLOR
	# make a size argument? 
	var poly_vert = Polygon2D.new()
	var poly_horz = Polygon2D.new()
	poly_vert.set_polygon(PackedVector2Array([Vector2((size_x/2)-size, 0),
								Vector2((size_x/2)+size, 0),
								Vector2((size_x/2)+size, size_y),
								Vector2((size_x/2)-size, size_y),
								]))
	poly_horz.set_polygon(PackedVector2Array([Vector2(0, (size_y/2)-size),
								Vector2(size_x, (size_y/2)-size),
								Vector2(size_x, (size_y/2)+size),
								Vector2(0, (size_y/2)+size),
								]))
	poly_vert.color = Color(r,g,b,1)
	poly_horz.color = Color(r,g,b,1)
	add_child(poly_vert)
	add_child(poly_horz)

func border(size, r, g, b):
	#this is ONE COLOR
	var poly_vert = Polygon2D.new()
	var poly_horz = Polygon2D.new()
	var poly_vert1 = Polygon2D.new()
	var poly_horz1 = Polygon2D.new()
	poly_vert.set_polygon(PackedVector2Array([Vector2(0, 0),
								Vector2(size_x, 0),
								Vector2(size_x, size),
								Vector2(0, size),
								]))
	poly_horz.set_polygon(PackedVector2Array([Vector2(0, 0),
								Vector2(0, size_y),
								Vector2(size, size_y),
								Vector2(size, 0),
								]))
	poly_vert1.set_polygon(PackedVector2Array([Vector2(0, size_y),
								Vector2(size_x, size_y),
								Vector2(size_x, size_y-size),
								Vector2(0, size_y-size),
								]))
	poly_horz1.set_polygon(PackedVector2Array([Vector2(size_x, 0),
								Vector2(size_x-size, 0),
								Vector2(size_x-size, size_y),
								Vector2(size_x, size_y),
								]))
	poly_vert.color = Color(r,g,b,1)
	poly_horz.color = Color(r,g,b,1)
	poly_vert1.color = Color(r,g,b,1)
	poly_horz1.color = Color(r,g,b,1)
	add_child(poly_vert)
	add_child(poly_horz)
	add_child(poly_vert1)
	add_child(poly_horz1)

func icon(name):
	var poly_vert = Polygon2D.new()
	
	
func circle(radius, position: Vector2, r, g, b):
	pass
	
#func generate_circle_polygon(radius: float, num_sides: int, position: Vector2) -> PackedVector2Array:
	#var angle_delta: float = (PI * 2) / num_sides
	#var vector: Vector2 = Vector2(radius, 0)
	#var polygon: PackedVector2Array
#
	#for _i in num_sides:
		#polygon.append(vector + position)
		#vector = vector.rotated(angle_delta)
	#
	#polygon.color = Color(256,256,256,1)
	#return polygon

#func ran_color_flag_maker(Array A) -> Array:
	#var r = rfloats()
	
	
func ran_flag_maker() -> Array:
	# THIS FUNCTION ONLY PRODCUES AN ARRAY!!!!!!
	# 0 = False, 1 = True
	
	#Predicts if there will be a horizontal or vertical stripes
	var ran_for_stripes = rng.randi_range(0, 10)
	var background_applicable = 1
	if ran_for_stripes >= 5:
		background_applicable = 0
	
	#Background
	if background_applicable == 1:
		var r10 = rfloats()
		var g10 = gfloats()
		var b10 = bfloats()
		#background(r10,g10,b10)
		arraytofill.append([0, r10, g10, b10])
	
	#Stripes
	if background_applicable == 0:
		var r1 = rfloats()
		var g1 = gfloats()
		var b1 = bfloats()
		var r2 = rfloats()
		var g2 = gfloats()
		var b2 = bfloats()
		var r1_2 = rfloats()
		var g1_2 = gfloats()
		var b1_2 = bfloats()
		var r2_2 = rfloats()
		var g2_2 = gfloats()
		var b2_2 = bfloats()
		if ran_for_stripes >=5 && ran_for_stripes <=7:
			if ran_for_stripes == 5:
				#horizontal_cuts(2, r1, g1, b1, r2, g2, b2)
				arraytofill.append([1, 2, r1, g1, b1, r2, g2, b2])
			if ran_for_stripes == 6:
				#horizontal_cuts(3, r1, g1, b1, r2, g2, b2, r1_2, g1_2, b1_2)
				arraytofill.append([1, 3, r1, g1, b1, r2, g2, b2, r1_2, g1_2, b1_2])
			if ran_for_stripes == 7:
				#horizontal_cuts(4, r1, g1, b1, r2, g2, b2, r1_2, g1_2, b1_2, r2_2, g2_2, b2_2)
				arraytofill.append([1, 4, r1, g1, b1, r2, g2, b2, r1_2, g1_2, b1_2, r2_2, g2_2, b2_2])
		if ran_for_stripes >=8 && ran_for_stripes <=10:
			if ran_for_stripes == 8:
				#vertical_cuts(2, r1, g1, b1, r2, g2, b2)
				arraytofill.append([2, 2, r1, g1, b1, r2, g2, b2])
			if ran_for_stripes == 9:
				#vertical_cuts(3, r1, g1, b1, r2, g2, b2, r1_2, g1_2, b1_2)
				arraytofill.append([2, 3, r1, g1, b1, r2, g2, b2, r1_2, g1_2, b1_2])
			if ran_for_stripes == 10:
				#vertical_cuts(4, r1, g1, b1, r2, g2, b2, r1_2, g1_2, b1_2, r2_2, g2_2, b2_2)
				arraytofill.append([2, 4, r1, g1, b1, r2, g2, b2, r1_2, g1_2, b1_2, r2_2, g2_2, b2_2])
	
	#Diagonal Cuts
	for i in range(1, 5):
		var ran3 = rng.randi_range(0, 6*i) #Make range smaller for higher chance
		if ran3 == 1:
			var r3 = rfloats()
			var g3 = gfloats()
			var b3 = bfloats()
			var pos = rng.randi_range(0,3)
			#diagonal_cuts(pos, r3, g3, b3)
			arraytofill.append([3, pos, r3, g3, b3])
		else:
			break
	
	#End Triangle
	for i in range(1, 5):
		var ran4 = rng.randi_range(0, 6*i) #Make range smaller for higher chance
		if ran4 == 1:
			var r4 = rfloats()
			var g4 = gfloats()
			var b4 = bfloats()
			var pos = rng.randi_range(0,3)
			#end_triangle(pos, r4, g4, b4)
			arraytofill.append([4, pos, r4, g4, b4])
		else:
			break
	
	#Center Triangle
	for i in range(1, 5):
		var ran5 = rng.randi_range(0, 6*i) #Make range smaller for higher chance
		if ran5 == 1:
			var r5 = rfloats()
			var g5 = gfloats()
			var b5 = bfloats()
			var pos = rng.randi_range(0,3)
			#center_triangle(pos, r5, g5, b5)
			arraytofill.append([5, pos, r5, g5, b5])
		else:
			break
	
	#Equilateral Triangle
	for i in range(1, 3):
		var ran6 = rng.randi_range(0, 6*i) #Make range smaller for higher chance
		if ran6 == 1:
			var r6 = rfloats()
			var g6 = gfloats()
			var b6 = bfloats()
			var pos = rng.randi_range(0,1)
			#equil_triangle(pos, r6, g6, b6)
			arraytofill.append([6, pos, r6, g6, b6])
		else:
			break
	
	
	#Diagonal Stripes
	var past_size7 = 130
	for i in range(1, 4):
		var ran7 = rng.randi_range(0, 6*i) #Make range smaller for higher chance
		if ran7 == 1:
			var r7 = rfloats()
			var g7 = gfloats()
			var b7 = bfloats()
			var size7 = rng.randi_range(1, 130)
			if size7 <= past_size7:
				#diagonal_stripes(size7, r7, g7, b7)
				arraytofill.append([7, size7, r7, g7, b7])
				past_size7 = size7
		else:
			break
	
	#Border
	var past_size8 = size_y/2
	for i in range(1, 4):
		var ran8 = rng.randi_range(0, 7*i) #Make range smaller for higher chance
		if ran8 == 1:
			var r8 = rfloats()
			var g8 = gfloats()
			var b8 = bfloats()
			var size8 = rng.randi_range(1, size_y/2)
			if size8 <= past_size8:
				#border(size8, r8, g8, b8)
				arraytofill.append([8, size8, r8, g8, b8])
				past_size8 = size8
		else:
			break
	#Circle
	#var ran9 = rng.randi_range(0,7)
	var ran9 = 1
	if ran9 == 1:
		var r9 = rfloats()
		var g9 = gfloats()
		var b9 = bfloats()
		var color = Color(r9,g9,b9,1)
		if size_x >= size_y:
			var circle_radius = rng.randi_range(1,size_y)
		else:
			var circle_radius = rng.randi_range(1,size_x)
		arraytofill.append([9, position, circle_radius, r9, g9, b9])
	return arraytofill



func flag_loader(array: Array):
	var array_item = []
	var item = 0
	for i in range(0, array.size()):
		array_item = array[i]
		item = array_item[0] # item = index of function (0 = background)
		#print(item)
		if item == 0: #Background
			var r = array_item[1]
			var g = array_item[2]
			var b = array_item[3]
			background(r,g,b)
		if item == 1: #Horz
			if array_item[1] == 2:
				var r = array_item[2]
				var g = array_item[3]
				var b = array_item[4]
				var r1 = array_item[5]
				var g1 = array_item[6]
				var b1 = array_item[7]
				horizontal_cuts(2,r,g,b,r1,g1,b1)
			if array_item[1] == 3:
				var r = array_item[2]
				var g = array_item[3]
				var b = array_item[4]
				var r1 = array_item[5]
				var g1 = array_item[6]
				var b1 = array_item[7]
				var r2 = array_item[8]
				var g2 = array_item[9]
				var b2 = array_item[10]
				horizontal_cuts(3,r,g,b,r1,g1,b1,r2,g2,b2)
			if array_item[1] == 4:
				var r = array_item[2]
				var g = array_item[3]
				var b = array_item[4]
				var r1 = array_item[5]
				var g1 = array_item[6]
				var b1 = array_item[7]
				var r2 = array_item[8]
				var g2 = array_item[9]
				var b2 = array_item[10]
				var r3 = array_item[11]
				var g3 = array_item[12]
				var b3 = array_item[13]
				horizontal_cuts(4,r,g,b,r1,g1,b1,r2,g2,b2,r3,g3,b3)
		if item == 2: #Vert
			if array_item[1] == 2:
				var r = array_item[2]
				var g = array_item[3]
				var b = array_item[4]
				var r1 = array_item[5]
				var g1 = array_item[6]
				var b1 = array_item[7]
				vertical_cuts(2,r,g,b,r1,g1,b1)
			if array_item[1] == 3:
				var r = array_item[2]
				var g = array_item[3]
				var b = array_item[4]
				var r1 = array_item[5]
				var g1 = array_item[6]
				var b1 = array_item[7]
				var r2 = array_item[8]
				var g2 = array_item[9]
				var b2 = array_item[10]
				vertical_cuts(3,r,g,b,r1,g1,b1,r2,g2,b2)
			if array_item[1] == 4:
				var r = array_item[2]
				var g = array_item[3]
				var b = array_item[4]
				var r1 = array_item[5]
				var g1 = array_item[6]
				var b1 = array_item[7]
				var r2 = array_item[8]
				var g2 = array_item[9]
				var b2 = array_item[10]
				var r3 = array_item[11]
				var g3 = array_item[12]
				var b3 = array_item[13]
				vertical_cuts(4,r,g,b,r1,g1,b1,r2,g2,b2,r3,g3,b3)
		if item == 3: #Diagonal Cuts
			var pos = array_item[1]
			var r = array_item[2]
			var g = array_item[3]
			var b = array_item[4]
			diagonal_cuts(pos,r,g,b)
		if item == 4: #End Triangle
			var pos = array_item[1]
			var r = array_item[2]
			var g = array_item[3]
			var b = array_item[4]
			end_triangle(pos,r,g,b)
		if item == 5: #Center Triangle
			var pos = array_item[1]
			var r = array_item[2]
			var g = array_item[3]
			var b = array_item[4]
			center_triangle(pos,r,g,b)
		if item == 6: #Equilateral Triangle
			var pos = array_item[1]
			var r = array_item[2]
			var g = array_item[3]
			var b = array_item[4]
			equil_triangle(pos,r,g,b)
		if item == 7: #Diagonal Triangle
			var size = array_item[1]
			var r = array_item[2]
			var g = array_item[3]
			var b = array_item[4]
			diagonal_stripes(size,r,g,b)
		if item == 8: #Border
			var size = array_item[1]
			var r = array_item[2]
			var g = array_item[3]
			var b = array_item[4]
			border(size,r,g,b)
		if item == 9:
			_draw()
	firm_region = region

#func save():
	#var save = PackedScene.new()
	#for c in self.get_children():
		#c.set_owner(self)
	#save.pack(self)
	#ResourceSaver.save(save, "res://JDC.tscn")
	#FileAccess.save_var()

#func _draw():
	#var ran9 = rng.randi_range(1, 2)
	#if ran9 == 1:
		#if size_x >= size_y:
			#var circle_radius = rng.randi_range(1,size_y)
		#else:
			#var circle_radius = rng.randi_range(1,size_x)
		#var r9 = rfloats()
		#var g9 = gfloats()
		#var b9 = bfloats()
		#var color = Color(r9,g9,b9,1)
		#set_global_position(center)
		#draw_circle(position, circle_radius, color)
		#arraytofill.append([9, position, circle_radius, r9, g9, b9])

func _draw():
	var array_item = []
	var item = 0
	for i in range(0, arraytofill.size()):
		array_item = arraytofill[i]
		item = array_item[0] # item = index of function (0 = background)
		#print(item)
		if item == 9:
			print("drawing")
			var circle_radius = array_item[2]
			var r9 = array_item[3]
			var g9 = array_item[4]
			var b9 = array_item[5]
			var color = Color(r9,g9,b9,1)
			set_global_position(center)
			draw_circle(position, circle_radius, color)
# C:/Users/wolft/Downloads/FlagImage-


func save_full(content):
	var file = FileAccess.open("C:/Users/wolft/Downloads/AllFlags.txt", FileAccess.WRITE)
	file.store_string(content)
func save(content):
	var file2 = FileAccess.open("C:/Users/wolft/Downloads/LatestFlag.txt", FileAccess.WRITE)
	file2.store_string(content)
#"user://save_game.dat"
func load():
	var file = FileAccess.open("C:/Users/wolft/Downloads/Test.txt", FileAccess.READ)
	var content = file.get_as_text()
	return content


func _ready():
	
	#Manual Flag Loader
	#flag_loader([[1, 2, 0.53986954689026, 0.83116608858109, 0.72330510616302, 0.63153827190399, 0.67106854915619, 0.27056628465652], [3, 2, 0.82124531269073, 0.03621172532439, 0.78931576013565], [5, 1, 0.74769020080566, 0.13423976302147, 0.87819617986679], [8, 42, 0.34034031629562, 0.66358017921448, 0.10202322900295]])
	
	
	#Random Flag Maker (Array)
	current_array = ran_flag_maker()

	#Automatic Flag_loader(current_array)
	flag_loader(current_array)
	
	var string_array = str(current_array)
	print(string_array)
	#save(str)
	
	#String name = load()
	#print(load())
	#save(current_array)
	
	#icon("circle")

	#$ColorRect.color = Color(r8, g8, b8, a8) # Set ColorRect's color to red.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


#func _on_check_button_toggled(toggled_on):
	#print("I will download the Flag now")
	#var string_array = str(current_array)
	#save(string_array)
	##save(content)


func _on_button_pressed(): #Button_NewFlag
	current_array.clear()
	current_array = ran_flag_maker()
	flag_loader(current_array)
	#for i in range(0,flag_count+10): # saves only the current flag
		#current_array.remove_at(i)
	
	var string_array = str(current_array)
	print(string_array)
	#flag_count += 1



func _on_button_save_list_pressed(): #Button_SaveList
	print("I will download the Flag List now")
	full_array = current_array
	var string_array = str(current_array)
	string_full_array += str(full_array)
	string_full_array += "\n"
	string_full_array += "\n"
	#string_full_array = str(full_array)
	save(string_array)
	save_full(string_full_array)

var to3d = ""

func _on_line_edit_sl_text_changed(new_text):
	to3d = new_text
	return to3d


func _on_button_save_image_pressed():
	print("I will download the Flag Image now")
	print(to3d)
	var capture = get_viewport().get_texture().get_image().get_region(firm_region)
	var _time = Time.get_datetime_string_from_system()
	var newtime = ""
	for char in _time:
		if char == ":":
			char = "."
		if char == "T":
			char = "_"
		newtime += char
	#var filename = "C:/Users/wolft/Downloads/FlagImage-"
	to3d += "-{0}.png".format({"0":newtime})
	capture.save_png(to3d)
	#var image = get_viewport().get_texture().get_data()
	#image.flip_y()
	#image.save_png("C:/Users/wolft/Downloads/FlagImage.png")
	#$Viewport.get_texture().get_image().save_png("user://Screenshot.png")



func _on_ready_pressed():
	var manual_input = $Paste_Text_Here.text #still don't know what $ means
	var array_manual_input = String_to_Array(manual_input)
	flag_loader(array_manual_input)
	print(manual_input)




func _on_line_edit_text_changed(length_text):
	var length = str_to_var(length_text)
	if typeof(length) == TYPE_NIL:
		length = 0
	if typeof(length) != TYPE_NIL:
		if length > 500:
			length = 500
		if length < 1:
			length = 1
	size_x = length
	region = Rect2(0, 0, size_x, size_y)
	var array = ratio(size_x,size_y)
	#print(array[0],":", array[1])
	$Ratio.clear()
	var stringy = ""
	stringy += str(array[0])
	stringy += ":"
	stringy += str(array[1])
	$Ratio.add_text(stringy)

func _on_line_edit_w_text_changed(height_text):
	var height = str_to_var(height_text)
	if typeof(height) == TYPE_NIL:
		height = 0
	if typeof(height) != TYPE_NIL:
		if height > 500:
			height = 500
		if height < 1:
			height = 1
	size_y = height
	region = Rect2(0, 0, size_x, size_y)
	var array = ratio(size_x,size_y)
	print(array[0],":", array[1])
	$Ratio.clear()
	var stringy = ""
	stringy += str(array[0])
	stringy += ":"
	stringy += str(array[1])
	$Ratio.add_text(stringy)



func _on_line_edit_h_text_change_rejected(rejected_substring):
	pass # Replace with function body.


func _on_make_3d_pressed():
	pass # Replace with function body.


