module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessMapViewAudio", package.seeall)

slot0 = class("Activity1_3ChessMapViewAudio", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseGameView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenGameView, slot0)
end

function slot0._onCloseGameView(slot0, slot1)
	if (slot1 == ViewName.Activity1_3ChessGameView or slot1 == ViewName.StoryFrontView) and slot0:_canPlayAmbient() then
		slot0:playAmbientAudio()
	end
end

function slot0._onOpenGameView(slot0, slot1)
	if slot1 == ViewName.Activity1_3ChessGameView or slot1 == ViewName.StoryFrontView then
		AudioMgr.instance:trigger(AudioEnum.Story.Stop_Plot_noise)
	end
end

function slot0.onOpen(slot0)
	slot0:playEnterAudio()
	slot0:playAmbientAudio()
end

function slot0.playEnterAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.RoleChessGame1_3Common.EnterChessMap)
end

function slot0.playAmbientAudio(slot0)
	slot0:closeAmbientSound()

	slot0._ambientAudioId = AudioMgr.instance:trigger(AudioEnum.Bgm.Activity1_3ChessMapViewAmbientBgm)
end

function slot0.closeAmbientSound(slot0)
	if slot0._ambientAudioId then
		AudioMgr.instance:stopPlayingID(slot0._ambientAudioId)

		slot0._ambientAudioId = nil
	end
end

function slot0.onClose(slot0)
	slot0:closeAmbientSound()
end

function slot0._canPlayAmbient(slot0)
	if ViewMgr.instance:isOpen(ViewName.Activity1_3ChessGameView) or ViewMgr.instance:isOpen(ViewName.StoryFrontView) then
		return false
	end

	return true
end

return slot0
