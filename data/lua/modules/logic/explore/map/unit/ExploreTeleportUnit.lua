module("modules.logic.explore.map.unit.ExploreTeleportUnit", package.seeall)

slot0 = class("ExploreTeleportUnit", ExploreBaseMoveUnit)

function slot0.onTriggerDone(slot0)
	uv0.super.onTriggerDone(slot0)
	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Teleport)
end

return slot0
