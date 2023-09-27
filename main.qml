import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
 import QtQuick.Dialogs
import QtMultimedia
Window {
    width: 1024
    height: 640
    visible: true
    title: qsTr("Quiz")
    Image {
        id: backshade2
        source: "happy.jpg"
        anchors.centerIn: parent
        opacity: 1000
        width: 1024
        height:640
    }
    Image {
        id: backshade
        source: "applause.jpg"
        anchors.centerIn: parent
        visible: false
        width: 1024
        height:640
    }
    Image {
        id: trophy
        source: "trophy.png"
        x:65
        y:85
        visible: false
        width: 100
        height:150
    }
    Text {
        text: "Fun Quiz !"
        font.bold: true
        x:300
        y:0
        font.pointSize: 50
        color: "blue"
    }

        property int currentQuestionIndex: 0
        property int totalPoints: 0

        // Define the quiz questions and options
    property var questions: [
                 {
                     question: "What is the capital of India?",
                     options: ["delhi", "kolkatta", "kochi"],
                     correctOption: 0
                 },
                 {
                     question: "What is the largest planet in our solar system?",
                     options: ["Jupiter", "Saturn", "Neptune"],
                     correctOption: 0
                 },
                  {
                       question: "What is the capital of France?",
                       options: ["Paris", "London", "Berlin"],
                     correctOption: 0
                   },
                   {
                       question: "Who painted the Mona Lisa?",
                       options: ["Leonardo da Vinci", "Vincent van Gogh", "Pablo Picasso"],
                       correctOption: 0
                   },
                   {
                       question: "Who wrote the play 'Romeo and Juliet'?",
                       options: ["William Shakespeare", "George Orwell", "Jane Austen"],
                      correctOption: 0
                   },
                   {
                       question: "What is the chemical symbol for gold?",
                       options: ["Au", "Ag", "Hg"],
                       correctOption: 0
                   }
                 // Add more questions here
             ]

        Column {

            spacing: 10
            x:100;y:100

            Text {
                 id:columnx
                  visible: true
                text: questions[currentQuestionIndex].question
                font.bold: true
                font.pointSize: 15
                color: "black"
            }

            Repeater {
                id:repeaterrr
                visible: true
                model: questions[currentQuestionIndex].options.length
                delegate: RadioButton {id:rb
                    visible: true
                    text: questions[currentQuestionIndex].options[index]
                    checked: index === selectedOptionIndex
                    onCheckedChanged: {
                        if (checked) {
                            selectedOptionIndex = index;
                        }
                    }
                }
            }

            MediaPlayer {
                id: mediaPlayer

                source: "crowdclapping.wav"
                audioOutput: AudioOutput {}}
            Button {
                text: "Next"
                onClicked: {
                    // Process the user's answer
                    var currentQuestion = questions[currentQuestionIndex];
                    var selectedOption = currentQuestion.options[selectedOptionIndex];
                    var correctOption = currentQuestion.correctOption;
                    var isAnswerCorrect = selectedOption === currentQuestion.options[correctOption];

                    // Increment points if answer is correct
                    if (isAnswerCorrect) {
                        totalPoints++;
                    }

                    // Display the result
                    if (isAnswerCorrect) {
                        resultLabel.text = "Correct!";
                        resultLabel.color = "dark blue";
                    } else {
                        resultLabel.text = "Incorrect! The correct answer is: " + currentQuestion.options[correctOption];
                        resultLabel.color = "red";
                    }

                    // Clear the selection of the radio buttons
                    selectedOptionIndex = -1;

                    // Move to the next question or finish the quiz
                    if (currentQuestionIndex < questions.length - 1) {
                        currentQuestionIndex++;
                    } else {
                       backshade.visible=true
                        columnx.visible=false

                        resultLabel.visible=false
                        mediaPlayer.play()

                        resultLabel2.text += "\nTotal Points: " + totalPoints;
                        repeaterrr.visible=false

                        trophy.visible=true
                        console.log("Quiz finished!");
                        // Add your own logic for the end of the quiz
                    }
                }
                enabled: selectedOptionIndex !== -1
            }

            Label {
                id: resultLabel
                text: ""
                visible: true
                font.pixelSize: 50
                font.bold: true
                color: "black"
            }
            Label {
                id: resultLabel2
                text: ""
                font.pixelSize: 100
                font.bold: true
               x:100;y:130

                color: "green"
            }
        }

        property int selectedOptionIndex: -1


//    Rectangle {
//        width: 640
//        height: 110
//        visible: true
//        anchors.centerIn: parent
//        ListView {
//            id: listView
//            anchors.fill: parent
//            model: ListModel {
//                ListElement { sender: "Whatsapp"; title: "How are you going?" }
//                ListElement { sender: "Flipkart"; title: "SALE! All rugs MUST go!" }
//                ListElement { sender: "Paytm"; title: "Electricity bill 15/07/2016 overdue" }
//                ListElement { sender: "Tips"; title: "Five ways this tip will save your life" }
//            }
//            delegate: SwipeDelegate {
//                id: swipeDelegate
//                text: model.sender + " - " + model.title
//                width: parent.width

//                ListView.onRemove: SequentialAnimation {
//                    PropertyAction {
//                        target: swipeDelegate
//                        property: "ListView.delayRemove"
//                        value: true
//                    }
//                    NumberAnimation {
//                        target: swipeDelegate
//                        property: "height"
//                        to: 0
//                        easing.type: Easing.InOutQuad
//                    }
//                    PropertyAction {
//                        target: swipeDelegate
//                        property: "ListView.delayRemove"
//                        value: false
//                    }
//                }

//                swipe.right: Label {
//                    id: deleteLabel
//                    text: qsTr("Delete")
//                    color: "white"
//                    verticalAlignment: Label.AlignVCenter
//                    padding: 12
//                    height: parent.height
//                    anchors.right: parent.right

//                    SwipeDelegate.onClicked: listView.model.remove(index)

//                    background: Rectangle {
//                        color: deleteLabel.SwipeDelegate.pressed ? Qt.darker("tomato", 1.1) : "tomato"
//                    }
//                }
//            }
//        }
//    }
}
