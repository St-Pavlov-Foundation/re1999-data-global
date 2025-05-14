module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameOpenEffectView", package.seeall)

local var_0_0 = class("AiZiLaGameOpenEffectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "ani/#simage_FullBG")
	arg_1_0._txtInfo = gohelper.findChildText(arg_1_0.viewGO, "ani/Title/#txt_Info")
	arg_1_0._txtdaydesc = gohelper.findChildText(arg_1_0.viewGO, "ani/Title/image_Info/#txt_daydesc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	if arg_6_0.viewContainer then
		NavigateMgr.instance:addEscape(arg_6_0.viewContainer.viewName, arg_6_0._onEscape, arg_6_0)
	end

	arg_6_0._callback = arg_6_0.viewParam and arg_6_0.viewParam.callback
	arg_6_0._callbackObj = arg_6_0.viewParam and arg_6_0.viewParam.callbackObj

	TaskDispatcher.runDelay(arg_6_0._onAnimFinish, arg_6_0, AiZiLaEnum.AnimatorTime.EffectViewOpen)
	TaskDispatcher.runDelay(arg_6_0.closeThis, arg_6_0, AiZiLaEnum.AnimatorTime.EffectViewOpen + 0.1)
	arg_6_0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_level_transition)
end

function var_0_0._onEscape(arg_7_0)
	return
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0._onAnimFinish(arg_9_0)
	if arg_9_0._callback then
		if arg_9_0._callbackObj then
			arg_9_0._callback(arg_9_0._callbackObj)
		else
			arg_9_0._callback()
		end

		arg_9_0._callbackObj = nil
		arg_9_0._callback = nil
	end
end

function var_0_0.onDestroyView(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._onAnimFinish, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.closeThis, arg_10_0)
end

function var_0_0.refreshUI(arg_11_0)
	local var_11_0 = AiZiLaGameModel.instance:getEpisodeMO()

	if not var_11_0 then
		return
	end

	local var_11_1 = var_11_0:getConfig()

	arg_11_0._txtInfo.text = var_11_1 and var_11_1.name
	arg_11_0._txtdaydesc.text = formatLuaLang("v1a5_aizila_day_explore", var_11_0.day)
end

function var_0_0.playViewAnimator(arg_12_0, arg_12_1)
	return
end

return var_0_0
