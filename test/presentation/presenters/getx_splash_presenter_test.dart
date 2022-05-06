import 'package:faker/faker.dart';
import 'package:fordev/domain/entities/entities.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:fordev/domain/usecases/usecases.dart';
import 'package:fordev/ui/pages/pages.dart';

class GetxSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;

  var _navigateTo = RxString();

  GetxSplashPresenter({@required this.loadCurrentAccount});

  Stream<String> get navigateToStream => _navigateTo.stream;

  Future<void> checkAccount() async {
    try {
      final account = await loadCurrentAccount.load();
      _navigateTo.value = account.isNull ? '/login' : '/surveys';
    } catch (e) {
      _navigateTo.value = '/login';
    }
  }
}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

void main() {
  LoadCurrentAccountSpy loadcurrentAccount;
  GetxSplashPresenter sut;

  PostExpectation mockLoadCurrentAccountCall() => when(loadcurrentAccount.load());

  void mockLoadCurrentAccount({@required AccountEntity account}) {
    mockLoadCurrentAccountCall().thenAnswer((realInvocation) async => account);
  }

  void mockLoadCurrentAccountError() {
    mockLoadCurrentAccountCall().thenThrow(Exception());
  }

  setUp(() {
    loadcurrentAccount = LoadCurrentAccountSpy();
    sut = GetxSplashPresenter(loadCurrentAccount: loadcurrentAccount);
    mockLoadCurrentAccount(account: AccountEntity(faker.guid.guid()));
  });
  test('Should call LoadCurrentAccount', () async {
    await sut.checkAccount();
    verify(loadcurrentAccount.load()).called(1);
  });

  test('Should go surveys page on success', () async {
    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/surveys')));

    await sut.checkAccount();
  });

  test('Should go login page on null result', () async {
    mockLoadCurrentAccount(account: null);

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount();
  });

  test('Should go login page on error', () async {
    mockLoadCurrentAccountError();

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount();
  });
}
