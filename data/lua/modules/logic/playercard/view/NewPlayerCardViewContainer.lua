module("modules.logic.playercard.view.NewPlayerCardViewContainer", package.seeall)

local var_0_0 = class("NewPlayerCardViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.playercardview = NewPlayerCardView.New()

	table.insert(var_1_0, arg_1_0.playercardview)
	table.insert(var_1_0, PlayerCardAchievement.New())
	table.insert(var_1_0, PlayerCardThemeView.New())
	table.insert(var_1_0, PlayerCardPlayerInfo.New())
	arg_1_0:buildThemeScrollView(var_1_0)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_2_0.navigateView:setOverrideClose(arg_2_0._overrideClose, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.buildThemeScrollView(arg_3_0, arg_3_1)
	local var_3_0 = ListScrollParam.New()

	var_3_0.scrollGOPath = "bottom/#scroll_theme"
	var_3_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_3_0.prefabUrl = "bottom/#scroll_theme/viewport/Content/#go_themeitem"
	var_3_0.cellClass = PlayerCardThemeItem
	var_3_0.scrollDir = ScrollEnum.ScrollDirH
	var_3_0.lineCount = 1
	var_3_0.cellWidth = 404
	var_3_0.cellHeight = 172
	var_3_0.cellSpaceH = 16
	var_3_0.cellSpaceV = 0
	var_3_0.startSpace = 4
	var_3_0.endSpace = 0
	arg_3_0.scrollView = LuaListScrollView.New(PlayerCardThemeListModel.instance, var_3_0)

	table.insert(arg_3_1, arg_3_0.scrollView)
end

function var_0_0._overrideClose(arg_4_0)
	if not PlayerCardModel.instance:getIsOpenSkinView() then
		arg_4_0:closeThis()
	else
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.OnCloseBottomView)
	end
end

return var_0_0
