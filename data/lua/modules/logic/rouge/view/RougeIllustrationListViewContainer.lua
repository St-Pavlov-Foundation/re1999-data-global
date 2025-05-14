module("modules.logic.rouge.view.RougeIllustrationListViewContainer", package.seeall)

local var_0_0 = class("RougeIllustrationListViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RougeIllustrationListView.New())
	table.insert(var_1_0, RougeScrollAudioView.New("#scroll_view"))
	table.insert(var_1_0, TabViewGroup.New(1, "#go_LeftTop"))

	local var_1_1 = MixScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_view"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = RougeIllustrationListPage
	var_1_1.scrollDir = ScrollEnum.ScrollDirH
	var_1_1.lineCount = 1
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 0
	var_1_1.endSpace = 120
	arg_1_0._scrollView = LuaMixScrollView.New(RougeIllustrationListModel.instance, var_1_1)

	table.insert(var_1_0, arg_1_0._scrollView)

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

return var_0_0
