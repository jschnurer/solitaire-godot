extends Panel

export(PackedScene) var card_scene

var cards = []

func add_card(card_face):
	cards.append(card_face)
	update_display()

func update_display():
	if get_children().size() > 0:
		remove_card()
	if cards.size() > 0:
		instance_card()

func remove_card():
	get_children()[0].queue_free()

func instance_card():
	var new_card = card_scene.instance()
	new_card.face = cards[cards.size() - 1]
	new_card.is_face_up = true
	add_child(new_card)

func get_child_cards(child_card):
	return [child_card]

func reveal_next():
	cards.pop_back()
	update_display()

func get_cards():
	return cards

func empty():
	cards = []
	update_display()
