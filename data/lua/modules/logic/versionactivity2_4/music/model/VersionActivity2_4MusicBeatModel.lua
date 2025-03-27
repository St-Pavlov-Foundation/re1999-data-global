module("modules.logic.versionactivity2_4.music.model.VersionActivity2_4MusicBeatModel", package.seeall)

slot0 = class("VersionActivity2_4MusicBeatModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
end

function slot0.onStart(slot0, slot1)
	VersionActivity2_4MusicController.instance:initBgm()

	slot0._episodeId = slot1
	slot2, slot3 = Activity179Model.instance:getConstValue(VersionActivity2_4MusicEnum.Const.Score)
	slot0._scoreList = string.splitToNumber(slot3, "#")
	slot4, slot5 = Activity179Model.instance:getConstValue(VersionActivity2_4MusicEnum.Const.ScoreTime)
	slot6 = GameUtil.splitString2(slot5, true, "|", "#")
	slot0._scoreShowTimeList = slot6[1]
	slot0._scoreTimeList = {
		[VersionActivity2_4MusicEnum.BeatGrade.Perfect] = slot6[2],
		[VersionActivity2_4MusicEnum.BeatGrade.Great] = slot6[3],
		[VersionActivity2_4MusicEnum.BeatGrade.Cool] = slot6[1]
	}
	slot0._successCount = 0
end

function slot0.getSuccessCount(slot0)
	return slot0._successCount
end

function slot0.setSuccessCount(slot0, slot1)
	slot0._successCount = slot1
end

function slot0.getEpisodeId(slot0)
	return slot0._episodeId
end

function slot0.updateGradleList(slot0, slot1)
	slot0._gradeList = slot1
end

function slot0.getGradleList(slot0)
	return slot0._gradeList or {}
end

function slot0.getShowTime(slot0)
	return slot0._scoreShowTimeList[1]
end

function slot0.getHideTime(slot0)
	return slot0._scoreShowTimeList[2]
end

function slot0.getScoreTimeList(slot0)
	return slot0._scoreTimeList
end

function slot0.getGradeScore(slot0, slot1)
	return slot0._scoreList and slot0._scoreList[slot1] or 0
end

slot0.instance = slot0.New()

return slot0
