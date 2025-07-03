module("modules.logic.guide.controller.action.impl.WaitGuideActionOpenViewWithCondition", package.seeall)

local var_0_0 = class("WaitGuideActionOpenViewWithCondition", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.split(arg_1_0.actionParam, "#")

	arg_1_0._viewName = ViewName[var_1_0[1]]

	local var_1_1 = var_1_0[2]

	arg_1_0._conditionParam = var_1_0[3]
	arg_1_0._conditionCheckFun = arg_1_0[var_1_1]

	if ViewMgr.instance:isOpen(arg_1_0._viewName) and arg_1_0._conditionCheckFun(arg_1_0._conditionParam) then
		arg_1_0:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0._checkOpenView, arg_1_0)
end

function var_0_0._checkOpenView(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0._viewName == arg_2_1 and arg_2_0._conditionCheckFun(arg_2_0._conditionParam) then
		arg_2_0:clearWork()
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_3_0._checkOpenView, arg_3_0)
end

function var_0_0.manyFailure()
	if GuideModel.instance:getDoingGuideId() then
		return
	end

	local var_4_0 = DungeonModel.instance.curLookEpisodeId
	local var_4_1 = var_4_0 and lua_episode.configDict[var_4_0]

	if not var_4_1 then
		return
	end

	if DungeonConfig.instance:getChapterCO(var_4_1.chapterId).type ~= DungeonEnum.ChapterType.Normal then
		return
	end

	if DungeonModel.instance:hasPassLevel(var_4_0) then
		return
	end

	local var_4_2 = PlayerPrefsKey.DungeonFailure .. PlayerModel.instance:getPlayinfo().userId .. var_4_0

	if PlayerPrefsHelper.getNumber(var_4_2, 0) < 3 then
		return
	end

	return true
end

function var_0_0.enterFightSubEntity()
	local var_5_0 = FightDataHelper.entityMgr:getMyNormalList()

	if not var_5_0 or #var_5_0 < 3 then
		return
	end

	local var_5_1 = FightDataHelper.entityMgr:getMySubList()

	if not var_5_1 or #var_5_1 == 0 then
		return
	end

	if GuideModel.instance:getDoingGuideId() then
		return
	end

	return true
end

function var_0_0.clearedOneBattle()
	local var_6_0 = WeekWalkModel.instance:getMapInfo(201)

	if not var_6_0 then
		return
	end

	local var_6_1, var_6_2 = var_6_0:getCurStarInfo()

	return var_6_1 > 0
end

function var_0_0.remainStars()
	local var_7_0 = WeekWalkModel.instance:getCurMapInfo()

	if not var_7_0 or var_7_0.isFinish <= 0 then
		return
	end

	local var_7_1, var_7_2 = var_7_0:getCurStarInfo()

	return var_7_1 ~= var_7_2
end

function var_0_0.weekWalkFinishLayer()
	local var_8_0 = WeekWalkModel.instance:getCurMapInfo()

	if not var_8_0 or var_8_0.isFinish <= 0 then
		return
	end

	return true
end

function var_0_0.checkFirstPosHasEquip()
	local var_9_0 = HeroGroupModel.instance:getCurGroupMO():getPosEquips(0).equipUid
	local var_9_1 = var_9_0 and var_9_0[1]

	if var_9_1 and EquipModel.instance:getEquip(var_9_1) then
		return true
	end

	return false
end

function var_0_0.enterWeekWalkMap(arg_10_0)
	return WeekWalkModel.instance:getCurMapId() == tonumber(arg_10_0)
end

function var_0_0.enterWeekWalkBattle(arg_11_0)
	local var_11_0 = HeroGroupModel.instance.episodeId
	local var_11_1 = DungeonConfig.instance:getEpisodeCO(var_11_0)

	return DungeonConfig.instance:getChapterCO(var_11_1.chapterId).type == DungeonEnum.ChapterType.WeekWalk and WeekWalkModel.instance:getCurMapId() == tonumber(arg_11_0)
end

function var_0_0.checkBuildingPutInObMode(arg_12_0)
	if not RoomController.instance:isObMode() then
		return
	end

	if RoomBuildingController.instance:isBuildingListShow() then
		return
	end

	if not RoomInventoryBuildingModel.instance:checkBuildingPut(arg_12_0) then
		GameFacade.showToast(ToastEnum.WaitGuideActionOpen)

		return false
	end

	return true
end

function var_0_0.isMainMode()
	local var_13_0 = DungeonModel.instance.curLookChapterId

	if not var_13_0 then
		return false
	end

	return DungeonConfig.instance:getChapterCO(var_13_0).type == DungeonEnum.ChapterType.Normal
end

function var_0_0.isHardMode()
	local var_14_0 = HeroGroupModel.instance.episodeId
	local var_14_1 = DungeonConfig.instance:getEpisodeCO(var_14_0)

	return DungeonConfig.instance:getChapterCO(var_14_1.chapterId).type == DungeonEnum.ChapterType.Hard
end

function var_0_0.isEditMode()
	return RoomController.instance:isEditMode()
end

function var_0_0.isObMode()
	return RoomController.instance:isObMode()
end

function var_0_0.buildingStrengthen()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
		return
	end

	if not RoomController.instance:isObMode() then
		return false
	end

	if ItemModel.instance:getItemCount(190007) <= 0 then
		return false
	end

	local var_17_0 = RoomMapBuildingModel.instance:getBuildingMOList()

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		if iter_17_1.buildingId == 2002 then
			return true
		end
	end

	return false
end

function var_0_0.openSeasonDiscount()
	return Activity104Model.instance:isEnterSpecial()
end

function var_0_0.checkAct114CanGuide()
	return Activity114Model.instance:have114StoryFlow()
end

function var_0_0.checkActivity1_2DungeonBuildingNum()
	local var_20_0 = VersionActivity1_2DungeonModel.instance:getBuildingGainList()

	return var_20_0 and #var_20_0 > 0
end

function var_0_0.checkActivity1_2DungeonTrapPutting()
	local var_21_0 = VersionActivity1_2DungeonModel.instance:getTrapPutting()

	return var_21_0 and var_21_0 ~= 0
end

function var_0_0.check1_2DungeonCollectAllNote()
	return VersionActivity1_2NoteModel.instance:isCollectedAllNote()
end

function var_0_0.checkInEliminateEpisode(arg_23_0)
	return EliminateTeamSelectionModel.instance:getSelectedEpisodeId() == tonumber(arg_23_0)
end

function var_0_0.checkInWindows(arg_24_0)
	return BootNativeUtil.isWindows()
end

function var_0_0.enterWuErLiXiMap(arg_25_0)
	return WuErLiXiMapModel.instance:getCurMapId() == tonumber(arg_25_0)
end

function var_0_0.enterFeiLinShiDuoMap(arg_26_0)
	return FeiLinShiDuoGameModel.instance:getCurMapId() == tonumber(arg_26_0)
end

function var_0_0.isOpenEpisode(arg_27_0)
	return LiangYueModel.instance:getCurEpisodeId() == tonumber(arg_27_0)
end

function var_0_0.isAutoChessInEpisodeAndRound(arg_28_0)
	local var_28_0 = string.splitToNumber(arg_28_0, ",")
	local var_28_1 = var_28_0[1]

	if not AutoChessModel.instance.episodeId or AutoChessModel.instance.episodeId ~= var_28_1 then
		return
	end

	local var_28_2 = AutoChessModel.instance:getChessMo()

	if var_28_2 == nil or var_28_2.sceneRound == nil then
		return false
	end

	local var_28_3 = var_28_0[2]

	return var_28_2.sceneRound == var_28_3
end

function var_0_0.isUnlockEpisode(arg_29_0)
	local var_29_0 = LiangYueModel.instance:getCurActId()

	return LiangYueModel.instance:isEpisodeFinish(var_29_0, arg_29_0) == tonumber(arg_29_0)
end

function var_0_0.checkAct191NodeType(arg_30_0)
	arg_30_0 = tonumber(arg_30_0)

	local var_30_0 = Activity191Model.instance:getActInfo()

	if var_30_0 then
		local var_30_1 = var_30_0:getGameInfo()
		local var_30_2 = var_30_1:getNodeInfoById(var_30_1.curNode)

		if #var_30_2.selectNodeStr ~= 0 then
			local var_30_3 = Act191NodeDetailMO.New()

			var_30_3:init(var_30_2.selectNodeStr[1])

			if arg_30_0 == 1 and Activity191Helper.isPveBattle(var_30_3.type) then
				return true
			elseif arg_30_0 == 2 and Activity191Helper.isPvpBattle(var_30_3.type) then
				return true
			end
		end
	end

	return false
end

function var_0_0.checkAct191Stage(arg_31_0)
	arg_31_0 = tonumber(arg_31_0)

	local var_31_0 = Activity191Model.instance:getActInfo()

	if var_31_0 then
		local var_31_1 = var_31_0:getGameInfo()

		if var_31_1 and var_31_1.curStage == arg_31_0 then
			return true
		end
	end

	return false
end

function var_0_0.commonCheck(arg_32_0)
	if not arg_32_0 then
		return false
	end

	local var_32_0 = string.split(arg_32_0, "_")
	local var_32_1 = _G[var_32_0[1]]

	if not var_32_1 then
		return false
	end

	local var_32_2 = var_32_1[var_32_0[2]]

	if not var_32_2 then
		return false
	end

	if var_32_1.instance then
		return var_32_2(var_32_1.instance, unpack(var_32_0, 3))
	else
		return var_32_2(unpack(var_32_0, 3))
	end
end

return var_0_0
