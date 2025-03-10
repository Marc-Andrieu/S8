import QtQuick

Window {
    width: 320
    height: 240
    visible: true
    color: "#f1b2b2"
    title: qsTr("YOOOO FOUCAULD")

    Rectangle {
        id: rectangle
        x: 168
        y: 109
        width: 100
        height: 50
        color: "#59b0ac"

        Text {
            id: _text
            x: 0
            y: 0
            width: 100
            height: 50
            text: vueObjetCpt.cptQML
            Keys.onPressed: (event)=> {
              switch (event.key) {
                case Qt.Key_Up:
                  vueObjetCpt.increment();
                  break;
                case Qt.Key_Down:
                  vueObjetCpt.decrement();
                  break;
              }
            }
            font.pixelSize: 0
            focus: true
            transformOrigin: Item.Center
            font.bold: true
            font.family: "Tahoma"
        }

        Keys.onPressed: (event) => {
            if (event.key === Qt.Key_A) {
                prenom1.plugTextText=qsTr("A")
                console.log(event.key + " /// " + event.text);
                event.accepted = true;
            }
        }
    }
}
