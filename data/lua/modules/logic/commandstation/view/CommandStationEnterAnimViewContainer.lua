module("modules.logic.commandstation.view.CommandStationEnterAnimViewContainer", package.seeall)

local var_0_0 = class("CommandStationEnterAnimViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, CommandStationEnterAnimView.New())

	return var_1_0
end

function var_0_0.playOpenTransition(arg_2_0, arg_2_1)
	arg_2_0:_cancelBlock()
	arg_2_0:_stopOpenCloseAnim()

	if not arg_2_0._viewSetting.anim or arg_2_0._viewSetting.anim ~= ViewAnim.Default then
		if not string.nilorempty(arg_2_0._viewSetting.anim) then
			arg_2_0:_setAnimatorRes()

			if not arg_2_1 or not arg_2_1.noBlock then
				arg_2_0:startViewOpenBlock()
			end

			local var_2_0 = arg_2_0.viewGO:GetComponent("Animator")

			if not gohelper.isNil(var_2_0) then
				local var_2_1 = arg_2_1 and arg_2_1.anim or "open"

				var_2_0:Play(var_2_1, 0, 0)
			end

			local var_2_2 = 1.033

			TaskDispatcher.runDelay(arg_2_0.onPlayOpenTransitionFinish, arg_2_0, var_2_2)
		else
			arg_2_0:onPlayOpenTransitionFinish()
		end

		return
	end

	if not arg_2_0._canvasGroup then
		arg_2_0:onPlayOpenTransitionFinish()

		return
	end

	if not arg_2_1 or not arg_2_1.noBlock then
		arg_2_0:startViewOpenBlock()
	end

	arg_2_0:_animSetAlpha(0.01, true)

	local var_2_3 = arg_2_0._viewSetting.customAnimFadeTime and arg_2_0._viewSetting.customAnimFadeTime[1] or BaseViewContainer.openViewTime
	local var_2_4 = BaseViewContainer.openViewEase

	arg_2_0._openAnimTweenId = ZProj.TweenHelper.DOTweenFloat(0.01, 1, var_2_3, arg_2_0._onOpenTweenFrameCallback, arg_2_0._onOpenTweenFinishCallback, arg_2_0, nil, var_2_4)

	TaskDispatcher.runDelay(arg_2_0.onPlayOpenTransitionFinish, arg_2_0, 2)
end

return var_0_0
