import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scholar_chat/core/constant/color.dart';
import 'package:scholar_chat/provider/provider.dart';

class Product {
  final String imageUrl;
  final String name;
  final String price;
  final String details;

  Product({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.details,
  });
}

class ProductsPage extends StatelessWidget {
  final List<Product> products = [
    Product(
      imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
      name: 'Dermal Filler',
      price: '\$250',
      details: 'Injectable filler for facial volume restoration',
    ),
    Product(
      imageUrl: 'https://images.unsplash.com/photo-1522337660859-02fbefca4702?auto=format&fit=crop&w=800&q=80',
      name: 'Botox',
      price: '\$300',
      details: 'Botulinum toxin injections for wrinkle reduction',
    ),
    Product(
      imageUrl: 'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=crop&w=800&q=80',
      name: 'Medical Grade Skincare',
      price: '\$80',
      details: 'Clinically proven skincare for skin rejuvenation',
    ),
    Product(
      imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
      name: 'Chemical Peel',
      price: '\$150',
      details: 'Exfoliating treatment for skin texture improvement',
    ),
    Product(
      imageUrl: 'https://images.unsplash.com/photo-1522337660859-02fbefca4702?auto=format&fit=crop&w=800&q=80',
      name: 'Laser Therapy',
      price: '\$400',
      details: 'Advanced laser treatment for skin tightening',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final double screenWidth = media.width;
    final double screenHeight = media.height;

    return Scaffold(
      body: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return Stack(
            children: [
      
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColor.primaryColor, AppColor.back],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

           
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
                ),
              ),

         
              SafeArea(
                child: Column(
                  children: [
          
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.04,
                      ),
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      decoration: BoxDecoration(
                        color: AppColor.back.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColor.back, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.back.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'images/setting.png',
                            width: screenWidth * 0.18,
                            height: screenWidth * 0.18,
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          Expanded(
                            child: Text(
                              "To order products, contact us via chat",
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.bold,
                                color: AppColor.back,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];

                          return Container(
                            margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.back,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(screenWidth * 0.03),
                              child: Row(
                                children: [
                               
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      product.imageUrl,
                                      width: screenWidth * 0.25,
                                      height: screenWidth * 0.25,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          width: screenWidth * 0.25,
                                          height: screenWidth * 0.25,
                                          color: AppColor.white,
                                          child: const Icon(Icons.image_not_supported, size: 40),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: screenWidth * 0.04),
                      
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.045,
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromARGB(221, 60, 60, 60),
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.005),
                                        Text(
                                          product.price,
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.04,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.teal[800],
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.008),
                                        Text(
                                          product.details,
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.035,
                                            color: Colors.grey[600],
                                            height: 1.3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
