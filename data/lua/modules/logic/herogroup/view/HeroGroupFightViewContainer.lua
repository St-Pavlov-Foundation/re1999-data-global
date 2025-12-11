module("modules.logic.herogroup.view.HeroGroupFightViewContainer", package.seeall)

local var_0_0 = class("HeroGroupFightViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0:defineFightView()
	arg_1_0:addFirstViews(var_1_0)
	arg_1_0:addCommonViews(var_1_0)
	arg_1_0:addLastViews(var_1_0)

	return var_1_0
end

function var_0_0.addFirstViews(arg_2_0, arg_2_1)
	table.insert(arg_2_1, HeroGroupFightCleanView.New())
end

function var_0_0.defineFightView(arg_3_0)
	arg_3_0._heroGroupFightView = HeroGroupFightView.New()
	arg_3_0._heroGroupFightListView = HeroGroupListView.New()
end

function var_0_0.getFightLevelView(arg_4_0)
	return HeroGroupFightViewLevel.New()
end

function var_0_0.getFightRuleView(arg_5_0)
	return HeroGroupFightViewRule.New()
end

function var_0_0.addCommonViews(arg_6_0, arg_6_1)
	table.insert(arg_6_1, arg_6_0._heroGroupFightView)
	table.insert(arg_6_1, HeroGroupAnimView.New())
	table.insert(arg_6_1, arg_6_0._heroGroupFightListView.New())
	table.insert(arg_6_1, arg_6_0:getFightLevelView())
	table.insert(arg_6_1, arg_6_0:getFightRuleView())
	table.insert(arg_6_1, HeroGroupInfoScrollView.New())
	table.insert(arg_6_1, CheckActivityEndView.New())
	table.insert(arg_6_1, HeroGroupPresetFightView.New())
	table.insert(arg_6_1, TabViewGroup.New(1, "#go_container/btnContain/commonBtns"))
	table.insert(arg_6_1, TabViewGroup.New(2, "#go_righttop/#go_power"))
end

function var_0_0.addLastViews(arg_7_0, arg_7_1)
	return
end

function var_0_0.getHeroGroupFightView(arg_8_0)
	return arg_8_0._heroGroupFightView
end

function var_0_0.buildTabViews(arg_9_0, arg_9_1)
	if arg_9_1 == 1 then
		local var_9_0 = arg_9_0:getHelpId()

		arg_9_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			var_9_0 ~= nil
		}, var_9_0, arg_9_0._closeCallback, nil, nil, arg_9_0)

		arg_9_0._navigateButtonsView:setCloseCheck(arg_9_0.defaultOverrideCloseCheck, arg_9_0)

		return {
			arg_9_0._navigateButtonsView
		}
	elseif arg_9_1 == 2 then
		local var_9_1 = CurrencyEnum.CurrencyType

		return {
			CurrencyView.New({
				var_9_1.Power
			})
		}
	end
end

function var_0_0.getHelpId(arg_10_0)
	local var_10_0
	local var_10_1 = HeroGroupModel.instance.episodeId
	local var_10_2 = DungeonConfig.instance:getEpisodeCO(var_10_1)
	local var_10_3 = DungeonConfig.instance:getChapterCO(var_10_2.chapterId).type == DungeonEnum.ChapterType.Hard
	local var_10_4 = CommonConfig.instance:getConstNum(ConstEnum.HeroGroupGuideNormal)
	local var_10_5 = CommonConfig.instance:getConstNum(ConstEnum.HeroGroupGuideHard)

	if HeroGroupBalanceHelper.getIsBalanceMode() then
		return HelpEnum.HelpId.Balance
	end

	if var_10_3 then
		if GuideModel.instance:isGuideFinish(var_10_5) and HelpModel.instance:isShowedHelp(HelpEnum.HelpId.HeroGroupHard) then
			var_10_0 = HelpEnum.HelpId.HeroGroupHard
		end
	elseif GuideModel.instance:isGuideFinish(var_10_4) and HelpModel.instance:isShowedHelp(HelpEnum.HelpId.HeroGroupNormal) then
		var_10_0 = HelpEnum.HelpId.HeroGroupNormal
	end

	return var_10_0
end

function var_0_0._closeCallback(arg_11_0)
	arg_11_0:closeThis()

	if DungeonJumpGameController.instance:checkIsJumpGameBattle() then
		DungeonJumpGameController.instance:returnToJumpGameView()

		return
	end

	if VersionActivity2_8DungeonBossBattleController.instance:checkIsBossBattle() then
		VersionActivity2_8DungeonBossBattleController.instance:enterBossView(true)

		return
	end

	if ToughBattleController.instance:checkIsToughBattle() then
		ToughBattleController.instance:enterToughBattle(true)

		return
	end

	if arg_11_0:handleVersionActivityCloseCall() then
		return
	end

	local var_11_0 = HeroGroupModel.instance.episodeId
	local var_11_1 = DungeonConfig.instance:getEpisodeCO(var_11_0)

	if var_11_1.type == DungeonEnum.EpisodeType.Explore then
		ExploreController.instance:enterExploreScene()
	elseif var_11_1.type == DungeonEnum.EpisodeType.Survival then
		SurvivalController.instance:enterSurvivalMap()
	elseif var_11_1.type == DungeonEnum.EpisodeType.Shelter then
		SurvivalController.instance:enterShelterMap()
	else
		if var_11_1.chapterId == DungeonEnum.ChapterId.BossStory then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.VersionActivity2_8BossStoryLoadingView)
		end

		MainController.instance:enterMainScene(true, false)

		if TeachNoteModel.instance:isJumpEnter() then
			TeachNoteModel.instance:setJumpEnter(false)
			TeachNoteController.instance:enterTeachNoteView(var_11_0, true)

			DungeonModel.instance.curSendEpisodeId = nil
		end
	end
end

function var_0_0.handleVersionActivityCloseCall(arg_12_0)
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

function var_0_0.setNavigateOverrideClose(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._navigateButtonsView:setOverrideClose(arg_13_1, arg_13_2)
end

function var_0_0.defaultOverrideCloseCheck(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = DungeonModel.instance.curSendChapterId

	if DungeonConfig.instance:getChapterCO(var_14_0).actId == VersionActivityEnum.ActivityId.Act109 then
		GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, arg_14_1, nil, nil, arg_14_2)

		return false
	end

	return true
end

function var_0_0.onContainerInit(arg_15_0)
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, arg_15_0.refreshHelpBtnIcon, arg_15_0)
end

function var_0_0.onContainerOpenFinish(arg_16_0)
	arg_16_0._navigateButtonsView:resetOnCloseViewAudio(AudioEnum.UI.UI_Team_close)
end

function var_0_0.onContainerDestroy(arg_17_0)
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, arg_17_0.refreshHelpBtnIcon, arg_17_0)
end

function var_0_0.refreshHelpBtnIcon(arg_18_0)
	arg_18_0._navigateButtonsView:changerHelpId(arg_18_0:getHelpId())
end

return var_0_0
