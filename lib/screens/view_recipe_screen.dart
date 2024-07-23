import 'package:bt_assignment/utils/common_exports.dart';

class RecipeViewScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeViewScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(360, 690),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          recipe.title,
          style: TextStyle(fontSize: 20.sp),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewRecipeScreen(recipe: recipe),
                ),
              );
            },
            icon: Icon(
              Icons.edit,
              size: 24.sp,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: ListView(
          children: [
            _buildSection(
              context,
              AppText.ingredientsTitle,
              recipe.ingredients.map(
                (ingredient) => _buildListItem(ingredient, Icons.circle),
              ),
            ),
            SizedBox(height: 16.h),
            _buildSection(
              context,
              AppText.preparationStepsTitle,
              recipe.preparationSteps
                  .map((step) => _buildListItem(step, Icons.play_arrow)),
            ),
            SizedBox(height: 16.h),
            _buildSection(
              context,
              AppText.categoryTitle,
              [
                Text(
                  recipe.category,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black87,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    Iterable<Widget> content,
  ) {
    return Container(
      padding: EdgeInsets.all(12.0.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0.r),
        border: Border.all(color: Colors.grey[300]!, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 12.0.w),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(6.0.r),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          ...content,
        ],
      ),
    );
  }

  Widget _buildListItem(String content, IconData icon) {
    return Padding(
      padding: EdgeInsets.all(8.0.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18.sp,
            color: Colors.grey[700],
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              content,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
