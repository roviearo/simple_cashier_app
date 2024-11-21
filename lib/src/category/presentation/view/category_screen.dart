import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simple_cashier_app/src/category/presentation/cubits/add_category/add_category_cubit.dart';
import 'package:simple_cashier_app/src/category/presentation/cubits/list_category/list_category_cubit.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  TextEditingController nameCategory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: BlocListener<AddCategoryCubit, AddCategoryState>(
        listener: (context, state) {
          if (state.status == AddCategoryStatus.error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }

          if (state.status == AddCategoryStatus.success) {
            nameCategory.clear();
            context.read<AddCategoryCubit>().clearAddCategory();
            context.read<ListCategoryCubit>().getListCategory();
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          controller: nameCategory,
                          onChanged: (value) => context
                              .read<AddCategoryCubit>()
                              .nameChanged(value),
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        height: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            if (nameCategory.text.isNotEmpty) {
                              context.read<AddCategoryCubit>().addCategory();
                            }
                          },
                          child: SvgPicture.asset(
                            'icons/add.svg',
                            colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.onPrimary,
                                BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                BlocBuilder<ListCategoryCubit, ListCategoryState>(
                  builder: (context, state) {
                    final listCategory = state.listCategory;

                    if (listCategory.isEmpty) {
                      return const Expanded(
                        child: Center(
                          child: Text('Tidak ada data kategori'),
                        ),
                      );
                    }

                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          context
                              .read<ListCategoryCubit>()
                              .syncToLocalCategory();
                          context.read<ListCategoryCubit>().getListCategory();
                        },
                        child: ListView.builder(
                          itemCount: listCategory.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(listCategory[index].name),
                                    const Expanded(child: SizedBox.shrink()),
                                    IconButton(
                                      onPressed: () {},
                                      icon: SvgPicture.asset(
                                        'icons/edit.svg',
                                        colorFilter: ColorFilter.mode(
                                          Theme.of(context).colorScheme.primary,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: SvgPicture.asset(
                                        'icons/minus.svg',
                                        colorFilter: ColorFilter.mode(
                                          Theme.of(context).colorScheme.primary,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
