module("modules.logic.versionactivity2_5.challenge.view.result.Act183ReportViewContainer", package.seeall)

local var_0_0 = class("Act183ReportViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "root/#go_topleft"))
	table.insert(var_1_0, Act183ReportView.New())

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "root/#scroll_report"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = Act183ReportListItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 1636
	var_1_1.cellHeight = 248
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 20
	var_1_1.startSpace = 0
	var_1_1.endSpace = 0

	local var_1_2 = {}

	for iter_1_0 = 1, 4 do
		var_1_2[iter_1_0] = (iter_1_0 - 1) * 0.03
	end

	table.insert(var_1_0, LuaListScrollViewWithAnimator.New(Act183ReportListModel.instance, var_1_1, var_1_2))

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
