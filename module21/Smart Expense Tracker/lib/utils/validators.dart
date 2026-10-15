String? validateTitle(String? value) {
  if (value == null || value.trim().isEmpty) return 'Please enter a title';
  return null;
}

String? validateAmount(String? value) {
  if (value == null || value.trim().isEmpty) return 'Please enter an amount';
  final amount = double.tryParse(value.trim());
  if (amount == null) return 'Please enter a valid number';
  if (amount <= 0) return 'Amount must be greater than 0';
  return null;
}

String? validateBudget(String? value) {
  if (value == null || value.trim().isEmpty) return 'Please enter a budget';
  final budget = double.tryParse(value.trim());
  if (budget == null) return 'Please enter a valid number';
  if (budget < 0) return 'Budget cannot be negative';
  if (budget == 0) return 'Budget must be greater than 0';
  return null;
}
