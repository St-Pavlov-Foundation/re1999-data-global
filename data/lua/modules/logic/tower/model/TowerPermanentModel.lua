module("modules.logic.tower.model.TowerPermanentModel", package.seeall)

slot0 = class("TowerPermanentModel", MixScrollModel)

function slot0.onInit(slot0)
	slot0:initDataInfo()
end

function slot0.reInit(slot0)
	slot0:initDataInfo()

	slot0.lastPassLayer = 0
	slot0.localCurPassLayer = -1
end

function slot0.initDataInfo(slot0)
	slot0.permanentMoList = {}
	slot0.ItemType = 1
	slot0.PermanentInfoMap = {}
	slot0.defaultStage = 1
	slot0.curSelectStage = 1
	slot0.curPassLayer = 0
	slot0.curSelectLayer = 1
	slot0.curSelectEpisodeId = 0
	slot0.realSelectMap = {}
end

function slot0.cleanData(slot0)
	slot0:initDataInfo()
end

function slot0.initDefaultSelectStage(slot0, slot1)
	slot0.curPassLayer = slot1 and slot1.passLayerId or 0

	if slot0.curPassLayer == 0 then
		slot0.defaultStage = 1
		slot0.curSelectLayer = 1
	else
		slot0.defaultStage, slot0.curSelectLayer = slot0:getNewtStageAndLayer()
	end

	slot0.curSelectStage = slot0.defaultStage
	slot0.realSelectMap[slot0.curSelectStage] = slot0.curSelectLayer
end

function slot0.getNewtStageAndLayer(slot0)
	slot4 = TowerConfig.instance:getPermanentEpisodeCo(slot0.curPassLayer + 1)

	if not TowerConfig.instance:getPermanentEpisodeCo(slot0.curPassLayer) then
		logError("该层配置为空，请检查：" .. slot0.curPassLayer)

		return 1, 1
	end

	if not slot4 then
		slot1 = slot3.stageId
		slot2 = slot0:getPassLayerIndex()
	elseif slot3.stageId ~= slot4.stageId then
		if slot0:checkStageIsOnline(slot4.stageId) then
			slot1 = slot4.stageId
			slot2 = 1
		else
			slot1 = slot3.stageId
			slot2 = slot0:getPassLayerIndex()
		end
	else
		slot1 = slot3.stageId
		slot2 = slot0:getPassLayerIndex() + 1
	end

	return slot1, slot2
end

function slot0.getPassLayerIndex(slot0)
	return TowerConfig.instance:getPermanentEpisodeCo(slot0.curPassLayer).index
end

function slot0.getStageCount(slot0)
	return slot0.defaultStage
end

function slot0.checkhasLockTip(slot0)
	return slot0.defaultStage < #slot0.permanentMoList
end

function slot0.InitData(slot0)
	slot0:initDefaultSelectStage(TowerModel.instance:getCurPermanentMo())

	slot0.permanentMoList = {}

	for slot5 = 1, slot0.defaultStage do
		if not slot0.PermanentInfoMap[slot5] then
			slot0.PermanentInfoMap[slot5] = TowerPermanentMo.New()
		end

		slot6:init(slot5, TowerConfig.instance:getPermanentEpisodeStageCoList(slot5))
		table.insert(slot0.permanentMoList, slot6)
	end

	slot2 = slot0.defaultStage + 1

	if TowerConfig.instance:getPermanentEpisodeStageCoList(slot2) or TowerConfig.instance:getTowerPermanentTimeCo(slot2) then
		slot5 = TowerPermanentMo.New()
		slot0.PermanentInfoMap[slot2] = slot5

		slot5:init(slot2, {})
		table.insert(slot0.permanentMoList, slot5)
	end

	slot0:setList(slot0.permanentMoList)
end

function slot0.initStageUnFoldState(slot0, slot1)
	for slot6, slot7 in ipairs(slot0.permanentMoList) do
		slot7:setIsUnFold(slot7.stage == (slot1 or slot0:getCurSelectStage()))
	end
end

function slot0.getInfoList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(slot0:getList()) do
		table.insert(slot2, SLFramework.UGUI.MixCellInfo.New(slot0.ItemType, slot8:getStageHeight(slot8:getIsUnFold()), slot7))
	end

	return slot2
end

function slot0.getCurContentTotalHeight(slot0)
	for slot6, slot7 in ipairs(slot0:getList()) do
		slot2 = 0 + slot7:getStageHeight(slot7:getIsUnFold(slot7:getIsUnFold()))
	end

	return slot2
end

function slot0.setCurSelectStage(slot0, slot1)
	slot0.curSelectStage = slot1
	slot0.curSelectLayer = slot0.realSelectMap[slot1] or 1
	slot0.curSelectEpisodeId = 0
end

function slot0.getCurSelectStage(slot0)
	return slot0.curSelectStage
end

function slot0.setCurSelectLayer(slot0, slot1, slot2)
	slot0.realSelectMap = {
		[slot2] = slot1
	}
	slot0.curSelectLayer = slot1
	slot0.curSelectEpisodeId = 0
end

function slot0.getCurSelectLayer(slot0)
	return slot0.curSelectLayer
end

function slot0.getRealSelectStage(slot0)
	for slot4, slot5 in pairs(slot0.realSelectMap) do
		if slot4 then
			return slot4, slot5
		end
	end
end

function slot0.setCurSelectEpisodeId(slot0, slot1)
	slot0.curSelectEpisodeId = slot1
end

function slot0.getCurSelectEpisodeId(slot0)
	return slot0.curSelectEpisodeId
end

function slot0.checkLayerSubEpisodeFinish(slot0, slot1, slot2)
	for slot8, slot9 in ipairs(TowerModel.instance:getCurPermanentMo():getLayerSubEpisodeList(slot1, true) or {}) do
		if slot9.episodeId == slot2 then
			return slot9.status == TowerEnum.PassEpisodeState.Pass, slot9
		end
	end

	return false
end

function slot0.getFirstUnFinishEipsode(slot0, slot1)
	for slot7, slot8 in ipairs(TowerModel.instance:getCurPermanentMo():getLayerSubEpisodeList(slot1, true) or {}) do
		if slot8.status == TowerEnum.PassEpisodeState.NotPass then
			return slot8, slot7
		end
	end
end

function slot0.checkLayerUnlock(slot0, slot1)
	slot2 = TowerModel.instance:getCurPermanentMo()

	if slot1.preLayerId == 0 then
		return true
	else
		return slot3 <= slot2.passLayerId
	end
end

function slot0.getCurPermanentPassLayer(slot0)
	return TowerModel.instance:getCurPermanentMo().passLayerId or 0
end

function slot0.getCurPassEpisodeId(slot0)
	if TowerConfig.instance:getPermanentEpisodeCo((TowerModel.instance:getCurPermanentMo().passLayerId or 0) + 1) and slot4.isElite == 1 then
		for slot9, slot10 in ipairs(string.splitToNumber(slot4.episodeIds, "|")) do
			if slot1:getSubEpisodeMoByEpisodeId(slot10) and slot11.status == TowerEnum.PassEpisodeState.Pass then
				return slot10
			end
		end
	end

	if not TowerConfig.instance:getPermanentEpisodeCo(slot2) then
		return 0
	end

	if slot5.isElite == 1 then
		slot6 = string.splitToNumber(slot5.episodeIds, "|")

		return slot6[#slot6]
	else
		return tonumber(slot5.episodeIds)
	end
end

function slot0.setLastPassLayer(slot0, slot1)
	slot0.lastPassLayer = slot1
end

function slot0.setLocalPassLayer(slot0, slot1)
	slot0.localCurPassLayer = slot1
end

function slot0.getLocalPassLayer(slot0)
	return slot0.localCurPassLayer
end

function slot0.isNewPassLayer(slot0)
	return TowerModel.instance:getCurPermanentMo().passLayerId == slot0.lastPassLayer and slot0.localCurPassLayer < slot1.passLayerId
end

function slot0.isNewStage(slot0)
	if TowerConfig.instance:getPermanentEpisodeCo(TowerModel.instance:getCurPermanentMo().passLayerId).stageId < slot0.defaultStage and slot0:isNewPassLayer() then
		return true, slot0.defaultStage, slot2.stageId
	end

	return false, slot0.defaultStage, slot2.stageId
end

function slot0.checkStageIsOnline(slot0, slot1)
	if string.nilorempty(TowerConfig.instance:getTowerPermanentTimeCo(slot1).time) then
		return true
	else
		slot3 = string.splitToNumber(slot2.time, "-")

		if TimeUtil.timeToTimeStamp(slot3[1], slot3[2], slot3[3], TimeDispatcher.DailyRefreshTime) - ServerTime.now() <= 0 then
			return true
		else
			return false, slot5
		end
	end
end

function slot0.getCurUnfoldStage(slot0)
	for slot4, slot5 in ipairs(slot0.permanentMoList) do
		if slot5.isUnFold then
			return slot5.stage
		end
	end

	return slot0.curSelectStage
end

function slot0.checkNewLayerIsElite(slot0)
	if not TowerConfig.instance:getPermanentEpisodeCo((TowerModel.instance:getCurPermanentMo().passLayerId or 0) + 1) then
		return false
	end

	return slot4.isElite == 1
end

function slot0.localMopUpSaveKey(slot0)
	return TowerEnum.LocalPrefsKey.OpenMopUpViewWithFullTicket
end

function slot0.checkCanShowMopUpReddot(slot0)
	if not TowerController.instance:isOpen() then
		return false
	end

	slot1 = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpOpenLayerNum)

	if not TowerModel.instance:getCurPermanentMo() then
		return false
	end

	if not (tonumber(slot1) <= slot2.passLayerId) then
		return false
	end

	if TimeUtil.getDayFirstLoginRed(TowerEnum.LocalPrefsKey.MopUpDailyRefresh) and TowerModel.instance:getMopUpTimes() == tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MaxMopUpTimes)) then
		return true
	end

	return false
end

slot0.instance = slot0.New()

return slot0
