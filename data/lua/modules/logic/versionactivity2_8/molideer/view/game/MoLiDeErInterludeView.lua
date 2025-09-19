module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErInterludeView", package.seeall)

local var_0_0 = class("MoLiDeErInterludeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._txtStart = gohelper.findChildText(arg_1_0.viewGO, "#txt_Start")

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
	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._callback = arg_6_0.viewParam and arg_6_0.viewParam.callback
	arg_6_0._callbackObj = arg_6_0.viewParam and arg_6_0.viewParam.callbackObj
	arg_6_0._isNextRound = arg_6_0.viewParam and arg_6_0.viewParam.isNextRound or false

	arg_6_0._animator:Play(MoLiDeErEnum.AnimName.InterludeViewOpen)
	TaskDispatcher.runDelay(arg_6_0.onAnimFinish, arg_6_0, MoLiDeErEnum.AnimationTime.InterludeDuration)
	TaskDispatcher.runDelay(arg_6_0.closeThis, arg_6_0, MoLiDeErEnum.AnimationTime.InterludeCloseDuration)
	arg_6_0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_level_transition)
end

function var_0_0.refreshUI(arg_7_0)
	local var_7_0

	if not arg_7_0._isNextRound then
		local var_7_1 = MoLiDeErModel.instance:getCurEpisode()

		var_7_0 = var_7_1 and var_7_1.name
	else
		local var_7_2 = MoLiDeErGameModel.instance:getCurRound()

		var_7_0 = luaLang("molideer_interludeview_txt_title")
		var_7_0 = GameUtil.getSubPlaceholderLuaLangOneParam(var_7_0, var_7_2)
	end

	local var_7_3 = LuaUtil.subString(var_7_0, 1, 1)
	local var_7_4 = LuaUtil.subString(var_7_0, 2)

	arg_7_0._txtStart.text = string.format("<size=120>%s</size>%s", var_7_3, var_7_4)
end

function var_0_0.onAnimFinish(arg_8_0)
	arg_8_0._animator:Play(MoLiDeErEnum.AnimName.InterludeViewClose)

	if arg_8_0._callback then
		if arg_8_0._callbackObj then
			arg_8_0._callback(arg_8_0._callbackObj)
		else
			arg_8_0._callback()
		end

		arg_8_0._callbackObj = nil
		arg_8_0._callback = nil
	end
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._onAnimFinish, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.closeThis, arg_10_0)
end

return var_0_0
