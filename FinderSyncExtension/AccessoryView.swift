//
//  AccessoryView.swift
//  FinderSyncExtension
//
//  Created by Takuto Nakamura on 2021/06/25.
//

import Cocoa

typealias FileFormat = NSBitmapImageRep.FileType
typealias Attributes = (size: NSSize, fillColor: NSColor, fileFormat: FileFormat)

class AccessoryView: NSView {

    @IBOutlet weak var fileFormatPopUp: NSPopUpButton!
    @IBOutlet weak var widthField: NSTextField!
    @IBOutlet weak var heightField: NSTextField!
    @IBOutlet weak var fillColorWell: NSColorWell!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NSColor.ignoresAlpha = false
    }
    
    var size: NSSize {
        var w = widthField.integerValue
        var h = heightField.integerValue
        if w == 0 { w = 800 }
        if h == 0 { h = 450 }
        return NSSize(width: w, height: h)
    }

    var fillColor: NSColor {
        return fillColorWell.color
    }
    
    var fileFormat: FileFormat {
        let value = UInt(fileFormatPopUp.indexOfSelectedItem)
        return FileFormat.init(rawValue: value) ?? .png
    }
    
    var attributes: Attributes {
        return (self.size, self.fillColor, self.fileFormat)
    }
    
    var changeFileFormatHandler: ((_ format: String) -> Void)?
    
    @IBAction func changeFileFormat(_ sender: NSPopUpButton) {
        changeFileFormatHandler?(sender.title.lowercased())
    }
    
}
