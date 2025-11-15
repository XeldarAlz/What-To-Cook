import 'dart:convert';
import 'dart:io';
import '../lib/features/recipe/data/models/recipes_data.dart';
import '../lib/features/recipe/domain/entities/recipe.dart';

const String githubRepo = 'XeldarAlz/What-To-Cook';
const String githubBranch = 'main';
const String imagesPath = 'data/images';

void main(List<String> args) async {
  final autoImageUrl = args.contains('--auto-images');
  
  final recipes = RecipesData.getAllRecipes();
  
  final kahvalti = recipes.where((r) => r.category == RecipeCategory.kahvalti).toList();
  final ogle = recipes.where((r) => r.category == RecipeCategory.ogleYemegi).toList();
  final aksam = recipes.where((r) => r.category == RecipeCategory.aksamYemegi).toList();
  final tatli = recipes.where((r) => r.category == RecipeCategory.tatli).toList();
  
  final categories = [
    ('kahvalti', kahvalti),
    ('ogle', ogle),
    ('aksam', aksam),
    ('tatli', tatli),
  ];
  
  for (final (categoryName, categoryRecipes) in categories) {
    List<Map<String, dynamic>> jsonList;
    
    if (autoImageUrl) {
      jsonList = categoryRecipes.map((recipe) {
        final json = recipe.toJson();
        final imageUrl = 'https://raw.githubusercontent.com/$githubRepo/$githubBranch/$imagesPath/${recipe.id}.jpg';
        json['imageUrl'] = imageUrl;
        return json;
      }).toList();
    } else {
      jsonList = categoryRecipes.map((recipe) => recipe.toJson()).toList();
    }
    
    final jsonString = const JsonEncoder.withIndent('  ').convert(jsonList);
    
    final file = File('data/recipes_$categoryName.json');
    await file.create(recursive: true);
    await file.writeAsString(jsonString);
    
    print('✅ recipes_$categoryName.json dosyası oluşturuldu: ${file.path}');
    print('📦 ${categoryRecipes.length} tarif JSON formatına dönüştürüldü.');
  }
  
  print('');
  print('✅ Toplam ${recipes.length} tarif ${categories.length} kategoriye ayrıldı.');
  print('');
  
  if (autoImageUrl) {
    print('🖼️  Otomatik görsel URL\'leri oluşturuldu');
    print('📝 Görsel URL Formatı:');
    print('   https://raw.githubusercontent.com/$githubRepo/$githubBranch/$imagesPath/{recipe_id}.jpg');
    print('');
    print('📝 Sonraki adımlar:');
    print('1. Görselleri data/images/ klasörüne ekleyin (format: {recipe_id}.jpg)');
    print('2. data/recipes_*.json dosyalarını GitHub\'a commit edin ve push edin');
    print('3. Görselleri GitHub\'a commit edin ve push edin');
  } else {
    print('📝 Sonraki adımlar:');
    print('1. data/recipes_*.json dosyalarını GitHub repo\'nuzun data/ dizinine ekleyin');
    print('2. GitHub\'da dosyaları commit edin ve push edin');
    print('3. Raw content URL\'leri:');
    for (final (categoryName, _) in categories) {
      print('   - https://raw.githubusercontent.com/$githubRepo/$githubBranch/data/recipes_$categoryName.json');
    }
    print('');
    print('💡 İpucu: Otomatik görsel URL\'leri için şu komutu kullanın:');
    print('   dart run scripts/generate_recipes_json.dart --auto-images');
  }
}

