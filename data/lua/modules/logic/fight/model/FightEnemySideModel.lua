module("modules.logic.fight.model.FightEnemySideModel", package.seeall)

slot0 = class("FightEnemySideModel", BaseModel)

function slot0.getList(slot0)
	table.sort(slot0._list, FightHelper.sortAssembledMonsterFunc)

	return slot0._list
end

return slot0
