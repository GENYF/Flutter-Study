import 'package:bloc/bloc.dart';
import 'package:cart_bloc/src/item.dart';

enum CartEventType { add, remove }

class CartEvent {
  final CartEventType type;
  final Item item;

  CartEvent(this.type, this.item);
}

class CartBloc extends Bloc<CartEvent, List<Item>> {
  CartBloc() : super([]);

  @override
  Stream<List<Item>> mapEventToState(CartEvent event) async* {
    switch (event.type) {
      case CartEventType.add:
        state.add(event.item);
        break;
      case CartEventType.remove:
        state.remove(event.item);
        break;
    }
    yield state;
  }
}