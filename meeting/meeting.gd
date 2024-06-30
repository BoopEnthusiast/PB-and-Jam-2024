extends Control

@onready var question = $TimeLeft/Question
@onready var answer = $ButtonHolder/Answer
@onready var answer_2 = $ButtonHolder/Answer2
@onready var answer_3 = $ButtonHolder/Answer3
@onready var answer_4 = $ButtonHolder/Answer4
@onready var wrong = $Wrong
@onready var ding = $Ding
@onready var score_text = $Score
@onready var animation_player = $AnimationPlayer


var questions: Array[String] = [
	"Welcome to your interview. We will ask you about your knowledge of what we do here.",
	"What does our company do?",
	"Which role are you looking to fill?",
	"How well do you think this company is doing?",
	"Which one is part of our policies on office cleanliness?",
	"When is our next potluck?",
	"What’s your opinion on the idea of tech debt?",
	"What’s our favourite pastime?",
	"If you could be any animal, what would it be?",
	"What do you think we can do to make our business more sustainable?",
	"What is your expected salary for this role?",
	"Tell us about something outstanding you did in your previous role",
	"I saw you arrived at the office quite early today! What made you so eager to be here?",
	"What should you do if one of the printers break?",
	"How do you like your coffee?"
]

var answers: Array[String] = [
	"Thank you for having me", "OK", "I think I'm in the wrong room", "Whatever",
	"Stock trading", "Software development", "Marketing", "Customer Service",
	"Senior Producer", "Senior Management", "Artist", "Office Pet",
	"Exceptionally well", "Average", "Poorly", "Abysmal", 
	"No drinks at desks", "We have a smart vacuum", "No animals in the office", "The 3 R’s",
	"Tomorrow", "Next week", "Next month", "Next year",
	"It’s crucial", "It may be important", "Who cares?", "That’s a myth",
	"Reading", "Gaming", "Writing", "Debating",
	"A bird", "A snake", "A black cat", "A sloth",
	"Reusable coffee cups", "Reduce paper usage", "Renewable energy", "Water cooling",
	"$0", "Minimum wage", "Living wage or higher", "$1B per year", 
	"Huh?", "What?", "Um…", "*shrug*",
	"The business opportunity", "Financial wellbeing", "Alarm was set too early", "I wanted to play Espionage Office",
	"Stop printing so many sheets...?", "Cry", "Send a ticket to the IT guy", "Let someone else find out instead",
	"Medium filter roast", "Hot chocolate", "A large cappucino with chocolate powder topping", "Large double shot soy with a chocolate fish"
]

var right_answer: Array[int] = [
	0,
	4,
	5,
	1,
	2,
	-1,
	3,
	1,
	0,
	1,
	2,
	-1,
	4,
	3,
	-1
]

var current_question := 0


var score: int = 0


func _ready():
	next_question()


func next_question() -> void:
	if current_question >= 15:
		animation_player.play("winner")
		return
	question.text = questions[current_question]
	answer.text = answers[current_question * 4]
	answer_2.text = answers[current_question * 4 + 1]
	answer_3.text = answers[current_question * 4 + 2]
	answer_4.text = answers[current_question * 4 + 3]


func _on_answer_pressed():
	if right_answer[current_question] == 0 or right_answer[current_question] == 4 or right_answer[current_question] == 5:
		increase_score()
	else:
		wrong.play()
	current_question += 1
	next_question()


func _on_answer_2_pressed():
	if right_answer[current_question] == 1 or right_answer[current_question] == 4 or right_answer[current_question] == 5:
		increase_score()
	else:
		wrong.play()
	current_question += 1
	next_question()


func _on_answer_3_pressed():
	if right_answer[current_question] == 2 or right_answer[current_question] == 4:
		increase_score()
	else:
		wrong.play()
	current_question += 1
	next_question()


func _on_answer_4_pressed():
	if right_answer[current_question] == 3 or right_answer[current_question] == 4:
		increase_score()
	else:
		wrong.play()
	current_question += 1
	next_question()


func increase_score() -> void:
	ding.play()
	score += 1
	score_text.text = "Score: " + str(score)
