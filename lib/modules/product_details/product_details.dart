import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../layout/cubit/cubit.dart';

class Product_Details extends StatelessWidget {
  productModel? model;

  Product_Details({required this.model});

  var imageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model?.name}',
                    style: TextStyle(fontSize: 19),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 250,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: imageController,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => Image(
                        image: NetworkImage('${model?.images[index]}'),
                        width: double.infinity,
                        height: 250,
                      ),
                      itemCount: model?.images.length,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      count: model?.images.length ?? 0,
                      effect: ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          activeDotColor: defColor,
                          dotHeight: 10,
                          dotWidth: 10,
                          expansionFactor: 4,
                          spacing: 5),
                      controller: imageController,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${model?.price.round()}',
                        style: TextStyle(
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        'EGP',
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if(model?.discount!=0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        color: Colors.lightGreen[100],
                        padding: EdgeInsets.all(2),
                        child: Text(
                          '${model?.discount}% OFF',
                          style: TextStyle(fontSize: 13, color: Colors.green),
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        '${model?.oldPrice.round()} EGP',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    'description',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 22),
                  ),
                  myDivider(),
                  Text(
                    '${model?.description}',
                    style: TextStyle(
                      height: 1.4,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defultButton(
                      text: 'Add To Cart',
                      function: () {},
                      Background: defColor)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget buildImage(productModel? model)=> Image(
    image: NetworkImage('${model?.image}'),
    width: double.infinity,
    height: 250,
  );
}
