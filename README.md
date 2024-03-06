![ReadMe](https://github.com/yur4kur/UiLuxury_TeamProject/assets/105720427/bdd4f6f9-1c41-4ac7-911b-2ade2c57ce53)

# UiLuxury_TeamProject
Разрабатываем игру типа "Кликер"
## Предварительный стек:
Верстка: кодом

Контроллеры: TabBarController, ViewController, NavigationController + TableViewController

Передача данных: (Delegate??)

### Организация кода

Используйте марки для организации кода в логические блоки функциональности. Каждую марку следует помечать "// MARK: -", 
а дополнительные внутри большого блока "// MARK:" для придания большей читаемости кода.

Следующая последовательность является обязательной для следования:

// MARK: - Types

// MARK: - "Имя класса"

// MARK: - Public Properties

// MARK: - Private Properties

// MARK: - Initializers

// MARK: - Public methods

// MARK: - Private Methods

Далее private extensions:

// MARK: - Configure UI
  func setupUI{} - контейнер, который вызываем во viewDidLoad
  
// MARK: - Setup UI
  
  func addSubviews{} - контейнер
  func setupViews{} - настройка вида контроллера
  func setup/название элемента/
  
// MARK: - Constraints
  
  func setupConstraints{}

// MARK: - Constants
  
  enum Constants {
    static let... 
    }
  
