//
//  PickerCell.swift
//  SnapTrip
//
//  Created by LH on 2/20/16.
//  Copyright © 2016 mrsata. All rights reserved.
//

import UIKit

class PickerCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var picker: UIPickerView!
    
    var pickerData: [String] = [String]()
    var distance: Int = 50
    let distances:[Int] = [50, 100, 150, 200, 300, 500]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setDistance()
        
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        // Input data into the Array:
        pickerData = ["50 Miles","100 Miles", "150 Miles", "200 Miles", "300 Miles", "500 Miles"]
        picker.selectRow(0, inComponent: 0, animated: false)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // Catpure the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        distance = distances[row]
        setDistance()
    }
    
    // Set lvc.distance as this.distance
    func setDistance () {
        if let lVC = UIApplication.sharedApplication().keyWindow?.rootViewController?.childViewControllers.last as? LocateViewController {
            lVC.distance = self.distance
        }
    }

}
