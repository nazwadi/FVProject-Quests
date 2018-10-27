sub EVENT_SAY { 
	if ($text=~/Hail/i) {
		quest::say("Well met. $name!  I am Vacto Molunel.  If you are seeking to outfit yourself with the finest weapons in all of Kaladim, I am the one to see.  I also posses a [" . quest::saylink("rare talent") . "] you might find useful.");
	}
	if ($text=~/rare talent/i) {
		quest::say("Piqued your interest. did I?  Well. you see. I am one of the few dwarves who possess the knowledge and talent to craft a unique type of armor entirely out of scarab carapaces.  While my specialty is making [" . quest::saylink("scarab helms") . "], I have also been convinced to make [" . quest::saylink("scarab breastplates") . "] and [" . quest::saylink("scarab boots") . "] from time to time.  All of the pieces I craft are to dwarven proportions, but I have had some gnomish and halfling customers as well.  They come from all over for my armor.");
	}
	if ($text=~/scarab helms/i) {
		quest::say("Interested in a scarab helm. are you?  Well, because my talent is so unique and my time is so valuable, I am afraid I could only make you a helm if you were to provide me with the two scarab carapaces necessary to accommodate a head such as yours.  I will also need a payment of 5 gold pieces.  The Butcherblocks are crawling with worker scarabs that have just the right size carapaces for our needs.");
	}
	if ($text=~/scarab breastplates/i) {
		quest::say("Ah..  A  scarab breastplate.. hmm.  Well, if you want to convince me to go though the trouble of crafting one of those, not only will you have to pay my fee of 23 gold pieces, you must provide me with a pristine giant scarab carapace.  I refuse to make a breastplate with cracked carapaces."); 
	}
	if ($text=~/boots/i) {
		quest::say("Ah..  Scarab Boots.. hmm.  Well, if you want to convince me to go though the trouble of crafting a pair of those, not only will you have to pay my fee of 17 gold pieces, you must provide me with a cracked giant scarab shell and 2 scarab legs."); 
	}
}

sub EVENT_ITEM {
	#:: Match two 13849 - Scarab Carapace and 5 gold
	if (plugin::takeItemsCoin(0,0,5,0, 13849 => 2)) {
		#:: Give a 2175 - Small Scarab Helm
		quest::summonitem(2175); 
		quest::say("Here is your Scarab Helm!"); 
	}
	#:: Match a 13133 - Pristine Giant Scarab Carapace and 23 gold
	if (plugin::takeItemsCoin(0,0,23,0, 13133 => 1)) {
		#:: Give a 2176 - Small Scarab Breastplate
		quest::summonitem(2176); 
		quest::say("Here is your Scarab breastplate!"); 
	}
	#:: Match a 13132 - Cracked Giant Scarab Carapace, two 13848 - Scarab Legs, and 17 gold
	if (plugin::takeItemsCoin(0,0,17,0, 13132 => 1, 13848 => 2)) {
		#:: Give a 2177 - Small Scarab Boots
		quest::summonitem(2177); 
		quest::say("Here is your Scarab boots!"); 
	}
	#:: Return unused items
	plugin::return_items(\%itemcount);
}
