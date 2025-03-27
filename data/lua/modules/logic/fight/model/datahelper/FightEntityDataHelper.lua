module("modules.logic.fight.model.datahelper.FightEntityDataHelper", package.seeall)

slot1 = {
	class = true
}

return {
	isPlayerUid = function (slot0)
		return slot0 == FightEntityScene.MySideId or slot0 == FightEntityScene.EnemySideId
	end,
	isNotPlayerUid = function (slot0)
		return slot0 ~= FightEntityScene.MySideId and slot0 ~= FightEntityScene.EnemySideId
	end,
	copyEntityMO = function (slot0, slot1)
		FightDataHelper.coverData(slot0, slot1, uv0)
	end,
	sortSubEntityList = function (slot0, slot1)
		return slot1.position < slot0.position
	end
}
