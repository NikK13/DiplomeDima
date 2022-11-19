
class ListItem{
  String title;
  String value;

  ListItem(this.title, this.value);
}

List<ListItem> get languages => List.from([
  ListItem("English", 'en'),
  ListItem("Русский", 'ru'),
]);

List<ListItem> get comps => List.from([
  ListItem("Базовая", 'base'),
  ListItem("Комфорт", 'comfort'),
  ListItem("Люкс", 'luxury'),
]);

List<ListItem> get carTypes => List.from([
  ListItem("Внедорожник", 'jeep'),
  ListItem("Универсал", 'universal'),
  ListItem("Хэтчбек", 'hatchback'),
  ListItem("Седан", 'sedan'),
  ListItem("Минивэн", 'minivan'),
]);

List<ListItem> get models => List.from([
  ListItem("Superb", 'superb'),
  ListItem("Octavia", 'octavia'),
  ListItem("Rapid", 'rapid'),
  ListItem("Karoq", 'karoq'),
  ListItem("Kodiaq", 'kodiaq')
]);