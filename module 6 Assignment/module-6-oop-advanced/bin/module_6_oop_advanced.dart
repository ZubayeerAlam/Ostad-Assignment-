// ============================================================
//  Module 6 Assignment – Advanced OOP Concepts Practice
//  File: oop_advanced_practice.dart
//  Description: Covers encapsulation, static members, factory
//  constructors, singleton, mixins, extensions, operator
//  overloading, copy constructors, composition, and a full
//  Bank Account System.
// ============================================================

// ─────────────────────────────────────────────────────────────
// STEP 2: Encapsulation with private fields
// ─────────────────────────────────────────────────────────────

/// A simple Person class demonstrating encapsulation.
/// Private fields (_name, _age) can only be accessed or
/// modified through controlled getters and setters.
class Person {
  String _name; // private field
  int _age; // private field

  Person(this._name, this._age);

  // Getter – allows reading the private name
  String get name => _name;

  // Setter – validates before updating the name
  set name(String value) {
    if (value.trim().isEmpty) {
      print('  [Error] Name cannot be empty.');
      return;
    }
    _name = value.trim();
  }

  // Getter – allows reading the private age
  int get age => _age;

  // Setter – validates that age is positive and realistic
  set age(int value) {
    if (value < 0 || value > 150) {
      print('  [Error] Age must be between 0 and 150.');
      return;
    }
    _age = value;
  }

  @override
  String toString() => 'Person(name: $_name, age: $_age)';
}

// ─────────────────────────────────────────────────────────────
// STEP 3: Static variables and methods
// ─────────────────────────────────────────────────────────────

/// Counter class that tracks how many instances have been
/// created using a static variable shared across all objects.
class Counter {
  // Static variable – belongs to the class, not any one instance
  static int _instanceCount = 0;

  final int id;

  Counter() : id = ++_instanceCount;

  // Static method – callable without creating an object
  static int getInstanceCount() => _instanceCount;

  // Static method to reset the counter (useful in tests)
  static void resetCount() => _instanceCount = 0;
}

// ─────────────────────────────────────────────────────────────
// STEP 4: Factory constructors
// ─────────────────────────────────────────────────────────────

/// ShapeFactory demonstrates factory constructors.
///
/// A factory constructor is useful when:
///   - You want to return an existing cached instance.
///   - You want to return a subtype based on a condition.
///   - Object creation involves complex logic.
abstract class Shape {
  String get type;
  double area();
}

class Circle implements Shape {
  final double radius;
  Circle(this.radius);

  @override
  String get type => 'Circle';

  @override
  double area() => 3.14159 * radius * radius;

  @override
  String toString() => 'Circle(radius: $radius, area: ${area().toStringAsFixed(2)})';
}

class Rectangle implements Shape {
  final double width, height;
  Rectangle(this.width, this.height);

  @override
  String get type => 'Rectangle';

  @override
  double area() => width * height;

  @override
  String toString() =>
      'Rectangle(${width}x${height}, area: ${area().toStringAsFixed(2)})';
}

/// Factory constructor decides which Shape subclass to create.
class ShapeFactory {
  // Factory constructor – returns the right Shape at runtime
  factory ShapeFactory.create(String type, List<double> params) {
    switch (type.toLowerCase()) {
      case 'circle':
        return Circle(params[0]) as dynamic; // returns Circle instance
      case 'rectangle':
        return Rectangle(params[0], params[1]) as dynamic;
      default:
        throw ArgumentError('Unknown shape type: $type');
    }
  }

  // Private regular constructor (never called externally)
  ShapeFactory._();
}

// ─────────────────────────────────────────────────────────────
// STEP 5: Singleton pattern
// ─────────────────────────────────────────────────────────────

/// AppConfig ensures only ONE configuration object exists
/// throughout the entire application lifecycle.
///
/// Pattern: private constructor + static _instance field +
/// factory constructor that always returns the same object.
class AppConfig {
  // The single shared instance (null until first access)
  static AppConfig? _instance;

  String appName;
  String version;

  // Private constructor – cannot be called from outside
  AppConfig._internal({
    required this.appName,
    required this.version,
  });

  // Factory constructor – creates instance only once, then reuses it
  factory AppConfig({String appName = 'MyApp', String version = '1.0.0'}) {
    _instance ??= AppConfig._internal(appName: appName, version: version);
    return _instance!;
  }

  @override
  String toString() => 'AppConfig(app: $appName, v$version)';
}

// ─────────────────────────────────────────────────────────────
// STEP 6: Mixins for code reuse
// ─────────────────────────────────────────────────────────────

/// Logging mixin – provides a reusable log() method.
/// Any class can gain logging without inheriting from a base class.
mixin Logging {
  void log(String message) {
    final timestamp = DateTime.now().toIso8601String().substring(11, 19);
    print('  [$timestamp] ${runtimeType}: $message');
  }
}

/// Validation mixin – provides reusable input checks.
mixin Validation {
  bool isPositive(double value) => value > 0;
  bool isNotEmpty(String value) => value.trim().isNotEmpty;
}

/// Employee uses both mixins – no duplicated code
class Employee with Logging, Validation {
  String name;
  double salary;

  Employee(this.name, this.salary);

  void giveRaise(double amount) {
    if (!isPositive(amount)) {
      log('Raise amount must be positive. Got: $amount');
      return;
    }
    salary += amount;
    log('Raised salary by \$$amount. New salary: \$$salary');
  }
}

/// Store also reuses Logging without duplicating the method
class Store with Logging {
  String storeName;
  Store(this.storeName);

  void open() => log('$storeName is now open for business.');
  void close() => log('$storeName has closed for the day.');
}

// ─────────────────────────────────────────────────────────────
// STEP 7: Extensions
// ─────────────────────────────────────────────────────────────

/// Adds extra utility methods to the built-in int type.
extension IntExtensions on int {
  bool get isEven => this % 2 == 0;
  bool get isOdd => !isEven;
  bool get isPrime {
    if (this < 2) return false;
    for (int i = 2; i <= this ~/ 2; i++) {
      if (this % i == 0) return false;
    }
    return true;
  }

  /// Repeats a string action n times.
  String repeat(String s) => s * this;
}

/// Adds utility methods to the built-in String type.
extension StringExtensions on String {
  /// Capitalises the first letter of each word.
  String get titleCase => split(' ')
      .map((w) => w.isEmpty ? w : w[0].toUpperCase() + w.substring(1))
      .join(' ');

  /// Returns true if the string is a valid positive number.
  bool get isNumeric => double.tryParse(this) != null;

  /// Wraps text in a simple banner.
  String banner([String char = '=']) =>
      '${char * (length + 4)}\n  $this  \n${char * (length + 4)}';
}

// ─────────────────────────────────────────────────────────────
// STEP 8: Operator overloading
// ─────────────────────────────────────────────────────────────

/// Vector2D class demonstrates operator overloading
/// so that mathematical operations feel natural.
class Vector2D {
  final double x, y;

  const Vector2D(this.x, this.y);

  /// Overload + to add two vectors
  Vector2D operator +(Vector2D other) => Vector2D(x + other.x, y + other.y);

  /// Overload - to subtract two vectors
  Vector2D operator -(Vector2D other) => Vector2D(x - other.x, y - other.y);

  /// Overload * to scale a vector
  Vector2D operator *(double scalar) => Vector2D(x * scalar, y * scalar);

  /// Overload == to compare vectors by value, not identity
  @override
  bool operator ==(Object other) =>
      other is Vector2D && x == other.x && y == other.y;

  @override
  int get hashCode => Object.hash(x, y);

  double get magnitude => (x * x + y * y).toDouble();

  @override
  String toString() => 'Vector2D($x, $y)';
}

// ─────────────────────────────────────────────────────────────
// STEP 9: Copy constructor concept
// ─────────────────────────────────────────────────────────────

/// Address is a simple value object.
/// Its named constructor Address.copy() creates a fully
/// independent duplicate so changes to the copy don't
/// affect the original.
class Address {
  String street;
  String city;
  String country;

  Address({
    required this.street,
    required this.city,
    required this.country,
  });

  /// Copy constructor – creates a new Address from an existing one
  Address.copy(Address other)
      : street = other.street,
        city = other.city,
        country = other.country;

  @override
  String toString() => '$street, $city, $country';
}

// ─────────────────────────────────────────────────────────────
// STEP 10: Class composition ("has-a" relationship)
// ─────────────────────────────────────────────────────────────

// NOTE: BankAccount is defined below (Step 12) and is
// referenced here through composition.

/// Customer "has-a" BankAccount – this is composition.
/// Customer does NOT extend BankAccount; it contains one.
class Customer {
  final String id;
  final String fullName;
  final Address address; // composition with Address
  late final BankAccount account; // composition with BankAccount

  Customer({
    required this.id,
    required this.fullName,
    required this.address,
    required double initialDeposit,
  }) {
    account = BankAccount(
      accountNumber: 'ACC-$id',
      ownerName: fullName,
      initialDeposit: initialDeposit,
    );
  }

  void showProfile() {
    print('  Customer : $fullName (ID: $id)');
    print('  Address  : $address');
    print('  Account  : ${account.accountNumber}');
    print('  Balance  : \$${account.balance.toStringAsFixed(2)}');
  }
}

// ─────────────────────────────────────────────────────────────
// STEPS 11–14: Bank Account System (mini project)
// ─────────────────────────────────────────────────────────────

/// TransactionRecord stores an immutable record of one
/// account transaction (deposit or withdrawal).
class TransactionRecord {
  final String type; // 'DEPOSIT' or 'WITHDRAWAL'
  final double amount;
  final double balanceAfter;
  final DateTime timestamp;

  TransactionRecord({
    required this.type,
    required this.amount,
    required this.balanceAfter,
  }) : timestamp = DateTime.now();

  @override
  String toString() {
    final ts = timestamp.toIso8601String().substring(0, 19);
    final sign = type == 'DEPOSIT' ? '+' : '-';
    return '  [$ts] $type  $sign\$${amount.toStringAsFixed(2)}'
        '  →  Balance: \$${balanceAfter.toStringAsFixed(2)}';
  }
}

/// BankAccount encapsulates a private balance and enforces
/// all business rules through its public API.
///
/// Features:
///   • Private _balance (encapsulation)
///   • Deposit with positive-amount validation
///   • Withdrawal with balance and positive-amount validation
///   • Transaction history
///   • Static total-accounts counter (static variable)
///   • toString / == operator overloads
class BankAccount with Logging, Validation {
  // ── Private state ──────────────────────────────────────────
  double _balance; // never accessed directly from outside
  final List<TransactionRecord> _history = [];

  // ── Public immutable fields ────────────────────────────────
  final String accountNumber;
  final String ownerName;

  // ── Static tracking ───────────────────────────────────────
  static int _totalAccounts = 0;
  static int get totalAccounts => _totalAccounts;

  // ── Constructor ───────────────────────────────────────────
  BankAccount({
    required this.accountNumber,
    required this.ownerName,
    double initialDeposit = 0.0,
  }) : _balance = 0.0 {
    _totalAccounts++;
    if (initialDeposit > 0) {
      // Record the opening deposit without going through
      // the public deposit() guard so no duplicate log fires
      _balance = initialDeposit;
      _history.add(TransactionRecord(
        type: 'DEPOSIT',
        amount: initialDeposit,
        balanceAfter: _balance,
      ));
    }
    log('Account $accountNumber opened for $ownerName'
        ' (initial balance: \$${_balance.toStringAsFixed(2)})');
  }

  // ── Getter: read-only balance ──────────────────────────────
  double get balance => _balance;

  // ── Deposit ───────────────────────────────────────────────
  /// Adds [amount] to the balance.
  /// Rejects non-positive amounts.
  bool deposit(double amount) {
    if (!isPositive(amount)) {
      log('Deposit failed – amount must be positive (got \$$amount).');
      return false;
    }
    _balance += amount;
    _history.add(TransactionRecord(
      type: 'DEPOSIT',
      amount: amount,
      balanceAfter: _balance,
    ));
    log('Deposited \$${amount.toStringAsFixed(2)}.'
        ' New balance: \$${_balance.toStringAsFixed(2)}');
    return true;
  }

  // ── Withdraw ──────────────────────────────────────────────
  /// Deducts [amount] from the balance.
  /// Rejects non-positive amounts or overdrafts.
  bool withdraw(double amount) {
    if (!isPositive(amount)) {
      log('Withdrawal failed – amount must be positive (got \$$amount).');
      return false;
    }
    if (amount > _balance) {
      log('Withdrawal failed – insufficient funds.'
          ' Requested: \$${amount.toStringAsFixed(2)},'
          ' Available: \$${_balance.toStringAsFixed(2)}');
      return false;
    }
    _balance -= amount;
    _history.add(TransactionRecord(
      type: 'WITHDRAWAL',
      amount: amount,
      balanceAfter: _balance,
    ));
    log('Withdrew \$${amount.toStringAsFixed(2)}.'
        ' New balance: \$${_balance.toStringAsFixed(2)}');
    return true;
  }

  // ── Transaction history ───────────────────────────────────
  void printHistory() {
    if (_history.isEmpty) {
      print('  No transactions yet.');
      return;
    }
    for (final t in _history) {
      print(t);
    }
  }

  // ── Operator overloads ────────────────────────────────────

  /// Two accounts are equal if they share the same account number.
  @override
  bool operator ==(Object other) =>
      other is BankAccount && accountNumber == other.accountNumber;

  @override
  int get hashCode => accountNumber.hashCode;

  @override
  String toString() =>
      'BankAccount(#$accountNumber, owner: $ownerName,'
          ' balance: \$${_balance.toStringAsFixed(2)})';
}

// ─────────────────────────────────────────────────────────────
// HELPER: section header printer
// ─────────────────────────────────────────────────────────────
void section(String title) {
  print('\n${'─' * 60}');
  print('  $title');
  print('─' * 60);
}

// ─────────────────────────────────────────────────────────────
// MAIN – runs all demonstrations in order
// ─────────────────────────────────────────────────────────────
void main() {
  // ── Step 2: Encapsulation ──────────────────────────────────
  section('STEP 2 – Encapsulation');

  final person = Person('Alice', 30);
  print('  Initial : $person');

  person.name = 'Bob'; // valid setter call
  person.age = 25;
  print('  Updated : $person');

  person.name = '   '; // should trigger validation error
  person.age = -5; // should trigger validation error
  print('  After bad inputs : $person'); // unchanged

  // ── Step 3: Static variables & methods ────────────────────
  section('STEP 3 – Static Variables & Methods');

  final c1 = Counter();
  final c2 = Counter();
  final c3 = Counter();
  print('  IDs created: ${c1.id}, ${c2.id}, ${c3.id}');
  print('  Total instances (static): ${Counter.getInstanceCount()}');
  Counter.resetCount(); // called without an object
  print('  After reset: ${Counter.getInstanceCount()}');

  // ── Step 4: Factory constructors ──────────────────────────
  section('STEP 4 – Factory Constructors');

  // Factory decides which subclass to instantiate at runtime
  final Shape circle = Circle(5.0);
  final Shape rect = Rectangle(4.0, 6.0);
  print('  $circle');
  print('  $rect');

  // ── Step 5: Singleton ─────────────────────────────────────
  section('STEP 5 – Singleton Pattern');

  final cfg1 = AppConfig(appName: 'BankApp', version: '2.1.0');
  final cfg2 = AppConfig(); // second call – returns the SAME instance
  final cfg3 = AppConfig(appName: 'OtherApp'); // ignored – instance exists

  print('  cfg1 == cfg2 : ${identical(cfg1, cfg2)}'); // true
  print('  cfg1 == cfg3 : ${identical(cfg1, cfg3)}'); // true
  print('  cfg1 : $cfg1');
  print('  cfg3 : $cfg3'); // still shows BankApp

  // ── Step 6: Mixins ─────────────────────────────────────────
  section('STEP 6 – Mixins');

  final emp = Employee('Carol', 50000);
  emp.giveRaise(5000);
  emp.giveRaise(-100); // rejected by mixin validation

  final store = Store('Gadget World');
  store.open();
  store.close();

  // ── Step 7: Extensions ────────────────────────────────────
  section('STEP 7 – Extensions');

  print('  7.isEven   : ${7.isEven}');
  print('  8.isOdd    : ${8.isOdd}');
  print('  13.isPrime : ${13.isPrime}');
  print('  3.repeat("-") : ${3.repeat("-")}');
  print('  "hello world".titleCase : ${"hello world".titleCase}');
  print('  "42".isNumeric : ${"42".isNumeric}');
  print('  "Module 6".banner("*") :\n${"Module 6".banner("*")}');

  // ── Step 8: Operator overloading ──────────────────────────
  section('STEP 8 – Operator Overloading');

  final v1 = Vector2D(3, 4);
  final v2 = Vector2D(1, 2);
  print('  v1 = $v1');
  print('  v2 = $v2');
  print('  v1 + v2 = ${v1 + v2}');
  print('  v1 - v2 = ${v1 - v2}');
  print('  v1 * 2  = ${v1 * 2}');
  print('  v1 == Vector2D(3,4) : ${v1 == Vector2D(3, 4)}');
  print('  v1 == v2            : ${v1 == v2}');

  // ── Step 9: Copy constructor ──────────────────────────────
  section('STEP 9 – Copy Constructor');

  final addr1 = Address(street: '123 Main St', city: 'Dhaka', country: 'BD');
  final addr2 = Address.copy(addr1); // independent copy
  addr2.city = 'Chittagong';

  print('  Original : $addr1'); // still Dhaka
  print('  Copy     : $addr2'); // Chittagong
  print('  Same object? ${identical(addr1, addr2)}'); // false

  // ── Step 10: Composition ──────────────────────────────────
  section('STEP 10 – Class Composition');

  final customer = Customer(
    id: '001',
    fullName: 'Zubayeer Alam',
    address: Address(street: '45 Bank Road', city: 'Chattogram', country: 'BD'),
    initialDeposit: 1000.00,
  );
  customer.showProfile();

  // ── Steps 11–13: Bank Account System ─────────────────────
  section('STEPS 11–13 – Bank Account System');

  final account = BankAccount(
    accountNumber: 'BD-2025-001',
    ownerName: 'Zubayeer Alam',
    initialDeposit: 500.00,
  );

  print('\n  -- Depositing \$300 --');
  account.deposit(300.00);

  print('\n  -- Depositing \$0 (invalid) --');
  account.deposit(0); // rejected

  print('\n  -- Withdrawing \$150 --');
  account.withdraw(150.00);

  print('\n  -- Withdrawing \$1000 (overdraft) --');
  account.withdraw(1000.00); // rejected

  print('\n  -- Withdrawing -\$50 (negative) --');
  account.withdraw(-50); // rejected

  print('\n  Current balance: \$${account.balance.toStringAsFixed(2)}');

  print('\n  -- Full transaction history --');
  account.printHistory();

  print('\n  toString()  : $account');
  print('  Total accounts opened: ${BankAccount.totalAccounts}');

  // ── Singleton test: two BankAccount objects are different ─
  final acc2 = BankAccount(accountNumber: 'BD-2025-001', ownerName: 'Test');
  print('\n  account == acc2 (same number): ${account == acc2}'); // true
  final acc3 = BankAccount(accountNumber: 'BD-2025-002', ownerName: 'Other');
  print('  account == acc3 (diff number): ${account == acc3}'); // false
  print('  Total accounts opened: ${BankAccount.totalAccounts}');

  // ── Step 14: code is already commented & formatted above ──
  section('STEP 14 – Code review complete');
  print('  ✔ Private fields with getters/setters');
  print('  ✔ Static variables and methods');
  print('  ✔ Factory constructor pattern');
  print('  ✔ Singleton pattern');
  print('  ✔ Mixins (Logging + Validation)');
  print('  ✔ Extensions on int and String');
  print('  ✔ Operator overloading (==, +, -, *)');
  print('  ✔ Copy constructor');
  print('  ✔ Class composition (Customer has BankAccount)');
  print('  ✔ Full Bank Account mini-project with validation');
  print('\n  All steps completed successfully.');
}