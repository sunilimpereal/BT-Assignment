import 'package:bt_assignment/utils/common_exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';
  RecipeCategory selectedCategory = RecipeCategory.all;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RecipeBloc>(context).add(GetRecipeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.appTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all,
                size: 24.sp, semanticLabel: AppText.clearListButtonTooltip),
            onPressed: () {
              BlocProvider.of<RecipeBloc>(context).add(DeleteAllRecipesEvent());
            },
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            pinned: true,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: TextField(
                        onChanged: (query) {
                          setState(() {
                            searchQuery = query;
                          });
                          BlocProvider.of<RecipeBloc>(context)
                              .add(SearchRecipeEvent(query));
                        },
                        textAlign: TextAlign.justify,
                        decoration: InputDecoration(
                          hintText: AppText.searchHint,
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 8.w,
                          ),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: Icon(Icons.search,
                                color: Colors.black, size: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (selectedCategory != RecipeCategory.all)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      selectedCategory.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
              ],
            ),
            actions: [
              PopupMenuButton<RecipeCategory>(
                icon: Icon(Icons.filter_list, size: 24.sp),
                onSelected: (category) {
                  setState(() {
                    selectedCategory = category;
                  });
                  BlocProvider.of<RecipeBloc>(context)
                      .add(FilterRecipeEvent(category.name));
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: RecipeCategory.all,
                    child: Text(AppText.allCategories),
                  ),
                  const PopupMenuItem(
                    value: RecipeCategory.appetizer,
                    child: Text(AppText.appetizer),
                  ),
                  const PopupMenuItem(
                    value: RecipeCategory.mainCourse,
                    child: Text(AppText.mainCourse),
                  ),
                  const PopupMenuItem(
                    value: RecipeCategory.dessert,
                    child: Text(AppText.dessert),
                  ),
                  const PopupMenuItem(
                    value: RecipeCategory.beverage,
                    child: Text(AppText.beverage),
                  ),
                ],
              ),
            ],
          ),
        ],
        body: BlocBuilder<RecipeBloc, RecipeState>(
          builder: (context, state) {
            if (state is RecipeLoadedState) {
              final filteredRecipes = state.recipes.where((recipe) {
                final matchesSearch = recipe.title
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase());
                final matchesCategory =
                    selectedCategory == RecipeCategory.all ||
                        recipe.category == selectedCategory.name;
                return matchesSearch && matchesCategory;
              }).toList();

              if (filteredRecipes.isEmpty) {
                return Center(
                    child: Text(AppText.noRecipesAvailable,
                        style: TextStyle(fontSize: 16.sp)));
              }

              return ListView.builder(
                itemCount: filteredRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = filteredRecipes[index];
                  return _buildRecipeTile(context, recipe);
                },
              );
            }

            return Center(
                child: Text(AppText.somethingWentWrong,
                    style: TextStyle(fontSize: 16.sp)));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewRecipeScreen()),
          );
        },
        tooltip: AppText.addButtonTooltip,
        child: Icon(Icons.add, size: 24.sp),
      ),
    );
  }

  Widget _buildRecipeTile(BuildContext context, Recipe recipe) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      elevation: 2,
      shadowColor: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Text(
            recipe.title.isNotEmpty ? recipe.title[0] : '',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp),
          ),
        ),
        title: Text(
          recipe.title,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Text(
            recipe.category,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red.shade300, size: 20.sp),
          onPressed: () {
            BlocProvider.of<RecipeBloc>(context)
                .add(DeleteRecipeEvent(recipe.id));
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeViewScreen(recipe: recipe),
            ),
          );
        },
      ),
    );
  }
}
