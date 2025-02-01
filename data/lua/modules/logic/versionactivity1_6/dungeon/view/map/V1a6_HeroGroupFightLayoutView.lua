module("modules.logic.versionactivity1_6.dungeon.view.map.V1a6_HeroGroupFightLayoutView", package.seeall)

slot0 = class("V1a6_HeroGroupFightLayoutView", HeroGroupFightLayoutView)

function slot0.checkNeedSetOffset(slot0)
	return OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101)
end

return slot0
