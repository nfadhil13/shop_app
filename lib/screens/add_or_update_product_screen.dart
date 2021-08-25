import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_list_provider.dart';
import 'package:shop_app/providers/product_provider.dart';

enum AddOrUpdateMode {
  Update,
  Add
}

class AddOrUpdateProductScreen extends StatefulWidget {
  static final routeName = "/add-or-update-product";

  const AddOrUpdateProductScreen({Key? key}) : super(key: key);

  @override
  _AddOrUpdateProductScreenState createState() =>
      _AddOrUpdateProductScreenState();
}

class _AddOrUpdateProductScreenState extends State<AddOrUpdateProductScreen> {
  final _priceFocusNode = FocusNode();
  final _imageURLController = TextEditingController();
  final _descriptionFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();


  var _isLoading = false;


  var _mode = AddOrUpdateMode.Add;

  var _tobeSavedProduct = ProductProvider(
      id: "", title: "", description: "", price: 0, imageUrl: "");


  var _defaultProduct = ProductProvider(
      id: "", title: "", description: "", price: 0, imageUrl: "");

  var _isInit = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(!_isInit){
      final productId = ModalRoute.of(context)?.settings.arguments as String? ?? null;
      if(productId != null){
        final selectedPrdocut = Provider.of<ProductListProvider>(
            context,
            listen: false
        ).findById(productId);
        _mode = AddOrUpdateMode.Update;
        _tobeSavedProduct = selectedPrdocut;
        _defaultProduct = selectedPrdocut;
        _imageURLController.text = _tobeSavedProduct.imageUrl;
        _isInit = true;
    }
    super.didChangeDependencies();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageURLController.dispose();
    super.dispose();
  }

  void _saveForm()  async{
    try{
      final currentState = _form.currentState;
      if(currentState != null && currentState.validate()){
        currentState.save();
        final productListProvider = Provider.of<ProductListProvider>(
            context,
            listen: false
        );
        _isLoading = true;
        var updatedProduct = _tobeSavedProduct;
        if(_mode == AddOrUpdateMode.Update){
          updatedProduct = await productListProvider.updateProduct(_tobeSavedProduct);
        }else{
          updatedProduct = await productListProvider.addProduct(_tobeSavedProduct);
        }
        _isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(milliseconds: 2000),
              content: Text("Success ${_mode == AddOrUpdateMode.Update ? "update" : "add" } product"),
              action: SnackBarAction(
                label: "Undo",
                onPressed: () {
                  if(_mode == AddOrUpdateMode.Add) {
                    productListProvider.removeItem(_tobeSavedProduct.id);
                  }else{
                    productListProvider.updateProduct(_defaultProduct);
                  }
                },
              ),
            )
        );
        Navigator.of(context).pop(true);
      }
    }catch(error){
      _isLoading = false;
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Error updating the data"),
            content: Text("Something wrong with uploading the data"),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(context).pop(true);
              }, child: Text("Ok"))
            ],
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_mode == AddOrUpdateMode.Add ? "Add Product" : "Update Product"),
        actions: [IconButton(onPressed: _saveForm, icon: Icon(Icons.save))],
      ),
      body: Stack(
        children : [
          SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: _tobeSavedProduct.title,
                    decoration: InputDecoration(labelText: "Title"),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    validator: (value) {
                      if(value == null || value.isEmpty) return "Title has to be filled";
                      return null;
                    },
                    onSaved: (value) {
                      _tobeSavedProduct = ProductProvider(
                          id: _tobeSavedProduct.id,
                          title: value ?? _tobeSavedProduct.title,
                          description: _tobeSavedProduct.description,
                          price: _tobeSavedProduct.price,
                          imageUrl: _tobeSavedProduct.imageUrl);
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                      initialValue: _tobeSavedProduct.price.toString(),
                      decoration: InputDecoration(labelText: "Price"),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if(value == null || value.isEmpty) return "Price has to be filled";
                        final price = double.tryParse(value);
                        if(price == null) return "Price has to be a number";
                        if(price <= 0) return "Price cant be less than \$0";
                        return null;
                      },
                      onSaved: (value) {
                        _tobeSavedProduct = ProductProvider(
                            id: _tobeSavedProduct.id,
                            title: _tobeSavedProduct.title,
                            description: _tobeSavedProduct.description,
                            price: double.tryParse(value ?? "") ??
                                _tobeSavedProduct.price,
                            imageUrl: _tobeSavedProduct.imageUrl);
                      }),
                  SizedBox(height: 20),
                  TextFormField(
                      initialValue: _tobeSavedProduct.description,
                      decoration: InputDecoration(labelText: "Description"),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      validator: (value) {
                        if(value == null || value.isEmpty) return "Title has to be filled";
                        return null;
                      },
                      onSaved: (value) {
                        _tobeSavedProduct = ProductProvider(
                            id: _tobeSavedProduct.id,
                            title: _tobeSavedProduct.title,
                            description: value ?? _tobeSavedProduct.description,
                            price: _tobeSavedProduct.price,
                            imageUrl: _tobeSavedProduct.imageUrl);
                      }),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: _imageURLController.text.isEmpty
                              ? Text(
                            "Masukan url gambar",
                            textAlign: TextAlign.center,
                          )
                              : Image.network(_imageURLController.text,
                              fit: BoxFit.fill)),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                            decoration: InputDecoration(labelText: "Image URL"),
                            keyboardType: TextInputType.url,
                            controller: _imageURLController,
                            onEditingComplete: () {
                              setState(() {});
                            },
                            validator: (value) {
                              if(value == null || value.isEmpty) return "Title has to be filled";
                              if(!value.startsWith("http") || !value.startsWith("https")) return "Image url is not valid";
                              return null;
                            },
                            onSaved: (value) {
                              _tobeSavedProduct = ProductProvider(
                                  id: _tobeSavedProduct.id,
                                  title: _tobeSavedProduct.title,
                                  description: _tobeSavedProduct.description,
                                  price: _tobeSavedProduct.price,
                                  imageUrl: value ?? _tobeSavedProduct.imageUrl
                              );
                            }),
                      )
                    ],
                  ),
                ]
              ),
            ),
          ),
          if(_isLoading) Container(
            color: Colors.black.withOpacity(0.7),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        ]
      ),
    );
  }
}
