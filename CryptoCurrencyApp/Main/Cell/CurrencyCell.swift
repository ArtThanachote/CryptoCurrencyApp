//
//  CurrencyCell.swift
//  CryptoCurrencyApp
//
//  Created by IT-EFW-65-03 on 21/6/2566 BE.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    @IBOutlet weak var lb_name: UILabel!
    @IBOutlet weak var lb_rate: UILabel!
    @IBOutlet weak var lb_date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(_ item:Display?){
        guard let data = item else { return }
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]
        
        if let utcDate = dateFormatter.date(from: item?.time?.updatedISO ?? "") {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour, .minute, .second], from: utcDate)
            
            if let hour = components.hour, let minute = components.minute, let second = components.second {
                let formattedTime = String(format: "%02d:%02d:%02d", hour, minute, second)
                lb_date.text = formattedTime
            }
        }
        
        
        lb_name.text = data.eur?.code
        lb_rate.text = String(format: "%@ %@", data.eur?.rate ?? "-", data.eur?.symbol ?? "-").convertSymbols()
    }
    
}
