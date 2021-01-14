import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:garbagecan/model/item_data.dart';
import 'package:garbagecan/components/tiles/item_tile.dart';

class ItemTileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Consumer<ItemData>(
        builder: (context, itemData, child) {
          return ListView.builder(
            padding: EdgeInsets.only(top: 0.0),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = itemData.items[index];
              return ItemTile(
                itemText: item.name,
                isChecked: item.isChecked,
                checkboxCallback: (checkboxState) {
                  itemData.updateCheckbox(item);
                },
              );
            },
            itemCount: itemData.items.length,
          );
        },
      ),
    );
  }
}
