module("modules.logic.explore.map.unit.ExploreTeleportUnit", package.seeall)

local var_0_0 = class("ExploreTeleportUnit", ExploreBaseMoveUnit)

function var_0_0.onTriggerDone(arg_1_0)
	var_0_0.super.onTriggerDone(arg_1_0)
	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Teleport)
end

return var_0_0
