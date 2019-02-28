//
//  LCPViewModel.swift
//  r2-testapp-swift
//
//  Created by Mickaël Menu on 19.02.19.
//
//  Copyright 2019 Readium Foundation. All rights reserved.
//  Use of this source code is governed by a BSD-style license which is detailed
//  in the LICENSE file present in the project repository where this source code is maintained.
//

#if LCP

import Foundation
import R2Shared
import ReadiumLCP


final class LCPViewModel: DRMViewModel {

    private var lcpLicense: LCPLicense? {
        guard let license = license else {
            return nil
        }
        return license as? LCPLicense
    }
    
    override var type: String {
        return "LCP"
    }
    
    override var state: String? {
        return lcpLicense?.status?.status.rawValue
    }
    
    override var provider: String? {
        return lcpLicense?.license.provider
    }
    
    override var issued: Date? {
        return lcpLicense?.license.issued
    }
    
    override var updated: Date? {
        return lcpLicense?.license.updated
    }
    
    override var start: Date? {
        return lcpLicense?.license.rights.start
    }
    
    override var end: Date? {
        return lcpLicense?.license.rights.end
    }
    
    override var copiesLeft: String {
        guard let quantity = lcpLicense?.charactersToCopyLeft else {
            return super.copiesLeft
        }
        return "\(quantity) characters"
    }
    
    override var printsLeft: String {
        guard let quantity = lcpLicense?.pagesToPrintLeft else {
            return super.printsLeft
        }
        return "\(quantity) pages"
    }
    
    override var canRenewLoan: Bool {
        return lcpLicense?.canRenewLoan ?? false
    }
    
    override func renewLoan(completion: @escaping (Error?) -> Void) {
        guard let lcpLicense = lcpLicense else {
            completion(nil)
            return
        }
        lcpLicense.renewLoan(to: nil, completion: completion)
    }
    
    override var canReturnPublication: Bool {
        return lcpLicense?.canReturnPublication ?? false
    }
    
    override func returnPublication(completion: @escaping (Error?) -> Void) {
        guard let lcpLicense = lcpLicense else {
            completion(nil)
            return
        }
        lcpLicense.returnPublication(completion: completion)
    }
    
}

#endif
