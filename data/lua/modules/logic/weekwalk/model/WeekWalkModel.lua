module("modules.logic.weekwalk.model.WeekWalkModel", package.seeall)

slot0 = class("WeekWalkModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0._battleElementId = nil
	slot0._weekWalkInfo = nil
end

function slot0.isShallowLayer(slot0)
	return slot0 and slot0 <= 10
end

function slot0.isShallowMap(slot0)
	return slot0 and WeekWalkEnum.ShallowMapIds[slot0]
end

function slot0.setFinishMapId(slot0, slot1)
	slot0._curFinishMapId = slot1
end

function slot0.getFinishMapId(slot0)
	return slot0._curFinishMapId
end

function slot0.setCurMapId(slot0, slot1)
	slot0._curMapId = slot1
end

function slot0.getCurMapId(slot0)
	return slot0._curMapId
end

function slot0.getCurMapConfig(slot0)
	return WeekWalkConfig.instance:getMapConfig(slot0._curMapId)
end

function slot0.getCurMapIsFinish(slot0)
	return slot0:getCurMapInfo().isFinish > 0
end

function slot0.getCurMapInfo(slot0)
	return slot0:getMapInfo(slot0._curMapId)
end

function slot0.getOldOrNewCurMapInfo(slot0)
	return slot0._oldInfo and slot0._oldInfo:getMapInfo(slot0._curMapId) or slot0:getCurMapInfo()
end

function slot0.getMapInfo(slot0, slot1)
	return slot0._weekWalkInfo and slot0._weekWalkInfo:getMapInfo(slot1)
end

function slot0.setBattleElementId(slot0, slot1)
	slot0._battleElementId = slot1
end

function slot0.getBattleElementId(slot0)
	return slot0._battleElementId
end

function slot0.infoNeedUpdate(slot0)
	return slot0._oldInfo
end

function slot0.updateHeroHpInfo(slot0, slot1, slot2)
	slot0._weekWalkInfo:updateHeroHpInfo(slot1, slot2)
end

function slot0.updateInfo(slot0, slot1)
	slot0:initInfo(slot1)
end

function slot0.initInfo(slot0, slot1, slot2)
	slot3 = WeekwalkInfoMO.New()

	slot3:init(slot1)

	slot0._weekWalkInfo = slot3
end

function slot0.getInfo(slot0)
	return slot0._weekWalkInfo
end

function slot0.addOldInfo(slot0)
	if not slot0._curMapId or uv0.isShallowMap(slot0._curMapId) then
		return
	end

	slot0._oldInfo = slot0._weekWalkInfo
end

function slot0.clearOldInfo(slot0)
	slot0._oldInfo = nil
end

function slot0.getMaxLayerId(slot0)
	return slot0._weekWalkInfo.maxLayer
end

function slot0.getOldOrNewElementInfos(slot0, slot1)
	if slot0._oldInfo and slot0._oldInfo and slot0._oldInfo:getMapInfo(slot1) then
		return slot2.elementInfos
	end

	return slot0:getElementInfos(slot1)
end

function slot0.getElementInfos(slot0, slot1)
	return slot0:getMapInfo(slot1) and slot2.elementInfos
end

function slot0.getElementInfo(slot0, slot1, slot2)
	return slot0:getMapInfo(slot1) and slot3:getElementInfo(slot2)
end

function slot0.getBattleInfo(slot0, slot1, slot2)
	return slot0:getMapInfo(slot1) and slot3:getBattleInfo(slot2)
end

function slot0.getBattleInfoByLayerAndIndex(slot0, slot1, slot2)
	slot3 = slot0._weekWalkInfo and slot0._weekWalkInfo:getMapInfoByLayer(slot1)

	return slot3 and slot3:getBattleInfoByIndex(slot2)
end

function slot0.getCurMapHeroCd(slot0, slot1)
	return slot0:getHeroCd(slot0._curMapId, slot1)
end

function slot0.getHeroCd(slot0, slot1, slot2)
	return slot0:getMapInfo(slot1) and slot3:getHeroCd(slot2) or 0
end

function slot0.setSkipShowSettlementView(slot0, slot1)
	slot0._skipShowSettlementView = slot1
end

function slot0.getSkipShowSettlementView(slot0)
	return slot0._skipShowSettlementView
end

slot0.instance = slot0.New()

return slot0
