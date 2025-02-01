module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaMapViewAudio", package.seeall)

slot0 = class("JiaLaBoNaMapViewAudio", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
end

function slot0._onCloseGameView(slot0, slot1)
	if (slot1 == ViewName.JiaLaBoNaGameView or slot1 == ViewName.StoryFrontView) and slot0:_isCanPlayAmbient() then
		slot0:playAmbientAudio()
	end
end

function slot0._isCanPlayAmbient(slot0)
	if ViewMgr.instance:isOpen(ViewName.JiaLaBoNaGameView) or ViewMgr.instance:isOpen(ViewName.StoryFrontView) then
		return false
	end

	return true
end

function slot0._onOpenGameView(slot0, slot1)
	if slot1 == ViewName.JiaLaBoNaGameView or slot1 == ViewName.StoryFrontView then
		slot0:closeAmbientSound()
	end
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_ilbn_open)
	slot0:playAmbientAudio()
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseGameView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenGameView, slot0)
end

function slot0.playAmbientAudio(slot0)
	slot0:closeAmbientSound()

	slot0._ambientAudioId = AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_amb_activity_molu1_3_ganapona)
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

return slot0
