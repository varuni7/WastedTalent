import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';

import 'package:wastedtalent/models/categories.dart';
import 'package:wastedtalent/services/product/newProduct.dart';
import 'package:wastedtalent/services/product/newWork.dart';

class AddProduct extends StatefulWidget {
  final section;

  const AddProduct({Key? key, this.section}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<File>? files = [];
  final title = TextEditingController();
  final description = TextEditingController();
  final quantity = TextEditingController();
  final price = TextEditingController();
  List<DropDownValueModel> categories = category
      .map(
        (e) => DropDownValueModel(name: e, value: e),
      )
      .toList();
  late MultiValueDropDownController _cntMulti = MultiValueDropDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                  options: CarouselOptions(
                      height: MediaQuery.of(context).size.height / 3,
                      viewportFraction: 1),
                  itemCount: files!.length + 1,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    if (itemIndex == 0) {
                      return InkWell(
                        onTap: pickfile,
                        child: Stack(
                          children: [
                            Image(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 3,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80")),
                            Positioned(
                                child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 3,
                              decoration: BoxDecoration(color: Colors.black54),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ))
                          ],
                        ),
                      );
                    } else {
                      return Image(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width,
                          image: FileImage(files![itemIndex - 1]));
                    }
                  }),
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 16, 0, 0),
                child: Text(
                  widget.section == "Product" ? "Add Item" : "Add to Portfolio",
                  style: GoogleFonts.metrophobic(fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16, 16, 0),
                child: TextField(controller: title,
                  decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade100)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(controller: description,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Description",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade100)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
                child: DropDownTextField.multiSelection(
                  controller: _cntMulti,
                  listTextStyle: GoogleFonts.alata(),
                  dropDownList: categories,
                  textFieldDecoration: InputDecoration(
                    hintText: "Tags",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade100)),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Required field";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) {},
                ),
              ),
              widget.section == "Product"
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: TextField(controller: quantity,
                        keyboardType: TextInputType.number,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "Quantity",
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: EdgeInsets.all(8),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100)),
                        ),
                      ),
                    )
                  : Container(),
              widget.section == "Product"
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: TextField(controller: price,
                        keyboardType: TextInputType.number,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "Price",
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: EdgeInsets.all(8),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100)),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 2),
              child: InkWell(
                onTap: () async {

                  widget.section == "Product"
                      ? await newProduct(
                          FirebaseAuth.instance.currentUser?.uid,
                          title.text,
                          description.text,
                          _cntMulti.dropDownValueList!
                              .map((e) => e.name)
                              .toList()
                              .toString(),
                          quantity.text,
                          price.text,
                          files!)
                      : await newWork(
                          FirebaseAuth.instance.currentUser?.uid,
                          title.text,
                          description.text,
                          _cntMulti.dropDownValueList!
                              .map((e) => e.name)
                              .toList()
                              .toString(),
                          files!);
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.deepPurple),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.section == "Product" ? "Add Product" : "Add",
                        style: GoogleFonts.metrophobic(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  pickfile() async {
    final picker = await FilePicker.platform.pickFiles(allowMultiple: true);
    setState(() {
      files = picker?.paths.map((path) => File(path!)).toList();
    });
  }
}
