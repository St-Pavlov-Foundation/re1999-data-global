module("modules.logic.versionactivity1_6.dungeon.view.map.V1a6_HeroGroupFightLayoutView", package.seeall)

local var_0_0 = class("V1a6_HeroGroupFightLayoutView", HeroGroupFightLayoutView)

function var_0_0.checkNeedSetOffset(arg_1_0)
	return (OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101))
end

return var_0_0
