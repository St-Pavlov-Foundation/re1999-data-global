module("modules.logic.rouge.view.RougeDifficultyViewContainer", package.seeall)

local var_0_0 = class("RougeDifficultyViewContainer", BaseViewContainer)
local var_0_1 = 1

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = ListScrollParam.New()

	var_1_0.scrollDir = ScrollEnum.ScrollDirH
	var_1_0.lineCount = 1
	var_1_0.cellWidth = 480
	var_1_0.cellHeight = 980
	var_1_0.cellSpaceH = 36
	var_1_0.cellSpaceV = 0
	arg_1_0._listScrollParam = var_1_0
	arg_1_0._difficultyView = RougeDifficultyView.New()

	return {
		arg_1_0._difficultyView,
		TabViewGroup.New(var_0_1, "#go_lefttop")
	}
end

local var_0_2 = HelpEnum.HelpId.RougeDifficultyViewHelp

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == var_0_1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				true
			}, var_0_2)
		}
	end
end

function var_0_0.getScrollRect(arg_3_0)
	return arg_3_0._difficultyView._scrollViewLimitScrollCmp
end

function var_0_0.onContainerInit(arg_4_0)
	local var_4_0 = arg_4_0:getScrollRect()

	arg_4_0._scrollViewGo = var_4_0.gameObject
	arg_4_0._scrollContentTrans = var_4_0.content
	arg_4_0._scrollContentGo = arg_4_0._scrollContentTrans.gameObject
end

function var_0_0.getScrollViewGo(arg_5_0)
	return arg_5_0._scrollViewGo
end

function var_0_0.getScrollContentTranform(arg_6_0)
	return arg_6_0._scrollContentTrans
end

function var_0_0.getScrollContentGo(arg_7_0)
	return arg_7_0._scrollContentGo
end

function var_0_0.getListScrollParam(arg_8_0)
	return arg_8_0._listScrollParam
end

function var_0_0.getListScrollParam_cellSize(arg_9_0)
	local var_9_0 = arg_9_0._listScrollParam

	return var_9_0.cellWidth, var_9_0.cellHeight
end

function var_0_0.getListScrollParamStep(arg_10_0)
	local var_10_0 = arg_10_0:getListScrollParam()

	if var_10_0.scrollDir == ScrollEnum.ScrollDirH then
		return var_10_0.cellWidth + var_10_0.cellSpaceH
	else
		return var_10_0.cellHeight + var_10_0.cellSpaceV
	end
end

function var_0_0.rebuildLayout(arg_11_0)
	ZProj.UGUIHelper.RebuildLayout(arg_11_0:getScrollContentTranform())
end

function var_0_0.getSumDescIndexList(arg_12_0, ...)
	return arg_12_0._difficultyView:getSumDescIndexList(...)
end

return var_0_0
