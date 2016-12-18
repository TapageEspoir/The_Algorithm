s.waitForBoot{
	{
		{SinOsc.ar([50,51], 0, 0.3)}.play;

	}.fork;
}
