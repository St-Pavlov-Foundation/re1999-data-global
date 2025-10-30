module("modules.logic.commandstation.view.CommandStationDispatchEventMainViewContainer", package.seeall)

local var_0_0 = class("CommandStationDispatchEventMainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._mainView = CommandStationDispatchEventMainView.New()

	table.insert(var_1_0, arg_1_0._mainView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))
	table.insert(var_1_0, TabViewGroupFit.New(2, "#go_child"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_2_0.navigateView:setOverrideClose(arg_2_0._navigateClose, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end

	if arg_2_1 == 2 then
		local var_2_0 = {
			[CommandStationEnum.DispatchTabView.Normal] = CommandStationDispatchEventNormalView.New()
		}
		local var_2_1 = ListScrollParam.New()

		var_2_1.scrollGOPath = "#go_DispatchEvent/#go_DispatchPanel/Layout/left/#go_herocontainer/Mask/#scroll_hero"
		var_2_1.prefabType = ScrollEnum.ScrollPrefabFromRes
		var_2_1.prefabUrl = arg_2_0._viewSetting.otherRes[1]
		var_2_1.cellClass = CommandStationDispatchEventProcessHeroItem
		var_2_1.scrollDir = ScrollEnum.ScrollDirV
		var_2_1.lineCount = 3
		var_2_1.cellWidth = 150
		var_2_1.cellHeight = 150
		var_2_1.cellSpaceH = 8
		var_2_1.cellSpaceV = 1
		var_2_1.startSpace = 20
		var_2_0[CommandStationEnum.DispatchTabView.Process] = MultiView.New({
			CommandStationDispatchEventProcessView.New(),
			LuaListScrollView.New(CommandStationHeroListModel.instance, var_2_1)
		})

		return var_2_0
	end
end

function var_0_0.getCurrentEventConfig(arg_3_0)
	return arg_3_0._eventConfig
end

function var_0_0.switchTab(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._eventConfig = arg_4_2

	arg_4_0:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_4_1)
end

function var_0_0._navigateClose(arg_5_0)
	arg_5_0._mainView:checkClose()
end

return var_0_0
