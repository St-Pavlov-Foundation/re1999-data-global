module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaMapViewAudio", package.seeall)

local var_0_0 = class("JiaLaBoNaMapViewAudio", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	return
end

function var_0_0._onCloseGameView(arg_3_0, arg_3_1)
	if (arg_3_1 == ViewName.JiaLaBoNaGameView or arg_3_1 == ViewName.StoryFrontView) and arg_3_0:_isCanPlayAmbient() then
		arg_3_0:playAmbientAudio()
	end
end

function var_0_0._isCanPlayAmbient(arg_4_0)
	if ViewMgr.instance:isOpen(ViewName.JiaLaBoNaGameView) or ViewMgr.instance:isOpen(ViewName.StoryFrontView) then
		return false
	end

	return true
end

function var_0_0._onOpenGameView(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.JiaLaBoNaGameView or arg_5_1 == ViewName.StoryFrontView then
		arg_5_0:closeAmbientSound()
	end
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_ilbn_open)
	arg_6_0:playAmbientAudio()
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_6_0._onCloseGameView, arg_6_0)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_6_0._onOpenGameView, arg_6_0)
end

function var_0_0.playAmbientAudio(arg_7_0)
	arg_7_0:closeAmbientSound()

	arg_7_0._ambientAudioId = AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_amb_activity_molu1_3_ganapona)
end

function var_0_0.closeAmbientSound(arg_8_0)
	if arg_8_0._ambientAudioId then
		AudioMgr.instance:stopPlayingID(arg_8_0._ambientAudioId)

		arg_8_0._ambientAudioId = nil
	end
end

function var_0_0.onClose(arg_9_0)
	arg_9_0:closeAmbientSound()
end

return var_0_0
