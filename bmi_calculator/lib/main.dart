import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: BMICalculator()),
  );
}

enum WeightUnit { kg, pound }

enum HeightUnit { cm, feetInch }

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  WeightUnit weightUnit = WeightUnit.kg;
  HeightUnit heightUnit = HeightUnit.feetInch;

  final TextEditingController weight = TextEditingController();
  final TextEditingController feet = TextEditingController();
  final TextEditingController inch = TextEditingController();
  final TextEditingController cm = TextEditingController();

  double? bmi;
  String category = "";
  Color categoryColor = Colors.grey;

  void calculateBMI() {
    if (weight.text.isEmpty) {
      showError("Enter weight");
      return;
    }

    double w = double.tryParse(weight.text) ?? 0;
    if (weightUnit == WeightUnit.pound) w *= 0.453592; // LB → KG

    double h = 0;
    if (heightUnit == HeightUnit.cm) {
      if (cm.text.isEmpty) return showError("Enter height");
      h = (double.tryParse(cm.text) ?? 0) / 100;
    } else {
      double f = double.tryParse(feet.text) ?? 0;
      double i = double.tryParse(inch.text) ?? 0;
      h = ((f * 12) + i) * 0.0254; // Feet+Inch → Meter
    }

    if (h <= 0 || w <= 0) return showError("Enter valid values");

    setState(() {
      bmi = w / (h * h);
      updateCategory();
    });
  }

  void updateCategory() {
    if (bmi! < 18.5) {
      category = "Underweight";
      categoryColor = Colors.blue;
    } else if (bmi! < 25) {
      category = "Normal";
      categoryColor = Colors.green;
    } else if (bmi! < 30) {
      category = "Overweight";
      categoryColor = Colors.orange;
    } else {
      category = "Obese";
      categoryColor = Colors.red;
    }
  }

  void showError(String text) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(text), backgroundColor: Colors.red));
  }

  IconData getIcon() {
    if (bmi! < 18.5) return Icons.sentiment_dissatisfied;
    if (bmi! < 25) return Icons.sentiment_very_satisfied;
    if (bmi! < 30) return Icons.sentiment_neutral;
    return Icons.sentiment_very_dissatisfied;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Weight Unit Segmented Button
            const Text(
              "Weight Unit",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SegmentedButton<WeightUnit>(
              segments: const [
                ButtonSegment(value: WeightUnit.kg, label: Text("KG")),
                ButtonSegment(value: WeightUnit.pound, label: Text("Pound")),
              ],
              selected: {weightUnit},
              onSelectionChanged: (v) => setState(() => weightUnit = v.first),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: weight,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText:
                    "Weight (${weightUnit == WeightUnit.kg ? "kg" : "lb"})",
                border: const OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            /// Height Unit Segmented Button
            const Text(
              "Height Unit",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SegmentedButton<HeightUnit>(
              segments: const [
                ButtonSegment(value: HeightUnit.cm, label: Text("CM")),
                ButtonSegment(
                  value: HeightUnit.feetInch,
                  label: Text("Feet/Inch"),
                ),
              ],
              selected: {heightUnit},
              onSelectionChanged: (v) => setState(() => heightUnit = v.first),
            ),

            const SizedBox(height: 15),

            heightUnit == HeightUnit.cm
                ? TextField(
                    controller: cm,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Height (cm)",
                      border: OutlineInputBorder(),
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: feet,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Feet",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: inch,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Inch",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: calculateBMI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Check BMI",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 25),

            if (bmi != null)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        bmi!.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Chip(
                        label: Text(
                          category,
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: categoryColor,
                      ),
                      const SizedBox(height: 15),
                      Icon(getIcon(), size: 70, color: categoryColor),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
