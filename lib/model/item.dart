class Item {
  final String id;
  final String name;
  final String description;
  final String unit;
  final num value;
  bool isChecked;

  Item(this.id, Map<String, dynamic> data)
      : name = data['name'],
        description = data['description'],
        unit = data['unit'],
        value = data['value'],
        isChecked = false;

  void toogleCheckbox() {
    isChecked = !isChecked;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'unit': unit,
        'value': value,
      };
}
