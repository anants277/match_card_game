//
//  ViewController.swift
//  MatchCardGame
//
//  Created by Creo Server on 03/12/19.
//  Copyright © 2019 Creo Server. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    //our var for storing last tapped image
    var lastTappedImage: UIImage?
    //instance o0f playing card deck
    var playingCardDeck = PlayingCardDeck()
    //label outlet for total cards on centerDeck
    @IBOutlet weak var centerDeckLabel: UILabel!
    //imageviews where cards to match are displayed
    @IBOutlet weak var topCardImageView: UIImageView!
    @IBOutlet weak var bottomCardImageView: UIImageView!
    
    //our variable for storing string of both the last cards form both deck
    var cardImage1String = String()
    var cardImage2String = String()
    //our variable for storing deck1 and deck2
    var deck1: [PlayingCard]!
    var deck2: [PlayingCard]!
    
    var centerDeck: [PlayingCard]! = []
    
    //our player1card image view
    //here we are setting tap gesture
    @IBOutlet weak var player1ImageView: UIImageView!
    {
        didSet
        {
            let tap = UITapGestureRecognizer(target: self, action: #selector(cardAction1(_ :)))
            player1ImageView.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var player2ImageView: UIImageView!
    {
        didSet
        {
            let tap = UITapGestureRecognizer(target: self, action: #selector(cardAction2(_ : )))
            player2ImageView.addGestureRecognizer(tap)
        }
    }
    
    //our action which will be called when tap gesture on deck1 is recognised
    @objc func cardAction1(_ recognizer: UITapGestureRecognizer)
    {
        switch recognizer.state
        {
            case .ended:
                    //fliping card animation
                    UIView.transition(with: player1ImageView,
                                      duration: 0.6,
                                      options: .transitionFlipFromTop,
                                      animations: {
                                        //updating the count label
                                        self.player1ScoreLabel.text = "Total Cards = "+String(self.deck1.count)
                                        //getting string of top card on deck1
                                        self.cardImage1String = self.topCardString(&self.deck1)
                                        //setting up image based on the string
                                        self.player1ImageView.image = UIImage(named: self.cardImage1String)
                                      },
                                      completion: { finished in
                                        UIViewPropertyAnimator.runningPropertyAnimator(
                                            withDuration: 0.9,
                                            delay: 0.0,
                                            options: [],
                                            //animation for translation
                                            animations: {
                                                self.player1ImageView.transform = CGAffineTransform(translationX: -20, y: 200)
                                                
                                            },
                                            completion: { finished in
                                                self.centerDeckLabel.text = "Stack:\n"+String(self.centerDeck.count)
                                                self.topCardImageView.image = self.player1ImageView.image
                                                self.bottomCardImageView.image = self.lastTappedImage
                                                self.player1ImageView.isHidden = true
                                                self.player1ImageView.transform = .identity
                                                self.lastTappedImage = UIImage(named: self.cardImage1String)
                                                if self.centerDeck != nil && self.centerDeck.count > 1
                                                {
                                                    if self.matchCard(self.cardImage1String, self.cardImage2String)
                                                    {
                                                        self.deck1 += self.centerDeck
                                                        self.centerDeck.removeAll()
                                                        self.centerDeckLabel.text = "Stack:\n"+String(self.centerDeck.count)
                                                        self.player1ScoreLabel.text = "Total Cards = "+String(self.deck1.count)
                                                        
                                                        UIView.transition(with: self.topCardImageView,
                                                        duration: 0.6,
                                                        options: .transitionFlipFromLeft,
                                                        animations: {
                                                            self.bottomCardImageView.alpha = 0
                                                            self.bottomCardImageView.image = nil
                                                          self.topCardImageView.image = UIImage(named: "red_back")
                                                        },
                                                        completion: { finished in
                                                          UIViewPropertyAnimator.runningPropertyAnimator(
                                                              withDuration: 0.6,
                                                              delay: 0.0,
                                                              options: [],
                                                              animations: {
                                                                
                                                                  self.topCardImageView.transform = CGAffineTransform(translationX: 20, y: -200)
                                                        
                                                                  },
                                                              completion: { finished in
                                                                self.topCardImageView.isHidden = true
                                                                self.topCardImageView.transform = .identity
                                                                self.topCardImageView.image = nil
                                                                self.topCardImageView.isHidden = false
                                                                self.bottomCardImageView.alpha = 1
                                                                self.lastTappedImage = nil
                                                            }
                                                            )
                                                        })
                                                    }
                                                }
                                            }
                                        )
                                        //making player2ImageView visible and setting its image to card_back
                                        self.player2ImageView.isHidden = false
                                        self.player2ImageView.image = UIImage(named: "red_back")
                                      }
                                      )
            default: break
        }
    }
    
    //our action which will be called when tap gesture on deck2 is recognised
    @objc func cardAction2(_ recognizer: UITapGestureRecognizer)
    {
        switch recognizer.state
        {
            //working in .ended state
            case .ended:
                    UIView.transition(with: player2ImageView,
                                      duration: 0.6,
                                      options: .transitionFlipFromLeft,
                                      animations: {
                                        self.player2ScoreLabel.text = "Total Cards = "+String(self.deck2.count)
                                        self.cardImage2String = self.topCardString(&self.deck2)
                                        self.player2ImageView.image = UIImage(named: self.cardImage2String)
                                      },
                                      completion: { finished in
                                        UIViewPropertyAnimator.runningPropertyAnimator(
                                            withDuration: 0.6,
                                            delay: 0.0,
                                            options: [],
                                            animations: {
                                                self.player2ImageView.transform = CGAffineTransform(translationX: 20, y: -200)
                                                },
                                            completion: { finished in
                                                 self.centerDeckLabel.text = "Stack:\n"+String(self.centerDeck.count)
                                                self.topCardImageView.image = self.player2ImageView.image
                                                self.bottomCardImageView.image = self.lastTappedImage
                                                self.player2ImageView.isHidden = true
                                                self.player2ImageView.transform = .identity
                                                self.lastTappedImage = UIImage(named: self.cardImage2String)
                                                if self.centerDeck != nil && self.centerDeck.count > 1
                                                {
                                                    if self.matchCard(self.cardImage1String, self.cardImage2String)
                                                    {
                                                        
                                                        self.deck2 += self.centerDeck
                                                        self.centerDeck.removeAll()
                                                        self.centerDeckLabel.text = "Stack:\n"+String(self.centerDeck.count)
                                                        self.player2ScoreLabel.text = "Total Cards = "+String(self.deck2.count)
                                                        
                                                        UIView.transition(with: self.topCardImageView,
                                                        duration: 0.6,
                                                        options: .transitionFlipFromLeft,
                                                        animations: {
                                                            self.bottomCardImageView.alpha = 0
                                                            self.bottomCardImageView.image = nil
                                                          self.topCardImageView.image = UIImage(named: "red_back")
                                                        },
                                                        completion: { finished in
                                                          UIViewPropertyAnimator.runningPropertyAnimator(
                                                              withDuration: 0.6,
                                                              delay: 0.0,
                                                              options: [],
                                                              animations: {
                                                                
                                                                  self.topCardImageView.transform = CGAffineTransform(translationX: -20, y: 200)
                                                        
                                                                  },
                                                              completion: { finished in
                                                                self.topCardImageView.isHidden = true
                                                                self.topCardImageView.transform = .identity
                                                                self.topCardImageView.image = nil
                                                                self.topCardImageView.isHidden = false
                                                                self.bottomCardImageView.alpha = 1
                                                                self.lastTappedImage = nil
                                                            }
                                                            )
                                                        })
                                                        
                                                    }
                                                }
                                            }
                                        )
                                        self.player1ImageView.isHidden = false
                                        self.player1ImageView.image = UIImage(named: "red_back")
                                      }
                                      )
            default: break
        }
    }
    //Label Outlets for score
    @IBOutlet weak var player1ScoreLabel: UILabel!
    @IBOutlet weak var player2ScoreLabel: UILabel!
    //shuffle buttons action to shuffle the deck
    @IBAction func player1ShuffleButton(_ sender: Any)
    {
        playingCardDeck.deck2.shuffle()
    }
    @IBAction func player2ShuffleButton(_ sender: Any)
    {
        playingCardDeck.deck2.shuffle()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        player1ImageView.image = UIImage(named: "red_back")
        player2ImageView.image = UIImage(named: "red_back")
        player1ScoreLabel.text = "Total Cards = "+String(playingCardDeck.deck1.count)
        player2ScoreLabel.text = "Total Cards = "+String(playingCardDeck.deck2.count)
        centerDeckLabel.text = "stack:\n0"
        deck1 = playingCardDeck.deck1
        deck2 = playingCardDeck.deck2
    }
    //our function to return top card string from deck of cards
    func topCardString(_ cardDeck: inout [PlayingCard])-> String
    {
        let choosenCard = cardDeck.remove(at: cardDeck.startIndex)
        centerDeck.append(choosenCard)
        return choosenCard.rank.rawValue+choosenCard.suit.rawValue
    }
    //our function to check if the top cards of deck match which are in playing area
    func matchCard(_ str1: String,_ str2: String)-> Bool
    {
        return str1[str1.index(before: str1.endIndex)] == str2[str2.index(before: str2.endIndex)]  ? true : false
    }
    
    
//    func animate(_ playerImageView: UIImageView,_ oponentPlayerImageView: UIImageView, _ cardImageString: inout @escaping String,
//                 _ playerScoreLabel: UILabel, _ deck: [PlayingCard], _ centerDeck: [PlayingCard], _ centerDeckLabel: UILabel, _ lastTappedImage: UIImage)
//    {
//        //fliping card animation
//        UIView.transition(with: playerImageView,
//                          duration: 0.6,
//                          options: .transitionFlipFromTop,
//                          animations: {
//                            //updating the count label
//                            self.player1ScoreLabel.text = "Total Cards = "+String(self.deck1.count)
//                            //getting string of top card on deck1
//                            cardImageString = self.topCardString(&self.deck1)
//                            //setting up image based on the string
//                            playerImageView.image = UIImage(named: cardImageString)
//                          },
//                          completion: { finished in
//                            UIViewPropertyAnimator.runningPropertyAnimator(
//                                withDuration: 0.9,
//                                delay: 0.0,
//                                options: [],
//                                //animation for translation
//                                animations: {
//                                    playerImageView.transform = CGAffineTransform(translationX: -20, y: 200)
//
//                                },
//                                completion: { finished in
//                                    self.centerDeckLabel.text = "Stack:\n"+String(self.centerDeck.count)
//                                    self.topCardImageView.image = playerImageView.image
//                                    self.bottomCardImageView.image = self.lastTappedImage
//                                    playerImageView.isHidden = true
//                                    playerImageView.transform = .identity
//                                    self.lastTappedImage = UIImage(named: cardImageString)
//                                    if self.centerDeck != nil && self.centerDeck.count > 1
//                                    {
//                                        if self.matchCard(cardImageString, self.cardImage2String)
//                                        {
//                                            self.deck1 += self.centerDeck
//                                            self.centerDeck.removeAll()
//                                            self.centerDeckLabel.text = "Stack:\n"+String(self.centerDeck.count)
//                                            self.player1ScoreLabel.text = "Total Cards = "+String(self.deck1.count)
//
//                                            UIView.transition(with: self.topCardImageView,
//                                            duration: 0.6,
//                                            options: .transitionFlipFromLeft,
//                                            animations: {
//                                                self.bottomCardImageView.alpha = 0
//                                                self.bottomCardImageView.image = nil
//                                              self.topCardImageView.image = UIImage(named: "red_back")
//                                            },
//                                            completion: { finished in
//                                              UIViewPropertyAnimator.runningPropertyAnimator(
//                                                  withDuration: 0.6,
//                                                  delay: 0.0,
//                                                  options: [],
//                                                  animations: {
//
//                                                      self.topCardImageView.transform = CGAffineTransform(translationX: 20, y: -200)
//
//                                                      },
//                                                  completion: { finished in
//                                                    self.topCardImageView.isHidden = true
//                                                    self.topCardImageView.transform = .identity
//                                                    self.topCardImageView.image = nil
//                                                    self.topCardImageView.isHidden = false
//                                                    self.bottomCardImageView.alpha = 1
//                                                    self.lastTappedImage = nil
//                                                }
//                                                )
//                                            })
//                                        }
//                                    }
//                                }
//                            )
//                            //making player2ImageView visible and setting its image to card_back
//                            oponentPlayerImageView.isHidden = false
//                            oponentPlayerImageView.image = UIImage(named: "red_back")
//                          }
//                          )
//    }
//






}


