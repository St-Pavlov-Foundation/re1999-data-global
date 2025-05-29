module("modules.logic.act189.view.ShortenActViewContainer_impl", package.seeall)

local var_0_0 = class("ShortenActViewContainer_impl", Activity189BaseViewContainer)

function var_0_0.initTaskScrollView(arg_1_0, arg_1_1)
	if arg_1_0.__taskScrollView then
		return arg_1_0.__taskScrollView
	end

	if not arg_1_1 then
		arg_1_1 = ListScrollParam.New()
		arg_1_1.scrollGOPath = "root/right/#scroll_tasklist"
		arg_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
		arg_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
		arg_1_1.cellClass = ShortenAct_TaskItem
		arg_1_1.scrollDir = ScrollEnum.ScrollDirV
		arg_1_1.lineCount = 1
		arg_1_1.cellWidth = 872
		arg_1_1.cellHeight = 132
		arg_1_1.cellSpaceH = 0
		arg_1_1.cellSpaceV = 16
	end

	local var_1_0 = {}

	for iter_1_0 = 1, 5 do
		var_1_0[iter_1_0] = (iter_1_0 - 1) * 0.06
	end

	arg_1_0.__taskScrollView = LuaListScrollViewWithAnimator.New(Activity189_TaskListModel.instance, arg_1_1, var_1_0)
	arg_1_0.notPlayAnimation = true

	return arg_1_0.__taskScrollView
end

function var_0_0.taskScrollView(arg_2_0)
	return arg_2_0.__taskScrollView or arg_2_0:initTaskScrollView()
end

function var_0_0.onContainerInit(arg_3_0)
	var_0_0.super.onContainerInit(arg_3_0)

	arg_3_0.__taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(arg_3_0:taskScrollView())

	arg_3_0.__taskAnimRemoveItem:setMoveInterval(0)
end

function var_0_0.removeByIndex(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.__taskAnimRemoveItem:removeByIndex(arg_4_1, arg_4_2, arg_4_3)
end

function var_0_0.actId(arg_5_0)
	return ShortenActConfig.instance:getActivityId()
end

return var_0_0
