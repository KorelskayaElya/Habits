//
//  HabitTableView.swift
//  MyHabits
//
//  Created by Эля Корельская on 02.11.2022.
//

import UIKit
protocol HabitsCollecionDelegate: AnyObject {
    func addProgress(_ progress: Habit)
}
class HabitsCollectionViewCell: UICollectionViewCell {
    weak var delegate: HabitsCollecionDelegate?

    //стек для привычки
    private lazy var myStack: UIStackView = {
        let stack = UIStackView()
        stack.contentMode = .scaleAspectFit
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    // название привычки
    private lazy var textLabel1: UILabel = {
        let text = UILabel()
        text.text = "Выпить стакан воды"
        text.textColor = UIColor(named: "Blue")
        text.font = UIFont(name: "SF Pro Display", size: 13)
        text.font = UIFont.boldSystemFont(ofSize: 20)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    // время привычки
    private lazy var textLabel2: UILabel = {
        let text = UILabel()
        text.text = "Каждый день в 7:30"
        text.font = UIFont(name: "SF Pro Display", size: 12)
        text.textColor = .systemGray
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    // счетчик
    private lazy var textLabel3: UILabel = {
        let text = UILabel()
        // вставить перемнную для счетчика
        text.text = "Счетчик: \(5)"
        text.font = UIFont(name: "SF Pro Display", size: 13)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    // кнопка выполнения привычки
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
    @objc func didButtonClick() {
       // self.button.backgroundColor = UIColor(named: "Blue")
        delegate?.addProgress(Habit)
        print("цвет заменен")
    }
    func setupNewHabit(with habitsStore: Habit) {
        self.textLabel1.text = habitsStore.name
        self.textLabel2.text = habitsStore.dateString
        self.button.tintColor = habitsStore.color
        self.textLabel1.textColor = habitsStore.color
        self.button.layer.borderColor = habitsStore.color.cgColor
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
       }
    
    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupView() {
        self.contentView.addSubview(self.myStack)
        self.myStack.addSubview(self.textLabel1)
        self.myStack.addSubview(self.textLabel2)
        self.myStack.addSubview(self.textLabel3)
        self.myStack.addSubview(self.button)
        
        NSLayoutConstraint.activate([

            self.myStack.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.myStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.myStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.myStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            self.textLabel1.topAnchor.constraint(equalTo: self.myStack.topAnchor, constant: 10),
            self.textLabel1.leadingAnchor.constraint(equalTo: self.myStack.leadingAnchor, constant: 15),
            self.textLabel1.heightAnchor.constraint(equalToConstant: 30),
            self.textLabel1.widthAnchor.constraint(equalToConstant: 200),

            self.textLabel2.topAnchor.constraint(equalTo: self.textLabel1.bottomAnchor),
            self.textLabel2.leadingAnchor.constraint(equalTo: self.myStack.leadingAnchor, constant: 15),
            self.textLabel2.heightAnchor.constraint(equalToConstant: 20),
            self.textLabel2.widthAnchor.constraint(equalToConstant: 200),

            self.textLabel3.bottomAnchor.constraint(equalTo: self.myStack.bottomAnchor, constant: -20),
            self.textLabel3.leadingAnchor.constraint(equalTo: self.myStack.leadingAnchor, constant: 15),
            self.textLabel3.heightAnchor.constraint(equalToConstant: 20),
            self.textLabel3.widthAnchor.constraint(equalToConstant: 150),

            self.button.trailingAnchor.constraint(equalTo: self.myStack.trailingAnchor, constant: -30),
            self.button.topAnchor.constraint(equalTo: self.myStack.topAnchor, constant: 50),
            self.button.heightAnchor.constraint(equalToConstant: 40),
            self.button.widthAnchor.constraint(equalToConstant: 40),

        ])
    }

}
