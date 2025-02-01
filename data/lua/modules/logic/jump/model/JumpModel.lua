module("modules.logic.jump.model.JumpModel", package.seeall)

slot0 = class("JumpModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._recordFarmItem = nil
	slot0.jumpFromFightScene = nil
	slot0.jumpFromFightSceneParam = nil
end

function slot0.setRecordFarmItem(slot0, slot1)
	slot0._recordFarmItem = slot1
end

function slot0.getRecordFarmItem(slot0)
	return slot0._recordFarmItem
end

function slot0.clearRecordFarmItem(slot0)
	slot0._recordFarmItem = nil
end

slot0.instance = slot0.New()

return slot0
