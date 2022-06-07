import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';

import '../../shared/components/components.dart';

class Search_Screan extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => searchCubit(),
      child: BlocConsumer<searchCubit, searchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit =  searchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defultFormField(
                        label: 'Search',
                        controller: textController,
                        type: TextInputType.text,
                        validator: (String? val) {
                          if(val!.isEmpty){
                            return 'search must not be empty';
                          }
                        }, prefix: Icons.search,
                    onSubmeted: (text){
                         cubit.Search(text: text);
                    }
                    ),
                    if(state is searchLodingState)
                      LinearProgressIndicator(),
                    if(state is searchSucssesState)
                      Expanded(
                        child: ListView.separated(itemBuilder: (context, index) => BuildFavoritesItem(cubit.searchModel?.data?.data[index],context,isOldPrice: false),
                            separatorBuilder: (context,index)=> myDivider(),
                            itemCount: cubit.searchModel?.data?.data.length??0),
                      )

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
