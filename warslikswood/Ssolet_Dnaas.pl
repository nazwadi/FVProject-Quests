#:: VP Key

sub EVENT_SAY {
	if ($text=~/hail/i) {		
		if ( quest::is_content_flag_enabled("Kunark_HoleEra")) {
			quest::say("Greetingss, $name.  Unlesss you bring closssure to my ssearch, leave me while I contemplate thingss.");
		}
	}
	elsif ($text=~/search/i) {	
		if ( quest::is_content_flag_enabled("Kunark_HoleEra")) {
			quest::say("My sssearch. I have been ssent out by my massster to find an item. A burnished wooden sstaff. I know not why and I do not quessstion. I know not where thiss item is found. I musst have one though. Ssssss. If you can find one for me I will give you a trinket.");
		}
	}
}

sub EVENT_ITEM {
	if ( quest::is_content_flag_enabled("Kunark_HoleEra")) {
		#:: Match a 6353 - Burnished Wooden Stave
		if (plugin::takeItems(6353 => 1)) {
			quest::say("Sssss. Thisss is what I need. You have my thanksss. Please, take thiss. I know not what it iss for but maybe you will find a ussse for it.");
			#:: Give a 19958 - Piece of a medallion
			quest::summonitem(19958);
			#:: Ding!
			quest::ding();
			#:: Grant a moderate amount of experience
			quest::exp(1000);
		}
	}

	#:: Return unused items
	plugin::returnUnusedItems();
}
