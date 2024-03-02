

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

import '../errors/failure/failures.dart';


@lazySingleton
class LocationService {

  Future<Position?> getCurrentLocation() async {
    try {
      LocationPermission locationPermission = await Geolocator.checkPermission();
      debugPrint('locationPermission is : $locationPermission');
      if(locationPermission != LocationPermission.denied){
        var position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        return position;
      }else {
        return null;
      }

    } on TimeoutException catch (e) {
      throw LocationFailure(LocationFailureType.timeout, e.toString());
    } on LocationServiceDisabledException catch (e) {
      throw LocationFailure(
          LocationFailureType.locationServiceDisabled, e.toString());
    }on PlatformException catch (e){
      throw LocationFailure(
          LocationFailureType.platformException, e.toString());
    }on Exception catch(e){
      throw GeneralFailure(GeneralFailureType.unexpectedError, e.toString());
    }
  }



  Future<Placemark> getCity(Position myLocation ) async{
    try{

      List<Placemark> placemarks = await placemarkFromCoordinates(myLocation.latitude, myLocation.longitude);
      print('placemarks is : $placemarks');
      Placemark place = placemarks[0];
      var address = '${place.locality}';
      return place ;
    } on TimeoutException catch (e) {
      throw LocationFailure(LocationFailureType.timeout, e.toString());
    } on LocationServiceDisabledException catch (e) {
      throw LocationFailure(
          LocationFailureType.locationServiceDisabled, e.toString());
    }on PlatformException catch (e){
      throw LocationFailure(
          LocationFailureType.platformException, e.toString());
    }on Exception catch(e){
      throw GeneralFailure(GeneralFailureType.unexpectedError, e.toString());
    }
  }

}