import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:rick_and_morty/data/repasitory/abstract_api.dart';
import '../../data/models/rick_models.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharacterBloc(this.repasitory) : super(CharacterInitial()) {
    on<LoadCharacters>(_onLoadCharacters);
    on<SearchCharacters>(_onSearchCharacters);
  }

  final AbstractCharacter repasitory;

  Future<void> _onLoadCharacters(
    LoadCharacters event,
    Emitter<CharacterState> emit,
  ) async {
    if (state is! CharacterLoaded) {
      emit(CharacterLoading());
    }
    try {
      final response = await repasitory.getCharacterResponse();
      final characters = response;
      emit(CharacterLoaded(data: characters));
    } catch (e) {
      emit(CharacterError(e.toString()));
      debugPrint(e.toString());
    }
  }

  Future<void> _onSearchCharacters(
      SearchCharacters event, Emitter<CharacterState> emit) async {
    emit(CharacterLoading());
    try {
      final characters =
          await repasitory.getCharacterResponse(query: event.query);
      emit(CharacterLoaded(data: characters));
    } catch (e) {
      emit(CharacterError(e.toString()));
    }
  }
}
