//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Эля Корельская on 31.10.2022.
//

import UIKit
protocol HabitViewControllerDelegate: AnyObject {
    func addHabit(_ habit: Habit)
}
class HabitViewController: UIViewController {
    // кнопка сохранить изменения
    private lazy var buttonRight: UIBarButtonItem = {
        var button = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(self.didTapButtonRight))
        button.title = "Сохранить"
        button.tintColor = UIColor(named: "Purple")
        return button
       }()
    weak var delegate: HabitViewControllerDelegate?
    @objc private func didTapButtonRight() {
        let newHabit = Habit(name: textField.text!,
                             date: date.date,
                             color: myButtonColor.backgroundColor!)
        delegate?.addHabit(newHabit)
        dismiss(animated: true, completion: nil)
    }
    //кнопка отменить
    private lazy var buttonLeft: UIBarButtonItem = {
        var button = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(self.didTapButtonLeft))
        button.title = "Отменить"
        button.tintColor = UIColor(named: "Purple")
        return button
       }()
    // действие отмены
    @objc private func didTapButtonLeft() {
        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        print("отмена")
    }
    // линия для разделения бара и вью
    private var lineView: UIView =  {
        var line = UIView(frame: CGRect(x:0, y: 100, width: 1014, height:1))
        line.backgroundColor = UIColor.systemGray2
        return line
    }()
    // стек для содержимого
    private lazy var myStack: UIStackView = {
        let stack = UIStackView()
        stack.contentMode = .scaleAspectFit
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    // название надпись
    private lazy var textLabel1: UILabel = {
        let text = UILabel()
        text.text = "НАЗВАНИЕ"
        text.font = UIFont(name: "SF Pro Display", size: 13)
        text.font = UIFont.boldSystemFont(ofSize: 13)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    // кнопка для пикера
    private lazy var myButtonColor: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(self.didTapPicker), for: .touchUpInside)
        return button
    }()
    // пикер
    @objc private func didTapPicker() {
        let picker = UIColorPickerViewController()
        picker.supportsAlpha = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        print("цвет")
    }
    // время надпись
    private lazy var textLabel3: UILabel = {
        let text = UILabel()
        text.text = "ВРЕМЯ"
        text.font = UIFont(name: "SF Pro Display", size: 13)
        text.font = UIFont.boldSystemFont(ofSize: 13)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    // поле ввода
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.placeholder = "Бегать по утрам, спать 8 часов и т. п."
        return textField
    }()
    // цвет надпись
    private lazy var textLabel2: UILabel = {
        let text = UILabel()
        text.text = "ЦВЕТ"
        text.font = UIFont(name: "SF Pro Display", size: 13)
        text.font = UIFont.boldSystemFont(ofSize: 13)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()

    // надпись
    private lazy var textLabel4: UILabel = {
        let text = UILabel()
        text.text = "Каждый день в "
        text.font = UIFont(name: "SF Pro Display", size: 13)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    // надпись
    private lazy var textLabel5: UILabel = {
        let text = UILabel()
        text.text = "11:50 AM"
        text.textColor = UIColor(named: "Purple")
        text.font = UIFont(name: "SF Pro Display", size: 13)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    // дата
    private lazy var date: UIDatePicker = {
        let date = UIDatePicker()
        date.timeZone = NSTimeZone.local
        date.datePickerMode = .time
        date.preferredDatePickerStyle = .wheels
        date.backgroundColor = UIColor(named: "White")
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
        
    }()
    // первая клавиатура при ее появлении - русская
    private func getKeyboardLanguage() -> String? {
            return "ru"
        }
    // изменение стартовой клавиатуры
    override var textInputMode: UITextInputMode? {
        if let language = getKeyboardLanguage() {
            for tim in UITextInputMode.activeInputModes {
                if tim.primaryLanguage!.contains(language) {
                    return tim
                }
            }
        }
        return super.textInputMode
    }

    // при касании на область вне клавиатуры, закрывает клавиатуру
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    // при нажатии на return - убирается клавиатура
    private func setupDissmissToReturn() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(returnTap))
        self.view.addGestureRecognizer(tap)
    }
    // установка включения клаватуры при нажатии на контроллер
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.textField.becomeFirstResponder()
    }
    // скрываем клавиатуру
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @objc func returnTap() {
        textField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "White")
        self.view.addSubview(self.lineView)
        self.view.addSubview(self.myStack)
        self.myStack.addSubview(self.textLabel1)
        self.myStack.addSubview(self.textField)
        self.myStack.addSubview(self.textLabel2)
        self.myStack.addSubview(self.myButtonColor)
        self.myStack.addSubview(self.textLabel3)
        self.myStack.addSubview(self.textLabel4)
        self.myStack.addSubview(self.textLabel5)
        self.view.addSubview(self.date)
        textField.delegate = self
        self.setupNavBar()
        self.constraints()
        self.setupGesture()
        self.setupDissmissToReturn()
    }
    private func setupNavBar() {
        self.navigationItem.title = "Создать"
        self.navigationItem.leftBarButtonItem = buttonLeft
        self.navigationItem.rightBarButtonItem = buttonRight
    }
    private func constraints() {
        NSLayoutConstraint.activate([
            myStack.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120),
            myStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12),
            myStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12),
            myStack.heightAnchor.constraint(equalToConstant: 600),
            //название надпись
            textLabel1.topAnchor.constraint(equalTo: self.myStack.topAnchor,constant: 5),
            textLabel1.leadingAnchor.constraint(equalTo: self.myStack.leadingAnchor, constant: 5),
            textLabel1.heightAnchor.constraint(equalToConstant: 20),
            textLabel1.widthAnchor.constraint(equalToConstant: 100),
            //бегать по утрам поле
            textField.topAnchor.constraint(equalTo: self.textLabel1.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: self.myStack.leadingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),
            textField.widthAnchor.constraint(equalToConstant: 320),
            //цвет надпись
            textLabel2.topAnchor.constraint(equalTo: self.textField.bottomAnchor,constant: 8),
            textLabel2.leadingAnchor.constraint(equalTo: self.myStack.leadingAnchor, constant: 5),
            textLabel2.heightAnchor.constraint(equalToConstant: 30),
            textLabel2.widthAnchor.constraint(equalToConstant: 100),
            //пикер
            myButtonColor.topAnchor.constraint(equalTo: self.textLabel2.bottomAnchor,constant: 3),
            myButtonColor.leadingAnchor.constraint(equalTo: self.myStack.leadingAnchor, constant: 5),
            myButtonColor.heightAnchor.constraint(equalToConstant: 40),
            myButtonColor.widthAnchor.constraint(equalToConstant: 40),
            //время надпись
            textLabel3.topAnchor.constraint(equalTo: self.myButtonColor.bottomAnchor,constant: 12),
            textLabel3.leadingAnchor.constraint(equalTo: self.myStack.leadingAnchor, constant: 5),
            textLabel3.heightAnchor.constraint(equalToConstant: 20),
            textLabel3.widthAnchor.constraint(equalToConstant: 100),
            //каждый день
            textLabel4.topAnchor.constraint(equalTo: self.textLabel3.bottomAnchor,constant: 8),
            textLabel4.leadingAnchor.constraint(equalTo: self.myStack.leadingAnchor, constant: 5),
            textLabel4.heightAnchor.constraint(equalToConstant: 20),
            textLabel4.widthAnchor.constraint(equalToConstant: 125),
            //11:50
            textLabel5.topAnchor.constraint(equalTo: self.textLabel3.bottomAnchor,constant: 8),
            textLabel5.leadingAnchor.constraint(equalTo: self.textLabel4.trailingAnchor),
            textLabel5.heightAnchor.constraint(equalToConstant: 20),
            textLabel5.widthAnchor.constraint(equalToConstant: 80),
            //дата
            date.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 330),
            date.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            date.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            date.heightAnchor.constraint(equalToConstant: 200),

            ])
    }
}
extension  HabitViewController: UIColorPickerViewControllerDelegate, UITextFieldDelegate {
    
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        self.myButtonColor.backgroundColor = color
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        self.myButtonColor.backgroundColor = color
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

}
