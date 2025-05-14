module("modules.logic.versionactivity2_2.lopera.view.LoperaMainViewContainer", package.seeall)

local var_0_0 = class("LoperaMainViewContainer", BaseViewContainer)
local var_0_1 = 0.35

function var_0_0.buildViews(arg_1_0)
	arg_1_0._mainView = LoperaMainView.New()

	return {
		arg_1_0._mainView,
		TabViewGroup.New(1, "#go_left")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			true,
			false
		})

		var_2_0:setOverrideClose(arg_2_0._overrideCloseFunc, arg_2_0)

		return {
			var_2_0
		}
	end
end

function var_0_0.onContainerInit(arg_3_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_2Enum.ActivityId.Lopera)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_2Enum.ActivityId.Lopera
	})
end

function var_0_0.setVisibleInternal(arg_4_0, arg_4_1)
	var_0_0.super.setVisibleInternal(arg_4_0, arg_4_1)

	if not arg_4_0.viewGO then
		return
	end

	if not arg_4_0._anim then
		arg_4_0._anim = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	if arg_4_1 then
		arg_4_0._anim:Play(UIAnimationName.Open, 0, 0)
		arg_4_0._mainView:tryShowFinishUnlockView()
	end
end

function var_0_0._overrideCloseFunc(arg_5_0)
	if not arg_5_0._anim then
		arg_5_0._anim = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	arg_5_0._anim:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(arg_5_0.closeThis, arg_5_0, var_0_1)
end

function var_0_0.onContainerClose(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.closeThis, arg_6_0)
end

return var_0_0
