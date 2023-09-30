//
//  HabitTableView.swift
//  MyHabits
//
//  Created by Эля Корельская on 02.11.2022.
//

import UIKit
/// коллекции привычек
/// протокол нажатия на круг на ячейке (затрекать привычку)
protocol HabitsCollectionViewDelegate: AnyObject {
    func clickOnCircle(_ habit: Habit, indexPath: IndexPath)
}

class HabitsCollectionViewCell: UICollectionViewCell {
    // MARK: - UI
    /// стек для привычки
    private lazy var myStack: UIStackView = {
        let stack = UIStackView()
        stack.contentMode = .scaleAspectFit
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    /// название привычки
    private lazy var textLabel1: UILabel = {
        let text = UILabel()
        text.textColor = UIColor(named: "Blue")
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 0
        text.font = UIFont(name: "SF Pro Display", size: 13)
        text.font = UIFont.boldSystemFont(ofSize: 20)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    /// время привычки
    private lazy var textLabel2: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "SF Pro Display", size: 12)
        text.textColor = .systemGray
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    /// счетчик выполнения привычки
    private lazy var textLabel3: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "SF Pro Display", size: 13)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    /// кнопка выполнения привычки
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "White")
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(named: "Blue")?.cgColor
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.addTarget(self, action: #selector(didButtonClick), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(named: "White")
        return button
    }()
    // MARK: - Properties
    weak var clickDelegate: HabitsCollectionViewDelegate?
    var habit: Habit?
    var indexPath: IndexPath?
    private let calendar: Calendar = .current
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    /// Выполнение или отмена выполнения привычки
    @objc private func didButtonClick() {
        guard let habit = habit, let indexPath = indexPath else {
           return
       }
        if habit.isAlreadyTakenToday {
            /// Привычка была затрекана сегодня, отменяем выполнение
            if let index = habit.trackDates.lastIndex(where: { calendar.isDateInToday($0) }) {
                habit.trackDates.remove(at: index)
            }
        } else {
            /// Привычка не была затрекана сегодня, добавляем новую дату
            habit.trackDates.append(Date())
        }

        /// Обновляем текст счетчика
        textLabel3.text = "Счетчик: \(habit.trackDates.count)"

        /// Обновляем стиль кнопки круга
        updateButtonStyle(habit.isAlreadyTakenToday, habit: habit)
        
        /// Уведомляем делегата о нажатии на круг
        clickDelegate?.clickOnCircle(habit, indexPath: indexPath)
    }

    /// Обновление стиля кнопки круга на основе выполнения привычки
    private func updateButtonStyle(_ isChecked: Bool, habit: Habit) {
        if isChecked {
            /// Привычка была затрекана сегодня
            button.tintColor = UIColor(named: "White")
            textLabel1.textColor = habit.color
            button.layer.borderColor = habit.color.cgColor
            button.backgroundColor = habit.color
        } else {
            /// Привычка не была затрекана сегодня
            textLabel1.textColor = habit.color
            button.layer.borderColor = habit.color.cgColor
            button.backgroundColor = UIColor(named: "White")
        }
    }


    private func setupView() {
        contentView.addSubview(myStack)
        myStack.addSubview(textLabel1)
        myStack.addSubview(textLabel2)
        myStack.addSubview(textLabel3)
        myStack.addSubview(button)
        
        NSLayoutConstraint.activate([
            /// стек
            myStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            myStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            myStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            myStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            /// название привычки
            textLabel1.topAnchor.constraint(equalTo: myStack.topAnchor, constant: 10),
            textLabel1.leadingAnchor.constraint(equalTo: myStack.leadingAnchor, constant: 15),
            textLabel1.heightAnchor.constraint(equalToConstant: 30),
            textLabel1.widthAnchor.constraint(equalToConstant: 280),
            /// время привычки
            textLabel2.topAnchor.constraint(equalTo: textLabel1.bottomAnchor),
            textLabel2.leadingAnchor.constraint(equalTo: myStack.leadingAnchor, constant: 15),
            textLabel2.heightAnchor.constraint(equalToConstant: 20),
            textLabel2.widthAnchor.constraint(equalToConstant: 200),
            /// счетчик выполнения
            textLabel3.bottomAnchor.constraint(equalTo: myStack.bottomAnchor, constant: -20),
            textLabel3.leadingAnchor.constraint(equalTo: myStack.leadingAnchor, constant: 15),
            textLabel3.heightAnchor.constraint(equalToConstant: 20),
            textLabel3.widthAnchor.constraint(equalToConstant: 150),
            /// кнопка выполнения привычки
            button.trailingAnchor.constraint(equalTo: myStack.trailingAnchor, constant: -30),
            button.topAnchor.constraint(equalTo: myStack.topAnchor, constant: 40),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    // MARK: - Method
    /// установление новой привычки
    func setupNewHabit(with habitsStore: Habit, indexPath: IndexPath) {
        habit = habitsStore
        textLabel1.text = habitsStore.name
        textLabel2.text = habitsStore.dateString
        self.indexPath = indexPath
       
        DispatchQueue.main.async {
            self.textLabel3.text = "Счетчик: \(self.habit!.trackDates.count)"
            self.updateButtonStyle(self.habit!.isAlreadyTakenToday, habit: self.habit!)
            self.layoutIfNeeded()
        }
       
    }
}
