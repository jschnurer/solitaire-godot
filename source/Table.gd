extends Node2D

var cards = []

func _ready():
	randomize()
	addSuit("S")
	addSuit("D")
	addSuit("C")
	addSuit("H")
	cards.shuffle()
	
	deal()
	$DrawPile.set_cards(cards)

func addSuit(suit):
	cards.append("A" + suit)
	for i in range(9):
		cards.append(str(i + 2) + suit)
	cards.append("J" + suit)
	cards.append("Q" + suit)
	cards.append("K" + suit)

func deal():
	deal_to_stack($Stacks/Stack1, 1)
	deal_to_stack($Stacks/Stack2, 2)
	deal_to_stack($Stacks/Stack3, 3)
	deal_to_stack($Stacks/Stack4, 4)
	deal_to_stack($Stacks/Stack5, 5)
	deal_to_stack($Stacks/Stack6, 6)
	deal_to_stack($Stacks/Stack7, 7)

func deal_to_stack(stack, num_cards):
	for i in range(num_cards):
		stack.add_card(cards.pop_front(), i == num_cards - 1)

func _on_VictoryDialog_popup_hide():
	get_tree().reload_current_scene()
