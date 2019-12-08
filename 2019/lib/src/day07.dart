import 'computer.dart';
import 'package:trotter/trotter.dart';

class RoundRobinIO extends IO {
  int _next = 0;
  List<int> _responses = [0];
  int lastOutput = 0;

  RoundRobinIO(this._responses);

  @override
  int input() {
    int index = _next;
    _next = (_next + 1) % _responses.length;
    print('Inputting ${_responses[index]}');
    return _responses[index];
  }

  @override
  void output(int value) {
    lastOutput = value;
    print('Computer output: $value');
  }

}

int runThroughAmp(List<int> codeTemplate, int phase, int inputSignal) {
  var memory = List<int>.from(codeTemplate);
  var io = RoundRobinIO([phase, inputSignal]);
  var computer = Computer(memory, io: io);
  computer.run();
  return io.lastOutput;
}

int calculateAmplification(List<int> code, List<int> phaseConfig) {
  assert(phaseConfig.length == 5, "There should be 5 phase settings");
  assert(phaseConfig.toSet().length == 5, "Each phase setting should be different");
  // assert(phaseConfig.where((it) => it > 4).length > 0, "Phase settings could be in range 0-4");
  // assert(phaseConfig.where((it) => it < 0).length > 0, "Phase settings could be in range 0-4");

  var signal = 0;
  for (var i=0; i < 5; i++) {
    signal = runThroughAmp(code, phaseConfig[i], signal);
  }
  return signal;
}

int aplifyWithFeedback(List<int> code, List<int> phaseConfig) {
  assert(phaseConfig.length == 5, "There should be 5 phase settings");
  assert(phaseConfig.toSet().length == 5, "Each phase setting should be different");

  var signal = 0;
  var aplifiers = [
    Computer(List.from(code))
  ];
}

List<int> findBestPhaseConfig(List<int> code) {
  var p = new Permutations(5, <int>[0, 1, 2, 3, 4]);

  List<int> bestConfig = [];
  int bestSignal = 0;
  
  for(var perm in p()) {
    List<int> config = perm.cast();
    var signal = calculateAmplification(code, config.cast());
    if (signal > bestSignal) {
      bestSignal = signal;
      bestConfig = config;
    }
  }

  print('Best config $bestConfig, gives signal $bestSignal');
  return bestConfig;
}
