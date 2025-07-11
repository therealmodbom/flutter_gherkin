import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:flutter_gherkin/src/flutter/hooks/app_runner_hook.dart';
import 'package:test/test.dart';

import 'mocks/parameter_mock.dart';
import 'mocks/step_definition_mock.dart';

void main() {
  group('config', () {
    group('prepare', () {
      test('flutter app runner hook added', () {
        final config = FlutterTestConfiguration();
        expect(config.hooks, isNull);
        final config_new = config.prepare();
        expect(config_new.hooks, isNotNull);
        expect(config_new.hooks!.length, 1);
        expect(
            config_new.hooks!.elementAt(0), (x) => x is FlutterAppRunnerHook);
      });

      test('common steps definition added', () {
        final config = FlutterTestConfiguration();
        expect(config.stepDefinitions, isNull);

        final config_new = config.prepare();
        expect(config_new.stepDefinitions, isNotNull);
        expect(config_new.stepDefinitions!.length, 23);
        expect(config_new.customStepParameterDefinitions, isNotNull);
        expect(config_new.customStepParameterDefinitions!.length, 2);
      });

      test('common step definition added to existing steps', () {
        final config = FlutterTestConfiguration(
            stepDefinitions: [MockStepDefinition()],
            customStepParameterDefinitions: [MockParameter()]);

        expect(config.stepDefinitions!.length, 1);

        final config_new = config.prepare();
        expect(config_new.stepDefinitions, isNotNull);
        expect(config_new.stepDefinitions!.length, 24);
        expect(config_new.stepDefinitions!.elementAt(0),
            (x) => x is MockStepDefinition);
        expect(config_new.customStepParameterDefinitions, isNotNull);
        expect(config_new.customStepParameterDefinitions!.length, 3);
        expect(config_new.customStepParameterDefinitions!.elementAt(0),
            (x) => x is MockParameter);
      });
    });
  });
}
