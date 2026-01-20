-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/map/V1a6_HeroGroupFightLayoutView.lua

module("modules.logic.versionactivity1_6.dungeon.view.map.V1a6_HeroGroupFightLayoutView", package.seeall)

local V1a6_HeroGroupFightLayoutView = class("V1a6_HeroGroupFightLayoutView", HeroGroupFightLayoutView)

function V1a6_HeroGroupFightLayoutView:checkNeedSetOffset()
	local isAct148Unlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101)

	return isAct148Unlock
end

return V1a6_HeroGroupFightLayoutView
