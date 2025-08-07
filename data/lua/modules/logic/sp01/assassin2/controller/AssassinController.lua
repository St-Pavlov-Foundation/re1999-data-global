module("modules.logic.sp01.assassin2.controller.AssassinController", package.seeall)

local var_0_0 = class("AssassinController", BaseController)

function var_0_0.getAssassinOutsideInfo(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if not AssassinOutsideModel.instance:isAct195Open(arg_1_3) then
		return
	end

	local var_1_0 = AssassinOutsideModel.instance:getAct195Id()

	AssassinOutSideRpc.instance:sendGetAssassinOutSideInfoRequest(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onGetAssassinOutSideInfo(arg_2_0, arg_2_1)
	AssassinOutsideModel.instance:updateAllInfo(arg_2_1.buildingInfo, arg_2_1.unlockMapIds, arg_2_1.questInfo, arg_2_1.coin)
	AssassinItemModel.instance:updateAllInfo(arg_2_1.items)
	AssassinHeroModel.instance:updateAllInfo(arg_2_1.heroInfo)
	arg_2_0:dispatchEvent(AssassinEvent.OnAllAssassinOutSideInfoUpdate)
end

function var_0_0.onUnlockQuestContent(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	AssassinOutsideModel.instance:unlockMapList(arg_3_1)
	AssassinOutsideModel.instance:unlockQuestList(arg_3_4)
	AssassinHeroModel.instance:updateAssassinHeroInfoByList(arg_3_3)
	AssassinItemModel.instance:unlockNewItems(arg_3_2)

	if arg_3_2 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
			local var_3_0 = iter_3_1.itemId
			local var_3_1 = AssassinHelper.getPlayerCacheDataKey(AssassinEnum.PlayerCacheDataKey.NewAssassinItem, var_3_0)

			arg_3_0:setIsNewItem(var_3_1, true)
		end
	end

	arg_3_0:dispatchEvent(AssassinEvent.OnUnlockQuestContent)
end

function var_0_0.openAssassinMapView(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._tmpOpenAssassinMapParam = arg_4_1 or {}
	arg_4_0._tmpOpenAssassinMapParam.needLoginView = arg_4_2

	arg_4_0:getAssassinOutsideInfo(arg_4_0._openAssassinMapViewAfterGetInfo, arg_4_0, true)
end

function var_0_0._openAssassinMapViewAfterGetInfo(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 ~= 0 then
		return
	end

	if arg_5_0._tmpOpenAssassinMapParam and arg_5_0._tmpOpenAssassinMapParam.needLoginView then
		ViewMgr.instance:openView(ViewName.AssassinLoginView, arg_5_0._tmpOpenAssassinMapParam)
	else
		arg_5_0:realOpenAssassinMapView(arg_5_0._tmpOpenAssassinMapParam)
	end

	arg_5_0._tmpOpenAssassinMapParam = nil
end

function var_0_0.realOpenAssassinMapView(arg_6_0, arg_6_1)
	ViewMgr.instance:openView(ViewName.AssassinMapView, arg_6_1)
	ViewMgr.instance:closeView(ViewName.AssassinLoginView, true)
end

function var_0_0.openAssassinQuestMapView(arg_7_0, arg_7_1)
	ViewMgr.instance:openView(ViewName.AssassinQuestMapView, arg_7_1)
end

function var_0_0.clickQuestItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if AssassinOutsideModel.instance:isFinishQuest(arg_8_1) then
		return
	end

	arg_8_0:dispatchEvent(AssassinEvent.OnClickQuestItem, arg_8_1, arg_8_2, arg_8_3)
end

function var_0_0.startQuest(arg_9_0, arg_9_1, arg_9_2)
	if not AssassinOutsideModel.instance:isUnlockQuest(arg_9_1) then
		return
	end

	local var_9_0 = ({
		[AssassinEnum.QuestType.Fight] = arg_9_0._enterHeroPick,
		[AssassinEnum.QuestType.Dialog] = arg_9_0._enterDialog,
		[AssassinEnum.QuestType.Stealth] = arg_9_0._enterHeroPick
	})[AssassinConfig.instance:getQuestType(arg_9_1)]

	if not var_9_0 then
		logError(string.format("AssassinController:startQuest error, no handle func, questId:%s", arg_9_1))

		return
	end

	var_9_0(arg_9_0, arg_9_1, arg_9_2)
end

function var_0_0._enterDialog(arg_10_0, arg_10_1)
	local var_10_0 = tonumber(AssassinConfig.instance:getQuestParam(arg_10_1))
	local var_10_1 = AssassinConfig.instance:getLibrarConfig(var_10_0)

	if not var_10_1 then
		return
	end

	local var_10_2 = var_10_1.talk

	if var_10_2 and var_10_2 ~= 0 then
		DialogueController.instance:enterDialogue(var_10_2, arg_10_0._onCloseDialog, arg_10_0, arg_10_1)
	else
		arg_10_0:finishQuest(arg_10_1)
		arg_10_0:openAssassinLibraryDetailView(var_10_0)
	end
end

function var_0_0._onCloseDialog(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_2 then
		return
	end

	arg_11_0:finishQuest(arg_11_1)

	local var_11_0 = tonumber(AssassinConfig.instance:getQuestParam(arg_11_1))

	arg_11_0:openAssassinLibraryDetailView(var_11_0)
end

function var_0_0._enterHeroPick(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	arg_12_0:openAssassinHeroView(arg_12_1)
end

function var_0_0.finishQuest(arg_13_0, arg_13_1)
	AssassinOutSideRpc.instance:sendInteractiveRequest(arg_13_1, arg_13_0._onFinishQuestInteractiveCb, arg_13_0)
end

function var_0_0._onFinishQuestInteractiveCb(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_2 ~= 0 then
		return
	end

	arg_14_0:updateCoinNum(arg_14_3.coin)
	arg_14_0:onFinishQuest(arg_14_3.questId)
end

function var_0_0.onFinishQuest(arg_15_0, arg_15_1)
	AssassinOutsideModel.instance:finishQuest(arg_15_1)
	arg_15_0:dispatchEvent(AssassinEvent.OnFinishQuest)
end

function var_0_0.setHasPlayedAnimation(arg_16_0, arg_16_1)
	local var_16_0 = AssassinOutsideModel.instance:getPlayerCacheData()

	if not var_16_0 then
		return
	end

	var_16_0[arg_16_1] = true

	AssassinOutsideModel.instance:saveCacheData()
end

function var_0_0.setIsNewItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = AssassinOutsideModel.instance:getPlayerCacheData()

	if not var_17_0 then
		return
	end

	if arg_17_2 then
		var_17_0[arg_17_1] = true
	else
		var_17_0[arg_17_1] = nil
	end

	AssassinOutsideModel.instance:saveCacheData()
end

function var_0_0.enterQuestFight(arg_18_0, arg_18_1)
	if (arg_18_1 and AssassinConfig.instance:getQuestType(arg_18_1)) ~= AssassinEnum.QuestType.Fight then
		return
	end

	local var_18_0 = AssassinConfig.instance:getQuestParam(arg_18_1)
	local var_18_1 = tonumber(var_18_0)
	local var_18_2 = lua_episode.configDict[var_18_1]
	local var_18_3 = var_18_2 and var_18_2.battleId
	local var_18_4 = lua_battle.configDict[var_18_3]

	if not var_18_4 then
		logError(string.format("AssassinController:enterQuestFight error, not battleCfg, questId:%s, episodeId:%s, battleId:%s", arg_18_1, var_18_1, var_18_3))

		return
	end

	AssassinOutsideModel.instance:setEnterFightQuest(arg_18_1)
	DungeonModel.instance:SetSendChapterEpisodeId(nil, var_18_1)
	FightController.instance:setFightParamByEpisodeId(var_18_1, false, 1)

	local var_18_5 = FightModel.instance:getFightParam()

	if not var_18_5 then
		return false
	end

	local var_18_6 = {}
	local var_18_7 = {}
	local var_18_8 = {}
	local var_18_9 = {}
	local var_18_10 = var_18_4.roleNum
	local var_18_11 = tostring(0)
	local var_18_12 = AssassinStealthGameModel.instance:getPickHeroList()

	for iter_18_0 = 1, var_18_10 do
		local var_18_13 = var_18_12[iter_18_0]
		local var_18_14

		if var_18_13 then
			var_18_14 = AssassinHeroModel.instance:getHeroMo(var_18_13)
		end

		local var_18_15 = var_18_11

		if var_18_14 then
			var_18_15 = var_18_14.uid
			var_18_9[#var_18_9 + 1] = var_18_14.trialCo.id
		end

		var_18_6[iter_18_0] = var_18_15

		local var_18_16 = FightEquipMO.New()

		var_18_16.heroUid = var_18_15
		var_18_16.equipUid = {
			var_18_11
		}

		table.insert(var_18_8, var_18_16)
	end

	HeroGroupTrialModel.instance:setTrailByTrialIdList(var_18_9)
	var_18_5:setMySide(0, var_18_6, var_18_7, var_18_8)
	DungeonFightController.instance:sendStartDungeonRequest(var_18_5.chapterId, var_18_5.episodeId, var_18_5, var_18_5.multiplication)
end

function var_0_0.openAssassinHeroView(arg_19_0, arg_19_1)
	ViewMgr.instance:openView(ViewName.AssassinHeroView, {
		questId = arg_19_1
	})
end

function var_0_0.openHeroStatsView(arg_20_0, arg_20_1)
	ViewMgr.instance:openView(ViewName.AssassinStatsView, arg_20_1)
end

function var_0_0.openAssassinBackpackView(arg_21_0, arg_21_1)
	AssassinBackpackListModel.instance:setAssassinBackpackList()

	local var_21_0 = AssassinBackpackListModel.instance:getList()

	if not var_21_0 or #var_21_0 <= 0 then
		GameFacade.showToast(ToastEnum.AssassinStealthNoItem)

		return
	end

	ViewMgr.instance:openView(ViewName.AssassinBackpackView, arg_21_1)
end

function var_0_0.openAssassinEquipView(arg_22_0, arg_22_1)
	ViewMgr.instance:openView(ViewName.AssassinEquipView, arg_22_1)
end

function var_0_0.changeCareerEquip(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_1 or not arg_23_2 then
		return
	end

	if not AssassinConfig.instance:isAssassinHeroCanChangeToCareer(arg_23_1, arg_23_2) then
		return
	end

	if AssassinHeroModel.instance:getAssassinCareerId(arg_23_1) == arg_23_2 then
		return
	end

	AssassinOutSideRpc.instance:sendHeroTransferCareerRequest(arg_23_1, arg_23_2, arg_23_0._changeCareerEquipFinish, arg_23_0)
end

function var_0_0._changeCareerEquipFinish(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_2 ~= 0 then
		return
	end

	AssassinHeroModel.instance:updateAssassinHeroInfo(arg_24_3.hero)
	arg_24_0:dispatchEvent(AssassinEvent.OnChangeAssassinHeroCareer)
end

function var_0_0.backpackSelectItem(arg_25_0, arg_25_1, arg_25_2)
	AssassinBackpackListModel.instance:selectCell(arg_25_1, true)

	local var_25_0 = AssassinBackpackListModel.instance:getSelectedItemId()
	local var_25_1 = AssassinHelper.getPlayerCacheDataKey(AssassinEnum.PlayerCacheDataKey.NewAssassinItem, var_25_0)

	arg_25_0:setIsNewItem(var_25_1, false)
	arg_25_0:dispatchEvent(AssassinEvent.OnSelectBackpackItem, arg_25_2)
end

function var_0_0.changeEquippedItem(arg_26_0, arg_26_1)
	local var_26_0 = AssassinBackpackListModel.instance:getSelectedItemId()

	if not arg_26_1 or not var_26_0 then
		logError("AssassinController:changeEquippedItem error, has nil args, assassinHeroId:%s,assassinItemId:%s", arg_26_1, var_26_0)

		return
	end

	local var_26_1 = AssassinEnum.Const.EmptyAssassinItemType
	local var_26_2 = AssassinHeroModel.instance:getItemCarryIndex(arg_26_1, var_26_0)

	if not var_26_2 then
		var_26_2 = AssassinHeroModel.instance:findEmptyItemGridIndex(arg_26_1)

		if not var_26_2 then
			return
		end

		var_26_1 = AssassinConfig.instance:getAssassinItemType(var_26_0)
	end

	AssassinOutSideRpc.instance:sendEquipHeroItemRequest(arg_26_1, var_26_2, var_26_1, arg_26_0._changeEquippedItemFinish, arg_26_0)
end

function var_0_0._changeEquippedItemFinish(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if arg_27_2 ~= 0 then
		return
	end

	AssassinHeroModel.instance:updateAssassinHeroInfo(arg_27_3.hero)
	arg_27_0:dispatchEvent(AssassinEvent.OnChangeEquippedItem)
end

function var_0_0.openAssassinQuestDetailView(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = AssassinOutsideModel.instance:getProcessingQuest()
	local var_28_1 = var_28_0 and var_28_0 ~= 0

	if arg_28_2 and var_28_1 then
		AssassinStealthGameController.instance:returnAssassinStealthGame(var_28_0, arg_28_2)
	else
		ViewMgr.instance:openView(ViewName.AssassinQuestDetailView, {
			questId = arg_28_1,
			worldPos = arg_28_3
		})
	end
end

function var_0_0.openAssassinStealthGameOverView(arg_29_0, arg_29_1)
	if not arg_29_1 and not AssassinStealthGameModel.instance:getMapId() then
		logError("AssassinController:openAssassinStealthGameOverView error, questId and gameMapId is nil")

		return
	end

	ViewMgr.instance:openView(ViewName.AssassinStealthGameOverView, {
		questId = arg_29_1
	})
end

function var_0_0.openAssassinStealthGameGetItemView(arg_30_0, arg_30_1)
	if not arg_30_1 or not next(arg_30_1) then
		return
	end

	ViewMgr.instance:openView(ViewName.AssassinStealthGameGetItemView, arg_30_1)
end

function var_0_0.openAssassinStealthGamePauseView(arg_31_0)
	if not AssassinStealthGameModel.instance:isPlayerTurn() then
		return
	end

	ViewMgr.instance:openView(ViewName.AssassinStealthGamePauseView)
end

function var_0_0.openAssassinStealthGameResultView(arg_32_0)
	ViewMgr.instance:openView(ViewName.AssassinStealthGameResultView)
	ViewMgr.instance:closeView(ViewName.AssassinStealthGameGetItemView)
	ViewMgr.instance:closeView(ViewName.AssassinStealthGameOverView)
	ViewMgr.instance:closeView(ViewName.AssassinStealthGameEventView)
end

function var_0_0.openAssassinStealthGameEventView(arg_33_0)
	ViewMgr.instance:openView(ViewName.AssassinStealthGameEventView)
end

function var_0_0.openAssassinStealthTechniqueView(arg_34_0, arg_34_1)
	ViewMgr.instance:openView(ViewName.AssassinTechniqueView, {
		viewParam = arg_34_1
	})
end

function var_0_0.openAssassinLibraryView(arg_35_0, arg_35_1, arg_35_2)
	AssassinOutSideRpc.instance:sendGetAssassinLibraryInfoRequest(VersionActivity2_9Enum.ActivityId.Outside, function(arg_36_0, arg_36_1)
		if arg_36_1 ~= 0 then
			return
		end

		local var_36_0 = arg_35_2 and AssassinEnum.LibraryType2TabViewId[arg_35_2] or 1
		local var_36_1 = {
			[AssassinEnum.LibraryInfoViewTabId] = var_36_0
		}
		local var_36_2 = {
			actId = arg_35_1,
			libraryType = arg_35_2,
			defaultTabIds = var_36_1
		}

		ViewMgr.instance:openView(ViewName.AssassinLibraryView, var_36_2)
	end)
end

function var_0_0.openAssassinLibraryDetailView(arg_37_0, arg_37_1)
	local var_37_0 = AssassinConfig.instance:getLibrarConfig(arg_37_1)

	if (var_37_0 and var_37_0.type) == AssassinEnum.LibraryType.Video then
		local var_37_1 = string.splitToNumber(var_37_0.storyId, "#")

		StoryController.instance:playStories(var_37_1)
		AssassinLibraryModel.instance:readLibrary(arg_37_1)
	else
		ViewMgr.instance:openView(ViewName.AssassinLibraryDetailView, {
			libraryId = arg_37_1
		})
	end
end

function var_0_0.openAssassinBuildingMapView(arg_38_0, arg_38_1)
	ViewMgr.instance:openView(ViewName.AssassinBuildingMapView, arg_38_1)
end

function var_0_0.openAssassinBuildingLevelUpView(arg_39_0, arg_39_1)
	local var_39_0 = {
		buildingType = arg_39_1
	}

	ViewMgr.instance:openView(ViewName.AssassinBuildingLevelUpView, var_39_0)
end

function var_0_0.updateBuildingInfo(arg_40_0, arg_40_1)
	local var_40_0 = AssassinOutsideModel.instance:getBuildingMapMo()

	if not var_40_0 then
		return
	end

	var_40_0:updateBuildingInfo(arg_40_1)
	var_0_0.instance:dispatchEvent(AssassinEvent.UpdateBuildingInfo, arg_40_1.type)
end

function var_0_0.onGetBuildingUnlockInfo(arg_41_0, arg_41_1)
	local var_41_0 = AssassinOutsideModel.instance:getBuildingMapMo()

	if not var_41_0 or not arg_41_1 or #arg_41_1 <= 0 then
		return
	end

	var_41_0:updateUnlockBuildIds(arg_41_1)
	var_0_0.instance:dispatchEvent(AssassinEvent.UnlockBuildings, arg_41_1)
end

function var_0_0.openAssassinTaskView(arg_42_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.AssassinOutside
	}, function()
		ViewMgr.instance:openView(ViewName.AssassinTaskView)
	end)
end

function var_0_0.getCoinNum(arg_44_0)
	local var_44_0 = AssassinOutsideModel.instance:getOutsideMo()

	return var_44_0 and var_44_0:getCoinNum() or 0
end

function var_0_0.updateCoinNum(arg_45_0, arg_45_1)
	local var_45_0 = AssassinOutsideModel.instance:getOutsideMo()

	if not var_45_0 then
		return
	end

	AssassinOutsideModel.instance:updateIsNeedPlayGetCoin(arg_45_1)
	var_45_0:updateCoinNum(arg_45_1)
	arg_45_0:dispatchEvent(AssassinEvent.UpdateCoinNum, arg_45_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
