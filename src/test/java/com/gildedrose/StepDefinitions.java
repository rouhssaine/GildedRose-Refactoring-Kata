package com.gildedrose;

import io.cucumber.java.Before;
import io.cucumber.java.DataTableType;
import io.cucumber.java.Transpose;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import java.util.List;
import java.util.Map;

import static java.lang.String.format;
import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.presentation.StandardRepresentation.registerFormatterForType;

public class StepDefinitions {
    private GildedRose gildedRose;

    @DataTableType
    public Item item(Map<String, String> entry) {
        Item object = new Item(
                entry.get("name"),
                Integer.parseInt(entry.get("sellIn")),
                Integer.parseInt(entry.get("quality"))
        );
        return object;
    }

    @Before
    public void setUp() {
        registerFormatterForType(Item.class, this::formatItem);
    }

    @Given("I register the following items in the inventory")
    public void i_register_the_following_items_in_the_inventory(@Transpose List<Item> items) {
        assertThat(items).as("inventory items").isNotEmpty();
        gildedRose = new GildedRose(toArray(items));
    }

    @When("{int} day(s) pass(es)")
    public void day_passes(int days) {
        assertThat(gildedRose).isNotNull();
        for (int i = 0; i < days; ++i) {
            gildedRose.updateQuality();
        }
    }

    @Then("^the inventory holds the following items$")
    public void the_inventory_holds_the_following_items(@Transpose List<Item> items) {
        assertThat(gildedRose.getItems())
                .usingRecursiveFieldByFieldElementComparator()
                .containsOnly(toArray(items));
    }

    private String formatItem(Object object) {
        Item item = (Item) object;
        return format("(%s, sellIn=%d, quality=%d)", item.name, item.sellIn, item.quality);
    }

    private Item[] toArray(List<Item> items) {
        return items.toArray(new Item[items.size()]);
    }
}
