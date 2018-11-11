sub EVENT_SAY {
	if ($text=~/hail/i) {
		quest::say("It is a good thing to see new faces visiting our temple. We are the source of strength within this city. Do not be fooled by the Freeport Militia. They are not warriors of valor.  [" . quest::saylink("Join the fight") . "] against the Freeport Militia.");
	}
	if ($text=~/Join the fight/i) {
		quest::say("You are wise. If you are a paladin, either speak with Theron of this temple or visit the Hall of Truth here in North Freeport. Clerics should concetrate on keeping the knights strong and healthy. Would you care to [" . quest::saylink("assist") . "] the Temple of Marr?");
	}
	if ($text=~/assist/i) {
		#:: Match if faction is better than indifferent
		if ($faction < 5) {
			quest::say("Good. Take this Potion of Marr to the Sentries of Passion. They are the protectors of this temple. Start in alphabetical order and the first shall take but a sip then you shall take it to the next in order of the alphabet. There are but eight sentries. Sentry Andlin to Sentry Xyrin. Go.");
			#:: Summon 12127 - Full Potion of Marr
			quest::summonitem(12127);
		}
		else {
			quest::say("The path you walk is correct, but you have further to travel before you need worry about this.");
		}
	}
}

sub EVENT_ITEM {
	#:: Turn in for 10 Gold and 12126 - Shark Bones x3
	if (plugin::takeItemsCoin(0,10,0,0, 12126 => 3)) {
		quest::say("I thank you for your ten gold coins. Now we can pay the weekly oxygen tax imposed by the militia. Here is the shark powder.");
		#:: Give item 12125 - shark Powder
		quest::summonitem(12125);
		#:: Give a small amount of xp
		quest::exp(100);
		#:: Ding!
		quest::ding();
		#:: Set factions
		quest::faction(258,5); 		#:: + Priests of Marr
		quest::faction(105,-10); 	#:: - Freeport Militia
		quest::faction(184,5); 		#:: + Knights of Truth
	}
	#:: Turn in for 13983 - Inert Potion 
	if (plugin::takeItems(13983 => 1 )) {
		quest::say("I see Tonmerk has found a use for my shark powder. We agreed to this trade when last we met. Unfortunately, I am out of it. If you desire the shark powder you will have to get me three shark bones. I wish you luck. Oh. I also require a payment of ten gold pieces. The taxes in Freeport are fierce.");
		#:: Give a small amount of xp
		quest::exp(100);
		#:: Ding!
		quest::ding();
		#:: Set factions
		quest::faction(258,5); 		#:: + Priests of Marr
		quest::faction(105,-10); 	#:: - Freeport Militia
		quest::faction(184,5); 		#:: + Knights of Truth	
	}
	#:: Turn in for 12135- Empty Potion of Marr
	if (plugin::takeItems(12135 => 1 )) {
		quest::say("The Sentries of Passion informed me of your journey to the Ocean of Tears and the demise of Sentry Xyrin. You performed beyond the call of duty. This is what makes an exceptional person. Take this for your great deed. The twin deities would wish it so.");
		#:: Give a small amount of xp
		quest::exp(1000);
		#:: Give item 15207 - Spell: Divine Aura
		quest::summonitem(15207);
		#:: Ding!
		quest::ding();
		#:: Set factions
		quest::faction(258,5); 		#:: + Priests of Marr
		quest::faction(105,-10); 	#:: - Freeport Militia
		quest::faction(184,5); 		#:: + Knights of Truth	
	}
	#:: Return unused items
	plugin::returnUnusedItems();
}
