Feature: Gilded Rose Inventory management

  Scenario: items lose 1 quality each day while sell-in date is not past
    Given I register the following items in the inventory
      | name    | +5 Dexterity Vest | Elixir of the Mongoose |
      | sellIn  | 10                | 5                      |
      | quality | 20                | 7                      |
    When 1 day passes
    Then the inventory holds the following items
      | name    | +5 Dexterity Vest | Elixir of the Mongoose |
      | sellIn  | 9                 | 4                      |
      | quality | 19                | 6                      |


  Scenario: items lose 2 quality each day after sell-in date
    Given I register the following items in the inventory
      | name    | +5 Dexterity Vest | Elixir of the Mongoose |
      | sellIn  | 0                 | 0                      |
      | quality | 20                | 7                      |
    When 1 day passes
    Then the inventory holds the following items
      | name    | +5 Dexterity Vest | Elixir of the Mongoose |
      | sellIn  | -1                | -1                     |
      | quality | 18                | 5                      |


  Scenario: the quality of an item is never negative
    Given I register the following items in the inventory
      | name    | +5 Dexterity Vest | Elixir of the Mongoose |
      | sellIn  | -1                | 1                      |
      | quality | 0                 | 0                      |
    When 1 day passes
    Then the inventory holds the following items
      | name    | +5 Dexterity Vest | Elixir of the Mongoose |
      | sellIn  | -2                | 0                      |
      | quality | 0                 | 0                      |


  Scenario: the quality of "Aged brie" increases over time
    Given I register the following items in the inventory
      | name    | Aged Brie | Aged Brie | Aged Brie |
      | sellIn  | 1         | 1         | 0         |
      | quality | 3         | 5         | 5         |
    When 1 day passes
    Then the inventory holds the following items
      | name    | Aged Brie | Aged Brie | Aged Brie |
      | sellIn  | 0         | 0         | -1        |
      | quality | 4         | 6         | 7         |


  Scenario: the quality of an item is never more than 50
    Given I register the following items in the inventory
      | name    | Aged Brie | Aged Brie |
      | sellIn  | 2         | 2         |
      | quality | 48        | 49        |
    When 2 days pass
    Then the inventory holds the following items
      | name    | Aged Brie | Aged Brie |
      | sellIn  | 0         | 0         |
      | quality | 50        | 50        |


  Scenario: Sulfuras never has to be sold nor decreases in quality
    Given I register the following items in the inventory
      | name    | Sulfuras, Hand of Ragnaros | Sulfuras, Hand of Ragnaros |
      | sellIn  | 0                          | -1                         |
      | quality | 80                         | 80                         |
    When 2 days pass
    Then the inventory holds the following items
      | name    | Sulfuras, Hand of Ragnaros | Sulfuras, Hand of Ragnaros |
      | sellIn  | 0                          | -1                         |
      | quality | 80                         | 80                         |


  Scenario: the quality of "Backstage passes" increases over time
    Given I register the following items in the inventory
      | name    | Backstage passes to a TAFKAL80ETC concert |
      | sellIn  | 20                                        |
      | quality | 3                                         |
    When 1 day passes
    Then the inventory holds the following items
      | name    | Backstage passes to a TAFKAL80ETC concert |
      | sellIn  | 19                                        |
      | quality | 4                                         |


  Scenario: the quality of "Backstage passes" increases by 2 starting 10 days before the concert
    Given I register the following items in the inventory
      | name    | Backstage passes to a TAFKAL80ETC concert | Backstage passes to a TAFKAL80ETC concert |
      | sellIn  | 11                                        | 10                                        |
      | quality | 3                                         | 2                                         |
    When 1 day passes
    Then the inventory holds the following items
      | name    | Backstage passes to a TAFKAL80ETC concert | Backstage passes to a TAFKAL80ETC concert |
      | sellIn  | 10                                        | 9                                         |
      | quality | 4                                         | 4                                         |


  Scenario: the quality of "Backstage passes" increases by 3 starting 5 days before the concert
    Given I register the following items in the inventory
      | name    | Backstage passes to a TAFKAL80ETC concert | Backstage passes to a TAFKAL80ETC concert |
      | sellIn  | 6                                         | 5                                         |
      | quality | 3                                         | 2                                         |
    When 1 day passes
    Then the inventory holds the following items
      | name    | Backstage passes to a TAFKAL80ETC concert | Backstage passes to a TAFKAL80ETC concert |
      | sellIn  | 5                                         | 4                                         |
      | quality | 5                                         | 5                                         |


  Scenario: the quality of "Backstage passes" drops to 0 after the concert
    Given I register the following items in the inventory
      | name    | Backstage passes to a TAFKAL80ETC concert | Backstage passes to a TAFKAL80ETC concert |
      | sellIn  | 1                                         | 0                                         |
      | quality | 1                                         | 2                                         |
    When 1 day passes
    Then the inventory holds the following items
      | name    | Backstage passes to a TAFKAL80ETC concert | Backstage passes to a TAFKAL80ETC concert |
      | sellIn  | 0                                         | -1                                        |
      | quality | 4                                         | 0                                         |


  Scenario: the quality of "Conjured" items decreases twice as fast as normal
    Given I register the following items in the inventory
      | name    | Conjured +5 Dexterity Vest | Conjured Elixir of the Mongoose |
      | sellIn  | 4                          | 3                               |
      | quality | 5                          | 6                               |
    When 1 day passes
    Then the inventory holds the following items
      | name    | Conjured +5 Dexterity Vest | Conjured Elixir of the Mongoose |
      | sellIn  | 3                          | 2                               |
      | quality | 3                          | 4                               |


  Scenario: the quality of "Conjured" items decreases after its sell-in date
    Given I register the following items in the inventory
      | name    | Conjured +5 Dexterity Vest | Conjured Elixir of the Mongoose |
      | sellIn  | 0                          | 0                               |
      | quality | 5                          | 6                               |
    When 1 day passes
    Then the inventory holds the following items
      | name    | Conjured +5 Dexterity Vest | Conjured Elixir of the Mongoose |
      | sellIn  | -1                         | -1                              |
      | quality | 1                          | 2                               |
