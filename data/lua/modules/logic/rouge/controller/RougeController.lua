module("modules.logic.rouge.controller.RougeController", package.seeall)

slot0 = class("RougeController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.addConstEvents(slot0)
	StoryController.instance:registerCallback(StoryEvent.Start, slot0._onStoryStart, slot0)
end

function slot0._onStoryStart(slot0, slot1)
	if RougeFavoriteConfig.instance:inRougeStoryList(slot1) and not RougeOutsideModel.instance:storyIsPass(slot1) then
		RougeOutsideRpc.instance:sendRougeUnlockStoryRequest(RougeOutsideModel.instance:season(), slot1)
	end
end

function slot0.enterRouge(slot0)
	DungeonModel.instance.curSendEpisodeId = nil

	GameSceneMgr.instance:startScene(SceneType.Rouge, 1, 1, true)
end

function slot0.openRougeMainView(slot0, slot1, slot2, slot3, slot4)
	if not RougeOutsideModel.instance:isUnlock() then
		GameFacade.showToast(RougeOutsideModel.instance:openUnlockId())

		return
	end

	RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(RougeOutsideModel.instance:season(), function (slot0, slot1)
		if slot1 ~= 0 then
			logError("RougeController:openRougeMainView resultCode=" .. tostring(slot1))

			return
		end

		RougeOutsideRpc.instance:sendRougeGetNewReddotInfoRequest(uv0)
		RougeRpc.instance:sendGetRougeInfoRequest(uv0, function (slot0, slot1)
			if slot1 ~= 0 then
				logError("RougeController:openRougeMainView resultCode=" .. tostring(slot1))

				return
			end

			ViewMgr.instance:openView(ViewName.RougeMainView, uv0, uv1)

			if uv2 then
				uv2(uv3)
			end
		end)
	end)
end

function slot0.openRougeDifficultyView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeDifficultyView, slot1, slot2)
end

function slot0.openRougeSelectRewardsView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeCollectionGiftView, slot1, slot2)
end

function slot0.openRougeFactionView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeFactionView, slot1, slot2)
end

function slot0.createTeamViewParam(slot0, slot1, slot2, slot3)
	return {
		heroNum = slot1,
		callback = slot2,
		callbackTarget = slot3
	}
end

function slot0.openRougeTeamView(slot0, slot1, slot2)
	slot1 = slot1 or {}
	slot1.teamType = RougeEnum.TeamType.View

	ViewMgr.instance:openView(ViewName.RougeTeamView, slot1, slot2)
end

function slot0.openRougeTeamTreatView(slot0, slot1, slot2)
	slot1 = slot1 or {}
	slot1.teamType = RougeEnum.TeamType.Treat

	ViewMgr.instance:openView(ViewName.RougeTeamView, slot1, slot2)
end

function slot0.openRougeTeamReviveView(slot0, slot1, slot2)
	slot1 = slot1 or {}
	slot1.teamType = RougeEnum.TeamType.Revive

	ViewMgr.instance:openView(ViewName.RougeTeamView, slot1, slot2)
end

function slot0.openRougeTeamAssignmentView(slot0, slot1, slot2)
	slot1 = slot1 or {}
	slot1.teamType = RougeEnum.TeamType.Assignment

	ViewMgr.instance:openView(ViewName.RougeTeamView, slot1, slot2)
end

function slot0.openRougeReviewView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeReviewView, slot1, slot2)
end

function slot0.openRougeIllustrationListView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeIllustrationListView, slot1, slot2)
end

function slot0.openRougeIllustrationDetailView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeIllustrationDetailView, slot1, slot2)
end

function slot0.openRougeFactionIllustrationView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeFactionIllustrationView, slot1, slot2)
end

function slot0.openRougeFactionIllustrationDetailView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeFactionIllustrationDetailView, slot1, slot2)
end

function slot0.openRougeFavoriteView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeFavoriteView, slot1, slot2)
end

function slot0.openRougeFavoriteCollectionView(slot0, slot1, slot2)
	RougeOutsideRpc.instance:sendRougeGetUnlockCollectionsRequest(RougeOutsideModel.instance:season(), function (slot0, slot1)
		ViewMgr.instance:openView(ViewName.RougeFavoriteCollectionView, uv0, uv1)
	end)
end

function slot0.openRougeTalentView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeTalentView, slot1, slot2)
end

function slot0.openRougeResultReportView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeResultReportView, slot1, slot2)
end

function slot0.openRougeTalentTreeTrunkView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeTalentTreeTrunkView, slot1, slot2)
end

function slot0.openRougeRewardView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeRewardView, slot1, slot2)
end

function slot0.openRougeInitTeamView(slot0, slot1, slot2)
	RougeHeroGroupModel.instance:clear()
	RougeHeroGroupModel.instance:onGetHeroGroupList(RougeModel.instance:getTeamInfo():getGroupInfos())

	slot3 = RougeHeroGroupMO.New()

	slot3:setMaxHeroCount(RougeEnum.InitTeamHeroNum)
	slot3:init({
		groupId = 1
	})
	RougeHeroSingleGroupModel.instance:setMaxHeroCount(RougeEnum.InitTeamHeroNum)
	RougeHeroSingleGroupModel.instance:setSingleGroup(slot3)
	ViewMgr.instance:openView(ViewName.RougeInitTeamView, slot1, slot2)
end

function slot0.openSelectHero(slot0, slot1, slot2)
	RougeHeroGroupModel.instance:clear()

	slot3 = RougeHeroGroupMO.New()

	slot3:setMaxHeroCount(RougeEnum.InitTeamHeroNum)
	slot3:init({
		groupId = 1
	})
	RougeHeroSingleGroupModel.instance:setMaxHeroCount(RougeEnum.InitTeamHeroNum)
	RougeHeroSingleGroupModel.instance:setSingleGroup(slot3)

	slot7 = 1

	ViewMgr.instance:openView(ViewName.RougeHeroGroupEditView, {
		singleGroupMOId = slot7,
		originalHeroUid = RougeHeroSingleGroupModel.instance:getHeroUid(slot7),
		equips = {
			"0"
		},
		heroGroupEditType = RougeEnum.HeroGroupEditType.SelectHero,
		selectHeroCapacity = 0,
		curCapacity = 0,
		totalCapacity = tonumber(RougeConfig1.instance:getConstValueByID(RougeEnum.Const.SelectHeroCapacity)),
		selectHeroCallback = slot1,
		selectHeroCallbackTarget = slot2
	})
end

function slot0.openRougeCollectionTipView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeCollectionTipView, slot1, slot2)
end

function slot0.openRougeCollectionEnchantView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeCollectionEnchantView, slot1, slot2)
end

function slot0.openRougeCollectionOverView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeCollectionOverView, slot1, slot2)
end

function slot0.openRougeCollectionChessView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeCollectionChessView, slot1, slot2)
end

function slot0.openRougeCollectionFilterView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeCollectionFilterView, slot1, slot2)
end

function slot0.openRougeCollectionHandBookView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeCollectionHandBookView, slot1, slot2)
end

function slot0.openRougeCollectionInitialView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeCollectionInitialView, slot1, slot2)
end

function slot0.openRougeResultView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeResultView, slot1, slot2)
end

function slot0.openRougeSettlementView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeSettlementView, slot1, slot2)
end

function slot0.openRougeResultReView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeResultReView, slot1, slot2)
end

function slot0.openRougeDLCSelectView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.RougeDLCSelectView, slot1, slot2)
end

function slot0.getStyleConfig(slot0)
	return RougeModel.instance:getRougeInfo() and lua_rouge_style.configDict[slot1.season][slot1.style]
end

function slot0.useHalfCapacity(slot0)
	return slot0:getStyleConfig() and slot1.halfCost == 1
end

function slot0.getRoleStyleCapacity(slot0, slot1, slot2)
	if not slot1 then
		return 0
	end

	if slot0:useHalfCapacity() and slot2 then
		return RougeConfig1.instance:getRoleHalfCapacity(slot1.config.rare)
	else
		return RougeConfig1.instance:getRoleCapacity(slot1.config.rare)
	end
end

function slot0.setPickAssistViewParams(slot0, slot1, slot2)
	slot0.pickAssistViewParams = {
		curCapacity = slot1,
		totalCapacity = slot2
	}
end

function slot0.startEndFlow(slot0)
	if RougeModel.instance:isFinish() then
		slot0:clearFlow()

		slot0.flow = FlowSequence.New()

		if RougeModel.instance:getEndId() and slot1 ~= 0 then
			slot0:addEndStoryFlow(slot1)
		end

		slot0.flow:addWork(WaitFinishViewDoneWork.New(slot2))
		slot0.flow:addWork(WaitEndingThreeViewDoneWork.New(slot1))
		slot0.flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.RougeResultView))
		slot0.flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.RougeSettlementView))
		slot0.flow:addWork(WaitOpenRougeReviewWork.New())
		slot0.flow:addWork(WaitLimiterResultViewDoneWork.New())
		slot0.flow:registerDoneListener(slot0.onEndFlowDone, slot0)
		slot0.flow:start()
	end
end

function slot0.addEndStoryFlow(slot0, slot1)
	if RougeConfig.instance:getEndingCO(slot1) and slot2.endingStoryId then
		slot0.flow:addWork(WaitRougeStoryDoneWork.New(slot3))
	end
end

function slot0.clearFlow(slot0)
	if slot0.flow then
		slot0.flow:destroy()

		slot0.flow = nil
	end
end

function slot0.onEndFlowDone(slot0)
	slot0:clearAllData()
end

function slot0.clearAllData(slot0)
	RougeMapHelper.clearMapData()
	RougeModel.instance:clear()
end

function slot0.tryShowMessageBox(slot0)
	if not RougeModel.instance:inRouge() then
		return false
	end

	if not slot0:checkNeedContinueFight() then
		return false
	end

	if RougeModel.instance:getRougeRetryNum() == 0 then
		return false
	end

	MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.RougeFightFailConfirm, MsgBoxEnum.BoxType.Yes_No, luaLang("cachot_continue_fight"), "RE CHALLENGE", luaLang("cachot_abort_fight"), "QUIT", slot0.continueFight, slot0.abortRouge, nil, slot0, slot0, nil, RougeMapConfig.instance:getFightRetryNum() - slot1 + 1)

	return true
end

function slot0.checkNeedContinueFight(slot0)
	if (SLFramework.FrameworkSettings.IsEditor or isDebugBuild) and RougeEditorController.instance:isAllowAbortFight() then
		GMRpc.instance:sendGMRequest("rougeSetRetryNum 1 0")

		return false
	end

	if RougeMapModel.instance:isNormalLayer() then
		if not RougeMapModel.instance:getCurNode() then
			return false
		end

		if not slot1.eventMo or not slot2.fightFail then
			return false
		end
	elseif RougeMapModel.instance:isMiddle() then
		if not RougeMapModel.instance:getCurPieceMo() then
			return false
		end

		if not slot1.triggerStr then
			return false
		end

		if not slot2.fightFail then
			return false
		end
	else
		return false
	end

	return true
end

function slot0.abortRouge(slot0)
	RougeRpc.instance:sendRougeAbortRequest(RougeModel.instance:getSeason(), slot0.startEndFlow, slot0)
end

function slot0.continueFight(slot0)
	slot1 = RougeMapEnum.ChapterId
	slot2 = nil

	if RougeMapModel.instance:isNormalLayer() then
		slot2 = RougeMapConfig.instance:getFightEvent(RougeMapModel.instance:getCurNode():getEventCo().id).episodeId
	else
		slot6 = string.splitToNumber(lua_rouge_piece_select.configDict[RougeMapModel.instance:getCurPieceMo().selectId].triggerParam, "#")
		slot2 = slot6[1]

		RougeMapModel.instance:setEndId(slot6[2])
	end

	DungeonFightController.instance:enterFight(slot1, slot2)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
end

function slot0.onOpenViewFinish(slot0, slot1)
	if slot1 ~= ViewName.RougeHeroGroupFightView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)

	slot2 = FightModel.instance:getFightParam()
	slot2.isReplay = false
	slot2.multiplication = 1

	if RougeHeroGroupController.instance:setFightHeroSingleGroup() then
		DungeonFightController.instance:sendStartDungeonRequest(slot2.chapterId, slot2.episodeId, slot2, 1)
	end
end

function slot0.getStartViewAllInfo(slot0)
	return RougeOutsideModel.instance:getStartViewAllInfo(RougeModel.instance:getDifficulty())
end

slot0.instance = slot0.New()

return slot0
