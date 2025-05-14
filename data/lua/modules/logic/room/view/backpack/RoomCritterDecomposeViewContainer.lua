module("modules.logic.room.view.backpack.RoomCritterDecomposeViewContainer", package.seeall)

local var_0_0 = class("RoomCritterDecomposeViewContainer", BaseViewContainer)
local var_0_1 = 4
local var_0_2 = 0.03

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "left_container/#go_scrollcontainer/#scroll_critter"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "left_container/#go_scrollcontainer/#scroll_critter/Viewport/Content/#go_critterItem"
	var_1_1.cellClass = RoomCritterDecomposeItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = arg_1_0:getLineCount()
	var_1_1.cellWidth = 200
	var_1_1.cellHeight = 200
	var_1_1.frameUpdateMs = 0
	var_1_1.minUpdateCountInFrame = var_1_1.lineCount

	local var_1_2 = arg_1_0.getDelayTimeArray(var_1_1.lineCount)
	local var_1_3 = LuaListScrollViewWithAnimator.New(RoomCritterDecomposeListModel.instance, var_1_1, var_1_2)

	table.insert(var_1_0, var_1_3)
	table.insert(var_1_0, RoomCritterDecomposeView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttopbtns"))

	return var_1_0
end

function var_0_0.getLineCount(arg_2_0)
	local var_2_0 = gohelper.findChildComponent(arg_2_0.viewGO, "left_container/#go_scrollcontainer", gohelper.Type_Transform)
	local var_2_1 = recthelper.getWidth(var_2_0)

	return math.floor(var_2_1 / 200)
end

function var_0_0.getDelayTimeArray(arg_3_0)
	local var_3_0 = {}

	setmetatable(var_3_0, var_3_0)

	function var_3_0.__index(arg_4_0, arg_4_1)
		local var_4_0 = math.floor((arg_4_1 - 1) / arg_3_0)

		if var_4_0 > var_0_1 then
			return
		end

		return var_4_0 * var_0_2
	end

	return var_3_0
end

function var_0_0.buildTabViews(arg_5_0, arg_5_1)
	if arg_5_1 == 1 then
		arg_5_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_5_0.navigateView
		}
	end
end

function var_0_0.playCloseTransition(arg_6_0)
	arg_6_0:onPlayCloseTransitionFinish()
end

function var_0_0.onContainerCloseFinish(arg_7_0)
	RoomCritterDecomposeListModel.instance:onInit()
end

return var_0_0
