module("modules.logic.dungeon.view.DungeonMapLevelViewContainer", package.seeall)

local var_0_0 = class("DungeonMapLevelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, DungeonMapLevelView.New())
	table.insert(var_1_0, DungeonMapLevelRewardView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "anim/#go_righttop"))
	table.insert(var_1_0, TabViewGroup.New(2, "anim/top_left"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = CurrencyEnum.CurrencyType
		local var_2_1 = {
			var_2_0.Power
		}

		return {
			CurrencyView.New(var_2_1)
		}
	elseif arg_2_1 == 2 then
		local var_2_2 = DungeonModel.instance.curChapterType == DungeonEnum.ChapterType.Normal and HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Dungeon)

		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			var_2_2
		}, HelpEnum.HelpId.Dungeon)

		arg_2_0._navigateButtonView:setOverrideClose(arg_2_0._overrideClose, arg_2_0)
		arg_2_0._navigateButtonView:setAnimEnabled(false)

		return {
			arg_2_0._navigateButtonView
		}
	end
end

function var_0_0.onContainerOpenFinish(arg_3_0)
	arg_3_0._navigateButtonView:resetOnCloseViewAudio(0)
	DungeonModel.instance:setLastSelectMode(nil, nil)
end

function var_0_0._overrideClose(arg_4_0)
	if ViewMgr.instance:isOpen(ViewName.DungeonView) or ViewMgr.instance:isOpen(ViewName.RoleStoryDispatchMainView) or ViewMgr.instance:isOpen(ViewName.CommandStationEnterView) then
		ViewMgr.instance:closeView(ViewName.DungeonMapView, false, true)
		ViewMgr.instance:closeView(ViewName.DungeonMapLevelView, false, true)

		return
	end

	module_views_preloader.DungeonViewPreload(function()
		DungeonController.instance:openDungeonView(nil, true)
		ViewMgr.instance:closeView(ViewName.DungeonMapView, false, true)
		ViewMgr.instance:closeView(ViewName.DungeonMapLevelView, false, true)
	end)
end

function var_0_0.refreshHelp(arg_6_0)
	if arg_6_0._navigateButtonView then
		local var_6_0 = DungeonModel.instance.curChapterType == DungeonEnum.ChapterType.Normal and HelpModel.instance:isShowedHelp(HelpEnum.HelpId.Dungeon)

		arg_6_0._navigateButtonView:setParam({
			true,
			true,
			var_6_0
		})
	end
end

return var_0_0
