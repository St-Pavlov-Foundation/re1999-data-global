module("modules.logic.versionactivity2_1.aergusi.config.AergusiConfig", package.seeall)

slot0 = class("AergusiConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._episodeConfig = nil
	slot0._evidenceConfig = nil
	slot0._dialogConfig = nil
	slot0._bubbleConfig = nil
	slot0._clueConfig = nil
	slot0._taskConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"activity163_episode",
		"activity163_evidence",
		"activity163_dialog",
		"activity163_bubble",
		"activity163_clue",
		"activity163_task"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity163_episode" then
		slot0._episodeConfig = slot2
	elseif slot1 == "activity163_evidence" then
		slot0._evidenceConfig = slot2
	elseif slot1 == "activity163_dialog" then
		slot0._dialogConfig = slot2
	elseif slot1 == "activity163_bubble" then
		slot0._bubbleConfig = slot2
	elseif slot1 == "activity163_clue" then
		slot0._clueConfig = slot2
	elseif slot1 == "activity163_task" then
		slot0._taskConfig = slot2
	end
end

function slot0.getEpisodeConfigs(slot0, slot1)
	return slot0._episodeConfig.configDict[slot1 or VersionActivity2_1Enum.ActivityId.Aergusi]
end

function slot0.getEpisodeConfig(slot0, slot1, slot2)
	return slot0._episodeConfig.configDict[slot1 or VersionActivity2_1Enum.ActivityId.Aergusi][slot2]
end

function slot0.getEvidenceConfig(slot0, slot1)
	return slot0._evidenceConfig.configDict[slot1]
end

function slot0.getDialogConfigs(slot0, slot1)
	return slot0._dialogConfig.configDict[slot1]
end

function slot0.getDialogConfig(slot0, slot1, slot2)
	return slot0._dialogConfig.configDict[slot1][slot2]
end

function slot0.getEvidenceDialogConfigs(slot0, slot1)
	return slot0._dialogConfig.configDict[slot1]
end

function slot0.getBubbleConfigs(slot0, slot1)
	return slot0._bubbleConfig.configDict[slot1]
end

function slot0.getBubbleConfig(slot0, slot1, slot2)
	return slot0._bubbleConfig.configDict[slot1][slot2]
end

function slot0.getClueConfigs(slot0)
	return slot0._clueConfig.configDict
end

function slot0.getClueConfig(slot0, slot1)
	return slot0._clueConfig.configDict[slot1]
end

function slot0.getTaskConfig(slot0, slot1)
	return slot0._taskConfig.configDict[slot1]
end

function slot0.getTaskByActId(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot0._taskConfig.configList) do
		if slot7.activityId == slot1 then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
