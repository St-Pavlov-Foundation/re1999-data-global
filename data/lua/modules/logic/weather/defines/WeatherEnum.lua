module("modules.logic.weather.defines.WeatherEnum", package.seeall)

local var_0_0 = _M

var_0_0.LightMode = {
	"During",
	"Overcast",
	"Dusk",
	"Night"
}
var_0_0.LightModeDuring = 1
var_0_0.LightModeOvercast = 2
var_0_0.LightModeDusk = 3
var_0_0.LightModeNight = 4
var_0_0.DayTimeFireworks = 9
var_0_0.NightTimeFireworks = 10
var_0_0.EffectAudioTime = {
	[var_0_0.DayTimeFireworks] = 40,
	[var_0_0.NightTimeFireworks] = 40
}
var_0_0.EffectPlayAudio = {
	[var_0_0.DayTimeFireworks] = 20250601,
	[var_0_0.NightTimeFireworks] = 20250601
}
var_0_0.EffectStopAudio = {
	[var_0_0.DayTimeFireworks] = 20250602,
	[var_0_0.NightTimeFireworks] = 20250602
}
var_0_0.EffectMode = {
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
var_0_0.EffectAirColor = {
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
var_0_0.DoorLightColor = {
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
var_0_0.BloomFactor = 1
var_0_0.Percent = 1
var_0_0.BloomFactor2 = {
	0,
	0,
	0,
	0
}
var_0_0.Luminance = {
	0,
	0.223,
	0,
	0
}
var_0_0.FrameTintColor = {
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
var_0_0.FrameLumFactor = {
	0.5,
	0.77,
	0.77,
	0.77
}
var_0_0.HeroInFrameColor = {
	Color.New(0.74, 0.68, 0.59, 1),
	Color.New(0.51, 0.48, 0.45, 1),
	Color.New(0.44, 0.43, 0.39, 1),
	Color.New(0.41, 0.44, 0.5, 1)
}
var_0_0.HeroInFrameLumFactor = {
	0.25,
	0.5,
	0.5,
	0.5
}
var_0_0.HeroInSceneLumFactor = 0
var_0_0.Default = 0
var_0_0.Heavy_Rain = 4
var_0_0.Heavy_Rainstorm = 5
var_0_0.RainOn = {
	[var_0_0.Default] = 0,
	[var_0_0.Heavy_Rain] = 1,
	[var_0_0.Heavy_Rainstorm] = 1
}
var_0_0.RainValue = {
	[var_0_0.Default] = 0,
	[var_0_0.Heavy_Rain] = 1,
	[var_0_0.Heavy_Rainstorm] = 1
}
var_0_0.RainDistortionFactor = {
	[var_0_0.Default] = Vector4(0, 0, 0, 0),
	[var_0_0.Heavy_Rain] = Vector4(0, 1.3, 4.7, 0),
	[var_0_0.Heavy_Rainstorm] = Vector4(3, 1.3, 4.7, 0)
}
var_0_0.RainEmission = {
	[var_0_0.Default] = Vector4(0, 0, 0, 0),
	[var_0_0.Heavy_Rain] = Vector4(0, 3.5, 1.86, 0),
	[var_0_0.Heavy_Rainstorm] = Vector4(1.5, 3, 1.86, 0)
}
var_0_0.EffectTag = {
	Frame = "frame"
}

return var_0_0
