# Tarif Verileri Yönetimi

Bu klasör, uygulamanın tarif verilerini içeren JSON dosyasını barındırır.

## Nasıl Kullanılır?

### 1. JSON Dosyasını Oluşturma

Mevcut tarifleri JSON formatına dönüştürmek için:

```bash
dart run scripts/generate_recipes_json.dart
```

Bu komut `data/recipes.json` dosyasını oluşturur.

### 2. GitHub'a Yükleme

1. `data/recipes.json` dosyasını GitHub repo'nuzun root dizinine ekleyin
2. Dosyayı commit edin ve push edin:
   ```bash
   git add data/recipes.json
   git commit -m "feat: add recipes JSON file"
   git push origin main
   ```

### 3. URL'yi Güncelleme

GitHub'da dosya yüklendikten sonra, raw content URL'sini alın:
- Format: `https://raw.githubusercontent.com/[USERNAME]/[REPO]/[BRANCH]/data/recipes.json`
- Örnek: `https://raw.githubusercontent.com/XeldarAlz/What-To-Cook/main/data/recipes.json`

Bu URL'yi `lib/core/constants/app_constants.dart` dosyasındaki `recipesJsonUrl` değişkenine ekleyin.

### 4. Tarif Güncelleme

Tarifleri güncellemek için:

1. `lib/features/recipe/data/models/recipes_data.dart` dosyasını düzenleyin
2. JSON dosyasını yeniden oluşturun: `dart run scripts/generate_recipes_json.dart`
3. GitHub'a push edin
4. Uygulama otomatik olarak yeni tarifleri çekecek (cache süresi: 24 saat)

## Cache Mekanizması

- Tarifler 24 saat boyunca cache'lenir
- Cache süresi dolduğunda veya internet bağlantısı yoksa local tarifler kullanılır
- İlk açılışta remote'dan çeker, sonra cache'den okur

## Notlar

- JSON dosyası büyük olabilir, GitHub'ın dosya boyutu limitlerini kontrol edin
- Raw content URL'si her zaman `main` branch'ini işaret etmelidir
- Tarif eklerken veya güncellerken JSON formatını koruyun

