//
//  EvidenceTableViewDataSource.swift
//  BiasBike
//
//  Created by Bruce McTigue on 8/26/16.
//  Copyright © 2016 tiguer. All rights reserved.
//

import UIKit

class EvidenceTableViewDataSource: NSObject {
    
    private(set) var evidence:[Evidence] = []

    init(tableView: UITableView) {
        super.init()
        tableView.dataSource = self
    }
    
    func updateDataSource(evidence: [Evidence]) {
        self.evidence = evidence
    }
}

extension EvidenceTableViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return evidence.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EvidenceCell = tableView.dequeueReusableCell(withIdentifier: "EvidenceCell", for: indexPath as IndexPath) as! EvidenceCell
        return cell
    }
}
