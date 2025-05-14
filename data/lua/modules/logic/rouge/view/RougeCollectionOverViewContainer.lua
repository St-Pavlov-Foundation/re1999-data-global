module("modules.logic.rouge.view.RougeCollectionOverViewContainer", package.seeall)

local var_0_0 = class("RougeCollectionOverViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._scrollView = arg_1_0:buildScrollView()

	return {
		TabViewGroup.New(1, "#go_lefttop"),
		TabViewGroup.New(2, "#go_rougemapdetailcontainer"),
		RougeCollectionOverView.New(),
		arg_1_0._scrollView
	}
end

local var_0_1 = 0.06

function var_0_0.buildScrollView(arg_2_0)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "#scroll_view"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromView
	var_2_0.prefabUrl = "#scroll_view/Viewport/Content/#go_collectionitem"
	var_2_0.cellClass = RougeCollectionOverListItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirV
	var_2_0.lineCount = 3
	var_2_0.cellWidth = 620
	var_2_0.cellHeight = 190
	var_2_0.cellSpaceH = 0
	var_2_0.cellSpaceV = -6
	var_2_0.startSpace = 0
	var_2_0.endSpace = 0

	local var_2_1 = {}
	local var_2_2 = 5

	for iter_2_0 = 1, var_2_2 do
		for iter_2_1 = 1, var_2_0.lineCount do
			local var_2_3 = iter_2_0 * var_0_1

			var_2_1[(iter_2_0 - 1) * var_2_0.lineCount + iter_2_1] = var_2_3
		end
	end

	return (LuaListScrollViewWithAnimator.New(RougeCollectionOverListModel.instance, var_2_0, var_2_1))
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_3_0._navigateButtonView
		}
	elseif arg_3_1 == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

return var_0_0
