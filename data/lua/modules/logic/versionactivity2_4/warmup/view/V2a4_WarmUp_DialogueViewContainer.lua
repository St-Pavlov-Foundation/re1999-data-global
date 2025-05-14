module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_DialogueViewContainer", package.seeall)

local var_0_0 = class("V2a4_WarmUp_DialogueViewContainer", Activity125ViewBaseContainer)
local var_0_1 = 1

function var_0_0.buildViews(arg_1_0)
	return {
		V2a4_WarmUp_DialogueView.New(),
		TabViewGroup.New(var_0_1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == var_0_1 then
		arg_2_0._navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_2_0._navigationView:setOverrideClose(arg_2_0._overrideClose, arg_2_0)

		return {
			arg_2_0._navigationView
		}
	end
end

function var_0_0._overrideClose(arg_3_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.V2a4_WarmUp_DialogueView_AbortRequest, MsgBoxEnum.BoxType.Yes_No, arg_3_0._endYesCallback, nil, nil, arg_3_0, nil, nil)
end

function var_0_0._endYesCallback(arg_4_0)
	V2a4_WarmUpController.instance:abort()
end

function var_0_0.actId(arg_5_0)
	return V2a4_WarmUpConfig.instance:actId()
end

function var_0_0.onContainerClose(arg_6_0)
	V2a4_WarmUpController.instance:uploadToServer()
end

return var_0_0
