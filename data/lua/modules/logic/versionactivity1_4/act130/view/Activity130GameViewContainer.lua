module("modules.logic.versionactivity1_4.act130.view.Activity130GameViewContainer", package.seeall)

local var_0_0 = class("Activity130GameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._act130GameView = Activity130GameView.New()
	arg_1_0._act130MapView = Activity130Map.New()

	local var_1_0 = {}

	table.insert(var_1_0, arg_1_0._act130GameView)
	table.insert(var_1_0, arg_1_0._act130MapView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topbtns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_2_0._navigateButtonView:setOverrideClose(arg_2_0._overrideCloseFunc, arg_2_0)

		return {
			arg_2_0._navigateButtonView
		}
	end
end

function var_0_0.onContainerInit(arg_3_0)
	StatActivity130Controller.instance:statStart()
end

function var_0_0._overrideCloseFunc(arg_4_0)
	arg_4_0._act130GameView._viewAnim:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(arg_4_0._doClose, arg_4_0, 0.167)
end

function var_0_0._doClose(arg_5_0)
	arg_5_0:closeThis()
	Activity130Controller.instance:dispatchEvent(Activity130Event.BackToLevelView, true)
end

function var_0_0.onContainerClose(arg_6_0)
	StatActivity130Controller.instance:statAbort()
	Role37PuzzleModel.instance:clear()
	PuzzleRecordListModel.instance:clearRecord()
end

return var_0_0
