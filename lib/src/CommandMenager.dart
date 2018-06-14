import 'dart:async';
import 'dart:collection';
import 'dart:isolate';

import 'package:FiniteMachineState/FiniteMachineState.dart';

class CommandMenager {
    Queue<ICommandMenager> _finiteStateMachineQueue;

    CommandMenager() : _finiteStateMachineQueue = new Queue();

    add(ICommandMenager iFiniteStateMachine) {
        this._finiteStateMachineQueue.add(iFiniteStateMachine);
    }

    deleteLast() {
        this._finiteStateMachineQueue.removeLast();
    }

    deleteFirst() {
        this._finiteStateMachineQueue.removeFirst();
    }

    build() async {
        _execute(this._finiteStateMachineQueue);
    }


    clear() {
        this._finiteStateMachineQueue.clear();
    }

    static _execute(Queue<ICommandMenager> _finiteStateMachineQueue) async {
        var receivePort = new ReceivePort();
        await Isolate.spawn(_echo, receivePort.sendPort);

        var sendPort = await receivePort.first;

        mapIterate(element) async {
            await _sendReceive(sendPort, element);
        }

        _finiteStateMachineQueue.forEach(mapIterate);
    }

    static _echo(SendPort sendPort) async {
        var port = new ReceivePort();

        sendPort.send(port.sendPort);

        await for (var msg in port) {
            var data = msg[0];
            SendPort replyTo = msg[1];
            data.action();
            replyTo.send(true);

//            if () {
//                port.close();
//            }
        }
    }

    static Future _sendReceive(SendPort port, msg) {
        ReceivePort response = new ReceivePort();
        port.send([msg, response.sendPort]);
        return response.first;
    }
}
