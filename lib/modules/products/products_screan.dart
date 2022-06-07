import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/product_details/product_details.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class Products_Screan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppChangeFavouritesSuccsesState) {
          if (state.model?.status == false) {
            ShowToast(
                text: state.model?.message ?? '', state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return BuildCondition(
          condition: cubit.home_model != null && cubit.categories_model != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => productsBuilder(
              cubit.home_model, context, cubit.categories_model),
        );
      },
    );
  }

  Widget productsBuilder(
          Home_model? model, context, Categories_Model? categories_model) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model?.data?.banners
                    .map((e) => ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image: NetworkImage('${e.image}'),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 230,
                  reverse: false,
                  initialPage: 0,
                  autoPlay: true,
                  scrollDirection: Axis.horizontal,
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  enableInfiniteScroll: true,
                  viewportFraction: 1.0,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayCurve: Curves.easeIn,
                )),
            SizedBox(
              height: 10,
            ),
            myDivider(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 120,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      BuildCategorieItm(categories_model?.data?.data[index]),
                  separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                  itemCount: categories_model?.data?.data.length ?? 0),
            ),
            SizedBox(
              height: 5,
            ),
            myDivider(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'New Products',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsetsDirectional.only(top: 4, bottom: 4),
              color: Colors.grey[200],
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.58,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(
                    model?.data?.products.length ?? 0,
                    (index) => BuildGriedProduct(
                        model?.data?.products[index], context)),
              ),
            )
          ],
        ),
      );

  Widget BuildGriedProduct(productModel? model, context) => InkWell(
        onTap: () {
          navigateTo(
              context,
              Product_Details(
                model: model,
              ));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Image(
                        image: NetworkImage('${model?.image}'),
                        width: double.infinity,
                        height: 200,
                      ),
                      if (model?.discount != 0)
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                          color: Colors.red,
                          child: Text(
                            'DISCOUNT ${model?.discount}%',
                            style: TextStyle(color: Colors.white, fontSize: 9),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model?.name}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, height: 1.3),
                      ),
                      Row(
                        children: [
                          Text(
                            '${model?.price.round()}',
                            style: TextStyle(fontSize: 12, color: defColor),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          if (model?.discount != 0)
                            Text(
                              '${model?.oldPrice.round()}',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          Spacer(),
                          if (AppCubit.get(context).carts[model?.id]!)
                            Icon(
                              Icons.shopping_cart,
                              size: 22,
                              color: Colors.amber,
                            ),
                          SizedBox(
                            width: 5,
                          ),
                          IconButton(
                              onPressed: () {
                                AppCubit.get(context)
                                    .ChangeFavourites(model?.id ?? 0);
                                print(model?.id);
                              },
                              icon: CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      AppCubit.get(context).favorits[model?.id]!
                                          ? defColor
                                          : Colors.grey,
                                  child: Icon(
                                    Icons.favorite_border,
                                    size: 16,
                                    color: Colors.white,
                                  ))),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget BuildCategorieItm(DataModel? model) => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 150,
          height: 120,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Image(
                image: NetworkImage('${model?.image}'),
                width: 150,
                height: 120,
                fit: BoxFit.cover,
              ),
              Container(
                width: double.infinity,
                color: Colors.black.withOpacity(0.7),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Text(
                    '${model?.name}',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
