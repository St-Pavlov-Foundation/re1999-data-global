module("modules.logic.dungeon.view.DungeonMapViewContainer", package.seeall)

local var_0_0 = class("DungeonMapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, DungeonMapHoleView.New())

	arg_1_0._mapScene = DungeonMapScene.New()
	arg_1_0._mapTaskInfo = DungeonMapTaskInfo.New()

	table.insert(var_1_0, DungeonMapView.New())
	table.insert(var_1_0, arg_1_0._mapTaskInfo)
	table.insert(var_1_0, DungeonMapSceneElements.New())
	table.insert(var_1_0, arg_1_0._mapScene)
	table.insert(var_1_0, DungeonMapEpisode.New())
	table.insert(var_1_0, DungeonMapElementReward.New())
	table.insert(var_1_0, DungeonMapEquipEntry.New())
	table.insert(var_1_0, TabViewGroup.New(1, "top_left"))
	table.insert(var_1_0, DungeonMapOtherBtnView.New())
	table.insert(var_1_0, DungeonMapActDropView.New())
	table.insert(var_1_0, DungeonMapToughBattleActView.New())
	table.insert(var_1_0, BalanceUmbrellaDungeonMapView.New())
	table.insert(var_1_0, InvestigateDungeonMapView.New())
	table.insert(var_1_0, DiceHeroDungeonMapView.New())
	table.insert(var_1_0, VersionActivity2_8BossActDungeonMapView.New())

	return var_1_0
end

function var_0_0.getMapScene(arg_2_0)
	return arg_2_0._mapScene
end

function var_0_0.getMapTaskInfo(arg_3_0)
	return arg_3_0._mapTaskInfo
end

function var_0_0.buildTabViews(arg_4_0, arg_4_1)
	local var_4_0 = DungeonModel.instance.curChapterType
	local var_4_1 = var_4_0 == DungeonEnum.ChapterType.Normal and HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Dungeon)

	arg_4_0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		var_4_1
	}, HelpEnum.HelpId.Dungeon)

	arg_4_0._navigateButtonView:setOverrideClose(arg_4_0.overrideClose, arg_4_0)

	if var_4_0 == DungeonEnum.ChapterType.Equip then
		arg_4_0._navigateButtonView.helpId = nil

		arg_4_0._navigateButtonView:setParam({
			true,
			true,
			false
		})
	end

	return {
		arg_4_0._navigateButtonView
	}
end

function var_0_0.onContainerInit(arg_5_0)
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, arg_5_0.refreshHelpBtnIcon, arg_5_0)
end

function var_0_0.onContainerOpenFinish(arg_6_0)
	arg_6_0._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_OperaHouse)
end

function var_0_0.onContainerDestroy(arg_7_0)
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, arg_7_0.refreshHelpBtnIcon, arg_7_0)
end

function var_0_0.refreshHelpBtnIcon(arg_8_0)
	arg_8_0._navigateButtonView:changerHelpId(HelpEnum.HelpId.Dungeon)
end

function var_0_0.overrideCloseElement(arg_9_0)
	DungeonController.instance:dispatchEvent(DungeonEvent.closeMapInteractiveItem)
end

function var_0_0._overrideHelp(arg_10_0)
	ViewMgr.instance:openView(ViewName.DungeonRewardTipView)
end

function var_0_0.overrideClose(arg_11_0)
	arg_11_0:closeThis()
end

function var_0_0.refreshHelp(arg_12_0)
	if arg_12_0._navigateButtonView then
		local var_12_0 = DungeonModel.instance.curChapterType == DungeonEnum.ChapterType.Normal and HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Dungeon)

		arg_12_0._navigateButtonView:setParam({
			true,
			true,
			var_12_0
		})
	end
end

function var_0_0.onContainerUpdateParam(arg_13_0)
	arg_13_0._mapScene:setSceneVisible(true)
end

function var_0_0.setVisibleInternal(arg_14_0, arg_14_1)
	var_0_0.super.setVisibleInternal(arg_14_0, arg_14_1)

	if arg_14_0._mapScene then
		arg_14_0._mapScene:setSceneVisible(arg_14_1)
	end
end

return var_0_0
