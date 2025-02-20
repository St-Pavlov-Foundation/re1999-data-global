module("modules.logic.versionactivity2_1.aergusi.model.AergusiModel", package.seeall)

slot0 = class("AergusiModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._episodeInfos = {}
	slot0._evidenceDicts = {}
	slot0._curEpisodeId = 0
	slot0._curClueId = 0
	slot0._readClueList = {}
	slot0._unlockProcess = {
		0,
		0
	}
end

function slot0.setEpisodeInfos(slot0, slot1)
	slot0._episodeInfos = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = AergusiEpisodeMo.New()

		slot7:init(slot6)

		slot0._episodeInfos[slot6.episodeId] = slot7
	end
end

function slot0.getEpisodeInfo(slot0, slot1)
	return slot0._episodeInfos[slot1]
end

function slot0.getEpisodeInfos(slot0)
	function (slot0)
		slot1 = AergusiConfig.instance:getEpisodeConfigs()
		slot5 = slot1[slot0]

		table.insert(uv0, slot5)

		for slot5, slot6 in pairs(slot1) do
			if slot6.preEpisodeId == slot0 then
				return uv1(slot6.episodeId)
			end
		end
	end(slot0:getFirstEpisode())

	return {}
end

function slot0.getMaxUnlockEpisodeIndex(slot0)
	for slot5 = 1, #slot0:getEpisodeInfos() do
		if not slot0:isEpisodeUnlock(slot1[slot5].episodeId) and slot0:isEpisodeUnlock(slot1[slot5].preEpisodeId) then
			return slot5 - 1
		end
	end

	return #slot1
end

function slot0.getFirstEpisode(slot0)
	for slot5, slot6 in pairs(AergusiConfig.instance:getEpisodeConfigs()) do
		if slot6.preEpisodeId == 0 then
			return slot6.episodeId
		end
	end

	return 0
end

function slot0.getEpisodeNextEpisode(slot0, slot1)
	for slot6, slot7 in pairs(AergusiConfig.instance:getEpisodeConfigs()) do
		if slot7.preEpisodeId == slot1 then
			return slot7.episodeId
		end
	end

	return 0
end

function slot0.getEpisodeIndex(slot0, slot1)
	for slot6 = 1, #slot0:getEpisodeInfos() do
		if slot2[slot6].episodeId == slot1 then
			return slot6
		end
	end

	return 0
end

function slot0.getNewFinishEpisode(slot0)
	return slot0._newFinishEpisode or -1
end

function slot0.setNewFinishEpisode(slot0, slot1)
	slot0._newFinishEpisode = slot1
end

function slot0.getNewUnlockEpisode(slot0)
	return slot0._newUnlockEpisode or -1
end

function slot0.setNewUnlockEpisode(slot0, slot1)
	slot0._newUnlockEpisode = slot1
end

function slot0.isStoryEpisode(slot0, slot1)
	return AergusiConfig.instance:getEpisodeConfig(nil, slot1).evidenceId == ""
end

function slot0.getMaxPassedEpisode(slot0)
	slot2 = 0

	for slot6, slot7 in pairs(AergusiConfig.instance:getEpisodeConfigs()) do
		if slot7.preEpisodeId > 0 and slot0:isEpisodePassed(slot7.preEpisodeId) then
			if not slot0:isEpisodePassed(slot7.episodeId) then
				return slot7.preEpisodeId
			else
				slot2 = slot7.episodeId
			end
		end
	end

	return slot2
end

function slot0.setCurEpisode(slot0, slot1)
	slot0._curEpisodeId = slot1
end

function slot0.getCurEpisode(slot0)
	return slot0._curEpisodeId
end

function slot0.isEpisodeUnlock(slot0, slot1)
	if AergusiEnum.ProgressState.Finished <= slot0._episodeInfos[slot1].episodeState then
		return true
	else
		if not AergusiConfig.instance:getEpisodeConfig(nil, slot1).preEpisodeId or slot2 == 0 then
			return true
		end

		return AergusiEnum.ProgressState.Finished <= slot0._episodeInfos[slot2].episodeState
	end
end

function slot0.isEpisodePassed(slot0, slot1)
	return slot0._episodeInfos[slot1] and AergusiEnum.ProgressState.Finished <= slot0._episodeInfos[slot1].episodeState
end

function slot0.setReadClueList(slot0, slot1)
	slot0._readClueList = {}

	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0._readClueList, slot6)
	end
end

function slot0.isClueReaded(slot0, slot1)
	for slot5, slot6 in pairs(slot0._readClueList) do
		if slot6 == slot1 then
			return true
		end
	end

	if slot0._evidenceDicts[slot0._curEpisodeId] then
		slot5 = slot0._curEpisodeId

		for slot5, slot6 in pairs(slot0._evidenceDicts[slot5].clueInfos) do
			if slot6.clueId == slot1 then
				return slot6.status == 1
			end
		end
	end

	return false
end

function slot0.setClueReaded(slot0, slot1)
	table.insert(slot0._readClueList, slot1)
end

function slot0.setEvidenceInfo(slot0, slot1, slot2)
	if not slot0._evidenceDicts[slot1] then
		slot0._evidenceDicts[slot1] = AergusiEvidenceMo.New()

		slot0._evidenceDicts[slot1]:init(slot2)
	else
		slot0._evidenceDicts[slot1]:update(slot2)
	end
end

function slot0.setEpisodeUnlockAutoTipProcess(slot0, slot1)
	if slot1 == "" then
		slot0._unlockProcess = {
			0,
			0
		}
	else
		slot2 = string.splitToNumber(slot1, "_")
		slot0._unlockProcess = {
			slot2[1],
			slot2[2]
		}
	end
end

function slot0.getUnlockAutoTipProcess(slot0)
	return slot0._unlockProcess
end

function slot0.getEvidenceInfo(slot0, slot1)
	return slot0._evidenceDicts[slot1]
end

function slot0.hasClueNotRead(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if not slot0:isClueReaded(slot6.clueId) then
			return true
		end
	end

	return false
end

function slot0.getAllClues(slot0, slot1)
	if not slot0:isEpisodePassed(slot0:getEpisodeInfos()[1].episodeId) then
		return {}
	end

	for slot6 = 1, #slot2 do
		if not slot0:isEpisodePassed(slot2[slot6].episodeId) and slot0:isEpisodePassed(AergusiConfig.instance:getEpisodeConfig(nil, slot2[slot6].episodeId).preEpisodeId) then
			return slot0:getEpisodeClueConfigs(slot7.preEpisodeId, slot1)
		end
	end

	return slot0:getEpisodeClueConfigs(slot2[#slot2].episodeId, slot1)
end

function slot0.getEpisodeClueConfigs(slot0, slot1, slot2)
	slot3 = slot0:isEpisodePassed(slot1)
	slot4 = {}

	if slot2 then
		for slot9, slot10 in pairs(slot0._evidenceDicts[slot1].clueInfos) do
			table.insert(slot4, AergusiConfig.instance:getClueConfig(slot10.clueId))
		end
	else
		slot5 = {}

		for slot10, slot11 in pairs(AergusiConfig.instance:getClueConfigs()) do
			if slot3 and slot11.episodeId < slot1 or slot11.episodeId <= slot1 then
				table.insert(slot4, slot11)

				if slot11.materialId ~= "" then
					for slot17, slot18 in ipairs(string.splitToNumber(slot11.materialId, "#")) do
						table.insert(slot5, slot18)
					end
				end

				if slot11.replaceId ~= 0 then
					table.insert(slot5, slot11.replaceId)
				end
			end
		end

		for slot10 = #slot4, 1, -1 do
			for slot14, slot15 in pairs(slot5) do
				if slot4[slot10].clueId == slot15 then
					table.remove(slot4, slot10)

					break
				end
			end
		end
	end

	table.sort(slot4, function (slot0, slot1)
		return slot0.clueId < slot1.clueId
	end)

	return slot4
end

function slot0.getCouldMergeClues(slot0, slot1)
	slot2 = {}
	slot3 = {
		[slot8.clueId] = slot8
	}

	for slot7, slot8 in pairs(slot1) do
		-- Nothing
	end

	for slot8, slot9 in pairs(AergusiConfig.instance:getClueConfigs()) do
		if slot9.materialId ~= "" and slot3[string.splitToNumber(slot9.materialId, "#")[1]] and slot3[slot10[2]] then
			table.insert(slot2, {
				slot10[1],
				slot10[2]
			})
		end
	end

	return slot2
end

function slot0.getCurClueId(slot0)
	return slot0._curClueId
end

function slot0.setCurClueId(slot0, slot1)
	slot0._curClueId = slot1
end

function slot0.setClueMergePosSelect(slot0, slot1, slot2)
	slot0._mergeClueState.pos[slot1].selected = slot2
	slot0._mergeClueState.pos[3 - slot1].selected = false
end

function slot0.getClueMergePosSelectState(slot0, slot1)
	return slot0._mergeClueState.pos[slot1].selected
end

function slot0.setClueMergePosClueId(slot0, slot1, slot2)
	slot0._mergeClueState.pos[slot1].clueId = slot2

	if slot2 > 0 and not slot0._mergeClueState.pos[3 - slot1].selected and slot0._mergeClueState.pos[3 - slot1].clueId <= 0 then
		slot0._mergeClueState.pos[slot1].selected = false
		slot0._mergeClueState.pos[3 - slot1].selected = true
	end
end

function slot0.isClueInMerge(slot0, slot1)
	for slot5, slot6 in pairs(slot0._mergeClueState.pos) do
		if slot6.clueId == slot1 then
			return true
		end
	end

	return false
end

function slot0.getSelectPos(slot0)
	if not slot0._mergeClueState or not slot0._mergeClueState.pos then
		return 0
	end

	for slot4, slot5 in pairs(slot0._mergeClueState.pos) do
		if slot5.selected then
			return slot4
		end
	end

	return 0
end

function slot0.getMergeClueState(slot0)
	return slot0._mergeClueState
end

function slot0.clearMergePosState(slot0)
	if not slot0._mergeClueState then
		slot0._mergeClueState = {}
	end

	slot0._mergeClueState.open = false

	for slot4 = 1, 2 do
		if not slot0._mergeClueState.pos then
			slot0._mergeClueState.pos = {}
		end

		if not slot0._mergeClueState.pos[slot4] then
			slot0._mergeClueState.pos[slot4] = {}
		end

		slot0._mergeClueState.pos[slot4].selected = slot4 == 1
		slot0._mergeClueState.pos[slot4].clueId = 0
	end
end

function slot0.setMergeClueOpen(slot0, slot1)
	slot0._mergeClueState.open = slot1
end

function slot0.isMergeClueOpen(slot0)
	return slot0._mergeClueState.open
end

function slot0.getMergeClues(slot0)
	slot1 = {}

	for slot5 = 1, 2 do
		table.insert(slot1, slot0._mergeClueState.pos[slot5].clueId)
	end

	return slot1
end

function slot0.getTargetMergeClue(slot0, slot1, slot2)
	for slot7, slot8 in pairs(AergusiConfig.instance:getClueConfigs()) do
		if slot8.materialId == string.format("%s#%s", slot1, slot2) or slot8.materialId == string.format("%s#%s", slot2, slot1) then
			return slot8.clueId
		end
	end

	return 0
end

slot0.instance = slot0.New()

return slot0
