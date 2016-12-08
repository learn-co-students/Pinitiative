//
//  FormManager.swift
//  LemonHandshake
//
//  Created by Jhantelle Belleza on 12/3/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit
import Former

class FormManager: FormViewController {
    
    let mapStore = MapDataStore.sharedInstance
    
    var datePickerRow = DatePickerRowFormer<FormDatePickerCell>()
    var header = LabelViewFormer<FormLabelHeaderView>()
    let dateLabelRow = LabelRowFormer<FormLabelCell>()
    
    
    let dateFormatter = DateFormatter()
    var nameText = String()
    var descriptionText = String()
    var date = Date()
    var landmark: Landmark!
    
    func makeStartInitiativeForm() {
        
        let custom = CustomRowFormer()
        
        let header = LabelViewFormer<FormLabelHeaderView>() { (view) in
            view.textLabel?.text = "Initiative Details"
        }
        
        let landmarkDetail = LabelRowFormer<FormLabelCell>().configure { (row) in
            row.cellSetup { (cell) in
               cell.textLabel?.font = UIFont(name: font.avenirNext.rawValue, size: CGFloat(fontSize.tableLabel.rawValue))
               cell.contentMode = .scaleAspectFill
               cell.textLabel?.contentMode = .scaleAspectFit
            
                if self.landmark != nil {
                    cell.textLabel?.text = "\(self.landmark.name)"
                } else {
                    cell.textLabel?.text = "Initiative for Custom Location"
                }
            }
        }
        
        let initiativeLabelRow = LabelRowFormer<FormLabelCell>().configure { (row) in
            row.cellSetup { (cell) in
                cell.textLabel?.font = UIFont(name: font.avenirNext.rawValue, size: CGFloat(fontSize.tableLabel.rawValue))
                cell.textLabel?.text = "Initiative Name"
            }
        }
        
        let initiativeTextFieldRow = TextFieldRowFormer<FormTextFieldCell>().configure { (textfield) in
            textfield.placeholder = "Give your initiative a name"
            textfield.onTextChanged({ (input) in
                print("Text change")
                var edited = String()
                
                for character in input.characters {
                    if edited.characters.count != 5 {
                        edited += "\(character)"
                    }
                }
                
                textfield.text = edited
            })
            textfield.cellSetup { (cell) in
                cell.textLabel?.font = UIFont(name: font.avenirNext.rawValue, size: CGFloat(fontSize.tableLabel.rawValue))
                }
            }.onTextChanged { (text) in
                self.nameText = text
        }
    
        let initiativeDescLabelRow = LabelRowFormer<FormLabelCell>().configure { (row) in
            row.cellSetup { (cell) in
                cell.textLabel?.font = UIFont(name: font.avenirNext.rawValue, size: CGFloat(fontSize.tableLabel.rawValue))
                cell.textLabel?.text = "Initiative Description"
            }
        }
        
        
        let initiativeDescTextViewRow = TextViewRowFormer<FormTextViewCell>().configure { (textfield) in
            textfield.placeholder = "Describe your initiative"
            textfield.cellSetup{ (cell) in
                cell.textLabel?.font = UIFont(name: font.avenirNext.rawValue, size: CGFloat(fontSize.tableLabel.rawValue))
            }
        }.onTextChanged { (text) in
            self.descriptionText = text
        }
        
        let section1 = SectionFormer(rowFormer:
            landmarkDetail,
            initiativeLabelRow,
            initiativeTextFieldRow,
            initiativeDescLabelRow,
            initiativeDescTextViewRow).set(headerViewFormer: header)
        former.append(sectionFormer: section1)
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        let dateCell = FormDatePickerCell()
        dateCell.datePicker.datePickerMode = UIDatePickerMode.date
        
        let datePicker = DatePickerRowFormer<FormDatePickerCell>().cellSetup { (cell) in
            let date = cell as! FormDatePickerCell
            date.datePicker.datePickerMode = .date
        }
        
        datePicker.configure { (cell) in
            dateFormatter.dateStyle = .medium
            let dateString = dateFormatter.string(from: cell.date)
            self.dateLabelRow.text = dateString
        }
        
        datePicker.onDateChanged { (date) in
            self.date = date
            self.dateLabelRow.configure { (cell) in
                dateFormatter.dateStyle = .medium
                let dateString = dateFormatter.string(from: date)
                cell.text = String(describing: dateString)
            }.update()
        }

        let dateHeader =  LabelViewFormer<FormLabelHeaderView>() { (view) in
            view.textLabel?.text = "When do you want to start your initiative?"
        }
        
        let view = CustomViewFormer().configure { (view) in
            let button: UIButton!
            button = UIButton()
            button.titleLabel?.text = "Save Initiative"
            button.backgroundColor = UIColor.blue
            view.view.addSubview(button)
        }

        let section2 = SectionFormer(rowFormer: dateLabelRow, datePicker, custom, custom ).set(headerViewFormer: dateHeader).set(footerViewFormer: view)
        former.append(sectionFormer: section2)
        
    }
    
    func saveInitiative(_ landmark: Landmark?) -> Bool {
        if !nameText.isEmpty && !descriptionText.isEmpty {
        
            if let landmark = landmark {
            Initiative.startNewInitiativeAtLandmark(landmark: landmark, initiativeName: nameText, initiativeDescription: descriptionText, associatedDate: date)
            } else {
            Initiative.startNewInitiativeAtLocation(latitude: mapStore.userLatitude, longitude: mapStore.userLongitude, initiativeName: nameText, initiativeDescription: descriptionText, associatedDate: date)
            }

            return true
        } else {
            return false
        }
    }
}
