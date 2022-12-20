//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Эля Корельская on 29.10.2022.
//

import UIKit

// главный экран с ячейками привычек
class HabitsViewController: UIViewController, HabitViewControllerDelegate2, HabitDetailsVCDelegate, HabitDetailsVCDelegateChangeHabit {
    
    // скрыть кнопку удаления при создании новой ячейки
    func addDeleteButton(_ button: UIButton) {
        button.isHidden = true
    }
    var habit: Habit?
    private var habitDetailVC: HabitDetailsViewController?
    
    private lazy var flowLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 20, left: 8, bottom: 8, right: 8)
        return layout
    }()
    
    private lazy var collection: UICollectionView = {
        let myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        myCollectionView.backgroundColor = .systemGray2
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(HabitsCollectionViewCell.self, forCellWithReuseIdentifier: "HabitsCollectionViewCell")
        myCollectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "ProgressCollectionViewCell")
        myCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultcell")
        return myCollectionView
    }()
    // скролл
    private lazy var myScroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    // кнопка +
    private lazy var button: UIBarButtonItem = {
        var button = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(self.didTapButton))
        button.tintColor = UIColor(named: "Purple")
        return button
    }()
    // кнопка добавить ячейку
    @objc private func didTapButton() {
        let vc = HabitViewController()
        vc.title = "Создать"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        // проверяет к новой или старой привычке сейчас происходит обращение
        vc.newHabitBool = true
        self.navigationController?.pushViewController(vc, animated: true)
        // сокрытие кнопки "удалить привычку"
        vc.delegate2 = self
        // добавление привычки
        vc.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
        collection.reloadData()
    }

    // навигационный бар
    private func setupNavigationBar() {
        self.navigationItem.title = "Сегодня"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = button
        self.navigationItem.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    private func setupView() {
        self.view.backgroundColor = UIColor(named: "White")
        self.view.addSubview(self.collection)
        NSLayoutConstraint.activate([
            self.collection.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    // показывает на какую по номеру ячейку происходит нажатие
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collection.collectionViewLayout.invalidateLayout()
    }
    
}

extension HabitsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        // количество секций
        func numberOfSections(in collectionView: UICollectionView) -> Int { 2 }
        // сколько ячеек в каждой секции
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if section == 0 {
                return 1
            } else {
                return HabitsStore.shared.habits.count
            }
        }
        // ячейка с прогрессом 0 секция, ячейки с привычками - 1 секция
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
                myCell.setupNewHabit(with: habit)
                myCell.clickDelegate = self
                return myCell
            }
            
        }
        // при нажатии на ячейку 1 секции переход на habitDetailVC
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if indexPath.section != 0 {
                let habitVC = HabitViewController()
                let habit = HabitsStore.shared.habits[indexPath.row]
                let habitDetailVC = HabitDetailsViewController(habit: habit)
                habitDetailVC.delegate = self
                habitVC.delegate = self
                habitVC.changeDelegate = self
                habitDetailVC.changeHabit = self
                // передача идекса элемента для удаления и передача данных привычки
                habitVC.indexPath = indexPath
                habitDetailVC.indexPath = indexPath
                habitVC.habits = HabitsStore.shared.habits[indexPath.row]
                // передача названия привычки в заголовок
                habitDetailVC.title =  HabitsStore.shared.habits[indexPath.row].name
                self.navigationController?.pushViewController(habitDetailVC, animated: true)
                habitDetailVC.updatingDelegate = self
            }
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            // расстоние ячеек внутри секций
            if indexPath.section == 0 {
                return CGSize(width: (self.view.frame.size.width - 40), height: (self.view.frame.size.width - 350))
            } else {
                return CGSize(width: (self.view.frame.size.width - 40), height: (self.view.frame.size.width - 270))
            }
        }
    
}
extension HabitsViewController: HabitViewControllerDelegate,  HabitsCollectionViewDelegate, HabitVCDelegate, HabitVCDelegateChangeHabit, UpdatingCollectionDataDelegate {
    // изменить привычку
    func changeHabit(with indexPath: IndexPath, _ habit: Habit?) {
        HabitsStore.shared.habits[indexPath.row].name = habit!.name
        HabitsStore.shared.habits[indexPath.row].date = habit!.date
        HabitsStore.shared.habits[indexPath.row].color = habit!.color
        collection.reloadData()
    }
    
    // удалить привычку
    func removeHabit(with indexPath: IndexPath) {
        HabitsStore.shared.habits.remove(at: indexPath.row)
        collection.reloadData()
    }
    // затрекать привычку
    func clickOnCircle(_ habit: Habit) {
        HabitsStore.shared.track(habit)
        HabitsStore.shared.save()
        collection.reloadData()
    }
    // добавить привычку
    func addHabit(_ habit: Habit) {
        let store = HabitsStore.shared
        store.habits.append(habit)
        collection.reloadData()
        print("\(habit.name)", "\(habit.date)", "\(habit.color)")
    }
    func updateCollection() {
        print("collection.reload")
        collection.reloadData()
    }
}



