module("modules.logic.versionactivity1_2.yaxian.view.YaXianMapAudioView", package.seeall)

local var_0_0 = class("YaXianMapAudioView", BaseView)

function var_0_0.onInitView(arg_1_0)
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
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_4_0._onCloseView, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_4_0._onOpenView, arg_4_0)
	arg_4_0:addEventCb(YaXianController.instance, YaXianEvent.OnSelectChapterChange, arg_4_0.onSelectChapterChange, arg_4_0)
end

function var_0_0._onCloseView(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.YaXianGameView then
		arg_5_0:playAmbientAudio()
	end
end

function var_0_0._onOpenView(arg_6_0, arg_6_1)
	if arg_6_1 == ViewName.YaXianGameView then
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:playAmbientAudio()
end

function var_0_0.playAmbientAudio(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)

	local var_8_0 = YaXianConfig.instance:getChapterConfig(arg_8_0.viewContainer.chapterId)

	AudioMgr.instance:trigger(var_8_0.ambientAudio)
end

function var_0_0.onSelectChapterChange(arg_9_0)
	arg_9_0:playAmbientAudio()
end

function var_0_0.onClose(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
end

return var_0_0
