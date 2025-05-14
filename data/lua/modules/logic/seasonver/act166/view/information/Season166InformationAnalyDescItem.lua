module("modules.logic.seasonver.act166.view.information.Season166InformationAnalyDescItem", package.seeall)

local var_0_0 = class("Season166InformationAnalyDescItem", Season166InformationAnalyDetailItemBase)

function var_0_0.onInit(arg_1_0)
	arg_1_0.txtDesc = gohelper.findChildTextMesh(arg_1_0.go, "#txt_Descr")
	arg_1_0.goLine = gohelper.findChild(arg_1_0.go, "#txt_Descr/image_Line")
end

function var_0_0.onUpdate(arg_2_0)
	if arg_2_0.txtFadeIn and arg_2_0.txtFadeIn:isPlaying() then
		arg_2_0.txtFadeIn:conFinished()
		arg_2_0.txtFadeIn:onDestroy()
	end

	arg_2_0.txtDesc.text = arg_2_0.data.config.content
end

function var_0_0.playFadeIn(arg_3_0)
	if not arg_3_0.txtFadeIn then
		arg_3_0.txtFadeIn = MonoHelper.addNoUpdateLuaComOnceToGo(arg_3_0.txtDesc.gameObject, TMPFadeInWithScroll)
	end

	AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_feichi_yure_caption)
	arg_3_0.txtFadeIn:playNormalText(arg_3_0.data.config.content, arg_3_0.onTextFinish, arg_3_0)
end

function var_0_0.onTextFinish(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.Season166.stop_ui_feichi_yure_caption)
end

function var_0_0.onDestroy(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.Season166.stop_ui_feichi_yure_caption)
	var_0_0.super.onDestroy(arg_5_0)
end

return var_0_0
