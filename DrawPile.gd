extends Panel

var cards = []
var discard_pile = null

func _ready():
	for child in get_parent().get_children():
		if child.get_name() == "Discard":
			discard_pile = child
			break

func set_cards(cards_array):
	cards = cards_array
	update_display()

func update_display():
	$CardBack.visible = cards.size() > 0

func _on_DrawPile_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if cards.size() > 0:
			draw_card()
		else:
			restart()

func draw_card():
	discard_pile.add_card(cards.pop_front())
	update_display()

func restart():
	cards = discard_pile.get_cards()
	discard_pile.empty()
	update_display()
