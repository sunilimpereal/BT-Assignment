import 'package:bt_assignment/constants/app_strings.dart';
import 'package:bt_assignment/constants/app_enums.dart';
import 'package:bt_assignment/data/bloc/recipe_bloc.dart';
import 'package:bt_assignment/data/model/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewRecipeScreen extends StatefulWidget {
  final Recipe? recipe;

  const NewRecipeScreen({super.key, this.recipe});

  @override
  State<NewRecipeScreen> createState() => _NewRecipeScreenState();
}

class _NewRecipeScreenState extends State<NewRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  final List<TextEditingController> _ingredientsControllers = [];
  final List<TextEditingController> _stepsControllers = [];
  final _ingredientInputController = TextEditingController();
  final _stepInputController = TextEditingController();
  RecipeCategory _selectedCategory = RecipeCategory.appetizer;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.recipe?.title ?? '');
    _selectedCategory = widget.recipe != null
        ? RecipeCategory.values
            .firstWhere((category) => category.name == widget.recipe?.category)
        : RecipeCategory.appetizer;
    _initializeControllers(widget.recipe);
  }

  void _initializeControllers(Recipe? recipe) {
    if (recipe != null) {
      _ingredientsControllers.addAll(
        recipe.ingredients
            .map((ingredient) => TextEditingController(text: ingredient)),
      );
      _stepsControllers.addAll(
        recipe.preparationSteps
            .map((step) => TextEditingController(text: step)),
      );
    }
  }

  void _addItem(List<TextEditingController> controllers,
      TextEditingController inputController) {
    setState(() {
      controllers.add(TextEditingController(text: inputController.text));
      inputController.clear();
    });
  }

  void _removeItem(List<TextEditingController> controllers, int index) {
    setState(() {
      controllers.removeAt(index);
    });
  }

  void _moveItem(
      List<TextEditingController> controllers, int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final item = controllers.removeAt(oldIndex);
      controllers.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe == null ? AppText.newRecipeTitle : AppText.editRecipeTitle),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_titleController, AppText.titleLabel),
              _buildSectionTitle(AppText.ingredientsTitle),
              _buildAddItemSection(
                _ingredientInputController,
                () => _addItem(
                    _ingredientsControllers, _ingredientInputController),
              ),
              _buildReorderableList(
                _ingredientsControllers,
                (index) => _removeItem(_ingredientsControllers, index),
                (oldIndex, newIndex) =>
                    _moveItem(_ingredientsControllers, oldIndex, newIndex),
              ),
              _buildSectionTitle(AppText.preparationStepsTitle),
              _buildAddItemSection(
                _stepInputController,
                () => _addItem(_stepsControllers, _stepInputController),
              ),
              _buildReorderableList(
                _stepsControllers,
                (index) => _removeItem(_stepsControllers, index),
                (oldIndex, newIndex) =>
                    _moveItem(_stepsControllers, oldIndex, newIndex),
              ),
              _buildSectionTitle(AppText.categoryTitle),
              SizedBox(
                height: 16.h,
              ),
              _buildCategoryDropdown(),
              SizedBox(
                height: 16.h,
              ),
              _buildSaveButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 16.0.w),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? '${AppText.enterError} $label' : null,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        const Divider(),
        SizedBox(height: 20.h),
        Text(title,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildAddItemSection(
      TextEditingController inputController, VoidCallback onAdd) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.h),
            child: TextFormField(
              controller: inputController,
              decoration: InputDecoration(
                labelText: AppText.newItemLabel,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 16.0.w),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add, size: 24.sp),
          onPressed: onAdd,
        ),
      ],
    );
  }

  Widget _buildReorderableList(
    List<TextEditingController> controllers,
    void Function(int) onRemove,
    void Function(int, int) onReorder,
  ) {
    return ReorderableListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      onReorder: onReorder,
      children: [
        for (int index = 0; index < controllers.length; index++)
          ListTile(
            key: Key('${controllers[index].text}_$index'),
            leading: Icon(Icons.drag_indicator_sharp, size: 24.sp),
            contentPadding: const EdgeInsets.all(0),
            title: TextFormField(
              controller: controllers[index],
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12.0.h),
              ),
              validator: (value) => value == null || value.isEmpty
                  ? AppText.emptyFieldError
                  : null,
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, size: 24.sp),
              onPressed: () => onRemove(index),
            ),
          ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<RecipeCategory>(
      value: _selectedCategory,
      decoration: InputDecoration(
        labelText: AppText.categoryLabel,
        contentPadding:
            EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 16.0.w),
      ),
      items: RecipeCategory.values
          .map((category) => DropdownMenuItem<RecipeCategory>(
                value: category,
                child: Text(category.name, style: TextStyle(fontSize: 14.sp)),
              ))
          .toList(),
      onChanged: (RecipeCategory? newValue) {
        setState(() {
          _selectedCategory = newValue!;
        });
      },
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0.h),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final updatedRecipe = Recipe(
                id: widget.recipe?.id ?? DateTime.now().millisecondsSinceEpoch,
                title: _titleController.text,
                ingredients:
                    _ingredientsControllers.map((c) => c.text).toList(),
                preparationSteps: _stepsControllers.map((c) => c.text).toList(),
                category: _selectedCategory.name,
              );

              if (widget.recipe == null) {
                BlocProvider.of<RecipeBloc>(context)
                    .add(AddRecipeEvent(updatedRecipe));
              } else {
                BlocProvider.of<RecipeBloc>(context)
                    .add(EditRecipeEvent(updatedRecipe));
              }
              Navigator.pop(context);
            }
          },
          child: Text(AppText.saveButtonLabel, style: TextStyle(fontSize: 16.sp)),
        ),
      ),
    );
  }
}
