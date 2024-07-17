part of 'home_page.dart';

Widget createFieldRow(BuildContext context) {
  return SizedBox(
    height: 50,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        const Icon(Icons.drag_handle),

        const SizedBox(width: 16),
        const Expanded(
          child: Center(
            child: Text(
              '項目',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Center(
            child: Text(
              '單價',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Center(
            child: Text(
              '數量',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),

        const Expanded(
          child: Center(
            child: Text(
              '加總',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),

        FloatingActionButton(
          mini: true,
          child: const Icon(Icons.delete_forever_outlined),
          onPressed: () => {}
        ),
        
      ],
    ),
  );
}

Widget createTextFieldRow(BuildContext context, int index) {

  HomePageListItemModel currentItemModel = context.read<HomePageRepository>().getListItem(index);

  return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          
          Expanded(
            child: TextField(
              controller: TextEditingController(text: currentItemModel.itemName),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '項目',
              ),
              onChanged: (value) {
                context.read<HomePageListItemBloc>().add(HomePageListItemNameChangeEvent(index, value));
              }
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: TextEditingController(
                text: (currentItemModel.itemSinglePrice == 0) ? '0' : currentItemModel.itemSinglePrice.toStringAsFixed(2)),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '單價',
              ),
              inputFormatters: [
                // allow only numbers and one dot
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                //FilteringTextInputFormatter.digitsOnly,
                LeadingZeroFormatter(),
              ],
              keyboardType: TextInputType.number,

              onChanged: (value) {
                if (value.isEmpty) return;
                
                context.read<HomePageListItemBloc>().add(HomePageListItemSinglePriceChangeEvent(index, double.parse(value)));
              },
            ),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: TextField(
              controller: TextEditingController(text: currentItemModel.itemCount.toString()),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '數量',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LeadingZeroFormatter(),
              ],
              keyboardType: TextInputType.number,

              onChanged: (value) {
                if (value.isEmpty) return;
                
                context.read<HomePageListItemBloc>().add(HomePageListItemCountChangeEvent(index, int.parse(value)));
              },
            ),
            
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Center(
              child: 
                BlocBuilder<HomePageListItemBloc, HomePageListItemState>(
                  builder: (_, state) {
                      double itemTotalPrice;
                      switch(state) {
                        case HomePageListItemUpdateState _:
                          itemTotalPrice = (currentItemModel == state.updatedItemModel)
                            ? state.updatedItemModel.itemTotalPrice
                            : currentItemModel.itemTotalPrice;
                          break;

                        default:
                          itemTotalPrice = currentItemModel.itemTotalPrice;
                          break;
                      }
                      return Text(
                          itemTotalPrice.toStringAsFixed(2),
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 20,
                          )
                        );
                    },
                  
                )
            ),
          ),

          const SizedBox(width: 16),

          FloatingActionButton(
            mini: true,
            child: const Icon(Icons.delete),
            onPressed: () => context
                .read<HomePageListBloc>()
                .add(HomePageListRemoveItemEvent(index)),
          ),
        ],
      ));
}
