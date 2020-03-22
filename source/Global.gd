extends Node

var selected_card: TextureRect

var card_order = ["A","2","3","4","5","6","7","8","9","10","J","Q","K"]

func get_card_num_and_suit(face):
	var num = ""
	if face.length() == 2:
		num = face.substr(0, 1)
	else:
		num = face.substr(0, 2)
	
	var suit = ""
	if face.length() == 2:
		suit = face.substr(1, 1)
	else:
		suit = face.substr(2, 1)
	
	var color = ""
	if suit == "C" or suit == "S": color = "Black"
	else: color = "Red"
	
	return [num, suit, color]

func can_drop_onto_card(target_card):
	var drop_card_vals = get_card_num_and_suit(target_card.face)
	var drop_num = drop_card_vals[0]
	var drop_suit = drop_card_vals[1]
	var drop_color = drop_card_vals[2]
	
	var drag_card_vals = get_card_num_and_suit(selected_card.face)
	var drag_num = drag_card_vals[0]
	var drag_suit = drag_card_vals[1]
	var drag_color = drag_card_vals[2]
	
	var drop_ix = card_order.find(drop_num)
	var drag_ix = card_order.find(drag_num)
	
	var target_stack = target_card.get_parent()
	
	if target_stack.stack_rule == 1 and\
	(drop_ix != drag_ix + 1 or drop_color == drag_color):
		return false
	
	if target_stack.stack_rule == 0 and\
	(drop_ix != drag_ix - 1 or drop_suit != drag_suit):
		return false
	
	return true

func move_selected_card(stack):
	var old_stack = selected_card.get_parent()
	var moving_cards = old_stack.get_child_cards(selected_card)
	
	for card in moving_cards:
		stack.receive_card(card)
	
	old_stack.reveal_next()
	selected_card.deselect()
	selected_card = null
	
	if check_for_victory():
		win()

func check_for_victory():
	var aces_stacks = get_node("/root/Table/Aces").get_children()
	for stack in aces_stacks:
		var top_card = stack.get_top_card_face()
		print (top_card)
		if top_card == null or get_card_num_and_suit(top_card)[0] != "K":
			return false
	return true

func win():
	get_node("/root/Table/Fade").visible = true
	get_node("/root/Table/VictoryDialog").popup()
