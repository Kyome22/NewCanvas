//
//  AboutPane.swift
//  NewCanvas
//
//  Created by Takuto Nakamura on 2021/06/26.
//

import Cocoa

class AboutPane: NSViewController {

    @IBOutlet weak var versionLabel: NSTextField!
    @IBOutlet weak var copyrightLabel: NSTextField!
    
    var originalSize: CGSize!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalSize = self.view.frame.size
        
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        versionLabel.stringValue = "version \(version)"
        
        let copyright = Bundle.main.object(forInfoDictionaryKey: "NSHumanReadableCopyright") as! String
        copyrightLabel.stringValue = copyright
    }
    
}
