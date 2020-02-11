class DeletedModel {
  final _index;
  final _inputValues;
  DeletedModel(this._index, this._inputValues);
  void show() {
    print(_index);
    print(_inputValues.name);
  }

  get getIndex => _index;
  get getValue => _inputValues;
}
