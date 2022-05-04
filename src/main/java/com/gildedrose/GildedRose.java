package com.gildedrose;


import java.util.List;

import static java.util.Arrays.asList;
import static java.util.function.Predicate.not;

public class GildedRose {
    public static final String AGED_BRIE = "Aged Brie";
    public static final String BACKSTAGE_PASSES = "Backstage passes to a TAFKAL80ETC concert";
    public static final String SULFURAS = "Sulfuras, Hand of Ragnaros";
    public static final Integer MAX_VALUE_QUALITY = 50;
    private List<Item> items;

    public GildedRose(Item[] items) {
        this.items = asList(items);
    }

    public void updateQuality() {
        items.stream()
                .filter(not(item -> SULFURAS.equals(item.name)))
                .forEach(this::updateQuality);
    }

    private void updateQuality(Item item) {
        switch (item.name) {
            case AGED_BRIE:
                increaseQuality(item);
                if (isExpired(item)) increaseQuality(item);
                break;
            case BACKSTAGE_PASSES:
                updateBackStageQuality(item);
                break;
            default:
                decreaseQuality(item);
                if (isExpired(item)) decreaseQuality(item);
                break;
        }
        decreaseSellIn(item);
    }

    private void increaseQuality(Item item) {
        if (item.quality < MAX_VALUE_QUALITY) {
            item.quality += 1;
        }
    }

    private void decreaseQuality(Item item) {
        if (item.quality > 0) {
            item.quality -= 1;
        }
    }

    private void decreaseSellIn(Item item) {
        item.sellIn -= 1;
    }

    private void updateBackStageQuality(Item item) {
        increaseQuality(item);
        if (item.sellIn < 11) {
            increaseQuality(item);
        }
        if (item.sellIn < 6) {
            increaseQuality(item);
        }
        if (isExpired(item)) {
            item.quality = 0;
        }
    }

    private boolean isExpired(Item item) {
        return item.sellIn < 1;
    }

    public List<Item> getItems() {
        return items;
    }
}
