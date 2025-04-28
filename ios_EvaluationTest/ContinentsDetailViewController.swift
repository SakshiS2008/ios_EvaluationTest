//
//  ContinentsDetailViewController.swift
//  ios_EvaluationTest
//
//  Created by Mac on 26/04/25.
//

import UIKit

class ContinentsDetailViewController: UIViewController {

    
    @IBOutlet weak var codeLabel: UILabel!
    
    @IBOutlet weak var nameLabelView: UILabel!
    
    @IBOutlet weak var areaLabelView: UILabel!
    
    @IBOutlet weak var populationLabelView: UILabel!
    
    @IBOutlet weak var lineLabel: UILabel!
    
    @IBOutlet weak var countriesLabel: UILabel!
    
    @IBOutlet weak var oceanLabel: UILabel!
    
    @IBOutlet weak var devCountries: UILabel!
    
    var continentsContiner : Continents?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exractAndBindContinentData()
    }
     func exractAndBindContinentData(){
         self.codeLabel.text = continentsContiner!.code
         self.nameLabelView.text = continentsContiner!.name
         self.areaLabelView.text = "\(continentsContiner!.areaSqKm)"
         self.populationLabelView.text = "\(continentsContiner!.population)"
         self.countriesLabel.text = "\(continentsContiner!.countries )"
         self.lineLabel.text = "\(continentsContiner!.lines)"
         self.oceanLabel.text = "\(continentsContiner!.oceans)"
         self.devCountries.text = "\(continentsContiner!.developedCountries )"
    }
}
