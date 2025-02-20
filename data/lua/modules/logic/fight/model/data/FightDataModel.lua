module("modules.logic.fight.model.data.FightDataModel", package.seeall)

slot0 = class("FightDataModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.initDouQuQu(slot0)
	slot0.douQuQuMgr = FightDouQuQuDataMgr.New()

	return slot0.douQuQuMgr
end

slot0.instance = slot0.New()

return slot0
