import 'package:clean_architecture/featuers/home/domain/entity/product_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

import '../logic/products_cubit.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (BuildContext context, state) {
          if (state is ProductsLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ProductsError) {
            return Center(child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message),
                TextButton(onPressed: (){
                  context.read<ProductsCubit>().getAllProductsData();
                }, child: Text("retry"))
              ],
            ));
          }
          List<ProductsResponseData> products = state is ProductsSuccess
              ? state.products
              : [];

          return Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              child: VerticalCardPager(
                width: 400,
                unfocusIndexShouldBeSmaller: true,
                titles: products.map((e) => e.title).toList(),
                // required
                images: products.map((e) => Image.network(e.image)).toList(),
                // required
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                // optional
                onPageChanged: (page) {
                  // optional
                },
                onSelectedItem: (index) {
                  // optional
                },
                initialPage: 3,
                // optional
                align: ALIGN.CENTER,
                // optional
                physics: ClampingScrollPhysics(), // optional
              ),
            ),
          );
        },
      ),
    );
  }
}
