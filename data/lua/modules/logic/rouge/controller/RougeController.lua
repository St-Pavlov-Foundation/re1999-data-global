module("modules.logic.rouge.controller.RougeController", package.seeall)

local var_0_0 = class("RougeController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	StoryController.instance:registerCallback(StoryEvent.Start, arg_3_0._onStoryStart, arg_3_0)
end

function var_0_0._onStoryStart(arg_4_0, arg_4_1)
	if RougeFavoriteConfig.instance:inRougeStoryList(arg_4_1) and not RougeOutsideModel.instance:storyIsPass(arg_4_1) then
		RougeOutsideRpc.instance:sendRougeUnlockStoryRequest(RougeOutsideModel.instance:season(), arg_4_1)
	end
end

function var_0_0.enterRouge(arg_5_0)
	DungeonModel.instance.curSendEpisodeId = nil

	GameSceneMgr.instance:startScene(SceneType.Rouge, 1, 1, true)
end

function var_0_0.openRougeMainView(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if not RougeOutsideModel.instance:isUnlock() then
		GameFacade.showToast(RougeOutsideModel.instance:openUnlockId())

		return
	end

	local var_6_0 = RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(var_6_0, function(arg_7_0, arg_7_1)
		if arg_7_1 ~= 0 then
			logError("RougeController:openRougeMainView resultCode=" .. tostring(arg_7_1))

			return
		end

		RougeOutsideRpc.instance:sendRougeGetNewReddotInfoRequest(var_6_0)
		RougeRpc.instance:sendGetRougeInfoRequest(var_6_0, function(arg_8_0, arg_8_1)
			if arg_8_1 ~= 0 then
				logError("RougeController:openRougeMainView resultCode=" .. tostring(arg_8_1))

				return
			end

			ViewMgr.instance:openView(ViewName.RougeMainView, arg_6_1, arg_6_2)

			if arg_6_3 then
				arg_6_3(arg_6_4)
			end
		end)
	end)
end

function var_0_0.openRougeDifficultyView(arg_9_0, arg_9_1, arg_9_2)
	ViewMgr.instance:openView(ViewName.RougeDifficultyView, arg_9_1, arg_9_2)
end

function var_0_0.openRougeSelectRewardsView(arg_10_0, arg_10_1, arg_10_2)
	ViewMgr.instance:openView(ViewName.RougeCollectionGiftView, arg_10_1, arg_10_2)
end

function var_0_0.openRougeFactionView(arg_11_0, arg_11_1, arg_11_2)
	ViewMgr.instance:openView(ViewName.RougeFactionView, arg_11_1, arg_11_2)
end

function var_0_0.createTeamViewParam(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	return {
		heroNum = arg_12_1,
		callback = arg_12_2,
		callbackTarget = arg_12_3
	}
end

function var_0_0.openRougeTeamView(arg_13_0, arg_13_1, arg_13_2)
	arg_13_1 = arg_13_1 or {}
	arg_13_1.teamType = RougeEnum.TeamType.View

	ViewMgr.instance:openView(ViewName.RougeTeamView, arg_13_1, arg_13_2)
end

function var_0_0.openRougeTeamTreatView(arg_14_0, arg_14_1, arg_14_2)
	arg_14_1 = arg_14_1 or {}
	arg_14_1.teamType = RougeEnum.TeamType.Treat

	ViewMgr.instance:openView(ViewName.RougeTeamView, arg_14_1, arg_14_2)
end

function var_0_0.openRougeTeamReviveView(arg_15_0, arg_15_1, arg_15_2)
	arg_15_1 = arg_15_1 or {}
	arg_15_1.teamType = RougeEnum.TeamType.Revive

	ViewMgr.instance:openView(ViewName.RougeTeamView, arg_15_1, arg_15_2)
end

function var_0_0.openRougeTeamAssignmentView(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1 = arg_16_1 or {}
	arg_16_1.teamType = RougeEnum.TeamType.Assignment

	ViewMgr.instance:openView(ViewName.RougeTeamView, arg_16_1, arg_16_2)
end

function var_0_0.openRougeReviewView(arg_17_0, arg_17_1, arg_17_2)
	ViewMgr.instance:openView(ViewName.RougeReviewView, arg_17_1, arg_17_2)
end

function var_0_0.openRougeIllustrationListView(arg_18_0, arg_18_1, arg_18_2)
	ViewMgr.instance:openView(ViewName.RougeIllustrationListView, arg_18_1, arg_18_2)
end

function var_0_0.openRougeIllustrationDetailView(arg_19_0, arg_19_1, arg_19_2)
	ViewMgr.instance:openView(ViewName.RougeIllustrationDetailView, arg_19_1, arg_19_2)
end

function var_0_0.openRougeFactionIllustrationView(arg_20_0, arg_20_1, arg_20_2)
	ViewMgr.instance:openView(ViewName.RougeFactionIllustrationView, arg_20_1, arg_20_2)
end

function var_0_0.openRougeFactionIllustrationDetailView(arg_21_0, arg_21_1, arg_21_2)
	ViewMgr.instance:openView(ViewName.RougeFactionIllustrationDetailView, arg_21_1, arg_21_2)
end

function var_0_0.openRougeFavoriteView(arg_22_0, arg_22_1, arg_22_2)
	ViewMgr.instance:openView(ViewName.RougeFavoriteView, arg_22_1, arg_22_2)
end

function var_0_0.openRougeFavoriteCollectionView(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendRougeGetUnlockCollectionsRequest(var_23_0, function(arg_24_0, arg_24_1)
		ViewMgr.instance:openView(ViewName.RougeFavoriteCollectionView, arg_23_1, arg_23_2)
	end)
end

function var_0_0.openRougeTalentView(arg_25_0, arg_25_1, arg_25_2)
	ViewMgr.instance:openView(ViewName.RougeTalentView, arg_25_1, arg_25_2)
end

function var_0_0.openRougeResultReportView(arg_26_0, arg_26_1, arg_26_2)
	ViewMgr.instance:openView(ViewName.RougeResultReportView, arg_26_1, arg_26_2)
end

function var_0_0.openRougeTalentTreeTrunkView(arg_27_0, arg_27_1, arg_27_2)
	ViewMgr.instance:openView(ViewName.RougeTalentTreeTrunkView, arg_27_1, arg_27_2)
end

function var_0_0.openRougeRewardView(arg_28_0, arg_28_1, arg_28_2)
	ViewMgr.instance:openView(ViewName.RougeRewardView, arg_28_1, arg_28_2)
end

function var_0_0.openRougeInitTeamView(arg_29_0, arg_29_1, arg_29_2)
	RougeHeroGroupModel.instance:clear()
	RougeHeroGroupModel.instance:onGetHeroGroupList(RougeModel.instance:getTeamInfo():getGroupInfos())

	local var_29_0 = RougeHeroGroupMO.New()
	local var_29_1 = 1

	var_29_0:setMaxHeroCount(RougeEnum.InitTeamHeroNum)
	var_29_0:init({
		groupId = var_29_1
	})
	RougeHeroSingleGroupModel.instance:setMaxHeroCount(RougeEnum.InitTeamHeroNum)
	RougeHeroSingleGroupModel.instance:setSingleGroup(var_29_0)
	ViewMgr.instance:openView(ViewName.RougeInitTeamView, arg_29_1, arg_29_2)
end

function var_0_0.openSelectHero(arg_30_0, arg_30_1, arg_30_2)
	RougeHeroGroupModel.instance:clear()

	local var_30_0 = RougeHeroGroupMO.New()
	local var_30_1 = 1

	var_30_0:setMaxHeroCount(RougeEnum.InitTeamHeroNum)
	var_30_0:init({
		groupId = var_30_1
	})
	RougeHeroSingleGroupModel.instance:setMaxHeroCount(RougeEnum.InitTeamHeroNum)
	RougeHeroSingleGroupModel.instance:setSingleGroup(var_30_0)

	local var_30_2 = RougeConfig1.instance:getConstValueByID(RougeEnum.Const.SelectHeroCapacity)
	local var_30_3 = tonumber(var_30_2)
	local var_30_4 = 1
	local var_30_5 = {
		singleGroupMOId = var_30_4,
		originalHeroUid = RougeHeroSingleGroupModel.instance:getHeroUid(var_30_4),
		equips = {
			"0"
		},
		heroGroupEditType = RougeEnum.HeroGroupEditType.SelectHero
	}

	var_30_5.selectHeroCapacity = 0
	var_30_5.curCapacity = 0
	var_30_5.totalCapacity = var_30_3
	var_30_5.selectHeroCallback = arg_30_1
	var_30_5.selectHeroCallbackTarget = arg_30_2

	ViewMgr.instance:openView(ViewName.RougeHeroGroupEditView, var_30_5)
end

function var_0_0.openRougeCollectionTipView(arg_31_0, arg_31_1, arg_31_2)
	ViewMgr.instance:openView(ViewName.RougeCollectionTipView, arg_31_1, arg_31_2)
end

function var_0_0.openRougeCollectionEnchantView(arg_32_0, arg_32_1, arg_32_2)
	ViewMgr.instance:openView(ViewName.RougeCollectionEnchantView, arg_32_1, arg_32_2)
end

function var_0_0.openRougeCollectionOverView(arg_33_0, arg_33_1, arg_33_2)
	ViewMgr.instance:openView(ViewName.RougeCollectionOverView, arg_33_1, arg_33_2)
end

function var_0_0.openRougeCollectionChessView(arg_34_0, arg_34_1, arg_34_2)
	ViewMgr.instance:openView(ViewName.RougeCollectionChessView, arg_34_1, arg_34_2)
end

function var_0_0.openRougeCollectionFilterView(arg_35_0, arg_35_1, arg_35_2)
	ViewMgr.instance:openView(ViewName.RougeCollectionFilterView, arg_35_1, arg_35_2)
end

function var_0_0.openRougeCollectionHandBookView(arg_36_0, arg_36_1, arg_36_2)
	ViewMgr.instance:openView(ViewName.RougeCollectionHandBookView, arg_36_1, arg_36_2)
end

function var_0_0.openRougeCollectionInitialView(arg_37_0, arg_37_1, arg_37_2)
	ViewMgr.instance:openView(ViewName.RougeCollectionInitialView, arg_37_1, arg_37_2)
end

function var_0_0.openRougeResultView(arg_38_0, arg_38_1, arg_38_2)
	ViewMgr.instance:openView(ViewName.RougeResultView, arg_38_1, arg_38_2)
end

function var_0_0.openRougeSettlementView(arg_39_0, arg_39_1, arg_39_2)
	ViewMgr.instance:openView(ViewName.RougeSettlementView, arg_39_1, arg_39_2)
end

function var_0_0.openRougeResultReView(arg_40_0, arg_40_1, arg_40_2)
	ViewMgr.instance:openView(ViewName.RougeResultReView, arg_40_1, arg_40_2)
end

function var_0_0.openRougeDLCSelectView(arg_41_0, arg_41_1, arg_41_2)
	ViewMgr.instance:openView(ViewName.RougeDLCSelectView, arg_41_1, arg_41_2)
end

function var_0_0.getStyleConfig(arg_42_0)
	local var_42_0 = RougeModel.instance:getRougeInfo()

	return var_42_0 and lua_rouge_style.configDict[var_42_0.season][var_42_0.style]
end

function var_0_0.useHalfCapacity(arg_43_0)
	local var_43_0 = arg_43_0:getStyleConfig()

	return var_43_0 and var_43_0.halfCost == 1
end

function var_0_0.getRoleStyleCapacity(arg_44_0, arg_44_1, arg_44_2)
	if not arg_44_1 then
		return 0
	end

	if arg_44_0:useHalfCapacity() and arg_44_2 then
		return RougeConfig1.instance:getRoleHalfCapacity(arg_44_1.config.rare)
	else
		return RougeConfig1.instance:getRoleCapacity(arg_44_1.config.rare)
	end
end

function var_0_0.setPickAssistViewParams(arg_45_0, arg_45_1, arg_45_2)
	arg_45_0.pickAssistViewParams = {
		curCapacity = arg_45_1,
		totalCapacity = arg_45_2
	}
end

function var_0_0.startEndFlow(arg_46_0)
	if RougeModel.instance:isFinish() then
		arg_46_0:clearFlow()

		arg_46_0.flow = FlowSequence.New()

		local var_46_0 = RougeModel.instance:getEndId()
		local var_46_1 = var_46_0 and var_46_0 ~= 0

		if var_46_1 then
			arg_46_0:addEndStoryFlow(var_46_0)
		end

		arg_46_0.flow:addWork(WaitFinishViewDoneWork.New(var_46_1))
		arg_46_0.flow:addWork(WaitEndingThreeViewDoneWork.New(var_46_0))
		arg_46_0.flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.RougeResultView))
		arg_46_0.flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.RougeSettlementView))
		arg_46_0.flow:addWork(WaitOpenRougeReviewWork.New())
		arg_46_0.flow:addWork(WaitLimiterResultViewDoneWork.New())
		arg_46_0.flow:registerDoneListener(arg_46_0.onEndFlowDone, arg_46_0)
		arg_46_0.flow:start()
	end
end

function var_0_0.addEndStoryFlow(arg_47_0, arg_47_1)
	local var_47_0 = RougeConfig.instance:getEndingCO(arg_47_1)
	local var_47_1 = var_47_0 and var_47_0.endingStoryId

	if var_47_1 then
		arg_47_0.flow:addWork(WaitRougeStoryDoneWork.New(var_47_1))
	end
end

function var_0_0.clearFlow(arg_48_0)
	if arg_48_0.flow then
		arg_48_0.flow:destroy()

		arg_48_0.flow = nil
	end
end

function var_0_0.onEndFlowDone(arg_49_0)
	arg_49_0:clearAllData()
end

function var_0_0.clearAllData(arg_50_0)
	RougeMapHelper.clearMapData()
	RougeModel.instance:clear()
end

function var_0_0.tryShowMessageBox(arg_51_0)
	if not RougeModel.instance:inRouge() then
		return false
	end

	if not arg_51_0:checkNeedContinueFight() then
		return false
	end

	local var_51_0 = RougeModel.instance:getRougeRetryNum()

	if var_51_0 == 0 then
		return false
	end

	local var_51_1 = RougeMapConfig.instance:getFightRetryNum()

	MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.RougeFightFailConfirm, MsgBoxEnum.BoxType.Yes_No, luaLang("cachot_continue_fight"), "RE CHALLENGE", luaLang("cachot_abort_fight"), "QUIT", arg_51_0.continueFight, arg_51_0.abortRouge, nil, arg_51_0, arg_51_0, nil, var_51_1 - var_51_0 + 1)

	return true
end

function var_0_0.checkNeedContinueFight(arg_52_0)
	if (SLFramework.FrameworkSettings.IsEditor or isDebugBuild) and RougeEditorController.instance:isAllowAbortFight() then
		GMRpc.instance:sendGMRequest("rougeSetRetryNum 1 0")

		return false
	end

	if RougeMapModel.instance:isNormalLayer() then
		local var_52_0 = RougeMapModel.instance:getCurNode()

		if not var_52_0 then
			return false
		end

		local var_52_1 = var_52_0.eventMo

		if not var_52_1 or not var_52_1.fightFail then
			return false
		end
	elseif RougeMapModel.instance:isMiddle() then
		local var_52_2 = RougeMapModel.instance:getCurPieceMo()

		if not var_52_2 then
			return false
		end

		local var_52_3 = var_52_2.triggerStr

		if not var_52_3 then
			return false
		end

		if not var_52_3.fightFail then
			return false
		end
	else
		return false
	end

	return true
end

function var_0_0.abortRouge(arg_53_0)
	RougeRpc.instance:sendRougeAbortRequest(RougeModel.instance:getSeason(), arg_53_0.startEndFlow, arg_53_0)
end

function var_0_0.continueFight(arg_54_0)
	local var_54_0 = RougeMapEnum.ChapterId
	local var_54_1

	if RougeMapModel.instance:isNormalLayer() then
		local var_54_2 = RougeMapModel.instance:getCurNode():getEventCo()

		var_54_1 = RougeMapConfig.instance:getFightEvent(var_54_2.id).episodeId
	else
		local var_54_3 = RougeMapModel.instance:getCurPieceMo().selectId
		local var_54_4 = lua_rouge_piece_select.configDict[var_54_3]
		local var_54_5 = string.splitToNumber(var_54_4.triggerParam, "#")

		var_54_1 = var_54_5[1]

		RougeMapModel.instance:setEndId(var_54_5[2])
	end

	DungeonFightController.instance:enterFight(var_54_0, var_54_1)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_54_0.onOpenViewFinish, arg_54_0)
end

function var_0_0.onOpenViewFinish(arg_55_0, arg_55_1)
	if arg_55_1 ~= ViewName.RougeHeroGroupFightView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_55_0.onOpenViewFinish, arg_55_0)

	local var_55_0 = FightModel.instance:getFightParam()

	var_55_0.isReplay = false
	var_55_0.multiplication = 1

	if RougeHeroGroupController.instance:setFightHeroSingleGroup() then
		DungeonFightController.instance:sendStartDungeonRequest(var_55_0.chapterId, var_55_0.episodeId, var_55_0, 1)
	end
end

function var_0_0.getStartViewAllInfo(arg_56_0)
	local var_56_0 = RougeModel.instance:getDifficulty()

	return RougeOutsideModel.instance:getStartViewAllInfo(var_56_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
