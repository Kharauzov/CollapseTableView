//
//  CollapseTableView.swift
//  CollapseTableView
//
//  Created by Serhii Kharauzov on 6/6/19.
//  Copyright © 2019 Serhii Kharauzov. All rights reserved.
//

import UIKit

open class CollapseTableView: UITableView {
    ///
    private weak var collapseDataSource: UITableViewDataSource!
    ///
    private weak var collapseDelegate: UITableViewDelegate!
    /// Represents opened/closed states of tableView's sections.
    private(set) var sectionStates = [Bool]()
    /// Determines, if section's headerView can be clickable.
    /// `True` by default.
    public var shouldHandleHeadersTap = true
    /// Completion, invoked on section tap.
    public var didTapSectionHeaderView: ((_ sectionIndex: Int, _ isOpen: Bool) -> Void)?
    
    // MARK: System
    
    override open var dataSource: UITableViewDataSource? {
        set {
            self.collapseDataSource = newValue
            super.dataSource = self.collapseDataSource != nil ? self : nil
        } get {
            return super.dataSource
        }
    }
    
    override open var delegate: UITableViewDelegate? {
        set {
            self.collapseDelegate = newValue
            super.delegate = self.collapseDelegate != nil ? self : nil
        } get {
            return super.delegate
        }
    }
    
    override open func forwardingTarget(for aSelector: Selector!) -> Any? {
        if collapseDataSource.responds(to: aSelector) {
            return collapseDataSource
        }
        if collapseDelegate.responds(to: aSelector) {
            return collapseDelegate
        }
        return nil
    }

    override open func responds(to aSelector: Selector!) -> Bool {
        if sel_isEqual(aSelector, #selector(tableView(_:viewForHeaderInSection:))) {
            return collapseDelegate?.responds(to: aSelector) ?? false
        }
        return super.responds(to: aSelector) || collapseDataSource?.responds(to: aSelector) ?? false || collapseDelegate?.responds(to: aSelector) ?? false
    }
    
    // MARK: Public methods
    
    public func toggleSection(_ sectionIndex: Int, animated: Bool) {
        if sectionIndex >= sectionStates.count {
            return
        }
        let sectionIsOpen = sectionStates[sectionIndex]
        if sectionIsOpen {
            closeSection(sectionIndex, animated: animated)
            didTapSectionHeaderView?(sectionIndex, false)
        } else {
            openSection(sectionIndex, animated: animated)
            didTapSectionHeaderView?(sectionIndex, true)
        }
    }
    
    public func openSection(_ sectionIndex: Int, animated: Bool) {
        if sectionIndex >= sectionStates.count || sectionStates[sectionIndex] {
            return
        }
        setSectionAtIndex(sectionIndex, open: true)
        if let headerView = headerView(forSection: sectionIndex) as? CollapseSectionHeader {
            headerView.updateViewForOpenState(animated: true)
        }
        if animated {
            if let indexPathsToInsert = indexPathsForRowsInSectionAtIndex(sectionIndex) {
                insertRows(at: indexPathsToInsert, with: .top)
            }
        } else {
            reloadData()
        }
    }
    
    public func closeSection(_ sectionIndex: Int, animated: Bool) {
        if sectionIndex >= sectionStates.count {
            return
        }
        setSectionAtIndex(sectionIndex, open: false)
        if let headerView = headerView(forSection: sectionIndex) as? CollapseSectionHeader {
            headerView.updateViewForCloseState(animated: true)
        }
        if animated {
            if let indexPathsToDelete = indexPathsForRowsInSectionAtIndex(sectionIndex) {
                deleteRows(at: indexPathsToDelete, with: .top)
            }
        } else {
            reloadData()
        }
    }
    
    public func isOpenSection(_ sectionIndex: Int) -> Bool {
        if sectionIndex >= sectionStates.count {
            return false
        }
        return sectionStates[sectionIndex]
    }
    
    // MARK: Private methods
    
    private func setSectionAtIndex(_ sectionIndex: Int, open: Bool) {
        if sectionIndex >= sectionStates.count {
            return
        }
        sectionStates[sectionIndex] = open
    }
    
    private func indexPathsForRowsInSectionAtIndex(_ sectionIndex: Int) -> [IndexPath]? {
        if sectionIndex >= sectionStates.count {
            return nil
        }
        let numberOfRows = collapseDataSource.tableView(self, numberOfRowsInSection: sectionIndex)
        var array = [IndexPath]()
        for index in 0 ..< numberOfRows {
            array.append(IndexPath(row: index, section: sectionIndex))
        }
        return array
    }
    
    @objc private  func handleTapGesture(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view, view.tag >= 0 else {
            return
        }
        toggleSection(view.tag, animated: true)
    }
}

// MARK: UITableViewDataSource

extension CollapseTableView: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        let numberOfSections = collapseDataSource.numberOfSections?(in: tableView) ?? 0
        while numberOfSections < sectionStates.count {
            sectionStates.removeAll()
        }
        while numberOfSections > sectionStates.count {
            sectionStates.append(false)
        }
        return numberOfSections
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionStates[section] {
            return collapseDataSource.tableView(tableView, numberOfRowsInSection: section)
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return collapseDataSource.tableView(tableView, cellForRowAt: indexPath)
    }
}

// MARK: UITableViewDelegate

extension CollapseTableView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = collapseDelegate.tableView?(tableView, viewForHeaderInSection: section) else {
            return nil
        }
        if shouldHandleHeadersTap {
            let gestures = view.gestureRecognizers ?? []
            var tapGestureFound = false
            for gesture in gestures {
                if gesture.isKind(of: UITapGestureRecognizer.self) {
                    tapGestureFound = true
                    break
                }
            }
            if !tapGestureFound {
                view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:))))
            }
        }
        view.tag = section
        if let collapseSectionHeader = view as? CollapseSectionHeader {
            if isOpenSection(section) {
                collapseSectionHeader.updateViewForOpenState(animated: false)
            } else {
                collapseSectionHeader.updateViewForCloseState(animated: false)
            }
        }
        return view
    }
}
