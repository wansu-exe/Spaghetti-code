/// Pure validation rules for the "Add New Product" form.
/// No Flutter imports: these are plain functions, easy to unit-test.
class ProductValidators {
  const ProductValidators._();

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Product name is required';
    }
    return null;
  }

  static String? price(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Price is required';
    }
    final parsed = double.tryParse(value);
    if (parsed == null) {
      return 'Price must be a number';
    }
    if (parsed <= 0) {
      return 'Price must be greater than zero';
    }
    return null;
  }
}
