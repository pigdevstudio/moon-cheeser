#MIT License
#
#Copyright (c) 2017 Pigdev Studio
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.
extends "res://Screens/abstract_screen.gd"

func _ready():
	acheesements.already_played = true
	get_node("ScreenMargin/ScreenPortions/TopPortion/Score").set_text("Score: %s" %score_handler.get_score())
	get_node("ScreenMargin/ScreenPortions/TopPortion/Highscore").set_text("Highscore: %s" %score_handler.read_highscore())

func _on_Back_released():
	change_to_next_scene("res://Screens/Title_Screen/TitleScreen.tscn")
	score_handler.set_score(0)

func _on_Retry_button_up():
	change_to_next_scene("res://Screens/Play_Screen/PlayScreen.tscn")
	score_handler.set_score(0)