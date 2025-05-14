module("modules.logic.versionactivity1_2.jiexika.view.Activity114ViewContainer", package.seeall)

local var_0_0 = class("Activity114ViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._nowTabIndex = arg_1_0.viewParam and type(arg_1_0.viewParam) == "table" and arg_1_0.viewParam.defaultTabIds and arg_1_0.viewParam.defaultTabIds[2] or 1
	arg_1_0._activity114Live2dView = Activity114Live2dView.New()

	return {
		arg_1_0._activity114Live2dView,
		Activity114View.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_content")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			true,
			true
		}, 167)

		var_2_0:setOverrideClose(arg_2_0.onClickClose, arg_2_0)

		return {
			var_2_0
		}
	elseif arg_2_1 == 2 then
		return {
			Activity114EnterView.New(),
			Activity114TaskView.New(),
			Activity114MainView.New()
		}
	end
end

function var_0_0.onContainerInit(arg_3_0)
	Activity114Model.instance:beginStat()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_2Enum.ActivityId.JieXiKa)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_2Enum.ActivityId.JieXiKa
	})
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_open)
end

function var_0_0.onClickClose(arg_4_0)
	if arg_4_0._nowTabIndex ~= Activity114Enum.TabIndex.EnterView then
		arg_4_0:switchTab(Activity114Enum.TabIndex.EnterView)
	else
		arg_4_0:closeThis()
	end
end

function var_0_0.onContainerClose(arg_5_0)
	Activity114Model.instance:endStat()
end

function var_0_0.getActivity114Live2d(arg_6_0)
	return arg_6_0._activity114Live2dView:getUISpine()
end

function var_0_0.switchTab(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._nowTabIndex

	arg_7_0._nowTabIndex = arg_7_1

	arg_7_0:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_7_1, var_7_0)
end

function var_0_0.playOpenTransition(arg_8_0)
	local var_8_0

	if arg_8_0._nowTabIndex ~= Activity114Enum.TabIndex.EnterView then
		var_8_0 = {}

		if arg_8_0._nowTabIndex == Activity114Enum.TabIndex.MainView then
			var_8_0.anim = "start_open"
		elseif arg_8_0._nowTabIndex == Activity114Enum.TabIndex.MainView then
			var_8_0.anim = "quest_open"
		end
	end

	var_0_0.super.playOpenTransition(arg_8_0, var_8_0)
end

function var_0_0.onPlayCloseTransitionFinish(arg_9_0)
	if arg_9_0.openViewName then
		ViewMgr.instance:openView(arg_9_0.openViewName)

		arg_9_0.openViewName = nil

		TaskDispatcher.cancelTask(arg_9_0.onPlayCloseTransitionFinish, arg_9_0)
		arg_9_0:_cancelBlock()
	else
		var_0_0.super.onPlayCloseTransitionFinish(arg_9_0)
	end
end

return var_0_0
