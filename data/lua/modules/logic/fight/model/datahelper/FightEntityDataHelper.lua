module("modules.logic.fight.model.datahelper.FightEntityDataHelper", package.seeall)

slot1 = {
	class = true
}

return {
	copyEntityMO = function (slot0, slot1)
		FightDataHelper.coverData(slot0, slot1, uv0)
	end,
	sortSubEntityList = function (slot0, slot1)
		return slot1.position < slot0.position
	end
}
