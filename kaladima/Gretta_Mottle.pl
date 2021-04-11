sub EVENT_SAY { 
	if ($text=~/hail/i) {
		quest::say("Greetings. $name.  I'm Gretta Mottle.  Tumpy has been kind enough to let me to set up my bakery in his fine establishment here.  Unfortunately. with that nasty plague corruptin' the crops in the Plains of Karana, things are goin' a bit slow for me.  I keep runnin' out of bread and muffins to sell.  Because of flour bein' easily spoiled now, it takes longer to make 'em just right.  My assistant Buggle is still learnin' how to cook.  Hehe.. All he can make is Meat Pie.  If I don't get any [help to bake] soon I won't be able to keep the supply up with the demand.");
	}
	elsif ($text=~/help to bake/i) {
		quest::say("Glad to hear it.  Are ye thinkin' of helpin' me to [bake muffins] or did ye want to [fetch some bread] for me?");
	}
	#:: Could not find original dialogue - TT
	elsif ($text=~/bake muffins/i) {
		quest::say("Ah, if ye want to help me with the bakin, take this here muffin crate, and fill it with fresh baked muffins. Once you have a full muffin crate, deliver it to Winda Lylil in Freeport.");
		#:: Give a 17881 - Muffin Crate
		quest::summonitem(17881);
	}
	elsif ($text=~/fetch some bread/i) {
		quest::say("The only one who can make bread almost as good as I can is Jarlen Meadowgreen.  He lives a long way off though.. in the southern Plains of Karana.  If ye travel there. tell him that you are there to pick up some bread loaves for me.");
	}
}

#:: Remove after the plague of the Karanas has been cured
sub EVENT_ITEM {
	#:: Match a 1838 - Bag of Bread Loaves
	if (plugin::takeItems(1838 => 1)) {
		quest::say("'Well now, what do we have here? You actually went out of your way to fetch bread for me? Thank ye so kindly. Please accept this payment for your service.");
		#:: Ding!
		quest::ding();
		#:: Set factions
		quest::faction(290, 4);		#:: + Merchants of Kaladim
		quest::faction(322, -1);	#:: - Miner's Guild 628
		quest::faction(293, 1); 	#:: + Miner's Guild 249
		quest::faction(312, 1); 	#:: + Storm Guard
		quest::faction(274, 1);		#:: + Kazon Stormhammer
		#:: Create a hash for storing cash - 1300 to 2200cp
		my %cash = plugin::RandomCash(1300,2200);
		#:: Grant a random cash reward
		quest::givecash($cash{copper},$cash{silver},$cash{gold},$cash{platinum});
		#:: Grant a small amount of level-based experience
		$client->AddLevelBasedExp(4, 14);
	}
	#:: Match a 1839 - Full Muffin Crate
	elsif (plugin::takeItems(1839 => 1)) {
		quest::emote("smells the aroma in the air and says,");
		quest::say("Mmm... Mmm... That sure smells good.  You truly are a fine baker.  Here, take this payment for such fine bakin'.");
		#:: Set factions
		quest::faction(290, 2);		#:: + Merchants of Kaladim
		quest::faction(322, -1);	#:: - Miner's Guild 628
		quest::faction(293, 1); 	#:: + Miner's Guild 249
		quest::faction(312, 1); 	#:: + Storm Guard
		quest::faction(274, 1);		#:: + Kazon Stormhammer
		#:: Grant a small amount of level-based experience
		$client->AddLevelBasedExp(4, 14);
		#:: Create a hash for storing cash - 500 to 750cp
		my %cash = plugin::RandomCash(500,750);
		#:: Grant a random cash reward
		quest::givecash($cash{copper},$cash{silver},$cash{gold},$cash{platinum});
		#:: South Kaladim >> Gretta_Mottle (60000) restock 13014 - Muffin, quantity 20
		quest::MerchantSetItem(60000, 13014, 20);
	}
	#:: Return unused items
	plugin::returnUnusedItems();
}
