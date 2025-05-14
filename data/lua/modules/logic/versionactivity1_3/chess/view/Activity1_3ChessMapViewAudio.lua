module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessMapViewAudio", package.seeall)

local var_0_0 = class("Activity1_3ChessMapViewAudio", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseGameView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_2_0._onOpenGameView, arg_2_0)
end

function var_0_0._onCloseGameView(arg_3_0, arg_3_1)
	if (arg_3_1 == ViewName.Activity1_3ChessGameView or arg_3_1 == ViewName.StoryFrontView) and arg_3_0:_canPlayAmbient() then
		arg_3_0:playAmbientAudio()
	end
end

function var_0_0._onOpenGameView(arg_4_0, arg_4_1)
	if arg_4_1 == ViewName.Activity1_3ChessGameView or arg_4_1 == ViewName.StoryFrontView then
		AudioMgr.instance:trigger(AudioEnum.Story.Stop_Plot_noise)
	end
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:playEnterAudio()
	arg_5_0:playAmbientAudio()
end

function var_0_0.playEnterAudio(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.EnterChessMap)
end

function var_0_0.playAmbientAudio(arg_7_0)
	arg_7_0:closeAmbientSound()

	arg_7_0._ambientAudioId = AudioMgr.instance:trigger(AudioEnum.Bgm.Activity1_3ChessMapViewAmbientBgm)
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

function var_0_0._canPlayAmbient(arg_10_0)
	if ViewMgr.instance:isOpen(ViewName.Activity1_3ChessGameView) or ViewMgr.instance:isOpen(ViewName.StoryFrontView) then
		return false
	end

	return true
end

return var_0_0
