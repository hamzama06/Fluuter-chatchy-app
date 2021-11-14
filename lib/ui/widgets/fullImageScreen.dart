import 'package:flutter/material.dart';

class FullImageScreen extends StatelessWidget {
  final imageUrl;
  FullImageScreen(this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return 
    SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
             icon: Icon(Icons.close, color: Colors.white54,),),
             backgroundColor: Colors.black.withOpacity(0.3),
        ),
        body: Container(
        child: Center(
          child: Image.network(
                                imageUrl,
                                
                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Container(
                                  
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                   
                                    child: Center(
                                      child: CircularProgressIndicator(
                                       
                                      ),
                                    ),
                                  );
                                },
                               
                              
                                fit: BoxFit.fill,
                              ),
        ),
      )
      ),
    );
    
    
  }
}