module("modules.logic.versionactivity2_5.challenge.model.Act183GroupEpisodeMO", package.seeall)

slot0 = pureTable("Act183GroupEpisodeMO")

function slot0.init(slot0, slot1)
	slot0._groupId = slot1.groupId
	slot0._finished = slot1.finished

	slot0:_onGetEpisodeList(slot1.episodeList)
end

function slot0._onGetEpisodeList(slot0, slot1)
	slot0._episodeList = {}
	slot0._episodeMap = {}
	slot0._bossPassCount = 0
	slot0._episodeFinishCount = 0

	for slot5, slot6 in ipairs(slot1) do
		slot7 = Act183EpisodeMO.New()

		slot7:init(slot6)
		table.insert(slot0._episodeList, slot7)

		slot0._episodeMap[slot7:getEpisodeId()] = slot7
	end

	slot0._groupType = slot0._episodeList[1] and slot2:getGroupType()
	slot0._episodeCount = slot0._episodeList and #slot0._episodeList or 0
end

function slot0.isHasFinished(slot0)
	return slot0._finished
end

function slot0.getEpisodeMos(slot0)
	return slot0._episodeList
end

function slot0.getGroupId(slot0)
	return slot0._groupId
end

function slot0.getGroupType(slot0)
	return slot0._groupType
end

function slot0.getStatus(slot0)
	slot1 = Act183Enum.GroupStatus.Locked

	if slot0._groupType == Act183Enum.GroupType.Daily then
		if not slot0:getUnlockRemainTime() or slot2 <= 0 then
			slot1 = Act183Enum.GroupStatus.Unlocked
		end
	elseif slot0._groupType == Act183Enum.GroupType.NormalMain then
		slot1 = slot0:isGroupFinished() and Act183Enum.GroupStatus.Finished or Act183Enum.GroupStatus.Unlocked
	elseif slot0._groupType == Act183Enum.GroupType.HardMain then
		slot4 = Act183Model.instance:getActInfo():getGroupEpisodeMos(Act183Enum.GroupType.NormalMain) and slot3[1]

		if slot4 and slot4:isHasFinished() then
			slot1 = slot0:isGroupFinished() and Act183Enum.GroupStatus.Finished or Act183Enum.GroupStatus.Unlocked
		end
	end

	return slot1
end

function slot0.isGroupFinished(slot0)
	return slot0._episodeCount <= (slot0:getStatusEpisodes(Act183Enum.GroupStatus.Finished) and #slot1 or 0)
end

function slot0.getUnlockRemainTime(slot0)
	return Act183Helper.getDailyGroupEpisodeUnlockRemainTime(slot0._groupId) or 0
end

function slot0.getEpisodeCount(slot0)
	return slot0._episodeCount
end

function slot0.getEpisodeFinishCount(slot0)
	return slot0:getStatusEpisodes(Act183Enum.EpisodeStatus.Finished) and #slot1 or 0
end

function slot0.isAllSubEpisodeFinished(slot0)
	for slot4, slot5 in ipairs(slot0._episodeList) do
		if slot5:getEpisodeType() == Act183Enum.EpisodeType.Sub and slot5:getStatus() ~= Act183Enum.EpisodeStatus.Finished then
			return false
		end
	end

	return true
end

function slot0.getTotalAndPassConditionIds(slot0, slot1)
	slot4 = {
		slot0:getEpisodeMo(slot1)
	}

	tabletool.addValues(slot4, slot0:getPreEpisodeMos(slot1))
	table.sort(slot4, slot0._sortEpisodeByPassOrder)

	slot5 = {}
	slot6 = {}

	for slot10, slot11 in ipairs(slot4) do
		tabletool.addValues(slot5, slot11:getConditionIds())
		tabletool.addValues(slot6, slot11:getPassConditions())
	end

	return slot5, slot6
end

function slot0.getEpisodeListByPassOrder(slot0)
	slot1 = tabletool.copy(slot0._episodeList)

	table.sort(slot1, slot0._sortEpisodeByPassOrder)

	return slot1
end

function slot0._sortEpisodeByPassOrder(slot0, slot1)
	if slot0:isFinished() ~= slot1:isFinished() then
		return slot2
	end

	if slot0:getPassOrder() ~= slot1:getPassOrder() then
		return slot4 < slot5
	end

	if slot0:getConfig().order ~= slot1:getConfig().order then
		return slot8 < slot9
	end

	return slot0:getEpisodeId() < slot1:getEpisodeId()
end

function slot0.isConditionPass(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._episodeList) do
		if slot6:isConditionPass(slot1) then
			return true
		end
	end
end

function slot0.getPreEpisodeMos(slot0, slot1)
	slot3 = {}

	if slot0:getEpisodeMo(slot1) and slot2:getPreEpisodeIds() then
		for slot8, slot9 in ipairs(slot4) do
			table.insert(slot3, slot0:getEpisodeMo(slot9))
		end
	end

	return slot3
end

function slot0.getConditionFinishCount(slot0)
	for slot5, slot6 in ipairs(slot0._episodeList) do
		slot1 = 0 + (slot6:getPassConditions() and #slot7 or 0)
	end

	return slot1
end

function slot0.getBossEpisodePassCount(slot0)
	for slot5, slot6 in ipairs(slot0._episodeList) do
		if slot6:getEpisodeType() == Act183Enum.EpisodeType.Boss and slot6:getStatus() == Act183Enum.EpisodeStatus.Finished then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.getEpisodeMo(slot0, slot1)
	return slot0._episodeMap[slot1]
end

function slot0.getEscapeRules(slot0, slot1)
	if not slot0:getEpisodeMo(slot1) then
		return
	end

	slot3 = {}

	for slot8, slot9 in ipairs(slot0:getEpisodeListByPassOrder()) do
		if not slot9:isFinished() then
			break
		end

		if slot9:getEpisodeId() == slot2:getEpisodeId() then
			break
		end

		if slot9:getEscapeRules() and #slot10 > 0 then
			for slot14, slot15 in ipairs(slot10) do
				if not string.nilorempty(slot15) then
					table.insert(slot3, {
						episodeId = slot9:getEpisodeId(),
						ruleDesc = slot15,
						ruleIndex = slot14,
						passOrder = slot9:getPassOrder()
					})
				end
			end
		end
	end

	return slot3
end

function slot0.isEpisodeCanRestart(slot0, slot1)
	if not slot0:getEpisodeMo(slot1) then
		return
	end

	slot3 = slot2:isFinished()

	if slot2:getEpisodeType() == Act183Enum.EpisodeType.Boss and slot3 then
		return true
	end

	return slot3 and slot2:getPassOrder() == slot0:findMaxPassOrder()
end

function slot0.isEpisodeCanReset(slot0, slot1)
	if not slot0:getEpisodeMo(slot1) then
		return
	end

	if slot2:getEpisodeType() == Act183Enum.EpisodeType.Boss then
		return
	end

	return slot2:getStatus() == Act183Enum.EpisodeStatus.Finished and slot2:getPassOrder() < slot0:findMaxPassOrder()
end

function slot0.isCanStart(slot0, slot1)
	if not slot0:getEpisodeMo(slot1) then
		return
	end

	if slot2:getStatus() ~= Act183Enum.EpisodeStatus.Unlocked then
		return
	end

	if slot2:getEpisodeType() == Act183Enum.EpisodeType.Sub then
		return true
	elseif slot4 == Act183Enum.EpisodeType.Boss then
		return slot0:isAllSubEpisodeFinished()
	end
end

function slot0.isEpisodeCanReRepress(slot0, slot1)
	if not slot0:getEpisodeMo(slot1) then
		return
	end

	if slot2:getEpisodeType() == Act183Enum.EpisodeType.Boss then
		return
	end

	return slot2:isFinished() and slot2:getPassOrder() == slot0:findMaxPassOrder() and not Act183Helper.isLastPassEpisodeInType(slot2)
end

function slot0.isHeroRepress(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0._episodeList) do
		if slot7:isHeroRepress(slot1) and (not slot2 or slot2 == slot7:getEpisodeId()) then
			return true
		end
	end

	return false
end

function slot0.findMaxPassOrder(slot0)
	for slot5, slot6 in ipairs(slot0._episodeList) do
		if slot6:isFinished() and 0 < slot6:getPassOrder() then
			slot1 = slot8
		end
	end

	return slot1
end

function slot0.isHeroRepressInPreEpisode(slot0, slot1, slot2)
	slot3 = slot0:getEpisodeMo(slot1)

	for slot9, slot10 in ipairs(slot0._episodeList) do
		if slot10:isFinished() and (not slot3:isFinished() or slot10:getPassOrder() < slot3:getPassOrder()) and slot10:isHeroRepress(slot2) then
			return true
		end
	end

	return false
end

function slot0.getStatusEpisodes(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0._episodeList) do
		if slot1 == slot7:getStatus() then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

return slot0
