module("modules.logic.player.view.PlayerClothViewContainer", package.seeall)

local var_0_0 = class("PlayerClothViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "#scroll_skills"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_0.prefabUrl = "#scroll_skills/Viewport/#go_skillitem"
	var_1_0.cellClass = PlayerClothItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 300
	var_1_0.cellHeight = 155
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = -4.34
	var_1_0.startSpace = 10
	arg_1_0._clothListView = LuaListScrollView.New(PlayerClothListViewModel.instance, var_1_0)

	return {
		PlayerClothView.New(),
		arg_1_0._clothListView,
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.viewParam and arg_2_0.viewParam.isTip

	arg_2_0.navigateView = NavigateButtonsView.New({
		true,
		false,
		not var_2_0
	}, HelpEnum.HelpId.PlayCloth)

	return {
		arg_2_0.navigateView
	}
end

function var_0_0.onContainerInit(arg_3_0)
	PlayerClothListViewModel.instance:update()
	PlayerController.instance:registerCallback(PlayerEvent.SelectCloth, arg_3_0._onSelectCloth, arg_3_0)
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, arg_3_0.navigateView.showHelpBtnIcon, arg_3_0.navigateView)
end

function var_0_0.onContainerDestroy(arg_4_0)
	PlayerController.instance:unregisterCallback(PlayerEvent.SelectCloth, arg_4_0._onSelectCloth, arg_4_0)
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, arg_4_0.navigateView.showHelpBtnIcon, arg_4_0.navigateView)
end

function var_0_0.onContainerOpen(arg_5_0)
	PlayerClothListViewModel.instance:update()
end

function var_0_0._onSelectCloth(arg_6_0, arg_6_1)
	local var_6_0 = PlayerClothListViewModel.instance:getById(arg_6_1)

	if var_6_0 then
		local var_6_1 = PlayerClothListViewModel.instance:getIndex(var_6_0)

		if var_6_1 then
			arg_6_0._index = var_6_1

			arg_6_0._clothListView:selectCell(var_6_1, true)
		end
	end
end

return var_0_0
