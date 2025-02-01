module("modules.common.gc.GameGCEvent", package.seeall)

return {
	FullGC = 1,
	DelayFullGC = 2,
	ResGC = 3,
	CancelDelayFullGC = 4,
	StoryGC = 5,
	AudioGC = 6,
	DelayAudioGC = 7,
	CancelDelayAudioGC = 8,
	OnFullGC = 11
}
