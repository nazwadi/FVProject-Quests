sub EVENT_SAY {
	if ($text=~/hail/i) {
		quest::say(""Huh? Oh hi $name. Youse want to buy sumthin?");
	}
}
