module("modules.logic.room.model.RoomModel", package.seeall)

slot0 = class("RoomModel", BaseModel)

function slot0.onInit(slot0)
	slot0:_clearData()
end

function slot0.reInit(slot0)
	slot0:_clearData()
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)
	slot0:_clearData()
end

function slot0._clearData(slot0)
	slot0._eidtInfo = nil
	slot0._obInfo = nil
	slot0._visitParam = nil
	slot0._enterParam = nil
	slot0._gameMode = RoomEnum.GameMode.Ob
	slot0._debugParam = nil
	slot0._roomInfoDict = {}
	slot0._buildingInfoDict = {}
	slot0._buildingIdCountDict = {}
	slot0._clickBuildingUidDict = {}
	slot0._buildingInfoList = {}
	slot0._formulaIdCountDict = {}
	slot0._blockPackageIds = {}
	slot0._specialBlockIds = {}
	slot0._specialBlockInfoList = {}
	slot0._themeItemMOListDict = {}
	slot0._roomLevel = 0
	slot0._interactionCount = 0
	slot0._existInteractionDict = {}
	slot0._characterPositionDict = {}
	slot0._hasGetRoomThemes = {}
	slot0._hasEdit = nil
	slot0._roadInfoListDict = {}
	slot0._atmosphereCacheData = nil

	if slot0._characterModel then
		slot0._characterModel:clear()
	else
		slot0._characterModel = BaseModel.New()
	end
end

function slot0.setEditInfo(slot0, slot1)
	slot0._eidtInfo = slot1

	slot0:_setInfoByMode(slot1, RoomEnum.GameMode.Edit)

	if slot1 and slot1.blockPackages then
		slot0:_addBlockPackageIdByPackageInfos(slot1.blockPackages)
	end
end

function slot0.getEditInfo(slot0)
	return slot0._eidtInfo
end

function slot0.setObInfo(slot0, slot1)
	slot0._obInfo = slot1

	slot0:_setInfoByMode(slot1, RoomEnum.GameMode.Ob)

	if slot1 and slot1.blockPackages then
		slot0:_addBlockPackageIdByPackageInfos(slot1.blockPackages)
	end

	if slot1 and slot1.hasGetRoomThemes then
		slot0:setGetThemeRewardIds(slot1.hasGetRoomThemes)
	end
end

function slot0.getObInfo(slot0)
	return slot0._obInfo
end

function slot0.setInfoByMode(slot0, slot1, slot2)
	if slot2 == RoomEnum.GameMode.Ob then
		slot0:setObInfo(slot1)
	elseif slot2 == RoomEnum.GameMode.Edit then
		slot0:setEditInfo(slot1)
	else
		slot0:_setInfoByMode(slot1, slot2)
	end
end

function slot0._setInfoByMode(slot0, slot1, slot2)
	slot0._roomInfoDict[slot2] = slot1

	slot0:setRoadInfoListByMode(slot1 and slot1.roadInfos, slot2)
end

function slot0.getRoadInfoListByMode(slot0, slot1)
	return slot0._roadInfoListDict[slot1]
end

function slot0.setRoadInfoListByMode(slot0, slot1, slot2)
	slot0._roadInfoListDict[slot2] = {}

	if slot1 then
		for slot7 = 1, #slot1 do
			table.insert(slot3, RoomTransportHelper.serverRoadInfo2Info(slot1[slot7]))
		end
	end
end

function slot0.removeRoadInfoByIdsMode(slot0, slot1, slot2)
	if slot0._roadInfoListDict[slot2] then
		for slot7 = #slot3, 1, -1 do
			if tabletool.indexOf(slot1, slot3[slot7].id) then
				table.remove(slot3, slot7)
			end
		end
	end
end

function slot0.getInfoByMode(slot0, slot1)
	return slot0._roomInfoDict[slot1]
end

function slot0.setGameMode(slot0, slot1)
	slot0._gameMode = slot1
end

function slot0.getGameMode(slot0)
	return slot0._gameMode
end

function slot0.setEnterParam(slot0, slot1)
	slot0._enterParam = slot1
end

function slot0.getEnterParam(slot0)
	return slot0._enterParam
end

function slot0.setVisitParam(slot0, slot1)
	slot0._visitParam = slot1
end

function slot0.getVisitParam(slot0)
	return slot0._visitParam
end

function slot0.setDebugParam(slot0, slot1)
	slot0._debugParam = slot1
end

function slot0.getDebugParam(slot0)
	return slot0._debugParam
end

function slot0.getBuildingInfoList(slot0)
	return slot0._buildingInfoList
end

function slot0.resetBuildingInfos(slot0)
	for slot5 = 1, #slot0._buildingInfoList do
		slot1[slot5].use = false
	end
end

function slot0.setBuildingInfos(slot0, slot1)
	slot0._buildingIdCountDict = {}
	slot0._buildingInfoList = {}
	slot0._buildingInfoDict = {}

	slot0:updateBuildingInfos(slot1)
end

function slot0.updateBuildingInfos(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot6.defineId

		if not slot0._buildingInfoDict[slot6.uid] then
			slot8 = {}
			slot0._buildingInfoDict[slot6.uid] = slot8
			slot8.uid = slot6.uid
			slot8.buildingId = slot7
			slot8.defineId = slot7

			table.insert(slot0._buildingInfoList, slot8)

			slot0._buildingIdCountDict[slot7] = (slot0._buildingIdCountDict[slot7] or 0) + 1
		end

		slot8.use = slot6.use or false
		slot8.x = slot6.x or 0
		slot8.y = slot6.y or 0
		slot8.rotate = slot6.rotate or 0
		slot8.level = slot6.level or 0
	end
end

function slot0.getBuildingCount(slot0, slot1)
	return slot0._buildingIdCountDict[slot1] or 0
end

function slot0.getBuildingInfoByBuildingUid(slot0, slot1)
	return slot0._buildingInfoDict[slot1]
end

function slot0.blockPackageGainPush(slot0, slot1)
	slot0:_addBlockPackageIdByPackageInfos(slot1.blockPackages)
end

function slot0._addBlockPackageIdByPackageInfos(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5 = 1, #slot1 do
		slot0:_addBlockPackageId(slot1[slot5].blockPackageId)
	end
end

function slot0._addBlockPackageId(slot0, slot1)
	if not slot0:isHasBlockPackageById(slot1) then
		table.insert(slot0._blockPackageIds, slot1)
	end
end

function slot0.setGetThemeRewardIds(slot0, slot1)
	if not slot1 then
		return
	end

	slot0._hasGetRoomThemes = {}

	for slot5 = 1, #slot1 do
		table.insert(slot0._hasGetRoomThemes, slot1[slot5])
	end
end

function slot0.addGetThemeRewardId(slot0, slot1)
	table.insert(slot0._hasGetRoomThemes, slot1)
end

function slot0.isHasBlockPackageById(slot0, slot1)
	return tabletool.indexOf(slot0._blockPackageIds, slot1) and true or false
end

function slot0.isHasBlockById(slot0, slot1)
	if tabletool.indexOf(slot0._specialBlockIds, slot1) then
		return true
	end

	if RoomConfig.instance:getBlock(slot1) and slot3.ownType == RoomBlockEnum.OwnType.Package and tabletool.indexOf(slot0._blockPackageIds, slot3.packageId) then
		return true
	end

	return false
end

function slot0.isHasRoomThemeById(slot0, slot1)
	if slot0:getThemeItemMOListById(slot1) == nil or #slot2 < 1 then
		return false
	end

	for slot6 = 1, #slot2 do
		slot7 = slot2[slot6]

		if slot7:getItemQuantity() < slot7.itemNum then
			return false
		end
	end

	return true
end

function slot0.setBlockPackageIds(slot0, slot1)
	slot2 = {}

	tabletool.addValues(slot2, slot1)

	slot0._blockPackageIds = slot2
end

function slot0.setSpecialBlockInfoList(slot0, slot1)
	slot2 = {}

	tabletool.addValues(slot2, slot1)

	slot0._specialBlockInfoList = slot2
	slot0._specialBlockIds = {}

	for slot6, slot7 in ipairs(slot2) do
		table.insert(slot0._specialBlockIds, slot7.blockId)
	end
end

function slot0.addSpecialBlockIds(slot0, slot1)
	for slot6 = 1, #slot1 do
		if slot1[slot6] and tabletool.indexOf(slot0._specialBlockIds, slot7) == nil then
			table.insert(slot0._specialBlockIds, slot7)
			table.insert(slot0._specialBlockInfoList, {
				blockId = slot7,
				createTime = ServerTime.now()
			})
		end
	end
end

function slot0.getBlockPackageIds(slot0)
	return slot0._blockPackageIds
end

function slot0.getSpecialBlockIds(slot0)
	return slot0._specialBlockIds
end

function slot0.getSpecialBlockInfoList(slot0)
	return slot0._specialBlockInfoList
end

function slot0.setFormulaInfos(slot0, slot1)
	slot0._formulaIdCountDict = {}

	slot0:addFormulaInfos(slot1)
end

function slot0.addFormulaInfos(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0._formulaIdCountDict[slot7] = (slot0._formulaIdCountDict[slot6.id] or 0) + 1
	end
end

function slot0.getFormulaCount(slot0, slot1)
	return slot0._formulaIdCountDict[slot1] or 0
end

function slot0.updateRoomLevel(slot0, slot1)
	slot0._roomLevel = slot1
end

function slot0.getRoomLevel(slot0)
	return slot0._roomLevel
end

function slot0.setCharacterList(slot0, slot1)
	slot2 = {}

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			slot8 = RoomCharacterMO.New()

			slot8:init(RoomInfoHelper.serverInfoToCharacterInfo(slot7))
			table.insert(slot2, slot8)
		end
	end

	slot0._characterModel:setList(slot2)
end

function slot0.getCharacterList(slot0)
	return slot0._characterModel:getList()
end

function slot0.removeCharacterById(slot0, slot1)
	slot0._characterModel:remove(slot0._characterModel:getById(slot1))
end

function slot0.getCharacterById(slot0, slot1)
	return slot0._characterModel:getById(slot1)
end

function slot0.getThemeItemMO(slot0, slot1, slot2, slot3)
	if not slot0:getThemeItemMOListById(slot1) then
		for slot8 = 1, #slot4 do
			if slot4[slot8].id == slot2 and slot9.materialType == slot3 then
				return slot9
			end
		end
	end

	return nil
end

function slot0.getThemeItemMOListById(slot0, slot1)
	if not slot0._themeItemMOListDict[slot1] and RoomConfig.instance:getThemeConfig(slot1) then
		slot2 = {}

		slot0:_addThemeMOToListByStr(slot3.packages, slot2, MaterialEnum.MaterialType.BlockPackage)
		slot0:_addThemeMOToListByStr(slot3.building, slot2, MaterialEnum.MaterialType.Building)

		slot0._themeItemMOListDict[slot1] = slot2
	end

	return slot2
end

function slot0.findHasGetThemeRewardThemeId(slot0)
	for slot5 = 1, #RoomConfig.instance:getThemeConfigList() do
		if slot0:isHasGetThemeRewardById(slot1[slot5].id) then
			return slot6
		end
	end
end

function slot0.isGetThemeRewardById(slot0, slot1)
	return tabletool.indexOf(slot0._hasGetRoomThemes, slot1)
end

function slot0.isHasGetThemeRewardById(slot0, slot1)
	if tabletool.indexOf(slot0._hasGetRoomThemes, slot1) then
		return false
	end

	if not RoomConfig.instance:getThemeCollectionRewards(slot1) or #slot2 < 1 then
		return false
	end

	if not slot0:getThemeItemMOListById(slot1) or #slot3 < 1 then
		return false
	end

	for slot7 = 1, #slot3 do
		for slot13, slot14 in ipairs(slot2) do
			if #slot14 >= 3 and slot14[1] == slot8.materialType and slot14[2] == slot8.itemId then
				slot9 = slot14[3] + slot3[slot7]:getItemQuantity()
			end
		end

		if slot9 < slot8.itemNum then
			return false
		end
	end

	return true
end

function slot0.isFinshThemeById(slot0, slot1)
	if not slot0:getThemeItemMOListById(slot1) or #slot2 < 1 then
		return false
	end

	for slot6 = 1, #slot2 do
		slot7 = slot2[slot6]

		if slot7:getItemQuantity() < slot7.itemNum then
			return false
		end
	end

	return true
end

function slot0._addThemeMOToListByStr(slot0, slot1, slot2, slot3)
	slot2 = slot2 or {}

	for slot8, slot9 in ipairs(GameUtil.splitString2(slot1, true)) do
		slot10 = RoomThemeItemMO.New()

		slot10:init(slot11, ItemModel.instance:getItemConfig(slot3, slot9[1]) and slot12.numLimit or 1, slot3)
		table.insert(slot2, slot10)
	end

	return slot2
end

function slot0.updateInteraction(slot0, slot1)
	slot0._interactionCount = slot1.interactionCount
	slot0._existInteractionDict = {}

	for slot5, slot6 in ipairs(slot1.infos) do
		if RoomConfig.instance:getCharacterInteractionConfig(slot6.id) then
			slot0._existInteractionDict[slot6.id] = slot6.finish and RoomCharacterEnum.InteractionState.Complete or RoomCharacterEnum.InteractionState.Start
		end
	end
end

function slot0.getExistInteractionDict(slot0)
	return slot0._existInteractionDict
end

function slot0.getInteractionCount(slot0)
	return slot0._interactionCount
end

function slot0.getInteractionState(slot0, slot1)
	return slot0._existInteractionDict[slot1] or RoomCharacterEnum.InteractionState.None
end

function slot0.interactStart(slot0, slot1)
	slot0._interactionCount = slot0._interactionCount + 1
	slot0._existInteractionDict[slot1] = RoomCharacterEnum.InteractionState.Start
end

function slot0.interactComplete(slot0, slot1)
	slot0._existInteractionDict[slot1] = RoomCharacterEnum.InteractionState.Complete
end

function slot0.updateCharacterPoint(slot0)
	slot0._characterPositionDict = {}

	for slot5, slot6 in ipairs(RoomCharacterModel.instance:getList()) do
		slot0._characterPositionDict[slot6.heroId] = slot6.currentPosition
	end
end

function slot0.getCharacterPosition(slot0, slot1)
	return slot0._characterPositionDict[slot1]
end

function slot0.setEditFlag(slot0)
	slot0._hasEdit = true
end

function slot0.clearEditFlag(slot0)
	slot0._hasEdit = nil
end

function slot0.hasEdit(slot0)
	return slot0._hasEdit
end

function slot0.getOpenAndEndAtmosphereList(slot0, slot1)
	slot2 = {}
	slot3 = {}
	slot5 = ServerTime.now()

	for slot9, slot10 in ipairs(RoomConfig.instance:getBuildingAtmospheres(slot1)) do
		slot11 = RoomConfig.instance:getAtmosphereOpenTime(slot10)

		if slot11 <= slot5 and slot5 <= slot11 + RoomConfig.instance:getAtmosphereDurationDay(slot10) * TimeUtil.OneDaySecond then
			slot14, slot15 = slot0:isAtmosphereTrigger(slot10)

			if slot14 then
				slot2[#slot2 + 1] = slot10
			elseif slot15 then
				slot3[#slot3 + 1] = slot10
			end
		else
			slot3[#slot3 + 1] = slot10
		end
	end

	return slot2, slot3
end

function slot0.getAtmosphereCacheData(slot0)
	if not slot0._atmosphereCacheData then
		slot0._atmosphereCacheData = {}

		if not string.nilorempty(GameUtil.playerPrefsGetStringByUserId(RoomEnum.AtmosphereCacheKey, "")) then
			for slot6, slot7 in ipairs(GameUtil.splitString2(slot1, true) or {}) do
				if slot7 and #slot7 > 1 then
					slot0._atmosphereCacheData[slot7[1]] = slot7[2]
				end
			end
		end
	end

	return slot0._atmosphereCacheData
end

function slot0.setAtmosphereHasPlay(slot0, slot1)
	slot3 = slot0:getAtmosphereCacheData()
	slot3[slot1] = ServerTime.now()
	slot4 = ""

	for slot9, slot10 in pairs(slot3) do
		if true then
			slot5 = false
			slot4 = slot9 .. "#" .. slot10
		else
			slot4 = slot4 .. "|" .. slot9 .. "#" .. slot10
		end
	end

	GameUtil.playerPrefsSetStringByUserId(RoomEnum.AtmosphereCacheKey, slot4)
end

function slot0._isCdTimeAtmosphereTrigger(slot0, slot1)
	if not uv0._checkAtmospherCdTime(slot0, slot1) then
		return false
	end

	slot3 = RoomConfig.instance:getAtmosphereOpenTime(slot0)

	if slot3 <= ServerTime.now() and slot5 <= slot3 + RoomConfig.instance:getAtmosphereDurationDay(slot0) * TimeUtil.OneDaySecond then
		slot2 = true
	end

	return slot2
end

function slot0._checkAtmospherCdTime(slot0, slot1)
	if (RoomConfig.instance:getAtmosphereCfg(slot0) and slot2.cdtimes or 0) and slot3 ~= 0 and slot3 > ServerTime.now() - slot1 then
		return false
	end

	return true
end

slot4 = {
	[RoomEnum.AtmosphereTriggerType.None] = function ()
		return false
	end,
	[RoomEnum.AtmosphereTriggerType.Disposable] = function (slot0, slot1)
		if not uv0._checkAtmospherCdTime(slot0, slot1) then
			return false
		end

		slot3 = RoomConfig.instance:getAtmosphereOpenTime(slot0)

		if slot1 < slot3 or slot3 + RoomConfig.instance:getAtmosphereDurationDay(slot0) * TimeUtil.OneDaySecond < slot1 then
			slot2 = true
		end

		return slot2
	end,
	[RoomEnum.AtmosphereTriggerType.IntegralPoint] = function (slot0, slot1)
		slot2 = false
		slot3 = ServerTime.now()
		slot5 = math.modf((slot3 + TimeUtil.OneMinuteSecond) / TimeUtil.OneHourSecond) * TimeUtil.OneHourSecond
		slot7 = slot5 + TimeUtil.OneMinuteSecond

		if slot5 - TimeUtil.OneMinuteSecond <= slot3 and slot3 <= slot7 and not (slot6 <= slot1 and slot1 <= slot7) and uv0._checkAtmospherCdTime(slot0, slot1) then
			slot2 = true
		end

		return slot2, not slot2
	end,
	[RoomEnum.AtmosphereTriggerType.CDTime] = slot0._isCdTimeAtmosphereTrigger
}

function slot0.isAtmosphereTrigger(slot0, slot1)
	slot2 = false
	slot3 = false

	if uv0[RoomConfig.instance:getAtmosphereTriggerType(slot1)] then
		slot2, slot3 = slot5(slot1, slot0:getAtmosphereCacheData()[slot1] or 0)
	else
		logError(string.format("RoomModel:isAtmosphereTrigger error atmosphereId:%s triggerType:%s not defined", slot1, slot4))
	end

	return slot2, slot3
end

slot0.instance = slot0.New()

return slot0
