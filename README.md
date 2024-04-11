
# CoinsRain
Игра типа «кликер», ставящая целью прокачку игрока через зарабатывание монет путем нажатия на кнопку и покупки модификаторов к этой кнопке. Приложение выполнено на архитектуре МВВМ с использованием паттерна Координатор и кастомных расширений UI-элементов. На текущий момент в приложении намеренно использованы только нативные элементы. Выпущена в релиз альфа-версия проекта.

![1 (1)](https://github.com/yur4kur/UiLuxury_TeamProject/assets/105720427/16c0663d-1f1a-4888-9974-5f691c5c17ee)
![2 (1)](https://github.com/yur4kur/UiLuxury_TeamProject/assets/105720427/5312ce65-5b17-4d9a-8ff2-8fdee696321b)

## Технологии
<details>
<summary> Стек технологий </summary>

- Архитектура: МВВМ(KVO)
- Навигация: паттерн Координатор, UINavigationController, UITabBarController
- Передача данных: Координатор, Синглтон (для моковых данных)
- Верстка UI: кодом
- Фреймворки и библиотеки: UKit, Core Animation, AVFoundation
- UI-стек: UITableView, UIScrollView, UIPageControl
- Анимация: UIDynamicAnimator, CAKeyframeAnimation
- Звук: AVAudioPlayer
- Тактильный отклик: UIFeedbackGenerator
</details>

### План корректировок по результатам альфа-версии
<details>
<summary> Ближайшие доработки </summary>  
  
- Оптимизация кода экрана «Команда»
- Внедрить сохранение прогресса пользователя (хотя бы в UserDefaults)
- Перекрыть все сервисные слои протоколами
</details>

### План развития проекта
<details>
<summary> Дальнейшие доработки </summary>  
  
- Внедрить полноценную авторизацию пользователей с сетевым слоем

- Хранение пользовательских данных реализовать во внешнем хранилище
- Синхронизировать внешнее хранилище с локальным
- Доработать игровую анимацию и озвучку с использованием внешних библиотек
- Доработать игровую систему: расширить список товаров, проработать уровни достижений
</details> 

### Код-стайл 
<details>
<summary> Обязательные требования </summary>  
Используйте марки для организации кода в логические блоки функциональности. Каждую марку следует помечать "// MARK: -", 
а дополнительные внутри большого блока "// MARK:" для придания большей читаемости кода.

Следующая последовательность является обязательной для следования:

// MARK: - Types

// MARK: - "Имя класса"

// MARK: - Public Properties

// MARK: - Private Properties

// MARK: - Initializers

// MARK: - Lifecycle methods

// MARK: - Public methods

// MARK: - Private Methods

Далее private extensions:

// MARK: - Configure UI
  
  func setupUI{} - контейнер, который вызываем во viewDidLoad

  
// MARK: - Setup UI
  
  func addSubviews{} - контейнер views контроллера
  
  func setupViews{} - настройка вида контроллера
  
  func setup/название элемента/

  
// MARK: - Constraints
  
  func setupConstraints{}


// MARK: - Constants
  
  enum Constants {
    static let... 
    }
</details>  
