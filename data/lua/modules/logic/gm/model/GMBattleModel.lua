module("modules.logic.gm.model.GMBattleModel", package.seeall)

slot0 = class("GMBattleModel")

function slot0.setBattleParam(slot0, slot1)
	slot0._battleParam = slot1
end

function slot0.getBattleParam(slot0)
	return slot0._battleParam
end

function slot0.setGMFightRecordEnable(slot0)
	slot0.enableGMFightRecord = true
end

function slot0.setGMFightRecord(slot0, slot1)
	slot0.fightRecordMsg = slot1
end

slot0.instance = slot0.New()

return slot0
