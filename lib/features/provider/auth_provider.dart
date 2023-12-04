import 'dart:convert';

import 'package:app/models/admin_support_response.dart';
import 'package:app/models/bakery_details_responase.dart';
import 'package:app/models/bakery_response.dart';
import 'package:app/models/favorite_response.dart';
import 'package:app/models/favorite_response_get.dart';
import 'package:app/models/get_branch_map_response.dart';
import 'package:app/models/payResponse.dart';
import 'package:app/models/rating_response.dart';
import 'package:app/models/recover_response.dart';
import 'package:app/models/register_response.dart';
import 'package:app/models/restaurant_response.dart';
import 'package:app/models/revu_sorpresa_response.dart';
import 'package:app/models/supermarket_response.dart';
import 'package:app/models/support_response.dart';
import 'package:app/models/user_put_response.dart';
import 'package:app/models/usuario_response.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:app/config/config.dart';
import 'package:app/models/login_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider with ChangeNotifier {
  bool _autenticando = false;
  List<Restaurant> onRestaurant = [];
  List<Bakery> onBakery = [];
  List<Supermarket> onSuperMarket = [];
  List<Favorite> onFavorite = [];
  List<Support> onSupport = [];
  List<BranchMap> onBranchMap = [];

  List<BakeryAliado> onBakeryAliado = [];

  final _storage = const FlutterSecureStorage();

  bool get autenticando => _autenticando;

  set autenticando(bool valor) {
    _autenticando = valor;
    notifyListeners();
  }

// Getters token
  static Future<String?> getToken() async {
    final _storage = const FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    const _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future login(String email, String password) async {
    autenticando = true;
    final data = {'email': email, 'password': password};

    final response = await http.post(
        Uri.parse('${Environment.apiURL}/auth/login/Mobile'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'});

    autenticando = false;

    if (response.statusCode == 201) {
      final loginResponse = loginResponseFromJson(response.body);
      _saveToken(loginResponse.data.accessToken);
      return true;
    } else {
      final responseBody = jsonDecode(response.body);
      return responseBody['error'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    final response = await http
        .get(Uri.parse('${Environment.apiURL}/auth/validateToken'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    autenticando = false;

    if (response.statusCode == 200) {
      final loginResponse = loginResponseFromJson(response.body);
      _saveToken(loginResponse.data.accessToken ?? '');
      return true;
    } else {
      logout();
      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }

// REGISTER

  Future register(String names, String last_names, String email,
      String cellphone, String password) async {
    autenticando = true;
    final data = {
      'names': names,
      'last_names': last_names,
      'email': email,
      'cellphone': cellphone,
      'password': password
    };

    final responseRegister = await http.post(
        Uri.parse('${Environment.apiURL}/user'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'});

    autenticando = false;

    if (responseRegister.statusCode == 201) {
      final registerResponse = registerResponseFromJson(responseRegister.body);

      return true;
    } else {
      final registerBody = jsonDecode(responseRegister.body);
      return registerBody['message'];
    }
  }

  // Logout
  Future logOut() async {
    final token = await _storage.read(key: 'token');
    final responseRegister = await http
        .delete(Uri.parse('${Environment.apiURL}/auth/logout'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (responseRegister.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

// RECOVER PASSWORD

  Future recoverPassword(
    String email,
  ) async {
    autenticando = true;
    final data = {'email': email};

    final responseRecover = await http.post(
        Uri.parse('${Environment.apiURL}/auth/recoverPassword'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'});

    autenticando = false;

    if (responseRecover.statusCode == 201) {
      final recoverResponse = recoverResponseFromJson(responseRecover.body);
      return true;
    } else {
      final recoverBody = jsonDecode(responseRecover.body);
      return recoverBody['message'];
    }
  }

  Future support(
    String question,
  ) async {
    autenticando = true;

    final token = await _storage.read(key: 'token');
    final data = {'question': question};

    final supportResponse = await http.post(
        Uri.parse('${Environment.apiURL}/support'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    autenticando = false;

    if (supportResponse.statusCode == 201) {
      final responseSupport = supportResponseFromJson(supportResponse.body);
      return true;
    } else {
      return false;
    }
  }

  Future<UsuarioResponse> userInfo() async {
    final token = await _storage.read(key: 'token');
    final responseUsuario = await http
        .get(Uri.parse('${Environment.apiURL}/auth/validateToken'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    return usuarioResponseFromJson(responseUsuario.body);
  }

  Future updateUser(
    String userId,
    String names,
    String lastName,
    String email,
    String cellphone,
  ) async {
    final data = {
      'names': names,
      'last_names': lastName,
      'email': email,
      'cellphone': cellphone
    };
    final token = await _storage.read(key: 'token');
    final userUpdate = await http.put(
        Uri.parse('${Environment.apiURL}/user/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(data));

    if (userUpdate.statusCode == 200) {
      final updateResponse = userPutResponseFromJson(userUpdate.body);
      debugPrint("updateResponse");
      debugPrint(updateResponse.toString());
      return true;
    } else {
      final updateBody = jsonDecode(userUpdate.body);
      return updateBody['message'];
    }
  }

// Category
  Future restaurant() async {
    final token = await _storage.read(key: 'token');
    final jsonData = await http.get(
        Uri.parse('${Environment.apiURL}/branch?category=RESTAURANT'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'bearer $token'
        });

    final data = restaurantResponseFromJson(jsonData.body);
    onRestaurant = data.data;
    return data.data;
  }

  Future bakery() async {
    final token = await _storage.read(key: 'token');
    final jsonData = await http.get(
        Uri.parse('${Environment.apiURL}/branch?category=BAKERY'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'bearer $token'
        });

    final data = bakeryResponseFromJson(jsonData.body);
    onBakery = data.data;
    return data.data;
//SUPERMARKET
  }

  Future supermarket() async {
    final token = await _storage.read(key: 'token');
    final jsonData = await http.get(
        Uri.parse('${Environment.apiURL}/branch?category=SUPERMARKET'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'bearer $token'
        });

    final data = supermarketResponseFromJson(jsonData.body);
    onSuperMarket = data.data;
    return data.data;
  }

  Future<AdminSupportResponse> getSupport() async {
    try {
      final token = await _storage.read(key: 'token');
      final getSupport = await http.get(
        Uri.parse('${Environment.apiURL}/support/byCreator'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'bearer $token',
        },
      );
      print(getSupport.body);
      if (getSupport.statusCode == 200) {
        final data = adminSupportResponseFromJson(getSupport.body);
        onSupport = data.data;
        return data;
      } else {
        throw Exception('Failed to load support');
      }
    } catch (error) {
      throw Exception('Failed to load support');
    }
  }

  Future favorite(String businesse, String branch) async {
    final token = await _storage.read(key: 'token');
    final data = {
      'businesse': businesse,
      'branch': branch,
    };
    final favoriteResponse = await http.post(
        Uri.parse('${Environment.apiURL}/favorite'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (favoriteResponse.statusCode == 201) {
      final responsefavorite = favoriteResponseFromJson(favoriteResponse.body);
      return true;
    } else {
      return false;
    }
  }

  Future<FavoriteResponseGet> getFavorite() async {
    try {
      final token = await _storage.read(key: 'token');
      final favorite = await http.get(
        Uri.parse('${Environment.apiURL}/favorite'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'bearer $token',
        },
      );

      if (favorite.statusCode == 200) {
        final data = favoriteResponseGetFromJson(favorite.body);
        onFavorite = data.data;
        return data;
      } else {
        throw Exception('Failed to load favorites');
      }
    } catch (error) {
      throw Exception('Failed to load favorites');
    }
  }

  // Details and Revusorpresa
  Future<BakeryAliado?> bakeryAliado(
    String aliadoId,
    String bakeryId,
  ) async {
    final token = await _storage.read(key: 'token');
    final bakeryAliadoResponse = await http.get(
      Uri.parse('${Environment.apiURL}/branch/$aliadoId/$bakeryId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'bearer $token'
      },
    );

    if (bakeryAliadoResponse.statusCode != 200) {
      // Maneja el caso de respuesta no exitosa
      return null;
    }

    final data = bakeryDetailsResponseFromJson(bakeryAliadoResponse.body);
    final bakeryAliado = data.data as BakeryAliado?;
    return bakeryAliado;
  }

  Future<RevuSopresa?> revuSopresaBakery(
    String aliadoId,
    String bakeryId,
  ) async {
    final token = await _storage.read(key: 'token');
    final bakeryRevuSorpresa = await http.get(
      Uri.parse('${Environment.apiURL}/revuSurprise/$aliadoId/$bakeryId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'bearer $token'
      },
    );

    if (bakeryRevuSorpresa.statusCode != 200) {
      // Maneja el caso de respuesta no exitosa
      return null;
    }

    final data = revuSopresaResponseFromJson(bakeryRevuSorpresa.body);
    final revuAliadoBakery = data.data;
    return revuAliadoBakery;
  }

  Future rating(
      String businesse, String branch, double rating, String comment) async {
    final token = await _storage.read(key: 'token');

    final data = {
      'businesse': businesse,
      'branch': branch,
      'rating': rating,
      'comment': comment
    };

    final ratingResponse = await http.post(
        Uri.parse('${Environment.apiURL}/rating'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(data));

    if (ratingResponse.statusCode == 201) {
      final responseRatings = ratingResponseFromJson(ratingResponse.body);
      return true;
    } else {
      return false;
    }
  }

  Future payment(List<Map<String, dynamic>> products) async {
    autenticando = true;

    final token = await _storage.read(key: 'token');
    final data = {
      'products': products
    }; // Asegúrate de que el nombre del campo coincida con la API

    final payResponse = await http.post(
      Uri.parse('${Environment.apiURL}/shopping'),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    autenticando = false;

    if (payResponse.statusCode == 201) {
      final responsePay = payResponseFromJson(payResponse.body);
      return true;
    } else {
      return false;
    }
  }

  Future<GetBranchMapResponse> getAliado() async {
    try {
      final token = await _storage.read(key: 'token');
      final getBranchMap = await http.get(
        Uri.parse('${Environment.apiURL}/branch/map'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'bearer $token',
        },
      );

      if (getBranchMap.statusCode == 200) {
        final data = getBranchMapResponseFromJson(getBranchMap.body);
        onBranchMap = data.data;

        return data;
      } else {
        throw Exception('Failed to load favorites');
      }
    } catch (error) {
      throw Exception('Failed to load favorites');
    }
  }
}
