extends TextureRect

export(String) var face
export(bool) var is_face_up = false
export(Texture) var back_texture
export(bool) var is_selected = false
export(Color) var selected_color

var face_texture: Texture

func _ready():
	face_texture = load("res://images/cards/" + face + ".png")
	update_display()

func select():
	is_selected = true
	update_display()

func deselect():
	is_selected = false
	update_display()

func reveal():
	is_face_up = true
	update_display()

func update_display():
	if is_face_up:
		texture = face_texture
	else:
		texture = back_texture
	
	if is_selected:
		modulate = selected_color
	else:
		modulate = Color.white
	
func _on_Card_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if !is_face_up:
			return
		elif Global.selected_card == null && !is_selected:
			Global.selected_card = self
			select()
		elif is_selected:
			Global.selected_card = null
			deselect()
		else:
			try_move_selected()

func try_move_selected():
	if Global.can_drop_onto_card(self):
		Global.move_selected_card(get_parent())
	else:
		Global.selected_card.deselect()
		Global.selected_card = null
		Global.selected_card = self
		select()
