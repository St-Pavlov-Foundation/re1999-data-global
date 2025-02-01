module("modules.logic.teach.model.TeachNoteInfoMo", package.seeall)

slot0 = pureTable("TeachNoteInfoMo")

function slot0.ctor(slot0)
	slot0.unlockIds = {}
	slot0.getRewardIds = {}
	slot0.getFinalReward = false
	slot0.openIds = {}
end

function slot0.init(slot0, slot1)
	slot0:update(slot1)
end

function slot0.update(slot0, slot1)
	slot0.unlockIds = slot0:_getUnlockTopicIds(slot1.unlockIds)
	slot0.getRewardIds = slot1.getRewardIds
	slot0.getFinalReward = slot1.getFinalReward
	slot0.openIds = slot0:_getUnlockTopicIds(slot1.openIds)
end

function slot0._getUnlockTopicIds(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		for slot12, slot13 in pairs(TeachNoteConfig.instance:getInstructionLevelCos()) do
			if slot7 == slot13.episodeId then
				table.insert(slot2, slot13.id)
			end
		end
	end

	return slot2
end

return slot0
