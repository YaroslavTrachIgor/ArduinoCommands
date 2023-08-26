//
//  ACURLs.swift
//  ArduinoCommands
//
//  Created by User on 28.06.2022.
//

import Foundation

//MARK: - URLs storage
public enum ACURLs {
    
    //MARK: Public
    enum API {
        
        //MARK: Static
        static let applicationAPI = "https://yaroslavtrachigor.github.io/ArduinoCommandsInfo/arduinoCommandsInfo.json"
        static let devicesImagesAPIFirstPart = "https://api.unsplash.com/search/photos?page=1&per_page=50&query="
        static let devicesImagesAPISecondPart = "&client_id=xiglQ07MdBqYYf-RUAd73pHEslxlZlNRJlfsK0pEtMY"
    }
    enum Materials {
        
        //MARK: Static
        static let wikiArduino = "https://uk.wikipedia.org/wiki/Arduino"
        static let allArduino = "https://all-arduino.ru/biblioteki-arduino/arduino-biblioteka-servo/"
        static let kiberKoder = "https://bitkit.com.ua/file_downloads/kiberkozer_manual/RUS_instr_kiberkoder.pdf"
        static let arduinoRu = "https://All-arduino.ru"
        static let arduinoCc = "https://www.arduino.cc"
    }
}
