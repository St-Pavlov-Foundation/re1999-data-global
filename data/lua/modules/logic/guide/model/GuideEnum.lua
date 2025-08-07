module("modules.logic.guide.model.GuideEnum", package.seeall)

local var_0_0 = _M

var_0_0.uiTypeCircle = 1
var_0_0.uiTypeRectangle = 2
var_0_0.uiTypeNoHole = 3
var_0_0.uiTypeDragCard = 4
var_0_0.uiTypeArrow = 5
var_0_0.uiTypePressArrow = 6
var_0_0.uiTypeDragCard2 = 7
var_0_0.uiTypeMaxCount = 7
var_0_0.ArrowRotation = {
	160,
	0,
	-110,
	70
}
var_0_0.GuideIconWithCn = {
	true,
	true,
	nil,
	nil,
	nil,
	true,
	true,
	true
}
var_0_0.SpecialEventEnum = {
	SummonDraw = 6,
	SummonFog = 2,
	SummonWheel = 3,
	FightCardOp = 7,
	SummonTouch = 4,
	SummonOpen = 1,
	SummonTurn = 5
}
var_0_0.RoomStrengthenGuideId = 168
var_0_0.VerticalDrawingSwitchingGuide = 135
var_0_0.GuideRoom = {
	TaskGuideID = 401
}
var_0_0.GuideId = {
	RoomCritterTrain = 415,
	Act157FactoryUnlock = 18103,
	WeekWalkDeep = 506,
	RoomDailyOrder = 418
}
var_0_0.EventTrigger = {
	Act178FoodNotEnough = 2,
	MusicFreeView = 1,
	FightItemPlayerSkillGroup = 3
}

return var_0_0
