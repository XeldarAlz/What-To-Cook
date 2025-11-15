import 'dart:convert';
import 'dart:io';
import '../lib/features/recipe/data/models/recipes_data.dart';
import '../lib/features/recipe/data/models/recipe_model.dart';

const String githubRepo = 'XeldarAlz/What-To-Cook';
const String githubBranch = 'main';
const String imagesPath = 'data/images';

void main(List<String> args) async {
  final autoImageUrl = args.contains('--auto-images');
  
  final recipes = RecipesData.getAllRecipes();
  
  List<Map<String, dynamic>> jsonList;
  
  if (autoImageUrl) {
    jsonList = recipes.map((recipe) {
      final json = recipe.toJson();
      final imageUrl = 'https://raw.githubusercontent.com/$githubRepo/$githubBranch/$imagesPath/${recipe.id}.jpg';
      json['imageUrl'] = imageUrl;
      return json;
    }).toList();
    print('🖼️  Otomatik görsel URL\'leri oluşturuldu');
  } else {
    jsonList = recipes.map((recipe) => recipe.toJson()).toList();
  }
  
  final jsonString = const JsonEncoder.withIndent('  ').convert(jsonList);
  
  final file = File('data/recipes.json');
  await file.create(recursive: true);
  await file.writeAsString(jsonString);
  
  print('✅ recipes.json dosyası oluşturuldu: ${file.path}');
  print('📦 Toplam ${recipes.length} tarif JSON formatına dönüştürüldü.');
  print('');
  
  if (autoImageUrl) {
    print('📝 Görsel URL Formatı:');
    print('   https://raw.githubusercontent.com/$githubRepo/$githubBranch/$imagesPath/{recipe_id}.jpg');
    print('');
    print('📝 Sonraki adımlar:');
    print('1. Görselleri data/images/ klasörüne ekleyin (format: {recipe_id}.jpg)');
    print('2. data/recipes.json dosyasını GitHub\'a commit edin ve push edin');
    print('3. Görselleri GitHub\'a commit edin ve push edin');
  } else {
    print('📝 Sonraki adımlar:');
    print('1. data/recipes.json dosyasını GitHub repo\'nuzun root dizinine ekleyin');
    print('2. GitHub\'da dosyayı commit edin ve push edin');
    print('3. Raw content URL\'si: https://raw.githubusercontent.com/$githubRepo/$githubBranch/data/recipes.json');
    print('');
    print('💡 İpucu: Otomatik görsel URL\'leri için şu komutu kullanın:');
    print('   dart run scripts/generate_recipes_json.dart --auto-images');
  }
}

