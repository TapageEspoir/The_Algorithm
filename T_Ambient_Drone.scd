Server.default.options.memSize = 1024000;
s.waitForBoot{
	{
		~buf = Buffer.alloc(s, s.sampleRate, 1);
		~buff = Buffer.alloc(s, s.sampleRate*4, 1);
		s.sync;
		//Ndef(\drone).fadeTime_(10);
		Ndef(\drone, {RecordBuf.ar(LeakDC.ar(FreeVerb.ar(CombL.ar(GVerb.ar(PitchShift.ar(PitchShift.ar(DynKlank.ar(`[[25, 100, 200, 600, 1200, 3000, 8000],[0.2, 0.001, 0.2, 0.5, 0.3, 0.6, 0.3],[3, 0.2, 0.03, 0.4, 0.5, 2, 6]],LeakDC.ar(BLowPass.ar(BHiPass.ar(PinkNoise.ar(SinOsc.ar(0.02, 0, 0.001, 0.002)),80))), 2), 0.6, TChoose.kr(Dust.kr(22),[0.5,1,1.5,2,3,4,6,12])!2, 0, 1.5), 0.5, 0.25, 0, 2), 120, 6).sum, 0.2, 300.reciprocal, 0.01).tanh*PitchShift.ar(CombL.ar(BLowPass.ar(SinOsc.ar(6.125),130),0.1, 2000.reciprocal, 14, 0.14),0.5, 1, 0, 2.4), 0.9, 0.9, 0.1, 5).sum).tanh, ~buf.bufnum, 0,1,0,1,1,1); Silent.ar()})
		.play;

		Ndef(\grainedDrone, {RecordBuf.ar(LeakDC.ar(BLowPass.ar(FreeVerb.ar(DynKlank.ar(`[[50, 100, 200, 600, 1200, 3000, 4000],[0.02, 0.001, 0.2, 0.05, 0.3, 0.16, 0.003],[0.3, 0.2, 0.03, 0.04, 0.005, 0.02, 0.6]],TGrains.ar(2, Dust.kr([8.9,9]), ~buf.bufnum, 1, 0.5, 0.4, LFDNoise3.ar([6,6.1], 0.5), 0.01, 4))*0.2, 0.9), 2800, 0.4, 0.2)).tanh.sum.sum, ~buff.bufnum, 0,1,0,1,1,1); Silent.ar()})
		.play;

		Ndef(\doubleGrainedDrone, {GVerb.ar(PitchShift.ar(CombL.ar(PlayBuf.ar(1, ~buff.bufnum, TChoose.kr(Dust.kr(2),[0.25, 0.5, 1]).lag(0.0003)!2, Impulse.ar(2), 0).sum*EnvGen.ar(Env.sine(0.3, 1), Impulse.ar(2)),0.1, 100.reciprocal, 0.00012, 2), 0.4, 1, 0, 2), 120, 80, 0.2, 0.1, 80, 0, mul:0.2)})
		.play;

		//Ndef(\doubleGrainedDrone).stop(10)

	}.fork;
}

