module("modules.logic.versionactivity3_1.gaosiniao.view.CorvusTaskViewContainer", package.seeall)

local var_0_0 = class("CorvusTaskViewContainer", TaskViewBaseContainer)

function var_0_0.actId(arg_1_0)
	return assert(arg_1_0.viewParam.actId)
end

function var_0_0.taskType(arg_2_0)
	return assert(arg_2_0.viewParam.taskType)
end

function var_0_0._createMainView(arg_3_0)
	return arg_3_0:onCreateMainView()
end

function var_0_0._createLeftTopView(arg_4_0)
	return arg_4_0:onCreateLeftTopView()
end

function var_0_0._createListScrollParam(arg_5_0)
	return arg_5_0:onCreateListScrollParam()
end

function var_0_0._createScrollView(arg_6_0)
	local var_6_0 = arg_6_0:onCreateScrollView()
	local var_6_1 = arg_6_0:_createListScrollParam()

	return var_6_0, var_6_1
end

function var_0_0.buildViews(arg_7_0)
	local var_7_0, var_7_1 = arg_7_0:_createScrollView()

	arg_7_0.__scrollModel = var_7_0
	arg_7_0.__listScrollParam = var_7_1
	arg_7_0.__mainView = arg_7_0:_createMainView()
	arg_7_0.__leftTopView = arg_7_0:_createLeftTopView()

	return arg_7_0:onBuildViews()
end

function var_0_0.onBuildViews(arg_8_0)
	local var_8_0 = {}

	for iter_8_0 = 1, 10 do
		var_8_0[iter_8_0] = (iter_8_0 - 1) * 0.06
	end

	assert(arg_8_0.__listScrollParam.cellClass)
	assert(arg_8_0.__listScrollParam.scrollGOPath)
	assert(arg_8_0.__listScrollParam.prefabUrl)

	arg_8_0.__scrollView = LuaListScrollViewWithAnimator.New(arg_8_0.__scrollModel, arg_8_0.__listScrollParam, var_8_0)

	return {
		arg_8_0.__scrollView,
		arg_8_0.__mainView,
		arg_8_0.__leftTopView
	}
end

function var_0_0.scrollModel(arg_9_0)
	return arg_9_0.__scrollModel
end

function var_0_0.onContainerInit(arg_10_0)
	var_0_0.super.onContainerInit(arg_10_0)

	arg_10_0._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(arg_10_0.__scrollView)

	arg_10_0._taskAnimRemoveItem:setMoveInterval(0)
end

function var_0_0.removeByIndex(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0._taskAnimRemoveItem:removeByIndex(arg_11_1, arg_11_2, arg_11_3)
end

function var_0_0.onContainerClickModalMask(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_12_0:closeThis()
end

function var_0_0.onCreateMainView(arg_13_0)
	assert(false, "please overeide this function!")
end

function var_0_0.onCreateLeftTopView(arg_14_0)
	return TabViewGroup.New(1, "#go_lefttop")
end

function var_0_0.onCreateScrollView(arg_15_0)
	return CorvusTaskListModel.New()
end

function var_0_0.onCreateListScrollParam(arg_16_0)
	local var_16_0 = ListScrollParam.New()

	var_16_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_16_0.sortMode = ScrollEnum.ScrollSortDown
	var_16_0.scrollDir = ScrollEnum.ScrollDirV
	var_16_0.prefabUrl = arg_16_0._viewSetting.otherRes[1]
	var_16_0.lineCount = 1
	var_16_0.cellWidth = 1160
	var_16_0.cellHeight = 165
	var_16_0.cellSpaceV = 0
	var_16_0.startSpace = 0
	var_16_0.scrollGOPath = "#scroll_TaskList"
	var_16_0.cellClass = CorvusTaskItem
	var_16_0.rectMaskSoftness = {
		0,
		0
	}

	return var_16_0
end

function var_0_0.buildTabViews(arg_17_0, arg_17_1)
	if arg_17_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return var_0_0
