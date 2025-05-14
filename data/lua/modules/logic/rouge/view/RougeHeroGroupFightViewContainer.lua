module("modules.logic.rouge.view.RougeHeroGroupFightViewContainer", package.seeall)

local var_0_0 = class("RougeHeroGroupFightViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._heroGroupFightView = RougeHeroGroupFightView.New()
	arg_1_0._heroGroupLayoutView = HeroGroupFightLayoutView.New()

	return {
		arg_1_0._heroGroupLayoutView,
		arg_1_0._heroGroupFightView,
		HeroGroupAnimView.New(),
		RougeHeroGroupListView.New(),
		RougeHeroGroupFightViewLevel.New(),
		RougeHeroGroupFightViewRule.New(),
		HeroGroupInfoScrollView.New(),
		CheckActivityEndView.New(),
		RougeHeroGroupFightMiscView.New(),
		RougeBaseDLCViewComp.New(),
		TabViewGroup.New(1, "#go_container/btnContain/commonBtns"),
		TabViewGroup.New(2, "#go_righttop/#go_power")
	}
end

function var_0_0.getHeroGroupFightView(arg_2_0)
	return arg_2_0._heroGroupFightView
end

function var_0_0.beforeEnterFight(arg_3_0)
	return
end

function var_0_0.buildTabViews(arg_4_0, arg_4_1)
	if arg_4_1 == 1 then
		local var_4_0 = arg_4_0:getHelpId()
		local var_4_1 = not arg_4_0:_checkHideHomeBtn()

		arg_4_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			var_4_1,
			var_4_0 ~= nil
		}, var_4_0, arg_4_0._closeCallback, nil, nil, arg_4_0)

		arg_4_0._navigateButtonsView:setCloseCheck(arg_4_0.defaultOverrideCloseCheck, arg_4_0)

		return {
			arg_4_0._navigateButtonsView
		}
	elseif arg_4_1 == 2 then
		local var_4_2 = CurrencyEnum.CurrencyType
		local var_4_3 = arg_4_0:_checkHidePowerCurrencyBtn() and {} or {
			var_4_2.Power
		}

		return {
			CurrencyView.New(var_4_3)
		}
	end
end

function var_0_0.getHelpId(arg_5_0)
	return HelpEnum.HelpId.RougeHeroGroupFightViewHelp
end

function var_0_0._closeCallback(arg_6_0)
	arg_6_0._manualClose = true

	arg_6_0:closeThis()
end

function var_0_0.onContainerCloseFinish(arg_7_0)
	if arg_7_0._manualClose then
		RougeController.instance:enterRouge()
	end
end

function var_0_0.handleVersionActivityCloseCall(arg_8_0)
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

function var_0_0._checkHideHomeBtn(arg_9_0)
	return true
end

var_0_0._hideHomeBtnEpisodeType = {
	[DungeonEnum.EpisodeType.Act1_3Role1Chess] = true,
	[DungeonEnum.EpisodeType.Act1_3Role2Chess] = true
}

function var_0_0.checkShowHomeByEpisodeType(arg_10_0)
	local var_10_0 = HeroGroupModel.instance.episodeId
	local var_10_1 = DungeonConfig.instance:getEpisodeCO(var_10_0)

	return var_0_0._hideHomeBtnEpisodeType[var_10_1.type]
end

function var_0_0._checkHidePowerCurrencyBtn(arg_11_0)
	return (arg_11_0:checkHidePowerCurrencyBtnByEpisodeType())
end

var_0_0._hidePowerCurrencyBtnEpisodeType = {
	[DungeonEnum.EpisodeType.Act1_3Role1Chess] = true,
	[DungeonEnum.EpisodeType.Act1_3Role2Chess] = true
}

function var_0_0.checkHidePowerCurrencyBtnByEpisodeType(arg_12_0)
	local var_12_0 = HeroGroupModel.instance.episodeId
	local var_12_1 = DungeonConfig.instance:getEpisodeCO(var_12_0)

	return var_0_0._hidePowerCurrencyBtnEpisodeType[var_12_1.type]
end

function var_0_0.setNavigateOverrideClose(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._navigateButtonsView:setOverrideClose(arg_13_1, arg_13_2)
end

function var_0_0.defaultOverrideCloseCheck(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = DungeonModel.instance.curSendChapterId

	if DungeonConfig.instance:getChapterCO(var_14_0).actId == VersionActivityEnum.ActivityId.Act109 then
		local function var_14_1()
			arg_14_1(arg_14_2)
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, var_14_1)

		return false
	end

	return true
end

function var_0_0.onContainerInit(arg_16_0)
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, arg_16_0.refreshHelpBtnIcon, arg_16_0)
end

function var_0_0.onContainerOpenFinish(arg_17_0)
	arg_17_0._navigateButtonsView:resetOnCloseViewAudio(AudioEnum.UI.UI_Team_close)
end

function var_0_0.onContainerDestroy(arg_18_0)
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, arg_18_0.refreshHelpBtnIcon, arg_18_0)
end

function var_0_0.refreshHelpBtnIcon(arg_19_0)
	arg_19_0._navigateButtonsView:changerHelpId(arg_19_0:getHelpId())
end

return var_0_0
