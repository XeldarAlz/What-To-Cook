## What-To-Cook (Ne Pişirsem?)

Flutter ile geliştirilmiş, elinizdeki malzemelere ve yemek kategorilerine göre tarif öneren bir mobil uygulama.

Uygulama, **Clean Architecture** ve **feature-first** yaklaşımı ile yapılandırılmıştır ve tarif verilerini **harici (GitHub)** üzerinden dinamik olarak alır. 

---

## Özellikler

- **Rastgele tarif**: Ana sekmede tek dokunuşla rastgele tarif önerisi
- **Malzemeye göre tarif bulma**: Elinizdeki malzemeleri seçerek uygun tarifleri listeleme
- **Kategori bazlı tarifler**: Kahvaltı, öğle, akşam, tatlı vb. kategorilere göre filtreleme
- **Harici veri yönetimi**:
  - Tarifler GitHub üzerindeki JSON dosyalarından okunur
  - Uygulama içi cache ile performanslı ve kontrollü veri kullanımı
- **Görsel destek**: Her tarif için uzaktan yüklenen görseller

---

## Mimarinin Genel Yapısı

Proje, `lib/` altında **feature-first + Clean Architecture** yapısını takip eder:

- **`core/`**
  - Ortak sabitler (`app_constants.dart`)
  - Hata modellemesi (`failures.dart`)
  - Ortak yardımcılar ve widget'lar

- **`features/recipe/`**
  - `data/`
    - `datasources/`
      - `recipe_remote_data_source.dart`: Tarifleri GitHub Raw JSON dosyalarından çeker
      - `recipe_cache_data_source.dart`: Tarifleri `SharedPreferences` ile cache'ler
      - `recipe_local_data_source.dart`: Uygulama içi statik/veri kaynağı
    - `models/`: JSON model ve dönüşümler
    - `repositories/recipe_repository_impl.dart`: Domain katmanındaki repository arayüzünün implementasyonu
  - `domain/`
    - `entities/recipe.dart`: Tarif için domain entity
    - `repositories/recipe_repository.dart`: Tarif okuma/arama sözleşmesi
    - `usecases/`: Tarifleri getiren ve filtreleyen iş kuralları (use case'ler)
  - `presentation/`
    - `pages/random_recipe_page.dart`: Rastgele tarif ekranı
    - `widgets/recipe_detail_widget.dart`: Tarif detay görünümü
    - `bloc/`: Tariflerle ilgili BLoC/Cubit yapıları (varsa)

- **`features/ingredients/`**
  - Kullanıcının elindeki malzemeleri seçtiği ve tarif aradığı ekran
  - `presentation/pages/ingredients_page.dart`
  - `presentation/bloc/ingredients_bloc.dart`

- **`core/injection/injection.dart`**
  - `get_it` ile dependency injection
  - Repository, data source, use case ve BLoC kayıtları

- **`main.dart`**
  - Uygulama giriş noktası
  - DI başlatma (`initDependencies`)
  - Uygulama başlarken tarif cache'ini temizleme / yenileme
  - Alt gezinme (tabs) yönetimi

---

## Tarif Verilerinin Yönetimi

Tarif verileri proje kökünde yer alan `data/` klasörü üzerinden yönetilir:

- `data/recipes_kahvalti.json`
- `data/recipes_ogle.json`
- `data/recipes_aksam.json`
- `data/recipes_tatli.json`

Bu dosyalar GitHub deposunda tutulur ve uygulama çalışırken **GitHub Raw Content** üzerinden okunur. Versiyon yayınlamadan sadece bu JSON dosyalarını güncelleyerek:

- Yeni tarif ekleyebilir
- Mevcut tarifleri düzenleyebilir
- Tarif görsellerini güncelleyebilirsiniz

`scripts/generate_recipes_json.dart` betiği, `recipes_data.dart` içeriğinden bu JSON dosyalarını otomatik üretmek ve görsel URL'lerini üretmek için kullanılabilir.

Detaylı veri yönetimi ve görsel ayarları için:

- `data/README.md`
- `data/IMAGES_README.md`

dosyalarına göz atabilirsiniz.

---

## Teknolojiler

- **Flutter** (Material 3)
- **flutter_bloc**: Ekran ve iş akışı yönetimi
- **get_it**: Dependency injection
- **dartz**: `Either` tabanlı fonksiyonel hata yönetimi
- **http**: Uzak JSON dosyalarından veri çekme
- **shared_preferences**: Basit cache mekanizması