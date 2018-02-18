sub EVENT_SPAWN {
	#:: Set up a 50 unit distance
	$x = $npc->GetX();
	$y = $npc->GetY();
	quest::set_proximity($x - 50, $x + 50, $y - 50, $y + 50);
}

sub EVENT_ENTER {
	#:: Check for 18775- Tattered Note
	if (plugin::check_hasitem($client, 18775)) { 
		$client->Message(15,"Iony Gredlong's tiny voice echoes throughout the room. 'Welcome to the Abbey of Deep Musing $name. I am Iony Gredlong, your new Guild Master should you accept the ways of the Clerics of the Deep Muses. Read the note in your inventory and then hand it to me when you are ready to begin your training.'");
	}
}

sub EVENT_SAY {
	if ($text=~/trades/i) {
		quest::say("I thought you might be one who was interested in the various different trades, but which one would suit you? Ahh, alas, it would be better to let you decide for yourself, perhaps you would even like to master them all! That would be quite a feat. Well, lets not get ahead of ourselves, here, take this book. When you have finished reading it, ask me for the [" . quest::saylink("second book") . "], and I shall give it to you. Inside them you will find the most basic recipes for each trade. These recipes are typically used as a base for more advanced crafting, for instance, if you wished to be a smith, one would need to find some ore and smelt it into something usable. Good luck!");
		#:: Give a 51121 - Tradeskill Basics: Volume 1
		quest::summonitem(51121); 
	}
	if ($text=~/second book/i) { 
		quest::say("Here is the second volume of the book you requested, may it serve you well!");
		#:: Give a 51122 - Tradeskill Basics: Volume II
		quest::summonitem(51122); 
	}
}

sub EVENT_ITEM {
	#:: Check for 18775 - Tattered Note
	if (plugin::check_handin(\%itemcount, 18775 => 1)) { 
		quest::Say("Welcome to the Abbey of Deep Musing.  Here you can train and raise your abilities to the peak of perfection. Take this tunic and wear it with pride. Return to me when you have become more experienced in our art, I will be able to further instruct you on how to progress through your early ranks, as well as in some of the various [" . quest::saylink("trades") . "] you will have available to you.");
		#:: Reward 13522 - Worn Felt Tunic
		quest::summonitem(13522);
		#:: Set factions
		quest::faction(322,15); 	# Merchants of Ak'Anon
		quest::faction(76,100); 	# Deep Muses
		quest::faction(71,-15); 	# Dark Reflection
		quest::faction(115,15); 	# Gem Choppers
		quest::ding();
		quest::exp(100);
	}
	#:: Return unused items
	plugin::return_items(\%itemcount);
}

# converted to Perl by SS
