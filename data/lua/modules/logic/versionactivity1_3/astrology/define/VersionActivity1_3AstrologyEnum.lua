module("modules.logic.versionactivity1_3.astrology.define.VersionActivity1_3AstrologyEnum", package.seeall)

local var_0_0 = _M

var_0_0.Planet = {
	muxing = 6,
	huoxing = 5,
	tuxing = 7,
	shuixing = 2,
	taiyang = 1,
	jinxing = 3,
	yueliang = 4
}
var_0_0.PlanetItem = {
	[var_0_0.Planet.shuixing] = 970004,
	[var_0_0.Planet.jinxing] = 970005,
	[var_0_0.Planet.yueliang] = 970006,
	[var_0_0.Planet.huoxing] = 970007,
	[var_0_0.Planet.muxing] = 970008,
	[var_0_0.Planet.tuxing] = 970009
}
var_0_0.TipPos = {
	{
		-130,
		280
	},
	{
		25,
		275
	},
	{
		-210,
		245
	}
}
var_0_0.PlanetOffsetX = -779
var_0_0.PlanetOffsetY = -152
var_0_0.Angle = 60
var_0_0.MaxStarNum = 10

return var_0_0
