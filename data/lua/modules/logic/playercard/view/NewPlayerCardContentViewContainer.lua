module("modules.logic.playercard.view.NewPlayerCardContentViewContainer", package.seeall)

local var_0_0 = class("NewPlayerCardContentViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, NewPlayerCardContentView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))
	arg_1_0:buildThemeScrollView(var_1_0)

	return var_1_0
end

function var_0_0.buildThemeScrollView(arg_2_0, arg_2_1)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "bottom/#scroll_theme"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_2_0.prefabUrl = "bottom/#scroll_theme/viewport/Content/#go_themeitem"
	var_2_0.cellClass = PlayerCardThemeItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirH
	var_2_0.lineCount = 1
	var_2_0.cellWidth = 392
	var_2_0.cellHeight = 162
	var_2_0.cellSpaceH = -26
	var_2_0.cellSpaceV = 0
	var_2_0.startSpace = 50
	var_2_0.endSpace = 0
	arg_2_0.scrollView = LuaListScrollView.New(PlayerCardThemeListModel.instance, var_2_0)

	table.insert(arg_2_1, arg_2_0.scrollView)
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_3_0.navigateView:setOverrideClose(arg_3_0._overrideClose, arg_3_0)

		return {
			arg_3_0.navigateView
		}
	end
end

function var_0_0._overrideClose(arg_4_0)
	if not PlayerCardModel.instance:getIsOpenSkinView() then
		arg_4_0:closeThis()
	else
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.OnCloseBottomView)
	end
end

return var_0_0
