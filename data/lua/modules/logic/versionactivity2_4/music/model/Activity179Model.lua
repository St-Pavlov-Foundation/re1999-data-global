module("modules.logic.versionactivity2_4.music.model.Activity179Model", package.seeall)

slot0 = class("Activity179Model", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
end

function slot0.reInit(slot0)
	slot0._episodeMap = {}
	slot0._activityId = nil
end

function slot0.getActivityId(slot0)
	slot0._activityId = slot0._activityId or VersionActivity2_4Enum.ActivityId.MusicGame

	return slot0._activityId
end

function slot0.getConstValue(slot0, slot1)
	return Activity179Config.instance:getConstValue(slot0:getActivityId(), slot1)
end

function slot0.initEpisodeList(slot0, slot1)
	slot0._episodeMap = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0:updateEpisode(slot6)
	end
end

function slot0.updateEpisode(slot0, slot1)
	slot2 = slot0._episodeMap[slot1.episodeId] or Act179EpisodeMO.New()

	slot2:init(slot1)

	slot0._episodeMap[slot1.episodeId] = slot2
end

function slot0.getEpisodeMo(slot0, slot1)
	return slot0._episodeMap[slot1]
end

function slot0.episodeIsFinished(slot0, slot1)
	return slot0:getEpisodeMo(slot1) and slot2.isFinished
end

function slot0.getCalibration(slot0)
	return (tonumber(PlayerPrefsHelper.getNumber(PlayerPrefsKey.Activity179Calibration, 0)) or 0) / 1000
end

function slot0.setCalibration(slot0, slot1)
	return PlayerPrefsHelper.setNumber(PlayerPrefsKey.Activity179Calibration, slot1)
end

function slot0.clearSelectedEpisodeId(slot0)
	slot0._selectedEpisodeId = nil
end

function slot0.getSelectedEpisodeId(slot0)
	slot0._selectedEpisodeId = slot0._selectedEpisodeId or GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Version2_4MusicSelectEpisode, VersionActivity2_4MusicEnum.FirstEpisodeId)

	return slot0._selectedEpisodeId
end

slot0.instance = slot0.New()

return slot0
