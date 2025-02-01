module("modules.logic.teach.model.TeachNoteModel", package.seeall)

slot0 = class("TeachNoteModel", BaseModel)

function slot0.onInit(slot0)
	slot0._topicId = 0
	slot0._topicIndex = 0
	slot0._teachNoteInfos = {}
	slot0._isJumpEnter = false
end

function slot0.reInit(slot0)
	slot0._topicId = 0
	slot0._topicIndex = 0
	slot0._teachNoteInfos = {}
	slot0._isJumpEnter = false
end

function slot0.setTeachNoticeTopicId(slot0, slot1, slot2)
	slot0._topicId = slot1
	slot0._topicIndex = slot2
end

function slot0.getTeachNoticeTopicId(slot0)
	return slot0._topicId, slot0._topicIndex
end

function slot0.getTopicLevelCos(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in pairs(TeachNoteConfig.instance:getInstructionLevelCos()) do
		if slot8.topicId == slot1 then
			table.insert(slot2, slot8)
		end
	end

	table.sort(slot2, function (slot0, slot1)
		if uv0.instance:isLevelUnlock(slot0.id) and not uv0.instance:isLevelUnlock(slot1.id) then
			return true
		elseif not slot2 and slot3 then
			return false
		end

		return slot0.id < slot1.id
	end)

	return slot2
end

function slot0.setTeachNoteInfo(slot0, slot1)
	slot0._teachNoteInfos = TeachNoteInfoMo.New()

	slot0._teachNoteInfos:init(slot1)
end

function slot0.isFinalRewardGet(slot0)
	return slot0._teachNoteInfos.getFinalReward
end

function slot0.getNewOpenIndex(slot0)
	slot1 = 0

	if #slot0:getNewOpenTopics() > 0 then
		slot1 = slot2[#slot2]
	end

	slot3 = 0

	if #slot0:getNewOpenTopicLevels(slot1) > 0 then
		for slot10, slot11 in ipairs(slot0:getTopicLevelCos(slot1)) do
			if slot11.id == slot4[#slot4] then
				slot3 = math.floor(0.5 * (slot10 - 1))
			end
		end
	end

	return slot1, slot3
end

function slot0.isEpisodeOpen(slot0, slot1)
	for slot6, slot7 in pairs(TeachNoteConfig.instance:getInstructionLevelCos()) do
		if slot7.episodeId == slot1 then
			for slot11, slot12 in pairs(slot0._teachNoteInfos.openIds) do
				if slot7.id == slot12 then
					return true
				end
			end
		end
	end

	return false
end

function slot0.isTopicNew(slot0, slot1)
	if not slot0:isTopicUnlock(slot1) then
		return false
	end

	slot2 = {}

	for slot6, slot7 in pairs(slot0._teachNoteInfos.openIds) do
		if TeachNoteConfig.instance:getInstructionLevelCO(slot7).topicId == slot1 then
			table.insert(slot2, slot7)
		end
	end

	return #slot2 < 1
end

function slot0.getNewOpenTopics(slot0)
	slot1 = {}

	for slot6, slot7 in pairs(TeachNoteConfig.instance:getInstructionTopicCos()) do
		if slot0:isTopicNew(slot7.id) then
			table.insert(slot1, slot7.id)
		end
	end

	table.sort(slot1)

	return slot1
end

function slot0.getNewOpenTopicLevels(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in pairs(slot0:getNewOpenLevels()) do
		if TeachNoteConfig.instance:getInstructionLevelCO(slot8).topicId == slot1 then
			table.insert(slot3, slot8)
		end
	end

	table.sort(slot3)

	return slot3
end

function slot0.getNewOpenLevels(slot0)
	slot1 = {}
	slot2 = TeachNoteConfig.instance:getInstructionLevelCos()

	if #slot0._teachNoteInfos.openIds == 0 then
		return slot0._teachNoteInfos.unlockIds
	else
		for slot6, slot7 in pairs(slot0._teachNoteInfos.unlockIds) do
			slot8 = false

			for slot12, slot13 in pairs(slot0._teachNoteInfos.openIds) do
				if slot7 == slot13 then
					slot8 = true
				end
			end

			if not slot8 then
				table.insert(slot1, slot7)
			end
		end
	end

	return slot1
end

function slot0.isLevelNewUnlock(slot0, slot1)
	for slot6, slot7 in pairs(slot0:getNewOpenLevels()) do
		if slot7 == slot1 then
			return true
		end
	end

	return false
end

function slot0._getUnlockLevelsByTopicId(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in pairs(slot0:getTopicLevelCos(slot1)) do
		if slot0:isLevelUnlock(slot8.id) then
			table.insert(slot2, slot8.id)
		end
	end

	return slot2
end

function slot0.isTopicRewardGet(slot0, slot1)
	for slot5, slot6 in pairs(slot0._teachNoteInfos.getRewardIds) do
		if slot6 == slot1 then
			return true
		end
	end

	return false
end

function slot0.isTopicUnlock(slot0, slot1)
	for slot6, slot7 in pairs(TeachNoteConfig.instance:getInstructionLevelCos()) do
		if slot7.topicId == slot1 and slot0:isLevelUnlock(slot7.id) then
			return true
		end
	end

	return false
end

function slot0.isRewardCouldGet(slot0, slot1)
	if not slot0:isTopicUnlock(slot1) then
		return false
	end

	if uv0.instance:getTeachNoteTopicFinishedLevelCount(slot1) == uv0.instance:getTeachNoteTopicLevelCount(slot1) and not uv0.instance:isTopicRewardGet(slot1) then
		return true
	else
		return false
	end
end

function slot0.hasRewardCouldGet(slot0)
	for slot5, slot6 in pairs(TeachNoteConfig.instance:getInstructionTopicCos()) do
		if slot0:isTopicUnlock(slot6.id) and slot0:isRewardCouldGet(slot6.id) then
			return true
		end
	end

	if slot0:isTeachNoteFinalRewardCouldGet() then
		return true
	end

	return false
end

function slot0.isLevelUnlock(slot0, slot1)
	for slot5, slot6 in pairs(slot0._teachNoteInfos.unlockIds) do
		if slot6 == slot1 then
			return true
		end
	end

	return false
end

function slot0.isTeachNoteUnlock(slot0)
	return slot0._teachNoteInfos and slot0._teachNoteInfos.unlockIds and #slot0._teachNoteInfos.unlockIds > 0 and not slot0:isFinalRewardGet()
end

function slot0.isTeachNoteLevelPass(slot0, slot1)
	return DungeonModel.instance:hasPassLevel(TeachNoteConfig.instance:getInstructionLevelCO(slot1).episodeId)
end

function slot0.getTeachNoteTopicUnlockLevelCount(slot0, slot1)
	for slot7, slot8 in pairs(slot0:getTopicLevelCos(slot1)) do
		if slot0:isLevelUnlock(slot8.id) then
			slot2 = 0 + 1
		end
	end

	return slot2
end

function slot0.getTeachNoteTopicFinishedLevelCount(slot0, slot1)
	for slot7, slot8 in pairs(slot0:getTopicLevelCos(slot1)) do
		if slot0:isTeachNoteLevelPass(slot8.id) then
			slot2 = 0 + 1
		end
	end

	return slot2
end

function slot0.getTeachNoteTopicLevelCount(slot0, slot1)
	return #slot0:getTopicLevelCos(slot1)
end

function slot0.isTeachNoteChapter(slot0, slot1)
	for slot6, slot7 in pairs(TeachNoteConfig.instance:getInstructionTopicCos()) do
		if slot7.chapterId == slot1 then
			return true
		end
	end

	return false
end

function slot0.isTeachNoteEpisode(slot0, slot1)
	for slot6, slot7 in pairs(TeachNoteConfig.instance:getInstructionLevelCos()) do
		if slot7.episodeId == slot1 then
			return true
		end
	end

	return false
end

function slot0.getTeachNoteInstructionLevelCo(slot0, slot1)
	for slot6, slot7 in pairs(TeachNoteConfig.instance:getInstructionLevelCos()) do
		if slot7.episodeId == slot1 then
			return slot7
		end
	end

	return slot2[101]
end

function slot0.getTeachNoteEpisodeTopicId(slot0, slot1)
	for slot6, slot7 in pairs(TeachNoteConfig.instance:getInstructionLevelCos()) do
		if slot7.episodeId == slot1 then
			return slot7.topicId
		end
	end

	return 1
end

function slot0.isTeachNoteFinalRewardCouldGet(slot0)
	for slot5, slot6 in pairs(TeachNoteConfig.instance:getInstructionTopicCos()) do
		if not slot0:isTopicRewardGet(slot6.id) then
			return false
		end
	end

	return not slot0:isFinalRewardGet()
end

function slot0.isTeachNoteEnterFight(slot0)
	return slot0._isTeachEnter
end

function slot0.setTeachNoteEnterFight(slot0, slot1, slot2)
	slot0._isTeachEnter = slot1
	slot0._isDetailEnter = slot2
end

function slot0.isFinishLevelEnterFight(slot0)
	return slot0._isFinishedEnter
end

function slot0.isDetailEnter(slot0)
	return slot0._isDetailEnter
end

function slot0.setLevelEnterFightState(slot0, slot1)
	slot0._isFinishedEnter = slot1
end

function slot0.isJumpEnter(slot0)
	return slot0._isJumpEnter
end

function slot0.setJumpEnter(slot0, slot1)
	slot0._isJumpEnter = slot1
end

function slot0.setJumpEpisodeId(slot0, slot1)
	slot0._jumpEpisodeId = slot1
end

function slot0.getJumpEpisodeId(slot0)
	return slot0._jumpEpisodeId
end

slot0.instance = slot0.New()

return slot0
