sub EVENT_SAY {
	if ($text=~/hail/i) {
		quest::say("Greetings. I would love to chat with you, but I just realized something.. I do not waste time with whelps.");
	}
	elsif ($text=~/lens/i) {
		quest::say("So you seek the Spare Lens. Yes. I have it. There are only two ways you can obtain it, [" . quest::saylink("fight") . "] the great Zenita or [" . quest::saylink("play a game of chance") . "].");
	}
	elsif ($text=~/play a game of chance/i) {
		quest::say("Great. It is rather simple. I have five cards and only one is King Naythox. Find it. In order to get one card all you need to do is buy me a bottle of Innoruuks Kiss of Death from the barkeep in Chops N Hops. One bottle for one card. Return the King Naythox card to me and you shall get the Spare Lens.");
	}
	elsif ($text=~/fight/i) {
		quest::say("Darn!! I was hoping not to hear that word, 'fight'. Oh well.");
		quest::attack($name);
	}
}

sub EVENT_ITEM {
	#:: Match a 22298 -  King Card
	if (plugin::takeItems(22298 => 1)) {
		quest::say("Why I will be.. You got it!! I thought I took it out of the deck. Very well. You win the Spare Lens fair and square. Here you are. Now get out of my sight.");
		#:: Give item 13279 - Telescope Lens (Phiz's Lens)
		quest::summonitem(13279);
		#:: Ding!
		quest::ding();
		#:: Give a small amount of xp
		quest::exp(500);
	}
	#:: Match a 13121 -  Innoruuk's Kiss of Death
	elsif (plugin::takeItems(13121 => 1)) {
		quest::say("Let see what card you pulled.");
		#:: Give item random playing card
		quest::summonitem(quest::ChooseRandom(22293,22294,22295,22296,22297,22298,22299));
	}
	#:: Turn in for Any Card aside from King or Joker 
	elsif ((plugin::takeItems(22299 => 1)) || (plugin::takeItems(22297 => 1)) || (plugin::takeItems(22296 => 1)) || (plugin::takeItems(22294 => 1)) || (plugin::takeItems(22293 => 1))) {
		quest::say("Bad luck must be one of your strong suits. You should have been a beggar because you sure aren't a very good $class. You lose! $name");
	}
	#:: Match a 22295 - Joker Card
	elsif (plugin::takeItems(22295 => 1)) {
		quest::say("I see you have drawn the card that best represents a $class such as yourself. You lose! $name");
	}
	#:: Return unused items
	plugin::returnUnusedItems();
}
