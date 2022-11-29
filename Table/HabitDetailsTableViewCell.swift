//
//  HabitDetailsTableViewCell.swift
//  MyHabits
//
//  Created by Эля Корельская on 14.11.2022.
//

import UIKit
// детали даты выполнения привычки
class HabitDetailsTableViewCell: UITableViewCell {
    // даты выполнения привычки
    var indexPath: IndexPath?
    var habit = HabitsStore.shared
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "Black")
        label.numberOfLines = 0
        label.font = UIFont(name: "SF Pro Display", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
      
    }
    private func setupView() {
        self.contentView.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            self.titleLabel.widthAnchor.constraint(equalToConstant: 200),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 20),

            ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

