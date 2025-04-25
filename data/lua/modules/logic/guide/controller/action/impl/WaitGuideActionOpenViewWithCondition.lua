module("modules.logic.guide.controller.action.impl.WaitGuideActionOpenViewWithCondition", package.seeall)

slot0 = class("WaitGuideActionOpenViewWithCondition", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot2 = string.split(slot0.actionParam, "#")
	slot0._viewName = ViewName[slot2[1]]
	slot0._conditionParam = slot2[3]
	slot0._conditionCheckFun = slot0[slot2[2]]

	if ViewMgr.instance:isOpen(slot0._viewName) and slot0._conditionCheckFun(slot0._conditionParam) then
		slot0:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._checkOpenView, slot0)
end

function slot0._checkOpenView(slot0, slot1, slot2)
	if slot0._viewName == slot1 and slot0._conditionCheckFun(slot0._conditionParam) then
		slot0:clearWork()
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0._checkOpenView, slot0)
end

function slot0.manyFailure()
	if GuideModel.instance:getDoingGuideId() then
		return
	end

	if not (DungeonModel.instance.curLookEpisodeId and lua_episode.configDict[slot1]) then
		return
	end

	if DungeonConfig.instance:getChapterCO(slot2.chapterId).type ~= DungeonEnum.ChapterType.Normal then
		return
	end

	if DungeonModel.instance:hasPassLevel(slot1) then
		return
	end

	if PlayerPrefsHelper.getNumber(PlayerPrefsKey.DungeonFailure .. PlayerModel.instance:getPlayinfo().userId .. slot1, 0) < 3 then
		return
	end

	return true
end

function slot0.enterFightSubEntity()
	if not FightDataHelper.entityMgr:getMyNormalList() or #slot0 < 3 then
		return
	end

	if not FightDataHelper.entityMgr:getMySubList() or #slot1 == 0 then
		return
	end

	if GuideModel.instance:getDoingGuideId() then
		return
	end

	return true
end

function slot0.clearedOneBattle()
	if not WeekWalkModel.instance:getMapInfo(201) then
		return
	end

	slot1, slot2 = slot0:getCurStarInfo()

	return slot1 > 0
end

function slot0.remainStars()
	if not WeekWalkModel.instance:getCurMapInfo() or slot0.isFinish <= 0 then
		return
	end

	slot1, slot2 = slot0:getCurStarInfo()

	return slot1 ~= slot2
end

function slot0.weekWalkFinishLayer()
	if not WeekWalkModel.instance:getCurMapInfo() or slot0.isFinish <= 0 then
		return
	end

	return true
end

function slot0.checkFirstPosHasEquip()
	slot2 = HeroGroupModel.instance:getCurGroupMO():getPosEquips(0).equipUid and slot1[1]

	if slot2 and EquipModel.instance:getEquip(slot2) then
		return true
	end

	return false
end

function slot0.enterWeekWalkMap(slot0)
	return WeekWalkModel.instance:getCurMapId() == tonumber(slot0)
end

function slot0.enterWeekWalkBattle(slot0)
	return DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId).chapterId).type == DungeonEnum.ChapterType.WeekWalk and WeekWalkModel.instance:getCurMapId() == tonumber(slot0)
end

function slot0.checkBuildingPutInObMode(slot0)
	if not RoomController.instance:isObMode() then
		return
	end

	if RoomBuildingController.instance:isBuildingListShow() then
		return
	end

	if not RoomInventoryBuildingModel.instance:checkBuildingPut(slot0) then
		GameFacade.showToast(ToastEnum.WaitGuideActionOpen)

		return false
	end

	return true
end

function slot0.isMainMode()
	if not DungeonModel.instance.curLookChapterId then
		return false
	end

	return DungeonConfig.instance:getChapterCO(slot0).type == DungeonEnum.ChapterType.Normal
end

function slot0.isHardMode()
	return DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId).chapterId).type == DungeonEnum.ChapterType.Hard
end

function slot0.isEditMode()
	return RoomController.instance:isEditMode()
end

function slot0.isObMode()
	return RoomController.instance:isObMode()
end

function slot0.buildingStrengthen()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
		return
	end

	if not RoomController.instance:isObMode() then
		return false
	end

	if ItemModel.instance:getItemCount(190007) <= 0 then
		return false
	end

	for slot6, slot7 in ipairs(RoomMapBuildingModel.instance:getBuildingMOList()) do
		if slot7.buildingId == 2002 then
			return true
		end
	end

	return false
end

function slot0.openSeasonDiscount()
	return Activity104Model.instance:isEnterSpecial()
end

function slot0.checkAct114CanGuide()
	return Activity114Model.instance:have114StoryFlow()
end

function slot0.checkActivity1_2DungeonBuildingNum()
	return VersionActivity1_2DungeonModel.instance:getBuildingGainList() and #slot0 > 0
end

function slot0.checkActivity1_2DungeonTrapPutting()
	return VersionActivity1_2DungeonModel.instance:getTrapPutting() and slot0 ~= 0
end

function slot0.check1_2DungeonCollectAllNote()
	return VersionActivity1_2NoteModel.instance:isCollectedAllNote()
end

function slot0.checkInEliminateEpisode(slot0)
	return EliminateTeamSelectionModel.instance:getSelectedEpisodeId() == tonumber(slot0)
end

function slot0.checkInWindows(slot0)
	return BootNativeUtil.isWindows()
end

function slot0.enterWuErLiXiMap(slot0)
	return WuErLiXiMapModel.instance:getCurMapId() == tonumber(slot0)
end

function slot0.enterFeiLinShiDuoMap(slot0)
	return FeiLinShiDuoGameModel.instance:getCurMapId() == tonumber(slot0)
end

function slot0.isOpenEpisode(slot0)
	return LiangYueModel.instance:getCurEpisodeId() == tonumber(slot0)
end

function slot0.isAutoChessInEpisodeAndRound(slot0)
	if not AutoChessModel.instance.episodeId or AutoChessModel.instance.episodeId ~= string.splitToNumber(slot0, ",")[1] then
		return
	end

	if AutoChessModel.instance:getChessMo() == nil or slot3.sceneRound == nil then
		return false
	end

	return slot3.sceneRound == slot1[2]
end

function slot0.isUnlockEpisode(slot0)
	return LiangYueModel.instance:isEpisodeFinish(LiangYueModel.instance:getCurActId(), slot0) == tonumber(slot0)
end

return slot0
