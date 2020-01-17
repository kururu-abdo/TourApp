import 'package:sailor/sailor.dart';
import 'package:tourapp/Models/location_models.dart';
import 'package:tourapp/Ui/detail_page.dart';
import 'package:tourapp/Ui/map_page.dart';
import 'package:tourapp/Ui/search_page.dart';

class Routes {
static final sailor =Sailor();
static void createRoutes(){
sailor.addRoutes([


  
SailorRoute(name: '/detail' , builder: (context , args , params){
return Details(desc:params.param("desc")  , 
pic:params.param("pic") 
 );
} , 
params: [SailorParam(name: "desc" , defaultValue:"my city" ) ,

SailorParam(name: "pic" , defaultValue: "" ) ,]   ) ,


SailorRoute(name: '/map' , builder: (context , args , params){
return mapPage(params.param<double >("lat")  ,params.param<double >("longitude") ,params.param("location"));
} , 
params: [SailorParam(name: "lat" , defaultValue: 15.866868 ) ,

SailorParam(name: "longitude" , defaultValue: 34.866868 ) ,
SailorParam(name: "location" , defaultValue: "khartoum" ) ,
]   ,
defaultTransitions:[SailorTransition.slide_from_bottom ]


) ,

   ]  
   
   
   );


}


}
