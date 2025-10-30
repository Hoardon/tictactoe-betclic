import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tictactoebetclic/src/core/utils/logger.dart';

base class CustomProviderObserver extends ProviderObserver {
  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    Log.log(
      '"addProvider": {'
      '"provider": "${context.provider.name ?? context.provider.runtimeType}'
      '"value": "$value"'
      '"container": "${context.container}"'
      '}',
    );
  }

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    Log.log(
      '"updateProvider": {'
      '"provider": "${context.provider.name ?? context.provider.runtimeType}"'
      '"previousValue": "$previousValue"'
      '"newValue": "$newValue"'
      '}',
    );
  }

  @override
  void didDisposeProvider(
    ProviderObserverContext context
  ) {
    Log.log(
      '"disposeProvider": {'
      '"provider": "${context.provider.name ?? context.provider.runtimeType}"'
      '"containers": "${context.container}"'
      '}',
    );
  }
}
