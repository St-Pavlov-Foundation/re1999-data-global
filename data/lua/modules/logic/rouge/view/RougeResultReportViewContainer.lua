module("modules.logic.rouge.view.RougeResultReportViewContainer", package.seeall)

local var_0_0 = class("RougeResultReportViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RougeResultReportView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_recordlist"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = RougeResultReportItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 1480
	var_1_1.cellHeight = 254
	var_1_1.cellSpaceH = 8
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 10
	var_1_1.endSpace = 0

	table.insert(var_1_0, LuaListScrollView.New(RougeResultReportListModel.instance, var_1_1))

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
