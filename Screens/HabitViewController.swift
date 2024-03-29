//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Эля Корельская on 31.10.2022.
//

import UIKit
/// добавление привычки
protocol HabitViewControllerDelegate: AnyObject {
    func addHabit(_ habit: Habit)
}
/// скрыть кнопку удаления привычки
protocol HabitViewControllerDelegate2: AnyObject {
    func addDeleteButton(_ button: UIButton)
}
/// удалить привычку
protocol HabitVCDelegate: AnyObject {
    func removeHabit(with indexPath: IndexPath)
}
/// изменение привычки
protocol HabitVCDelegateChangeHabit: AnyObject {
    func changeHabit(with indexPath: IndexPath,_ habit: Habit?)
}

class HabitViewController: UIViewController  {
    // MARK: - Properties
    var indexPath: IndexPath?
    var habit = HabitsStore.shared
    var habits : Habit?
    var newHabitBool: Bool = true
    weak var delegate: HabitViewControllerDelegate?
    weak var delegate2: HabitViewControllerDelegate2?
    weak var removeDelegate: HabitVCDelegate?
    weak var changeDelegate: HabitVCDelegateChangeHabit?
    weak var habitDetailVC: HabitDetailsViewController?
    public var updatingDelegate: UpdatingCollectionDataDelegate?
    /// изменение стартовой клавиатуры
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
    // MARK: - UI
    /// кнопка сохранить изменения
    private lazy var buttonRight: UIBarButtonItem = {
        var button = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(self.didTapButtonRight))
        button.title = "Сохранить"
        button.tintColor = UIColor(named: "Purple")
        return button
    }()
    /// кнопка отменить
    private lazy var buttonLeft: UIBarButtonItem = {
        var button = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(self.didTapButtonLeft))
        button.title = "Отменить"
        button.tintColor = UIColor(named: "Purple")
        return button
    }()
    /// линия для разделения бара и вью
    private var lineView: UIView =  {
        var line = UIView(frame: CGRect(x:0, y: 100, width: 1014, height:1))
        line.backgroundColor = UIColor.systemGray2
        return line
    }()
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:a"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter
    }()
    /// стек для содержимого
    private lazy var myStack: UIStackView = {
        let stack = UIStackView()
        stack.contentMode = .scaleAspectFit
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    /// название надпись
    private lazy var textLabel1: UILabel = {
        let text = UILabel()
        text.text = "НАЗВАНИЕ"
        text.font = UIFont(name: "SF Pro Display", size: 13)
        text.font = UIFont.boldSystemFont(ofSize: 13)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    /// кнопка удаления привычки
    private lazy var buttonAlert: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self,  action: #selector(didButtonDelete), for: .touchUpInside)
        return button
    }()
    /// кнопка для пикера
    public lazy var myButtonColor: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.layer.cornerRadius = 20
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(self.didTapPicker), for: .touchUpInside)
        return button
    }()
    /// время надпись
    private lazy var textLabel3: UILabel = {
        let text = UILabel()
        text.text = "ВРЕМЯ"
        text.font = UIFont(name: "SF Pro Display", size: 13)
        text.font = UIFont.boldSystemFont(ofSize: 13)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    /// поле ввода
    public lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        textField.textColor = UIColor(named: "Black")
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = true
        textField.placeholder = "Бегать по утрам, спать 8 часов и т. п."
        return textField
    }()
    /// цвет надпись
    private lazy var textLabel2: UILabel = {
        let text = UILabel()
        text.text = "ЦВЕТ"
        text.font = UIFont(name: "SF Pro Display", size: 13)
        text.font = UIFont.boldSystemFont(ofSize: 13)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    /// надпись
    private lazy var textLabel4: UILabel = {
        let text = UILabel()
        text.text = "Каждый день в "
        text.font = UIFont(name: "SF Pro Display", size: 13)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    /// надпись
    public lazy var textLabel5: UILabel = {
        let text = UILabel()
        text.text = dateFormatter.string(from: date.date)
        text.textColor = UIColor(named: "Purple")
        text.font = UIFont(name: "SF Pro Display", size: 13)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    /// дата
    public lazy var date: UIDatePicker = {
        let date = UIDatePicker()
        date.timeZone = NSTimeZone.local
        date.datePickerMode = .time
        date.preferredDatePickerStyle = .wheels
        date.backgroundColor = UIColor(named: "White")
        date.addTarget(self, action: #selector(changeTime), for: .valueChanged)
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    // MARK: - Lifecycle
    /// установка включения клаватуры при нажатии на контроллер
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.textField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "White")
        view.addSubview(lineView)
        view.addSubview(myStack)
        myStack.addSubview(textLabel1)
        myStack.addSubview(textField)
        myStack.addSubview(textLabel2)
        myStack.addSubview(myButtonColor)
        myStack.addSubview(textLabel3)
        myStack.addSubview(textLabel4)
        myStack.addSubview(textLabel5)
        view.addSubview(date)
        view.addSubview(buttonAlert)
        textField.delegate = self
        /// скрывает кнопку удаления привычки
        delegate2?.addDeleteButton(buttonAlert)
        setupNavBar()
        constraints()
        setupGesture()
        setupDissmissToReturn()
    }
    // MARK: - Private
    private func setupNavBar() {
        self.navigationItem.leftBarButtonItem = buttonLeft
        self.navigationItem.rightBarButtonItem = buttonRight
    }
    private func constraints() {
        NSLayoutConstraint.activate([
            myStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            myStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            myStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            myStack.heightAnchor.constraint(equalToConstant: 600),
            /// название надпись
            textLabel1.topAnchor.constraint(equalTo: myStack.topAnchor,constant: 5),
            textLabel1.leadingAnchor.constraint(equalTo: myStack.leadingAnchor, constant: 5),
            textLabel1.heightAnchor.constraint(equalToConstant: 20),
            textLabel1.widthAnchor.constraint(equalToConstant: 100),
            /// бегать по утрам поле
            textField.topAnchor.constraint(equalTo: textLabel1.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: myStack.leadingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),
            textField.widthAnchor.constraint(equalToConstant: 320),
            /// цвет надпись
            textLabel2.topAnchor.constraint(equalTo: textField.bottomAnchor,constant: 8),
            textLabel2.leadingAnchor.constraint(equalTo: myStack.leadingAnchor, constant: 5),
            textLabel2.heightAnchor.constraint(equalToConstant: 30),
            textLabel2.widthAnchor.constraint(equalToConstant: 100),
            /// пикер
            myButtonColor.topAnchor.constraint(equalTo: textLabel2.bottomAnchor,constant: 3),
            myButtonColor.leadingAnchor.constraint(equalTo: myStack.leadingAnchor, constant: 5),
            myButtonColor.heightAnchor.constraint(equalToConstant: 40),
            myButtonColor.widthAnchor.constraint(equalToConstant: 40),
            /// время надпись
            textLabel3.topAnchor.constraint(equalTo: myButtonColor.bottomAnchor,constant: 12),
            textLabel3.leadingAnchor.constraint(equalTo: myStack.leadingAnchor, constant: 5),
            textLabel3.heightAnchor.constraint(equalToConstant: 20),
            textLabel3.widthAnchor.constraint(equalToConstant: 100),
            /// каждый день
            textLabel4.topAnchor.constraint(equalTo: textLabel3.bottomAnchor,constant: 8),
            textLabel4.leadingAnchor.constraint(equalTo: myStack.leadingAnchor, constant: 5),
            textLabel4.heightAnchor.constraint(equalToConstant: 20),
            textLabel4.widthAnchor.constraint(equalToConstant: 125),
            /// 11:50
            textLabel5.topAnchor.constraint(equalTo: textLabel3.bottomAnchor,constant: 8),
            textLabel5.leadingAnchor.constraint(equalTo: textLabel4.trailingAnchor),
            textLabel5.heightAnchor.constraint(equalToConstant: 20),
            textLabel5.widthAnchor.constraint(equalToConstant: 80),
            /// дата
            date.topAnchor.constraint(equalTo: view.topAnchor,constant: 330),
            date.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            date.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            date.heightAnchor.constraint(equalToConstant: 200),
            /// удалить привычку
            buttonAlert.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -120),
            buttonAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonAlert.heightAnchor.constraint(equalToConstant: 30),
            buttonAlert.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
    @objc private func didTapButtonRight() {
        if ((textField.text?.isEmpty) != false) {
            textField.text = "Забыли заполнить поле"
        }
        print("Нажата кнопка сохранить", newHabitBool)
        if newHabitBool == true {
            let newHabit = Habit(name: textField.text!,
                                 date: date.date,
                                 color: myButtonColor.backgroundColor!,
                                 id: UUID().uuidString)
            delegate?.addHabit(newHabit)
            navigationController?.popToRootViewController(animated: true)
        } else {
            guard let indexPath = self.indexPath else { return }
            let oldHabit = Habit(name: textField.text!,
                                 date: date.date,
                                 color: myButtonColor.backgroundColor!,
                                 id: UUID().uuidString)
            changeDelegate?.changeHabit(with: indexPath, oldHabit)
        }
        dismiss(animated: true, completion: nil)
    }
    /// действие отмены
    @objc private func didTapButtonLeft() {
        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        print("отмена")
    }
    @objc private func didButtonDelete() {
        guard let indexPath = self.indexPath else { return }
        let alertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \(habit.habits[indexPath.row].name)?", preferredStyle: .alert)
        let firstAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            print("Удалить")
            self.removeDelegate?.removeHabit(with: indexPath)
            //self.updatingDelegate?.updateCollection()
            self.dismiss(animated: true, completion: nil)
        }
        let secondAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in
            print("Отмена")
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        self.present(alertController, animated: true)
    }
    /// пикер
    @objc private func didTapPicker() {
        let picker = UIColorPickerViewController()
        picker.supportsAlpha = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    /// преобразование даты в строку
    @objc private func changeTime(sender: UIDatePicker) {
        textLabel5.text = dateFormatter.string(from: sender.date)
    }
    /// первая клавиатура при ее появлении - русская
    private func getKeyboardLanguage() -> String? {
        return "ru"
    }
    /// при касании на область вне клавиатуры, закрывает клавиатуру
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    /// при нажатии на return - убирается клавиатура
    private func setupDissmissToReturn() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(returnTap))
        self.view.addGestureRecognizer(tap)
    }
    /// скрываем клавиатуру
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    @objc private func returnTap() {
        textField.resignFirstResponder()
    }
}
extension HabitViewController: UIColorPickerViewControllerDelegate, UITextFieldDelegate {
    
    /// сохранение и передача цвета привычки
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        self.myButtonColor.backgroundColor = color
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        self.myButtonColor.backgroundColor = color
    }
    /// клавиатура при  нажатии на return или ввод исчезает
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

