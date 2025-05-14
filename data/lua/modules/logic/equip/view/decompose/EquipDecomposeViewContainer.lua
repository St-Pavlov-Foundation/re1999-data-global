module("modules.logic.equip.view.decompose.EquipDecomposeViewContainer", package.seeall)

local var_0_0 = class("EquipDecomposeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollGOPath = "left_container/#go_scrollcontainer/#scroll_equip"
	var_1_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_0.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_0.cellClass = EquipDecomposeScrollItem
	var_1_0.scrollDir = ScrollEnum.ScrollDirV
	var_1_0.lineCount = arg_1_0:getLineCount()
	var_1_0.cellWidth = 200
	var_1_0.cellHeight = 200
	var_1_0.cellSpaceH = 0
	var_1_0.cellSpaceV = 0
	var_1_0.frameUpdateMs = 0
	var_1_0.minUpdateCountInFrame = var_1_0.lineCount

	return {
		EquipDecomposeView.New(),
		LuaListScrollViewWithAnimator.New(EquipDecomposeListModel.instance, var_1_0, arg_1_0.getDelayTimeArray(var_1_0.lineCount)),
		TabViewGroup.New(1, "#go_lefttopbtns")
	}
end

function var_0_0.getDelayTimeArray(arg_2_0)
	local var_2_0 = {}

	setmetatable(var_2_0, var_2_0)

	function var_2_0.__index(arg_3_0, arg_3_1)
		local var_3_0 = math.floor((arg_3_1 - 1) / arg_2_0)

		if var_3_0 > 4 then
			return nil
		end

		return var_3_0 * 0.03
	end

	return var_2_0
end

function var_0_0.getLineCount(arg_4_0)
	local var_4_0 = gohelper.findChildComponent(arg_4_0.viewGO, "left_container/#go_scrollcontainer", gohelper.Type_Transform)
	local var_4_1 = recthelper.getWidth(var_4_0)

	return math.floor(var_4_1 / 200)
end

function var_0_0.buildTabViews(arg_5_0, arg_5_1)
	if arg_5_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

function var_0_0.playCloseTransition(arg_6_0)
	arg_6_0:onPlayCloseTransitionFinish()
end

function var_0_0.onContainerCloseFinish(arg_7_0)
	EquipDecomposeListModel.instance:clear()
end

return var_0_0
