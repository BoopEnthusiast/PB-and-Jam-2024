extends Control

@onready var question = $TimeLeft/Question
@onready var answer = $ButtonHolder/Answer
@onready var answer_2 = $ButtonHolder/Answer2
@onready var answer_3 = $ButtonHolder/Answer3
@onready var answer_4 = $ButtonHolder/Answer4

var questions: Array[String] = [
	"Welcome to your pitch meeting. We will ask you about your project, you must please us if you want your funding, which you do.",
	
]

var answers: Array[String] = [
	"Thank you for having me", "OK", "I think I'm in the wrong room", "Whatever",
	
]

var right_answer: Array[int] = [
	0,
	
]

var current_question := 0


func _ready():
	next_question()


func next_question() -> void:
	question.text = questions[current_question]
	answer.text = answers[current_question * 4]
	answer_2.text = answers[current_question * 4 + 1]
	answer_3.text = answers[current_question * 4 + 2]
	answer_4.text = answers[current_question * 4 + 3]


func _on_answer_pressed():
	


func _on_answer_2_pressed():
	pass # Replace with function body.


func _on_answer_3_pressed():
	pass # Replace with function body.


func _on_answer_4_pressed():
	pass # Replace with function body.
