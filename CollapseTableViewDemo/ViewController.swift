//
//  ViewController.swift
//  CollapseTableView
//
//  Created by Serhii Kharauzov on 6/6/19.
//  Copyright © 2019 Serhii Kharauzov. All rights reserved.
//

import UIKit
import CollapseTableView

class ViewController: UIViewController {

    @IBOutlet weak var tableView: CollapseTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        tableView.didTapSectionHeaderView = { (sectionIndex, isOpen) in
            debugPrint("sectionIndex \(sectionIndex), isOpen \(isOpen)")
        }
        reloadTableView { [unowned self] in
            self.tableView.openSection(0, animated: true)
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib(nibName: SectionHeaderView.reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: SectionHeaderView.reuseIdentifier)
    }
    
    func reloadTableView(_ completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            completion()
        })
        tableView.reloadData()
        CATransaction.commit()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        cell.textLabel?.text = "Text for cell #\(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.reuseIdentifier) else {
            let view = Bundle.main.loadNibNamed(SectionHeaderView.reuseIdentifier, owner: self, options: nil)?.first as? SectionHeaderView
            return view
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

