//
//  HabitDetailsTableViewCell.swift
//  MyHabits
//
//  Created by Эля Корельская on 14.11.2022.
//

import UIKit
/// детали даты выполнения привычки
class HabitDetailsTableViewCell: UITableViewCell {
    // MARK: - Properties
    /// даты выполнения привычки
    var indexPath: IndexPath?
    var habit = HabitsStore.shared
    // MARK: - UI
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "Black")
        label.numberOfLines = 0
        label.font = UIFont(name: "SF Pro Display", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private
    private func setupView() {
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
        ])
    }
    
    
}

