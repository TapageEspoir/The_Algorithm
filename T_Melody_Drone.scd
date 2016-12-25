s.waitForBoot{
	{
		SynthDef(\sineTone, {|fr=220, len=2, cut=3|Out.ar(10, BLowPass.ar(Saw.ar([fr,fr+TRand.kr(-1,1,1)],EnvGen.ar(Env.perc(0.01, len, 0.4, -16), 1, doneAction:2)), fr/cut, 0.7, 0.3))}).add;

		Ndef(\delay, {FreeVerb.ar(CombL.ar(CombL.ar(InFeedback.ar(10,2),0.26, [0.251,0.249], SinOsc.ar(0.011, 0, 3, 4)), 0.15, [0.124,0.126], SinOsc.ar(0.01, 0, 3, 4), 0.6), 0.2, 0.9)})
		.play;

		Ndef(\sineDrone1, {Out.ar(12, SinOsc.ar(LFPulse.kr(0.01, 0, 0.5, 2, 36).midicps,0,SinOsc.ar([0.03,0.0301], 0, 0.02, 0.04)))})
		.play;

		Ndef(\sineDrone2, {Out.ar(12, SinOsc.ar(LFPulse.kr(0.02, 0, 0.5, 4, 48).midicps,0,SinOsc.ar([0.0201,0.02], 0, 0.02, 0.02)))})
		.play;

		Ndef(\sineDrone3, {Out.ar(12, SinOsc.ar(LFPulse.kr(0.03, 0, 0.5, 7, 60).midicps,0,SinOsc.ar([0.002,0.001], 0, 0.01, 0.01)))})
		.play;

		Ndef(\sineDrone4, {Out.ar(12, SinOsc.ar(LFPulse.kr(0.012, 0, 0.5, 9, 72).midicps,0,SinOsc.ar([0.001,0.002], 0, 0.01, 0.01)))})
		.play;

		Ndef(\Pitcher, {FreeVerb.ar(CombL.ar(PitchShift.ar(InFeedback.ar(12,2), 0.8, TChoose.kr(Dust.kr(3), [0.333,0.5,1,1.5,2]), 0.03, 4), 48.reciprocal, 48.midicps.reciprocal, 0.2), 0.9, 0.9, 0.1)})
		.play;

		s.sync;

		~pitches = [48, 53, 55, 58, 60, 65,67, 70,72, 82, 84].midicps;
		~curPitch = [0,1];
		~newPitch = 0;

		Tdef(\repDual, {
			inf.do{|i|
				if(i%8 == 0, {
					~newPitch = Array.fill(~pitches.size, {|i|i}).choose;
					if(~newPitch == ~curPitch[0],{
						~curPitch[0] = ((~newPitch + 1)%(~pitches.size));
						~curPitch[1] = ((~curPitch[0]+1)%(~pitches.size));
						Synth(\sineTone, [\fr, ~pitches[~curPitch[i%2]], \len, rrand(0.3, 13), \cut, rrand(1.2, 3)]);
					},{
						~curPitch[0] = ~newPitch;
						~curPitch[1] = ((~curPitch[0]+1)%(~pitches.size));
						Synth(\sineTone, [\fr, ~pitches[~curPitch[i%2]], \len, rrand(0.3, 13), \cut, rrand(1.2, 3)]);
					});

				},{
					Synth(\sineTone, [\fr, ~pitches[~curPitch[i%2]], \len, rrand(0.3, 13), \cut, rrand(1.2, 3)]);
				});
				0.125.wait;
			};
		})
		.play;
	}.fork;
}