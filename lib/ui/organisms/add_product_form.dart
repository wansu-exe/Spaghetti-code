import 'package:flutter/material.dart';

import '../../logic/product_validators.dart';
import '../../models/product.dart';
import '../atoms/primary_button.dart';
import '../atoms/section_title.dart';
import '../molecules/product_category_field.dart';
import '../molecules/product_description_field.dart';
import '../molecules/product_name_field.dart';
import '../molecules/product_price_field.dart';

/// Signature the Page implements to actually store a new product.
typedef AddProductCallback = void Function({
  required String name,
  required double price,
  required String category,
  required String description,
});

/// The "Add New Product" form.
///
/// Owns the *form* state only (controllers, form key, selected category),
/// runs validation, resets itself and shows the confirmation snackbar.
/// It does NOT own the product list: on a valid submit it hands the values
/// to [onSubmit] and the Page decides what to do with them.
class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key, required this.onSubmit});

  final AddProductCallback onSubmit;

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedCategory = kDefaultCategory;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text;

    widget.onSubmit(
      name: name,
      price: double.parse(_priceController.text),
      category: _selectedCategory,
      description: _descriptionController.text,
    );

    setState(() {
      _nameController.clear();
      _priceController.clear();
      _descriptionController.clear();
      _selectedCategory = kDefaultCategory;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name added to catalog!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Add New Product'),
        const SizedBox(height: 12),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductNameField(
                controller: _nameController,
                validator: ProductValidators.name,
              ),
              ProductPriceField(
                controller: _priceController,
                validator: ProductValidators.price,
              ),
              ProductCategoryField(
                value: _selectedCategory,
                categories: kProductCategories,
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value ?? kDefaultCategory;
                  });
                },
              ),
              ProductDescriptionField(controller: _descriptionController),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  onPressed: _handleSubmit,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: const Text(
                    'Submit Product',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
