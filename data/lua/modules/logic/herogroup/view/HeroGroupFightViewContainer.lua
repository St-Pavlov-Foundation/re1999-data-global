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

function var_0_0.addCommonViews(arg_4_0, arg_4_1)
	table.insert(arg_4_1, arg_4_0._heroGroupFightView)
	table.insert(arg_4_1, HeroGroupAnimView.New())
	table.insert(arg_4_1, arg_4_0._heroGroupFightListView.New())
	table.insert(arg_4_1, HeroGroupFightViewLevel.New())
	table.insert(arg_4_1, HeroGroupFightViewRule.New())
	table.insert(arg_4_1, HeroGroupInfoScrollView.New())
	table.insert(arg_4_1, CheckActivityEndView.New())
	table.insert(arg_4_1, TabViewGroup.New(1, "#go_container/btnContain/commonBtns"))
	table.insert(arg_4_1, TabViewGroup.New(2, "#go_righttop/#go_power"))
end

function var_0_0.addLastViews(arg_5_0, arg_5_1)
	return
end

function var_0_0.getHeroGroupFightView(arg_6_0)
	return arg_6_0._heroGroupFightView
end

function var_0_0.buildTabViews(arg_7_0, arg_7_1)
	if arg_7_1 == 1 then
		local var_7_0 = arg_7_0:getHelpId()

		arg_7_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			var_7_0 ~= nil
		}, var_7_0, arg_7_0._closeCallback, nil, nil, arg_7_0)

		arg_7_0._navigateButtonsView:setCloseCheck(arg_7_0.defaultOverrideCloseCheck, arg_7_0)

		return {
			arg_7_0._navigateButtonsView
		}
	elseif arg_7_1 == 2 then
		local var_7_1 = CurrencyEnum.CurrencyType

		return {
			CurrencyView.New({
				var_7_1.Power
			})
		}
	end
end

function var_0_0.getHelpId(arg_8_0)
	local var_8_0
	local var_8_1 = HeroGroupModel.instance.episodeId
	local var_8_2 = DungeonConfig.instance:getEpisodeCO(var_8_1)
	local var_8_3 = DungeonConfig.instance:getChapterCO(var_8_2.chapterId).type == DungeonEnum.ChapterType.Hard
	local var_8_4 = CommonConfig.instance:getConstNum(ConstEnum.HeroGroupGuideNormal)
	local var_8_5 = CommonConfig.instance:getConstNum(ConstEnum.HeroGroupGuideHard)

	if HeroGroupBalanceHelper.getIsBalanceMode() then
		return HelpEnum.HelpId.Balance
	end

	if var_8_3 then
		if GuideModel.instance:isGuideFinish(var_8_5) and HelpModel.instance:isShowedHelp(HelpEnum.HelpId.HeroGroupHard) then
			var_8_0 = HelpEnum.HelpId.HeroGroupHard
		end
	elseif GuideModel.instance:isGuideFinish(var_8_4) and HelpModel.instance:isShowedHelp(HelpEnum.HelpId.HeroGroupNormal) then
		var_8_0 = HelpEnum.HelpId.HeroGroupNormal
	end

	return var_8_0
end

function var_0_0._closeCallback(arg_9_0)
	arg_9_0:closeThis()

	if ToughBattleController.instance:checkIsToughBattle() then
		ToughBattleController.instance:enterToughBattle(true)

		return
	end

	if arg_9_0:handleVersionActivityCloseCall() then
		return
	end

	local var_9_0 = HeroGroupModel.instance.episodeId

	if DungeonConfig.instance:getEpisodeCO(var_9_0).type == DungeonEnum.EpisodeType.Explore then
		ExploreController.instance:enterExploreScene()
	else
		MainController.instance:enterMainScene(true, false)

		if TeachNoteModel.instance:isJumpEnter() then
			TeachNoteModel.instance:setJumpEnter(false)
			TeachNoteController.instance:enterTeachNoteView(var_9_0, true)

			DungeonModel.instance.curSendEpisodeId = nil
		end
	end
end

function var_0_0.handleVersionActivityCloseCall(arg_10_0)
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

function var_0_0.setNavigateOverrideClose(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._navigateButtonsView:setOverrideClose(arg_11_1, arg_11_2)
end

function var_0_0.defaultOverrideCloseCheck(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = DungeonModel.instance.curSendChapterId

	if DungeonConfig.instance:getChapterCO(var_12_0).actId == VersionActivityEnum.ActivityId.Act109 then
		GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, arg_12_1, nil, nil, arg_12_2)

		return false
	end

	return true
end

function var_0_0.onContainerInit(arg_13_0)
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, arg_13_0.refreshHelpBtnIcon, arg_13_0)
end

function var_0_0.onContainerOpenFinish(arg_14_0)
	arg_14_0._navigateButtonsView:resetOnCloseViewAudio(AudioEnum.UI.UI_Team_close)
end

function var_0_0.onContainerDestroy(arg_15_0)
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, arg_15_0.refreshHelpBtnIcon, arg_15_0)
end

function var_0_0.refreshHelpBtnIcon(arg_16_0)
	arg_16_0._navigateButtonsView:changerHelpId(arg_16_0:getHelpId())
end

return var_0_0
