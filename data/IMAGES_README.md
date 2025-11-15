# Görsel Yönetimi

## Görselleri GitHub'a Yükleme

### 1. Görselleri Hazırlama

Her tarif için görsel hazırlayın ve şu formatta isimlendirin:
- Format: `{recipe_id}.jpg` veya `{recipe_id}.png`
- Örnek: `kahvalti_1.jpg`, `ogle_1.png`

### 2. Görselleri GitHub'a Yükleme

1. Görselleri `data/images/` klasörüne koyun
2. GitHub'a commit edin ve push edin:
   ```bash
   git add data/images/
   git commit -m "feat: add recipe images"
   git push origin main
   ```

### 3. Raw URL Formatı

GitHub raw URL formatı:
```
https://raw.githubusercontent.com/XeldarAlz/What-To-Cook/main/data/images/{recipe_id}.jpg
```

### 4. JSON'da Görsel URL'lerini Güncelleme

`lib/features/recipe/data/models/recipes_data.dart` dosyasında her tarifin `imageUrl` değerini güncelleyin:

```dart
RecipeModel(
  id: 'kahvalti_1',
  name: 'Menemen',
  imageUrl: 'https://raw.githubusercontent.com/XeldarAlz/What-To-Cook/main/data/images/kahvalti_1.jpg',
  // ...
)
```

### 5. JSON Dosyasını Yeniden Oluşturma

Görsel URL'lerini güncelledikten sonra:
```bash
dart run scripts/generate_recipes_json.dart
```

### 6. GitHub'a Push Etme

```bash
git add data/recipes.json
git commit -m "feat: update recipe image URLs"
git push origin main
```

## Alternatif: Otomatik Görsel URL Oluşturma

Eğer görselleri belirli bir formatta isimlendirirseniz, script'i güncelleyerek otomatik URL oluşturabiliriz.

## Notlar

- Görsel boyutları: Önerilen maksimum 800x600px, dosya boyutu < 500KB
- Format: JPG (daha küçük dosya) veya PNG (şeffaflık gerekirse)
- GitHub dosya boyutu limiti: Dosya başına 100MB, repo için genel limitler var
- 80 tarif için toplam ~40MB görsel olabilir (ortalama 500KB/tarif)

