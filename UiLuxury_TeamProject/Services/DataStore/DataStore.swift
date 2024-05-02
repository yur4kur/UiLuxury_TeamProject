//
//  DataStore.swift
//  UiLuxury_TeamProject
//
//  Created by Юрий Куринной on 27.07.2023.
//

/// Хранилище моковых данных
final class DataStore {
    
    static let shared = DataStore()
    
    let user = User(name: GlobalConstants.emptyString, wallet: 150000, items: [])
    
    let items = [
        Item(
            title: "Потерянный навык",
             price: 1000,
            description: "Дополнительное очко за каждое нажатие кнопки",
            modifier: 1,
            actionOperator: .add
        ),
        
        Item(
            title: "Новый талант",
            price: 3000,
            description: "3 дополнительных очка при каждом нажатии кнопки",
            modifier: 2,
            actionOperator: .add
        ),
        
        Item(
            title: "Red-Bull",
            price: 6000,
            description: "7 дополнительных очков при каждом нажатии кнопки",
            modifier: 6,
            actionOperator: .add
        ),
        
        Item(
            title: "Лотерейный билет",
            price: 15000,
            description: "При каждом нажатии кнопки умножает дополнительные очки на 2",
            modifier: 2,
            actionOperator: .multiply
        )
    ]
    
    let developers = [
        Developer(
            name: """
            Михаил
            
            Роль: Идейный вдохновитель
            
            Разработал экран команды на основе PageControl и ScrollView

            """,
            contact: "https://t.me/AkiraReiTyan"
        ),
        
        Developer(
            name: """
            Кирилл
            
            Роль: Основатель команды
            
            Разработал экран магазина на основе TableView c применением CAKeyframeAnimation
            
            """,
            contact: "https://t.me/kizi_mcfly"
        ),
        
        Developer(
            name: """
            Юрий
            
            Роль: Архитектор
            
            Разработал стартовый и игровой экраны с динамической анимацией объектов. Внедрил в проект паттерн Координатор
            """,
            contact: "https://t.me/Radiator074"
        ),
        
        Developer(
            name: """
            Эльдар
            
            Роль: Ревьюер
            
            Разработал экран игрока. Внедрил в проект игровую озвучку на основе AVAudioPlayer и тактильный отклик игровой кнопки
            """,
            contact: "https://t.me/eldarovsky"
        ),
        
        Developer(
            name: """
            Бийбол
            
            Роль: Верстальщик
            
            Сверстал исходный макет приложения на основе сторибордов
            
            """,
            contact: "https://t.me/zubi312"
        )
    ]
    
    private init () {}
}

