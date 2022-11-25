
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

List<ListItem> get gearBoxes => List.from([
  ListItem("Механическая", 'manual'),
  ListItem("Автоматическая", 'automatic'),
]);

List<ListItem> get fuelTypes => List.from([
  ListItem("Бензин", 'gas'),
  ListItem("Дизель", 'diesel'),
  ListItem("Электро", 'electric'),
]);

List<ListItem> get carsTypes => List.from([
  ListItem("Все", 'all'),
  ListItem("Новые", 'new'),
  ListItem("Поддержанные", 'old'),
]);

List<ListItem> get engineValues => List.from([
  ListItem("1.2", '1.2'),
  ListItem("1.3", '1.3'),
  ListItem("1.4", '1.4'),
  ListItem("1.6", '1.6'),
  ListItem("1.8", '1.8'),
  ListItem("1.9", '1.9'),
  ListItem("2.0", '2.0'),
  ListItem("2.5", '2.5'),
  ListItem("3.0", '3.0'),
]);

List<ListItem> get transmissions => List.from([
  ListItem("AWD", 'awd'),
  ListItem("RWD", 'rwd'),
  ListItem("FWD", 'fwd'),
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
  ListItem("Kodiaq", 'kodiaq'),
  ListItem("Fabia", 'fabia'),
  ListItem("Roomster", 'roomster'),
  ListItem("Yeti", 'yeti'),
  ListItem("Praktik", 'praktik')
]);