//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Эля Корельская on 29.10.2022.
//

import UIKit
import UserNotifications


/// главный экран с ячейками привычек
class HabitsViewController: UIViewController {
    // MARK: - Properties
    var habit: Habit?
    private var habitDetailVC: HabitDetailsViewController?
    let notificationService = LocalNotificationsService()
    // MARK: - UI
    private lazy var flowLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 20, left: 8, bottom: 8, right: 8)
        return layout
    }()
    
    private lazy var collection: UICollectionView = {
        let myCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: flowLayout)
        myCollectionView.backgroundColor = .systemGray2
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(HabitsCollectionViewCell.self, forCellWithReuseIdentifier: "HabitsCollectionViewCell")
        myCollectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "ProgressCollectionViewCell")
        myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultcell")
        return myCollectionView
    }()
    /// скролл
    private lazy var myScroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    /// кнопка +
    private lazy var button: UIBarButtonItem = {
        var button = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(self.didTapButton))
        button.tintColor = UIColor(named: "Purple")
        return button
    }()
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collection.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
    }
    /// показывает на какую по номеру ячейку происходит нажатие
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collection.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - Private
    /// кнопка добавить ячейку
    @objc private func didTapButton() {
        let vc = HabitViewController()
        vc.title = "Создать"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        /// проверяет к новой или старой привычке сейчас происходит обращение
        vc.newHabitBool = true
        self.navigationController?.pushViewController(vc, animated: true)
        /// сокрытие кнопки "удалить привычку"
        vc.delegate2 = self
        /// добавление привычки
        vc.delegate = self
    }
    /// навигационный бар
    private func setupNavigationBar() {
        self.navigationItem.title = "Сегодня"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = button
        self.navigationItem.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    private func setupView() {
        view.backgroundColor = UIColor(named: "White")
        view.addSubview(collection)
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    // MARK: - Method
    func updateProgress() {
        collection.reloadSections(IndexSet(integer: 0))
    }
}

extension HabitsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HabitDetailsVCDelegate, HabitDetailsVCDelegateChangeHabit {
    /// количество секций
    func numberOfSections(in collectionView: UICollectionView) -> Int { 2 }
    /// сколько ячеек в каждой секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
    }
    /// ячейка с прогрессом 0 секция, ячейки с привычками - 1 секция
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressCollectionViewCell", for: indexPath) as! ProgressCollectionViewCell
            myCell.backgroundColor = UIColor(named: "White")
            myCell.layer.cornerRadius = 10
            let setProgress = HabitsStore.shared
            myCell.setupProgress(with: setProgress)
            return myCell
        } else {
            let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitsCollectionViewCell", for: indexPath) as! HabitsCollectionViewCell
            guard HabitsStore.shared.habits.count > indexPath.row else { return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultcell", for: indexPath) }
            myCell.backgroundColor = UIColor(named: "White")
            myCell.layer.cornerRadius = 10
            let habit = HabitsStore.shared.habits[indexPath.row]
            myCell.setupNewHabit(with: habit, indexPath: indexPath)
            myCell.clickDelegate = self
            return myCell
        }
        
    }
    /// при нажатии на ячейку 1 секции переход на habitDetailVC
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            let habitVC = HabitViewController()
            let habit = HabitsStore.shared.habits[indexPath.row]
            let habitDetailVC = HabitDetailsViewController(habit: habit)
            habitDetailVC.delegate = self
            habitVC.delegate = self
            habitVC.changeDelegate = self
            habitDetailVC.changeHabit = self
            /// передача идекса элемента для удаления и передача данных привычки
            habitVC.indexPath = indexPath
            habitDetailVC.indexPath = indexPath
            habitVC.habits = HabitsStore.shared.habits[indexPath.row]
            updateProgress()
            /// передача названия привычки в заголовок
            habitDetailVC.title =  HabitsStore.shared.habits[indexPath.row].name
            self.navigationController?.pushViewController(habitDetailVC, animated: true)
            habitDetailVC.updatingDelegate = self
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /// расстоние ячеек внутри секций
        if indexPath.section == 0 {
            return CGSize(width: (view.frame.size.width - 40), height: (view.frame.size.width - 320))
        } else {
            return CGSize(width: (view.frame.size.width - 40), height: (view.frame.size.width - 270))
        }
    }

    
}
// MARK: - HabitVCDelegate
extension HabitsViewController: HabitVCDelegate {
    /// удалить привычку
    func removeHabit(with indexPath: IndexPath) {
        let habit = HabitsStore.shared.habits.remove(at: indexPath.row)
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [habit.id])
        collection.reloadData()
    }
    
}
// MARK: - UpdatingCollectionDataDelegate
extension HabitsViewController: UpdatingCollectionDataDelegate {
    func updateCollection() {
        collection.reloadData()
    }
}
// MARK: - HabitVCDelegateChangeHabit
extension HabitsViewController: HabitVCDelegateChangeHabit {
    /// изменить привычку
    func changeHabit(with indexPath: IndexPath, _ habit: Habit?) {
        guard let habit = habit else {
            return
        }
        
        let updatedIndexPaths = [indexPath]
        
        HabitsStore.shared.habits[indexPath.row].name = habit.name
        HabitsStore.shared.habits[indexPath.row].date = habit.date
        HabitsStore.shared.habits[indexPath.row].color = habit.color
        
        
        let oldHabit = HabitsStore.shared.habits[indexPath.row]
           UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [oldHabit.id])
        notificationService.scheduleNotification(for: habit)
        
        collection.reloadItems(at: updatedIndexPaths)
    }
}
// MARK: - HabitViweControllerDelegate
extension HabitsViewController: HabitViewControllerDelegate {
    /// добавить привычку
    func addHabit(_ habit: Habit) {
        let store = HabitsStore.shared
        store.habits.append(habit)
        collection.reloadData()
        notificationService.scheduleNotification(for: habit)
        print("\(habit.name)", "\(habit.date)", "\(habit.color)")
    }
}
// MARK: - HabitsCollectionViewDelegate
extension HabitsViewController: HabitsCollectionViewDelegate {
    /// затрекать привычку
    func clickOnCircle(_ habit: Habit, indexPath: IndexPath) {
        if indexPath.row < HabitsStore.shared.habits.count {
            let updatedHabit = HabitsStore.shared.habits[indexPath.row]
            updatedHabit.isAlreadyTakenToday = !updatedHabit.isAlreadyTakenToday
            collection.reloadItems(at: [indexPath]) /// Обновление ячейки
            /// обновление прогресса
            updateProgress()
        }
    }
}
// MARK: - HabitViewControllerDelegate2
extension HabitsViewController: HabitViewControllerDelegate2 {
    /// скрыть кнопку удаления при создании новой ячейки
    func addDeleteButton(_ button: UIButton) {
        button.isHidden = true
    }
}




