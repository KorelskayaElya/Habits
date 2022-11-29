//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Эля Корельская on 29.10.2022.
//

import UIKit
 
class HabitsViewController: UIViewController {
    var progress = HabitsStore.shared.todayProgress
    var habits: [Habit] = HabitsStore.shared.habits
    let habitViewController = HabitViewController()
    
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
        return myCollectionView
    }()
    private lazy var myScroll: UIScrollView = {
           let scroll = UIScrollView()
           scroll.translatesAutoresizingMaskIntoConstraints = false
           return scroll
    }()

    private lazy var button: UIBarButtonItem = {
        var button = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(self.didTapButton))
        button.tintColor = UIColor(named: "Purple")
        return button
       }()
    @objc private func didTapButton() {
        let vc = UINavigationController(rootViewController: habitViewController)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        habitViewController.delegate = self
        print("добавить")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collection.reloadData()
    }
    
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
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collection.collectionViewLayout.invalidateLayout()
    }
 
}
extension HabitsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int { 2 }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return habits.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressCollectionViewCell", for: indexPath) as! ProgressCollectionViewCell
            myCell.backgroundColor = UIColor(named: "White")
            myCell.layer.cornerRadius = 10
            return myCell
        } else {
            let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitsCollectionViewCell", for: indexPath) as! HabitsCollectionViewCell
            myCell.backgroundColor = UIColor(named: "White")
            myCell.layer.cornerRadius = 10
            let habit = habits[indexPath.row]
            myCell.setupNewHabit(with: habit)
            return myCell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            print("1 секция")
            print("User tapped on item \(indexPath.row)")
            self.navigationController?.pushViewController(HabitDetailsViewController(), animated: true)
        } else {
            print("0 секция")
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: (self.view.frame.size.width - 40), height: (self.view.frame.size.width - 350))
        } else {
            return CGSize(width: (self.view.frame.size.width - 40), height: (self.view.frame.size.width - 270))
        }
    }

}

extension HabitsViewController: HabitViewControllerDelegate, HabitsCollecionDelegate {
    func addProgress(_ progress: Habit) {
        <#code#>
    }
    
    func addHabit(_ habit: Habit) {
        let store = HabitsStore.shared
        store.habits.append(habit)
        habits.append(habit)
        store.track(habit)
        print("\(habit.name)", "\(habit.date)", "\(habit.color)")
        print("### Store \(store.habits)")
    }
}
