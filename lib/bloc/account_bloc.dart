import 'dart:async';
import 'package:budgetpal/bloc/account_event.dart';
import 'package:budgetpal/bloc/account_state.dart';
import 'package:budgetpal/model/account.dart';
import 'package:budgetpal/repository/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository _accountRepository;

  AccountBloc(this._accountRepository) : super(AccountLoading());

  get accountsStream => null;

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is FetchAccounts) {
      yield* _mapFetchAccountsToState();
    } else if (event is AddAccount) {
      yield* _mapAddAccountToState(event.account);
    } else if (event is UpdateAccount) {
      yield* _mapUpdateAccountToState(event.account);
    } else if (event is DeleteAccount) {
      yield* _mapDeleteAccountToState(event.id);
    }
  }

  Stream<AccountState> _mapFetchAccountsToState() async* {
    try {
      final accounts = await _accountRepository.getAllAccounts();
      yield AccountsLoaded(accounts);
    } catch (_) {
      yield AccountError();
    }
  }

  Stream<AccountState> _mapAddAccountToState(Account account) async* {
    try {
      _accountRepository.addAccount(account);
      final accounts = await _accountRepository.getAllAccounts();
      yield AccountsLoaded(accounts);
    } catch (_) {
      yield AccountError();
    }
  }

  Stream<AccountState> _mapUpdateAccountToState(Account account) async* {
    try {
      _accountRepository.updateAccount(account);
      final accounts = await _accountRepository.getAllAccounts();
      yield AccountsLoaded(accounts);
    } catch (_) {
      yield AccountError();
    }
  }

  Stream<AccountState> _mapDeleteAccountToState(String id) async* {
    try {
      _accountRepository.deleteAccount(id);
      final accounts = await _accountRepository.getAllAccounts();
      yield AccountsLoaded(accounts);
    } catch (_) {
      yield AccountError();
    }
  }

void updateAccount(Account account) {
  add(UpdateAccount(account));
}

void addAccount(Account account) {
  add(AddAccount(account));
}
void fetchAccounts() {
  add(FetchAccounts());
}
void deleteAccount(String id) {
  add(DeleteAccount(id));
}
void dispose() {
  close();
}


}
