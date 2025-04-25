module("modules.logic.weather.defines.WeatherEnum", package.seeall)

slot0 = _M
slot0.LightMode = {
	"During",
	"Overcast",
	"Dusk",
	"Night"
}
slot0.LightModeDuring = 1
slot0.LightModeOvercast = 2
slot0.LightModeDusk = 3
slot0.LightModeNight = 4
slot0.DayTimeFireworks = 9
slot0.NightTimeFireworks = 10
slot0.EffectAudioTime = {
	[slot0.DayTimeFireworks] = 40,
	[slot0.NightTimeFireworks] = 40
}
slot0.EffectPlayAudio = {
	[slot0.DayTimeFireworks] = 20250601,
	[slot0.NightTimeFireworks] = 20250601
}
slot0.EffectStopAudio = {
	[slot0.DayTimeFireworks] = 20250602,
	[slot0.NightTimeFireworks] = 20250602
}
slot0.EffectMode = {
	"Normal",
	"Sunny",
	"Light_Rain",
	"Heavy_Rain",
	"Heavy_Rainstorm",
	"Little_Snow",
	"Heavy_Snow",
	"Heavy_Fog",
	"Normal",
	"Normal"
}
slot0.EffectAirColor = {
	{
		255,
		255,
		255,
		150
	},
	{
		47,
		112,
		212,
		94
	},
	{
		255,
		241,
		235,
		100
	},
	{
		0,
		103,
		255,
		148
	}
}
slot0.DoorLightColor = {
	{
		247,
		245,
		242,
		255
	},
	{
		184,
		186,
		188,
		255
	},
	{
		195,
		174,
		161,
		255
	},
	{
		148,
		160,
		186,
		255
	}
}
slot0.BloomFactor = 1
slot0.Percent = 1
slot0.BloomFactor2 = {
	0,
	0,
	0,
	0
}
slot0.Luminance = {
	0,
	0.223,
	0,
	0
}
slot0.FrameTintColor = {
	{
		1,
		1,
		1,
		0
	},
	{
		0.043,
		0.207,
		0.353,
		0.54
	},
	{
		0.235,
		0.196,
		0.203,
		0.54
	},
	{
		0.156,
		0.282,
		0.529,
		0.54
	}
}
slot0.FrameLumFactor = {
	0.5,
	0.77,
	0.77,
	0.77
}
slot0.HeroInFrameColor = {
	Color.New(0.74, 0.68, 0.59, 1),
	Color.New(0.51, 0.48, 0.45, 1),
	Color.New(0.44, 0.43, 0.39, 1),
	Color.New(0.41, 0.44, 0.5, 1)
}
slot0.HeroInFrameLumFactor = {
	0.25,
	0.5,
	0.5,
	0.5
}
slot0.HeroInSceneLumFactor = 0
slot0.Default = 0
slot0.Heavy_Rain = 4
slot0.Heavy_Rainstorm = 5
slot0.RainOn = {
	[slot0.Default] = 0,
	[slot0.Heavy_Rain] = 1,
	[slot0.Heavy_Rainstorm] = 1
}
slot0.RainValue = {
	[slot0.Default] = 0,
	[slot0.Heavy_Rain] = 1,
	[slot0.Heavy_Rainstorm] = 1
}
slot0.RainDistortionFactor = {
	[slot0.Default] = Vector4(0, 0, 0, 0),
	[slot0.Heavy_Rain] = Vector4(0, 1.3, 4.7, 0),
	[slot0.Heavy_Rainstorm] = Vector4(3, 1.3, 4.7, 0)
}
slot0.RainEmission = {
	[slot0.Default] = Vector4(0, 0, 0, 0),
	[slot0.Heavy_Rain] = Vector4(0, 3.5, 1.86, 0),
	[slot0.Heavy_Rainstorm] = Vector4(1.5, 3, 1.86, 0)
}
slot0.EffectTag = {
	Frame = "frame"
}

return slot0
