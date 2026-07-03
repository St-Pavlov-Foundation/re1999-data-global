-- chunkname: @modules/logic/abyss/define/AbyssEnum.lua

module("modules.logic.abyss.define.AbyssEnum", package.seeall)

local AbyssEnum = _M

AbyssEnum.MaxTaskStar = 1
AbyssEnum.ConstId = {
	ActId = 2,
	TargetBonus = 1
}
AbyssEnum.UIBlockKey = {
	EnterView = "AbyssEnterViewBlock",
	MainView = "AbyssMainViewBlock"
}
AbyssEnum.ViewOutTime = {
	EnterView = 0.33,
	MainView = 0.167
}

return AbyssEnum
