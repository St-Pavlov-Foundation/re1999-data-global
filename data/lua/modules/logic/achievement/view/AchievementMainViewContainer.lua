module("modules.logic.achievement.view.AchievementMainViewContainer", package.seeall)

local var_0_0 = class("AchievementMainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._scrollListView = LuaMixScrollView.New(AchievementMainListModel.instance, arg_1_0:getListContentParam())
	arg_1_0._scrollTileView = LuaMixScrollView.New(AchievementMainTileModel.instance, arg_1_0:getMixContentParam())
	arg_1_0._poolView = AchievementMainViewPool.New(AchievementEnum.MainIconPath)

	return {
		AchievementMainView.New(),
		TabViewGroup.New(1, "#go_btns"),
		arg_1_0._scrollTileView,
		arg_1_0._scrollListView,
		arg_1_0._poolView,
		AchievementMainViewFocus.New(),
		AchievementMainTopView.New(),
		AchievementMainViewFold.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.getMixContentParam(arg_3_0)
	local var_3_0 = MixScrollParam.New()

	var_3_0.scrollGOPath = "#go_container/#scroll_content"
	var_3_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_3_0.prefabUrl = arg_3_0._viewSetting.otherRes[1]
	var_3_0.cellClass = AchievementMainItem
	var_3_0.scrollDir = ScrollEnum.ScrollDirV
	var_3_0.startSpace = 0
	var_3_0.endSpace = 50

	return var_3_0
end

function var_0_0.getListContentParam(arg_4_0)
	local var_4_0 = MixScrollParam.New()

	var_4_0.scrollGOPath = "#go_container/#scroll_list"
	var_4_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_4_0.prefabUrl = "#go_container/#scroll_list/Viewport/content/#go_listitem"
	var_4_0.cellClass = AchievementMainListItem
	var_4_0.scrollDir = ScrollEnum.ScrollDirV
	var_4_0.startSpace = 0
	var_4_0.endSpace = 50

	return var_4_0
end

function var_0_0.getScrollView(arg_5_0, arg_5_1)
	if arg_5_1 == AchievementEnum.ViewType.Tile then
		return arg_5_0._scrollTileView
	else
		return arg_5_0._scrollListView
	end
end

function var_0_0.getPoolView(arg_6_0)
	return arg_6_0._poolView
end

return var_0_0
