import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable{
  LocationEvent([List probs =const[]]):super(probs);
}

class GetMesums extends LocationEvent{
final  String type ;

  GetMesums(this.type);

}
class GetPyramids extends LocationEvent{

  final String type ;

  GetPyramids(this.type);

}
class GetOthers extends LocationEvent{
final String  type;

  GetOthers(this.type);

}