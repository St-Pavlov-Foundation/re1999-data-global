module("modules.logic.room.model.map.RoomCharacterModel", package.seeall)

slot0 = class("RoomCharacterModel", BaseModel)

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
	slot0._tempCharacterMO = nil
	slot0._canConfirmPlaceDict = nil
	slot0._allNodePositionList = nil
	slot0._cantWadeNodePositionList = nil
	slot0._canDragCharacter = false
	slot0._waterNodePositions = nil
	slot0._hideFaithFullMap = {}
	slot0._emptyBlockPositions = nil
	slot0._showBirthdayToastTipCache = nil
end

function slot0.initCharacter(slot0, slot1)
	slot0:clear()

	if not slot1 or #slot1 <= 0 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		if RoomModel.instance:getCharacterPosition(RoomInfoHelper.serverInfoToCharacterInfo(slot6).heroId) then
			slot7.currentPosition = RoomCharacterHelper.reCalculateHeight(slot8)
		end

		slot9 = RoomCharacterMO.New()

		slot9:init(slot7)

		if RoomConfig.instance:getRoomCharacterConfig(slot9.skinId) then
			slot0:_addCharacterMO(slot9)
		end
	end

	slot0:_initHideFithData()
end

function slot0.addTempCharacterMO(slot0, slot1, slot2, slot3)
	if slot0._tempCharacterMO then
		return
	end

	slot0._tempCharacterMO = RoomCharacterMO.New()

	slot0._tempCharacterMO:init(RoomInfoHelper.generateTempCharacterInfo(slot1, slot2, slot3))
	RoomCharacterController.instance:correctCharacterHeight(slot0._tempCharacterMO)
	slot0:_addCharacterMO(slot0._tempCharacterMO)
	slot0:clearCanConfirmPlaceDict()

	return slot0._tempCharacterMO
end

function slot0.getTempCharacterMO(slot0)
	return slot0._tempCharacterMO
end

function slot0.changeTempCharacterMO(slot0, slot1)
	if not slot0._tempCharacterMO then
		return
	end

	slot0._tempCharacterMO:setPosition(RoomCharacterHelper.reCalculateHeight(slot1))
end

function slot0.removeTempCharacterMO(slot0)
	if not slot0._tempCharacterMO then
		return
	end

	slot0:_removeCharacterMO(slot0._tempCharacterMO)

	slot0._tempCharacterMO = nil

	slot0:clearCanConfirmPlaceDict()
end

function slot0.placeTempCharacterMO(slot0)
	if not slot0._tempCharacterMO then
		return
	end

	RoomCharacterController.instance:correctCharacterHeight(slot0._tempCharacterMO)

	slot0._tempCharacterMO.characterState = RoomCharacterEnum.CharacterState.Map
	slot0._tempCharacterMO = nil

	slot0:clearCanConfirmPlaceDict()
end

function slot0.revertTempCharacterMO(slot0, slot1)
	if slot0._tempCharacterMO then
		return
	end

	slot0._tempCharacterMO = slot0:getCharacterMOById(slot1)

	if not slot0._tempCharacterMO then
		return
	end

	slot0._tempCharacterMO.characterState = RoomCharacterEnum.CharacterState.Revert
	slot0._revertPosition = slot0._tempCharacterMO.currentPosition

	slot0:clearCanConfirmPlaceDict()

	return slot0._tempCharacterMO
end

function slot0.removeRevertCharacterMO(slot0)
	if not slot0._tempCharacterMO then
		return
	end

	slot0._tempCharacterMO:setPosition(RoomCharacterHelper.reCalculateHeight(slot0._revertPosition))

	slot0._tempCharacterMO.characterState = RoomCharacterEnum.CharacterState.Map
	slot0._tempCharacterMO = nil

	slot0:clearCanConfirmPlaceDict()

	return slot0._tempCharacterMO.heroId, slot0._revertPosition
end

function slot0.unUseRevertCharacterMO(slot0)
	if not slot0._tempCharacterMO then
		return
	end

	slot0:_removeCharacterMO(slot0._tempCharacterMO)

	slot0._tempCharacterMO = nil

	slot0:clearCanConfirmPlaceDict()
end

function slot0.getRevertPosition(slot0)
	return slot0._revertPosition
end

function slot0.resetCharacterMO(slot0, slot1, slot2)
	if not slot0:getById(slot1) then
		return
	end

	slot3:endMove()
	slot3:setPosition(RoomCharacterHelper.reCalculateHeight(slot2))
end

function slot0.deleteCharacterMO(slot0, slot1)
	if not slot0:getById(slot1) then
		return
	end

	slot0:_removeCharacterMO(slot2)
	slot0:setHideFaithFull(slot1, false)
end

function slot0.endAllMove(slot0)
	for slot5, slot6 in ipairs(slot0:getList()) do
		slot6:endMove()
	end
end

function slot0.getConfirmCharacterCount(slot0)
	for slot6, slot7 in ipairs(slot0:getList()) do
		if (slot7.characterState == RoomCharacterEnum.CharacterState.Map or slot7.characterState == RoomCharacterEnum.CharacterState.Revert) and slot7:isPlaceSourceState() then
			slot2 = 0 + 1
		end
	end

	return slot2
end

function slot0.getMaxCharacterCount(slot0, slot1, slot2)
	return (RoomConfig.instance:getRoomLevelConfig(slot2 or RoomMapModel.instance:getRoomLevel()) and slot4.characterLimit or 0) + RoomConfig.instance:getCharacterLimitAddByBuildDegree(slot1 or RoomMapModel.instance:getAllBuildDegree())
end

function slot0.refreshCanConfirmPlaceDict(slot0)
	if not slot0._tempCharacterMO then
		slot0._canConfirmPlaceDict = {}
	else
		slot0._canConfirmPlaceDict = RoomCharacterHelper.getCanConfirmPlaceDict(slot0._tempCharacterMO.heroId, slot0._tempCharacterMO.skinId)
	end
end

function slot0.isCanConfirm(slot0, slot1)
	if not slot0._canConfirmPlaceDict then
		slot0:refreshCanConfirmPlaceDict()
	end

	return slot0._canConfirmPlaceDict[slot1.x] and slot0._canConfirmPlaceDict[slot1.x][slot1.y]
end

function slot0.getCanConfirmPlaceDict(slot0)
	if not slot0._canConfirmPlaceDict then
		slot0:refreshCanConfirmPlaceDict()
	end

	return slot0._canConfirmPlaceDict
end

function slot0.clearCanConfirmPlaceDict(slot0)
	slot0._canConfirmPlaceDict = nil
end

function slot0._refreshNodePositionList(slot0)
	slot0._allNodePositionList = {}

	RoomHelper.cArrayToLuaTable(ZProj.AStarPathBridge.GetNodePositions(RoomCharacterHelper.getTag(true)), slot0._allNodePositionList)

	slot0._cantWadeNodePositionList = {}

	RoomHelper.cArrayToLuaTable(ZProj.AStarPathBridge.GetNodePositions(RoomCharacterHelper.getTag(false)), slot0._cantWadeNodePositionList)
end

function slot0.getNodePositionList(slot0, slot1)
	if not slot0._allNodePositionList or not slot0._cantWadeNodePositionList then
		slot0:_refreshNodePositionList()
	end

	return slot1 and slot0._allNodePositionList or slot0._cantWadeNodePositionList
end

function slot0.clearNodePositionList(slot0)
	slot0._cantWadeNodePositionList = nil
	slot0._allNodePositionList = nil
end

function slot0._addCharacterMO(slot0, slot1)
	slot0:addAtLast(slot1)
end

function slot0._removeCharacterMO(slot0, slot1)
	slot0:remove(slot1)
end

function slot0.editRemoveCharacterMO(slot0, slot1)
	if slot0:getById(slot1) then
		slot0:_removeCharacterMO(slot2)
	end
end

function slot0.getCharacterMOById(slot0, slot1)
	if not slot0:getById(slot1) and slot0._trainTempMO and slot0._trainTempMO.id == slot1 then
		return slot0._trainTempMO
	end

	return slot2
end

function slot0.updateCharacterFaith(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0:getCharacterMOById(slot6.heroId) then
			slot7.currentFaith = slot6.currentFaith
			slot7.currentMinute = slot6.currentMinute
			slot7.nextRefreshTime = slot6.nextRefreshTime
		end
	end
end

function slot0.setCanDragCharacter(slot0, slot1)
	slot0._canDragCharacter = slot1
end

function slot0.canDragCharacter(slot0)
	return slot0._canDragCharacter
end

function slot0._refreshWaterNodePositions(slot0)
	slot0._waterNodePositions = {}

	if ZProj.AStarPathBridge.GetNodePositions(bit.lshift(1, RoomEnum.AStarLayerTag.Water)) then
		slot2 = slot1:GetEnumerator()

		while slot2:MoveNext() do
			table.insert(slot0._waterNodePositions, slot2.Current)
		end
	end
end

function slot0.getWaterNodePositions(slot0)
	if not slot0._waterNodePositions then
		slot0:_refreshWaterNodePositions()
	end

	return slot0._waterNodePositions
end

function slot0.setHideFaithFull(slot0, slot1, slot2)
	if not slot2 and not slot0._hideFaithFullMap[slot1] then
		return
	end

	if (slot2 and true or false) ~= slot0._hideFaithFullMap[slot1] then
		slot0._hideFaithFullMap[slot1] = slot3

		slot0:_saveFaithFullData(slot0._hideFaithFullMap)
	end
end

function slot0.isShowFaithFull(slot0, slot1)
	if slot0._hideFaithFullMap[slot1] then
		return false
	end

	return true
end

function slot0._getFaithFullPrefsKey(slot0)
	return "room_character_faithfull_role#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function slot0._initHideFithData(slot0)
	slot0._hideFaithFullMap = {}

	if slot0:_canUseFaithFull() then
		slot3 = false

		for slot7, slot8 in ipairs(string.splitToNumber(PlayerPrefsHelper.getString(slot0:_getFaithFullPrefsKey(), ""), "#") or {}) do
			if slot0:getById(slot8) then
				slot0._hideFaithFullMap[slot8] = true
			else
				slot3 = true
			end
		end

		if slot3 then
			slot0:_saveFaithFullData(slot0._hideFaithFullMap)
		end
	end
end

function slot0._saveFaithFullData(slot0, slot1)
	if not slot0:_canUseFaithFull() or not slot1 then
		return
	end

	slot2 = ""

	for slot7, slot8 in pairs(slot1) do
		if slot8 == true then
			if true then
				slot3 = false
				slot2 = tostring(slot7)
			else
				slot2 = slot2 .. "#" .. tostring(slot7)
			end
		end
	end

	PlayerPrefsHelper.setString(slot0:_getFaithFullPrefsKey(), slot2)
end

function slot0._canUseFaithFull(slot0)
	return RoomModel.instance:getGameMode() == RoomEnum.GameMode.Ob or slot1 == RoomEnum.GameMode.Edit
end

function slot0.getEmptyBlockPositions(slot0)
	if not slot0._emptyBlockPositions then
		slot0._emptyBlockPositions = {}

		for slot5, slot6 in ipairs(RoomMapBlockModel.instance:getEmptyBlockMOList()) do
			if slot6.hexPoint then
				table.insert(slot0._emptyBlockPositions, HexMath.hexToPosition(slot6.hexPoint, RoomBlockEnum.BlockSize))
			end
		end
	end

	return slot0._emptyBlockPositions
end

function slot0.isOnBirthday(slot0, slot1)
	slot2 = false
	slot3 = slot1 and HeroConfig.instance:getHeroCO(slot1)

	if not string.nilorempty(slot3 and slot3.roleBirthday) then
		slot6 = string.splitToNumber(slot3.roleBirthday, "/")
		slot9 = os.time({
			hour = 5,
			min = 0,
			sec = 0,
			year = SignInModel.instance:getCurDate().year,
			month = slot6[1],
			day = slot6[2]
		}) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()

		if slot9 <= ServerTime.now() and slot12 < slot9 + CommonConfig.instance:getConstNum(ConstEnum.RoomBirthdayDurationDay) * TimeUtil.OneDaySecond then
			slot2 = true
		end
	end

	return slot2
end

function slot0.initShowBirthdayToastTipCache(slot0)
	if not string.nilorempty(GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.RoomBirthdayToastKey, "")) then
		slot0._showBirthdayToastTipCache = cjson.decode(slot1)
	end

	slot0._showBirthdayToastTipCache = slot0._showBirthdayToastTipCache or {}
end

function slot0.isNeedShowBirthdayToastTip(slot0, slot1)
	if not slot1 then
		return false
	end

	slot3 = false

	if not slot0._showBirthdayToastTipCache then
		slot0:initShowBirthdayToastTipCache()
	end

	if slot0._showBirthdayToastTipCache[tostring(slot1)] then
		slot3 = TimeUtil.isSameDay(slot5, ServerTime.now() - TimeDispatcher.DailyRefreshSecond)
	end

	return slot0:isOnBirthday(slot1) and not slot3
end

function slot0.getPlaceCount(slot0)
	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7:isPlaceSourceState() then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.setHasShowBirthdayToastTip(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0._showBirthdayToastTipCache then
		slot0:initShowBirthdayToastTipCache()
	end

	slot0._showBirthdayToastTipCache[tostring(slot1)] = ServerTime.now() - TimeDispatcher.DailyRefreshSecond

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.RoomBirthdayToastKey, cjson.encode(slot0._showBirthdayToastTipCache))
end

function slot0.getTrainTempMO(slot0)
	if not slot0._trainTempMO then
		slot0._trainTempMO = RoomCharacterMO.New()
	end

	return slot0._trainTempMO
end

slot0.instance = slot0.New()

return slot0
