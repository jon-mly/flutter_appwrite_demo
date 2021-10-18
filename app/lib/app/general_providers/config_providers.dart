import 'package:appwrite_demo/models/classes/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final configurationProvider = Provider<Configuration>((ref) => Configuration(
    appwriteEndpoint: "https://7980-90-127-37-203.ngrok.io",
    appwriteProjectId: "616d96cf3c63d"));
