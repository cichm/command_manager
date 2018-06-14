import 'dart:collection';

import 'package:FiniteMachineState/src/CommandMenager.dart';

import 'package:FiniteMachineState/src/ConcreteCommandMenagerFirst.dart';
import 'package:FiniteMachineState/src/ConcreteCommandSecond.dart';


main() {
    CommandMenager finiteStateMachine = new CommandMenager();

    finiteStateMachine.add(new ConcreteCommandMenagerFirst());
    finiteStateMachine.add(new ConcreteCommandMenagerSecond());

    finiteStateMachine.build();
}
