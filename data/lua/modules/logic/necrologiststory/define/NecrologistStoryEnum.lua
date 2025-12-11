module("modules.logic.necrologiststory.define.NecrologistStoryEnum", package.seeall)

local var_0_0 = _M

var_0_0.RoleStoryId = {
	V3A1 = 26
}
var_0_0.RoleStoryId2MOCls = {
	[var_0_0.RoleStoryId.V3A1] = "NecrologistV3A1MO"
}
var_0_0.StoryId2GameView = {
	[var_0_0.RoleStoryId.V3A1] = ViewName.V3A1_RoleStoryGameView
}
var_0_0.Pivot = {
	Left = Vector2(0, 1),
	Right = Vector2(1, 1),
	Down = Vector2(1, 0)
}
var_0_0.DefaultInterval = 50
var_0_0.BottomMargin = 50
var_0_0.StoryState = {
	Finish = 4,
	Reading = 2,
	Lock = 1,
	Normal = 3
}
var_0_0.StoryControlType = {
	StoryPic = 1,
	Effect = 4,
	Audio = 3,
	Magic = 5,
	ErasePic = 6,
	DragPic = 7,
	StopAudio = 8,
	Bgm = 2
}
var_0_0.GameState = {
	Win = 3,
	Fail = 2,
	Normal = 1
}
var_0_0.BaseType = {
	InteractiveBase = 3,
	SmallBase = 2,
	BigBase = 1
}
var_0_0.WeatherType = {
	Cloudy = 3,
	Light = 7,
	Snowy = 5,
	Flow = 6,
	Fog = 2,
	Rainy = 4,
	Sunny = 1
}
var_0_0.WeatherType2Name = {
	[var_0_0.WeatherType.Sunny] = "sun",
	[var_0_0.WeatherType.Fog] = "fog",
	[var_0_0.WeatherType.Cloudy] = "cloudy",
	[var_0_0.WeatherType.Rainy] = "rain",
	[var_0_0.WeatherType.Snowy] = "snow",
	[var_0_0.WeatherType.Flow] = "flow",
	[var_0_0.WeatherType.Light] = "light"
}
var_0_0.NeedDelayType = {
	options = 4,
	aside = 2,
	location = 3,
	dialog = 1
}
var_0_0.NeedDelayControlType = {
	[var_0_0.StoryControlType.Magic] = 1,
	[var_0_0.StoryControlType.ErasePic] = 2,
	[var_0_0.StoryControlType.DragPic] = 3
}

return var_0_0
