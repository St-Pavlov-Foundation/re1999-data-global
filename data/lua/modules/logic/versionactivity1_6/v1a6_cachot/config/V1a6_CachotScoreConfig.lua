module("modules.logic.versionactivity1_6.v1a6_cachot.config.V1a6_CachotScoreConfig", package.seeall)

slot0 = class("V1a6_CachotScoreConfig")

function slot0.init(slot0, slot1)
	slot0._scroeConfigTable = slot1
end

function slot0.getConfigList(slot0)
	return slot0._scroeConfigTable.configList
end

function slot0.getStagePartRange(slot0, slot1)
	if slot0._scroeConfigTable.configDict then
		slot2, slot3, slot4, slot5 = nil

		for slot9, slot10 in pairs(slot0._scroeConfigTable.configDict) do
			if slot1 <= slot10.score and (not slot2 or slot10.score <= slot2) then
				slot2 = slot10.score
				slot5 = slot9
			end

			if slot10.score < slot1 and (not slot3 or slot3 < slot10.score) then
				slot3 = slot10.score
				slot4 = slot9
			end
		end

		return slot4, slot5
	end
end

function slot0.getStagePartConfig(slot0, slot1)
	if slot0._scroeConfigTable and slot0._scroeConfigTable.configDict then
		return slot2[slot1]
	end
end

function slot0.getStagePartScore(slot0, slot1)
	if slot0._scroeConfigTable and slot0._scroeConfigTable.configDict and slot2[slot1] then
		return slot2[slot1].score
	end

	return 0
end

slot0.instance = slot0.New()

return slot0
