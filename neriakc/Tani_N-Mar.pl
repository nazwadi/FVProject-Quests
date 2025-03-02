sub EVENT_SAY {
	if ($text=~/hail/i) {
		quest::say("Greetings!  You must be a stranger or [new to the Hall].  If you are a stranger. be warned that these halls are intended for the Ebon Mask only. If you are found to be a member of another house. you just may feel the sting of a blade in your back.");
	}
	elsif ($text=~/new to the hall/i) {
		quest::say("Then I am glad to make your acquaintance. Have you ever been to Freeport?  If not, how would you like to go?  It is a test of your cunning we wish.  Are you prepared to risk your young life?  Are you [ready to venture to Freeport]?");
	}
	elsif ($text=~/ready to venture to freeport/i) {
		quest::say("Find a way to the port of Freeport.  Seek out Giz Dinree.  She is usually near the shores at night.  She is your contact. Tell her you were [sent by TanI].  She will fill you in on your mission.  Good luck.  Do not waste time practicing your skills. Go as you are.");
	}
	elsif ($text=~/book of souls/i && quest::is_content_flag_enabled("Kunark_EpicsEra")) {
		quest::say("The Book of Souls chronicles all the lives Innoruuk has tainted over the years. It is in the care of the Maestro of Rancor. I can use this tome as a basis for my translation, if you return it and the note to me. An experienced practitioner in the art of non-detection should be able to snatch it from its resting place, don't you think, $race?'");
	}
	elsif ($text=~/note/i && quest::is_content_flag_enabled("Kunark_EpicsEra")) {
		quest::say("Oh, you want that piece of paper Stanos was so hot after? Well it's mine now, though it looks like ogre scratch to me. You're not getting it, Stanos is not getting it, and Hanns is not getting it. It is MINE! Now, $race, scamper off like the dog you are, before I decide I need more practice with these short swords!");
	}
}

sub EVENT_ITEM {
	#:: Match a 13892 - Human Head
	if (plugin::takeItems(13892 =>1 )) {
		quest::say("Good work! I knew you could prove your worth. Most waste time training. I do not reward those who waste my time. Please take this. It is from our horde, from countless robberies. I hope you can use it to advance yourself. Remember to always stay faithful to Neriak.");
		#:: Give a 5066 - Cinctured Whip
		quest::summonitem(5066);
		#:: Ding!
		quest::ding();
		#:: Set factions
		quest::faction(244, 5);			#:: + Ebon Mask
		quest::faction(262,-5);			#:: - Guards of Qeynos
		quest::faction(320,-5);			#:: - Wolves of the North
		quest::faction(263,-5);			#:: - Guardians of the Vale
		quest::faction(329,-5);			#:: - Carson McCabe
		#:: Grant a moderate amount of experience
		quest::exp(5000);
		#:: Create a hash for storing cash - 75 to 100cp
		my %cash = plugin::RandomCash(75,100);
		#:: Grant a random cash reward
		quest::givecash($cash{copper},$cash{silver},$cash{gold},$cash{platinum});
	}
	#:: plugin::try_tome_handins(\%itemcount, $class, 'Rogue');
	#:: Return unused items
	plugin::returnUnusedItems();
}
