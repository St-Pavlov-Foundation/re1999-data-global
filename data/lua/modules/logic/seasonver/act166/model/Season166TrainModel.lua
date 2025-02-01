module("modules.logic.seasonver.act166.model.Season166TrainModel", package.seeall)

slot0 = class("Season166TrainModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0:cleanData()
end

function slot0.cleanData(slot0)
	slot0.curTrainId = 0
	slot0.curTrainConfig = nil
	slot0.curEpisodeId = nil
end

function slot0.initTrainData(slot0, slot1, slot2)
	slot0.actId = slot1
	slot0.curTrainId = slot2
	slot0.curTrainConfig = Season166Config.instance:getSeasonTrainCo(slot1, slot2)
	slot0.curEpisodeId = slot0.curTrainConfig and slot0.curTrainConfig.episodeId
end

function slot0.checkIsFinish(slot0, slot1, slot2)
	return Season166Model.instance:getActInfo(slot1).trainInfoMap[slot2] and slot4.passCount > 0
end

function slot0.getCurTrainPassCount(slot0, slot1)
	for slot7, slot8 in ipairs(Season166Config.instance:getSeasonTrainCos(slot1)) do
		if slot0:checkIsFinish(slot1, slot8.trainId) then
			slot2 = 0 + 1
		end
	end

	return slot2
end

function slot0.isHardEpisodeUnlockTime(slot0, slot1)
	slot3 = Season166Config.instance:getSeasonConstNum(slot1, Season166Enum.SpOpenTimeConstId) > 0 and slot3 - 1

	return slot3 <= math.floor((ServerTime.now() - ActivityModel.instance:getActMO(slot1):getRealStartTimeStamp()) / TimeUtil.OneDaySecond), slot3 - slot5
end

function slot0.getUnlockTrainInfoMap(slot0, slot1)
	return tabletool.copy(Season166Model.instance:getActInfo(slot1).trainInfoMap)
end

slot0.instance = slot0.New()

return slot0
