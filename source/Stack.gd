extends Panel

export(PackedScene) var card_scene
export(int) var card_offset = 25
export(int, "AscendingSameColor", "DescendingAlternatingcolor") var stack_rule = 1

func add_card(face, is_face_up):
	var new_card = card_scene.instance()
	new_card.face = face
	new_card.is_face_up = is_face_up
	add_child(new_card)
	new_card.rect_position = Vector2(0, (get_children().size() - 1) * card_offset)

func receive_card(card_node):
	card_node.get_parent().remove_child(card_node)
	add_child(card_node)
	card_node.rect_position = Vector2(0, (get_children().size() - 1) * card_offset)	

func reveal_next():
	var children = get_children()
	if children.size() == 0:
		return
	var last_card = children[children.size() - 1]
	if (last_card.is_face_up):
		return
	last_card.reveal()

func get_child_cards(starting_card):
	var children = get_children()
	var child_cards = []
	var found_card = false
	for card in children:
		if card == starting_card or found_card:
			found_card = true
			child_cards.append(card)
	return child_cards

func _on_Stack_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if get_children().size() == 0 and Global.selected_card != null:
			var card_info = Global.get_card_num_and_suit(Global.selected_card.face)
			if stack_rule == 1 and card_info[0] == "K":
				Global.move_selected_card(self)
			elif stack_rule == 0 and card_info[0] == "A":
				Global.move_selected_card(self)

func get_top_card_face():
	var children = get_children()
	if children.size() == 0:
		return null
	return children[children.size() - 1].face
