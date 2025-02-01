module("modules.logic.rouge.dlc.101.model.rpcmo.RougeMapSkillMO", package.seeall)

slot0 = pureTable("RougeMapSkillMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.useCount = slot1.useCount
	slot0.stepRecord = slot1.stepRecord
end

function slot0.getUseCount(slot0)
	return slot0.useCount
end

function slot0.getStepRecord(slot0)
	return slot0.stepRecord
end

return slot0
