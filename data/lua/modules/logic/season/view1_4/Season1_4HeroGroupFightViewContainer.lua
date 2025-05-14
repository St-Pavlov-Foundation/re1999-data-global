module("modules.logic.season.view1_4.Season1_4HeroGroupFightViewContainer", package.seeall)

local var_0_0 = class("Season1_4HeroGroupFightViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season1_4HeroGroupFightView.New(),
		Season1_4HeroGroupListView.New(),
		Season1_4HeroGroupFightViewRule.New(),
		Season1_4HeroFightViewLevel.New(),
		HeroGroupInfoScrollView.New(),
		TabViewGroup.New(1, "#go_container/#go_btns/commonBtns")
	}
end

function var_0_0.getSeason1_4HeroGroupFightView(arg_2_0)
	return arg_2_0._views[1]
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Season1_4HerogroupHelp, arg_3_0._closeCallback, nil, nil, arg_3_0)

		arg_3_0._navigateButtonsView:setCloseCheck(arg_3_0.defaultOverrideCloseCheck, arg_3_0)

		return {
			arg_3_0._navigateButtonsView
		}
	end
end

function var_0_0._closeCallback(arg_4_0)
	arg_4_0:closeThis()

	if arg_4_0:handleVersionActivityCloseCall() then
		return
	end

	local var_4_0 = HeroGroupModel.instance.episodeId
	local var_4_1 = DungeonConfig.instance:getEpisodeCO(var_4_0)

	if var_4_1.type == DungeonEnum.EpisodeType.Explore then
		ExploreController.instance:enterExploreChapter(var_4_1.chapterId)
	else
		MainController.instance:enterMainScene(true, false)
	end
end

function var_0_0.handleVersionActivityCloseCall(arg_5_0)
	if EnterActivityViewOnExitFightSceneHelper.checkCurrentIsActivityFight() then
		EnterActivityViewOnExitFightSceneHelper.enterCurrentActivity(true, true)

		return true
	end
end

function var_0_0.setNavigateOverrideClose(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._navigateButtonsView:setOverrideClose(arg_6_1, arg_6_2)
end

function var_0_0.defaultOverrideCloseCheck(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = DungeonModel.instance.curSendChapterId

	if DungeonConfig.instance:getChapterCO(var_7_0).actId == VersionActivityEnum.ActivityId.Act109 then
		local function var_7_1()
			arg_7_1(arg_7_2)
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, var_7_1)

		return false
	end

	return true
end

return var_0_0
