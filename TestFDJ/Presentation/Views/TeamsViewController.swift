//
//  TeamsViewController.swift
//  TestFDJ
//
//  Created by Bouziane Hamzi on 06/10/2023.
//

import Combine
import UIKit

class TeamsViewController: UIViewController, UICollectionViewDataSource,
    UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    var viewModel: TeamViewModel!
    private var cancellables: Set<AnyCancellable> = []
    private var teams: [Team] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }()

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var emptyView: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = layout

        viewModel.$teams
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] fetchedTeams in
                self?.teams = fetchedTeams
            })
            .store(in: &cancellables)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teams.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamCollectionViewCell", for: indexPath) as! TeamCollectionViewCell
        let team = teams[indexPath.item]
        cell.loadImage(with: team.strTeamBadge) // Assuming you have a configure method in your TeamCollectionViewCell to set the image.
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let paddingBetweenCells: CGFloat = 10
        let totalPadding = paddingBetweenCells * (numberOfColumns - 1)
        let availableWidth = collectionView.bounds.width - totalPadding - layout.sectionInset.left - layout.sectionInset.right
        let individualItemWidth = availableWidth / numberOfColumns
        return CGSize(width: individualItemWidth, height: individualItemWidth) // Assuming a square cell, adjust height as needed.
    }
}
