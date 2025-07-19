
import 'package:flutter/material.dart';
import 'package:scholar_chat/core/constant/color.dart';

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({ Key? key,});

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  final TextEditingController complaintController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String? selectedComplaintType;
  final List<String> complaintTypes = ['خدمة', 'منتج', 'دعم فني', 'أخرى'];

  static const int maxComplaintLength = 500;

  @override
  void dispose() {
    complaintController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void clearAllFields() {
    complaintController.clear();
    emailController.clear();
    setState(() {
      selectedComplaintType = null;
    });
  }

  void showSendConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تأكيد الإرسال', textAlign: TextAlign.right),
        content: const Text('هل أنت متأكد من إرسال الشكوى؟', textAlign: TextAlign.right),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("تم إرسال الشكوى بنجاح")),
              );
              clearAllFields();
            },
            child: const Text('إرسال'),
          ),
        ],
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
     
          SizedBox.expand(
            child: Image.asset(
              'images/on1.jpg',
              fit: BoxFit.cover,
            ),
          ),

     
          Container(
            color: Colors.black.withOpacity(0.4),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        BackButton(color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "الشكاوى",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    DropdownButtonFormField<String>(
                      value: selectedComplaintType,
                      items: complaintTypes
                          .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedComplaintType = val;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                        hintText: 'اختر نوع الشكوى',
                      ),
                      dropdownColor: Colors.white,
                      iconEnabledColor: AppColor.back,
                    ),
                    const SizedBox(height: 20),

                   
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "بريدك الإلكتروني (اختياري)",
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "اكتب شكواك بالتفصيل",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

              
                    TextField(
                      controller: complaintController,
                      maxLines: null,
                      minLines: 6,
                      maxLength: maxComplaintLength,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "اكتب هنا...",
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: AppColor.back, width: 2),
                        ),
                        counterStyle: const TextStyle(color: Colors.black54),
                      ),
                      onChanged: (value) {
                        setState(() {}); 
                      },
                    ),

                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${complaintController.text.length} / $maxComplaintLength',
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              String complaint = complaintController.text.trim();
                              String email = emailController.text.trim();

                              if (selectedComplaintType == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("يرجى اختيار نوع الشكوى")),
                                );
                                return;
                              }

                              if (complaint.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("يرجى كتابة الشكوى قبل الإرسال")),
                                );
                                return;
                              }

                              if (email.isNotEmpty && !isValidEmail(email)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("يرجى إدخال بريد إلكتروني صالح")),
                                );
                                return;
                              }

                              showSendConfirmationDialog();
                            },
                            icon: const Icon(Icons.send),
                            label: const Text(
                              "إرسال الشكوى",
                              style: TextStyle(fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.back,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // زر المسح
                        ElevatedButton.icon(
                          onPressed: clearAllFields,
                          icon: const Icon(Icons.clear),
                          label: const Text(
                            "مسح",
                            style: TextStyle(fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[600],
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // رسالة ختامية / توجيهية (اختياري)
                    const Text(
                      "شكراً لملاحظاتكم، سيتم مراجعة الشكوى خلال 48 ساعة.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}