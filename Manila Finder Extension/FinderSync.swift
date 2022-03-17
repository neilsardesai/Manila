//
//  FinderSync.swift
//  Manila Finder Extension
//
//  Created by Neil Sardesai on 1/23/22.
//

import Cocoa
import FinderSync

class FinderSync: FIFinderSync {
    
    private let extendedAttributeName = "com.NeilSardesai.Manila.FolderColor"

    override init() {
        super.init()
        
        // Set up the directory we are syncing.
        FIFinderSyncController.default().directoryURLs = [URL(fileURLWithPath: "/")]
    }
    
    // MARK: - Menu and toolbar item support
    
    override func menu(for menu: FIMenuKind) -> NSMenu? {
        guard case .contextualMenuForItems = menu,
              let selectedItemURLs = FIFinderSyncController.default().selectedItemURLs(),
              selectedItemURLs.filter({ !$0.hasDirectoryPath }).isEmpty
        else { return nil }
        
        let currentColorRawValues = Set(selectedItemURLs
            .map { try? $0.extendedAttribute(forName: extendedAttributeName) }
            .map { data in data.map { String(data: $0, encoding: .utf8)! } })
        
        let menu = NSMenu(title: "")
        let rootItem = NSMenuItem(title: String(localized: "Color"), action: nil, keyEquivalent: "")
        let submenu = NSMenu(title: "")
        
        let submenuItems = Color.allCases.map { color -> NSMenuItem in
            let menuItem = NSMenuItem(title: color.localizedName, action: #selector(handleMenuItem(_:)), keyEquivalent: "")
            menuItem.image = NSImage(named: color.menuImageName)
            if currentColorRawValues.count == 1 {
                let currentColor = currentColorRawValues[currentColorRawValues.startIndex]
                if currentColor == color.rawValue || currentColor == nil && color == .blue { menuItem.state = .on }
            }
            return menuItem
        }
        
        submenu.items = submenuItems
        rootItem.submenu = submenu
        menu.addItem(rootItem)
        return menu
    }
    
    @objc private func handleMenuItem(_ sender: NSMenuItem) {
        let selectedItemURLs = FIFinderSyncController.default().selectedItemURLs()
        
        for itemURL in selectedItemURLs! {
            let color = Color.allCases.first { $0.localizedName == sender.title }!
            var image: NSImage?
            if color != .blue { image = NSImage(named: color.rawValue) }
            
            if NSWorkspace.shared.setIcon(image, forFile: itemURL.path, options: []) {
                if image == nil {
                    try? itemURL.removeExtendedAttribute(forName: extendedAttributeName)
                } else {
                    try? itemURL.setExtendedAttribute(data: color.rawValue.data(using: .utf8)!, forName: extendedAttributeName)
                }
            }
        }
    }
    
}
