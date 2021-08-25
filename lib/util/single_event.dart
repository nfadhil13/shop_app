class SingleEvent<T> {

  final T _data;
  var _isConsumed = false;

  SingleEvent(this._data);

  T? consume() {
    print("ACCESSING DATA $_isConsumed");
    if(!_isConsumed){
      return this._data;
    }
    _isConsumed = true;
    return null;
  }

  T peek() {
    return _data;
  }

}