module("modules.logic.versionactivity2_2.lopera.view.LoperaLevelViewContainer", package.seeall)

local var_0_0 = class("LoperaLevelViewContainer", BaseViewContainer)
local var_0_1 = 0.35

function var_0_0.buildViews(arg_1_0)
	return {
		LoperaLevelView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			true,
			false
		})

		var_2_0:setOverrideClose(arg_2_0._overrideCloseAction, arg_2_0)
		var_2_0:setOverrideHome(arg_2_0._overrideClickHome, arg_2_0)

		return {
			var_2_0
		}
	end
end

function var_0_0._overrideCloseAction(arg_3_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, arg_3_0._playAniAndClose, nil, nil, arg_3_0)
end

function var_0_0._overrideClickHome(arg_4_0)
	LoperaController.instance:sendStatOnHomeClick()
	NavigateButtonsView.homeClick()
end

function var_0_0._playAniAndClose(arg_5_0)
	if not arg_5_0._anim then
		arg_5_0._anim = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	arg_5_0._anim:Play("out", 0, 0)
	LoperaController.instance:abortEpisode()
	TaskDispatcher.runDelay(arg_5_0.closeThis, arg_5_0, var_0_1)
end

function var_0_0.defaultOverrideCloseCheck(arg_6_0, arg_6_1, arg_6_2)
	local function var_6_0()
		LoperaController.instance:abortEpisode()
		arg_6_1(arg_6_2)
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, var_6_0)

	return false
end

function var_0_0.setVisibleInternal(arg_8_0, arg_8_1)
	var_0_0.super.setVisibleInternal(arg_8_0, arg_8_1)
end

return var_0_0
