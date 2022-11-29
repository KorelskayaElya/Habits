//
//  ActivityViewController.swift
//  MyHabits
//
//  Created by Эля Корельская on 02.11.2022.
//

import UIKit
// удаление привычки
protocol HabitDetailsVCDelegate: AnyObject {
    func removeHabit(with indexPath: IndexPath)
}
protocol HabitDetailsVCDelegateChangeHabit: AnyObject {
    func changeHabit(with indexPath: IndexPath, _ habit: Habit?)
}
class HabitDetailsViewController: UIViewController {
    var indexPath: IndexPath?
    var habit: Habit?
    var datas: [Date] = HabitsStore.shared.dates
    weak var delegate: HabitDetailsVCDelegate?
    weak var changeHabit: HabitDetailsVCDelegateChangeHabit?

    // кнопка править
    private lazy var buttonRight: UIBarButtonItem = {
        var button = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(self.didTapButtonRight))
        button.title = "Править"
        button.tintColor = UIColor(named: "Purple")
        return button
       }()
    @objc private func didTapButtonRight() {
        print("Править")
        let habitVC = HabitViewController()
        let vc = UINavigationController(rootViewController: habitVC)
        habitVC.indexPath = indexPath
        habitVC.title = "Править"
        habitVC.newHabitBool = false
        print("кнопка править ячейку занчит false",habitVC.newHabitBool)
        habitVC.removeDelegate = self
        habitVC.changeDelegate = self
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    private var lineView: UIView =  {
        var line = UIView(frame: CGRect(x:0, y: 0, width: 1014, height:1))
        line.backgroundColor = UIColor.systemGray2
        return line
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.register(HabitDetailsTableViewCell.self, forCellReuseIdentifier: "dateCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "White")
        self.setupNavigationBar()
        self.setupView()
       
    }
    // навигационный бар
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.rightBarButtonItem = buttonRight
        self.navigationController?.navigationBar.tintColor = UIColor(named: "Purple")
    }
    // таблица с датами
    private func setupView() {
        self.view.addSubview(self.tableView)
        self.tableView.addSubview(self.lineView)
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        ])
    }
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    // название секции
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Активность"
    }
    // высота ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    // количество элеметов в таблице
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    // данные для заполнения таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath) as! HabitDetailsTableViewCell
        cell.titleLabel.text = HabitsStore.shared.trackDateString(forIndex: indexPath.row)
        return cell
    }
}

extension HabitDetailsViewController: HabitVCDelegate, HabitVCDelegateChangeHabit {
    func changeHabit(with indexPath: IndexPath, _ habit: Habit?) {
        print("Изменение HabitDetailsViewController : HabitVCDelegate")
        self.navigationController?.popToRootViewController(animated: true)
        self.changeHabit?.changeHabit(with: indexPath, habit)
    }
    
    // удаление ячейки
    func removeHabit(with indexPath: IndexPath) {
        self.navigationController?.popToRootViewController(animated: true)
        self.delegate?.removeHabit(with: indexPath)
    }
}
