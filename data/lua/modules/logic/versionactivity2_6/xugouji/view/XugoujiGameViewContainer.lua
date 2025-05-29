module("modules.logic.versionactivity2_6.xugouji.view.XugoujiGameViewContainer", package.seeall)

local var_0_0 = class("XugoujiGameViewContainer", BaseViewContainer)
local var_0_1 = 0.35

function var_0_0.buildViews(arg_1_0)
	return {
		XugoujiGameView.New(),
		XugoujiGamePlayerInfoView.New(),
		XugoujiGameEnemyInfoView.New(),
		TabViewGroup.New(1, "#go_lefttop")
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
	if Activity188Model.instance:isGameGuideMode() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, arg_3_0._playAniAndClose, nil, nil, arg_3_0)
end

function var_0_0._overrideClickHome(arg_4_0)
	if Activity188Model.instance:isGameGuideMode() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, arg_4_0._playAniAndGoHome, nil, nil, arg_4_0)
end

function var_0_0._playAniAndClose(arg_5_0)
	if arg_5_0._isClosing then
		return
	end

	if not arg_5_0._anim then
		arg_5_0._anim = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	arg_5_0._anim:Play("out", 0, 0)
	XugoujiController.instance:manualExitGame()

	arg_5_0._isClosing = true

	TaskDispatcher.runDelay(arg_5_0._closeAction, arg_5_0, var_0_1)
end

function var_0_0._closeAction(arg_6_0)
	XugoujiController.instance:manualExitGame()
	XugoujiController.instance:sendExitGameStat()
	arg_6_0:closeThis()
end

function var_0_0._playAniAndGoHome(arg_7_0)
	XugoujiController.instance:manualExitGame()
	XugoujiController.instance:sendExitGameStat()
	NavigateButtonsView.homeClick()
end

function var_0_0.defaultOverrideCloseCheck(arg_8_0, arg_8_1, arg_8_2)
	local function var_8_0()
		arg_8_1(arg_8_2)
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, var_8_0)

	return false
end

function var_0_0.setVisibleInternal(arg_10_0, arg_10_1)
	var_0_0.super.setVisibleInternal(arg_10_0, arg_10_1)
end

return var_0_0
