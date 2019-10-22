sub EVENT_SPAWN {
	#:: Create a proximity, 100 units across, 100 units tall, without proximity say
	quest::set_proximity($x - 50, $x + 50, $y - 50, $y + 50, $z - 50, $z + 50, 0);
}

sub EVENT_ENTER {
	#:: Check for 18703 - Old Folded Letter
	if (plugin::check_hasitem($client, 18703)) { 
		$client->Message(15,"An evil cackle echoes throughout the mines as you get your bearings. Rilgor Plegnog turns his gaze upon you. 'Why do you stand about young apprentice?! There is much to learn. Read the note in your inventory and then hand it to me so that we can begin your training! The Dark Reflection will have its revenge!'");
	}
}

sub EVENT_SAY {
	if ($text=~/trades/i) {
		quest::say("I thought you might be one who was interested in the various different trades, but which one would suit you? Ahh, alas, it would be better to let you decide for yourself, perhaps you would even like to master them all! That would be quite a feat. Well, lets not get ahead of ourselves, here, take this book. When you have finished reading it, ask me for the [" . quest::saylink("second book") . "], and I shall give it to you. Inside them you will find the most basic recipes for each trade. These recipes are typically used as a base for more advanced crafting, for instance, if you wished to be a smith, one would need to find some ore and smelt it into something usable. Good luck!");
		#:: Give them 51121 - Tradeskill Basics : Volume I
		quest::summonitem(51121);
	}
	elsif ($text=~/second book/i) { 
		quest::say("Here is the second volume of the book you requested, may it serve you well!");
		#:: Give them 51122 - Tradeskill Basics : Volume II
		quest::summonitem(51122);
	}
}

sub EVENT_ITEM {
	#:: Match a 18703 - Old Folded Letter
	if (plugin::takeItems(18703 => 1)) {
		quest::say("Ah.. Welcome, friend! I am Tobon Starpyre, Master Wizard of Library Mechanimagica. This is our tunic - wear it with pride. Study hard, master your skills, and make us proud. Once you are ready to begin your training please make sure that you see Xalirilan, he can assist you in developing your hunting and gathering skills. Return to me when you have become more experienced in our art, I will be able to further instruct you on how to progress through your early ranks, as well as in some of the various [" . quest::saylink("trades") . "] you will have available to you.");
		#:: Give item 13524 - Dark Gold Felt Robe*
		quest::summonitem(13524);
		#:: Ding!
		quest::ding();
		#:: Set faction
		quest::faction(240, -10); 		#:: - Deep Muses
		quest::faction(245, -10); 		#:: - Eldritch Collective
		quest::faction(238, 100); 		#:: + Dark Reflection
		quest::faction(255, -10); 		#:: - Gem Choppers
		#:: Grant a small amount of experience
		quest::exp(100);
	}
	#:: Return unused items
	plugin::returnUnusedItems();
}
