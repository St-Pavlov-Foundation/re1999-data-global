module("modules.logic.toughbattle.define.ToughBattleEnum", package.seeall)

local var_0_0 = _M

var_0_0.Mode = {
	Act = 2,
	Story = 1
}
var_0_0.HeroType = {
	Skill = 3,
	Hero = 1,
	Rule = 2
}
var_0_0.MapId_stage1 = 10731
var_0_0.MapId_stage2 = 10732
var_0_0.TicketConstId = 2
var_0_0.HoldTicketMaxLimitConstId = 4
var_0_0.DungeonMapCameraSize = 6.6
var_0_0.MapId_7_28 = 10728
var_0_0.ActElementId = 100709
var_0_0.FinishIconPos = {
	Vector2.New(37.7, -19.76),
	Vector2.New(48.75, -24.42),
	Vector2.New(42.58, -19.16),
	Vector2.New(34.11, -24.03),
	(Vector2.New(48.37, -17.84))
}
var_0_0.WordInterval = 3.5
var_0_0.WordTxtPosYOffset = 5
var_0_0.WordTxtPosXOffset = 2
var_0_0.WordTxtInterval = 0.2
var_0_0.WordTxtOpen = 0.7
var_0_0.WordTxtIdle = 1.1
var_0_0.WordTxtClose = 0.5
var_0_0.WordLine2Delay = 1
var_0_0.WordPlace = {
	{
		x = -600,
		y = -50
	},
	{
		x = 420,
		y = -120
	},
	{
		x = 500,
		y = 20
	},
	{
		x = 400,
		y = 150
	},
	{
		x = 360,
		y = 350
	},
	{
		x = -800,
		y = -200
	},
	{
		x = -500,
		y = -350
	},
	{
		x = -100,
		y = 400
	}
}

return var_0_0
