module("modules.logic.guide.controller.exception.GuideExceptionChecker", package.seeall)

slot0 = _M

function slot0.checkCurrency(slot0, slot1, slot2)
	slot3 = string.split(slot2, "_")

	return tonumber(slot3[2]) <= (CurrencyModel.instance:getCurrency(tonumber(slot3[1])) and slot6.quantity)
end

function slot0.checkDungeonUsePower(slot0, slot1, slot2)
	return tonumber(string.split(string.split(DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId).cost, "|")[1], "#")[3] or 0) <= CurrencyModel.instance:getPower()
end

function slot0.checkBuildingPut(slot0, slot1, slot2)
	if RoomMapBuildingModel.instance:getBuildingMoByBuildingId(tonumber(slot2)) and slot4:isInMap() then
		return false
	end

	return not RoomInventoryBuildingModel.instance:checkBuildingPut(slot3)
end

function slot0.checkBuildingPutMatchStep(slot0, slot1, slot2)
	if not GuideModel.instance:getById(slot0) then
		return true
	end

	if #RoomMapBuildingModel.instance:getBuildingMOList() > 0 and slot3.serverStepId ~= tonumber(slot2) then
		return false
	end

	return true
end

function slot0.checkViewShow(slot0, slot1, slot2)
	return not ViewMgr.instance:getContainer(slot2) or not slot3._isVisible
end

function slot0.checkViewNotShow(slot0, slot1, slot2)
	return ViewMgr.instance:getContainer(slot2) and slot3._isVisible
end

function slot0.checkViewExist(slot0, slot1, slot2)
	return not ViewMgr.instance:getContainer(slot2)
end

function slot0.checkViewNotExist(slot0, slot1, slot2)
	return ViewMgr.instance:getContainer(slot2)
end

function slot0.noRemainStars()
	if not WeekWalkModel.instance:getCurMapInfo() or slot0.isFinish <= 0 then
		return
	end

	slot1, slot2 = slot0:getCurStarInfo()

	return slot1 ~= slot2
end

function slot0.checkHeroTalent(slot0, slot1, slot2)
	return not (tonumber(slot2) <= HeroModel.instance:getByHeroId(CharacterController.instance:getTalentHeroId()).talent)
end

function slot0.checkSummon(slot0, slot1, slot2)
	return not (HeroModel.instance:getList() and #slot3 > 1)
end

function slot0.checkAllEquipLevel(slot0, slot1, slot2)
	slot5 = false

	for slot9, slot10 in ipairs(EquipModel.instance:getEquips()) do
		if tonumber(slot2) <= slot10.level then
			slot5 = true

			break
		end
	end

	return not slot5
end

function slot0.noPointReward()
	return DungeonMapModel.instance:canGetRewardsList(lua_chapter_point_reward.configList[#lua_chapter_point_reward.configList].chapterId) and #slot1 > 0
end

function slot0.checkScene(slot0, slot1, slot2)
	slot3 = SceneType[slot2]
	slot4 = GameSceneMgr.instance:getCurSceneType()

	logError("sceneType = " .. slot3 .. ", curSceneType = " .. slot4)

	return slot3 == slot4
end

function slot0.checkMaterial(slot0, slot1, slot2)
	slot3 = string.split(slot2, "_")

	return tonumber(slot3[3]) <= ItemModel.instance:getItemQuantity(tonumber(slot3[1]), tonumber(slot3[2]))
end

function slot0.checkMaterialNotEnough(slot0, slot1, slot2)
	slot3 = string.split(slot2, "_")

	return ItemModel.instance:getItemQuantity(tonumber(slot3[1]), tonumber(slot3[2])) < tonumber(slot3[3])
end

function slot0.findTalentFirstChess()
	if not ViewMgr.instance:getContainer(ViewName.CharacterTalentChessView) then
		return true
	end

	if not gohelper.findChild(slot0.viewGO, "chessboard/#go_chessContainer") then
		return true
	end

	return slot2.transform.childCount <= 0
end

function slot0.checkTaskFinish(slot0, slot1, slot2)
	if tonumber(slot2) then
		if TaskModel.instance:getTaskById(slot3) then
			return TaskModel.instance:isTaskFinish(slot4.type, slot3)
		else
			return false
		end
	else
		logError("异常处理checkRoomTaskFinish参数错误：" .. slot0 .. "_" .. slot1)

		return false
	end
end

function slot0.checkTaskNotFinish(slot0, slot1, slot2)
	return not uv0.checkTaskFinish(slot0, slot1, slot2)
end

function slot0.checkBlockCountGE(slot0, slot1, slot2)
	return tonumber(slot2) <= RoomMapBlockModel.instance:getFullBlockCount()
end

function slot0.checkBlockCountL(slot0, slot1, slot2)
	return RoomMapBlockModel.instance:getFullBlockCount() < tonumber(slot2)
end

function slot0.checkRoomCanGetRes(slot0, slot1, slot2)
	return #RoomProductionHelper.getCanGainLineIdList(tonumber(slot2)) > 0
end

function slot0.check1_2DungeonHasNotCollectNote(slot0, slot1, slot2)
	return not VersionActivity1_2NoteModel.instance:isCollectedAllNote()
end

function slot0.check1_2DungeonBonusFinish(slot0, slot1, slot2)
	return not VersionActivity1_2NoteModel.instance:getBonusFinished(tonumber(slot2))
end

function slot0.check1_2DungeonHasNotBonusFinisd(slot0, slot1, slot2)
	return not VersionActivity1_2NoteModel.instance:isAllBonusFinished()
end

function slot0.checkRoleStoryCanExchange(slot0, slot1, slot2)
	return RoleStoryModel.instance:checkTodayCanExchange() and CommonConfig.instance:getConstNum(ConstEnum.RoleStoryPowerCost) <= RoleStoryModel.instance:getLeftNum()
end

function slot0.checkCurBgmGearStateEqual(slot0, slot1, slot2)
	return tonumber(slot2) == BGMSwitchModel.instance:getMechineGear()
end

function slot0.checkCurBgmDeviceNotShowingPPT(slot0, slot1, slot2)
	return not BGMSwitchModel.instance:getEggIsTrigger()
end

function slot0.checkCan174EnoughHpToBet(slot0, slot1, slot2)
	return Activity174Model.instance:getActInfo():getGameInfo().hp > 1
end

function slot0.checkReturnFalse()
	return false
end

return slot0
