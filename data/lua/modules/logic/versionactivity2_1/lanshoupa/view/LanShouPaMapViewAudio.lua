module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaMapViewAudio", package.seeall)

slot0 = class("LanShouPaMapViewAudio", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
end

function slot0._onCloseGameView(slot0, slot1)
	if (slot1 == ViewName.LanShouPaGameView or slot1 == ViewName.StoryFrontView) and slot0:_isCanPlayAmbient() then
		slot0:playAmbientAudio()
	end
end

function slot0._isCanPlayAmbient(slot0)
	if ViewMgr.instance:isOpen(ViewName.LanShouPaGameView) or ViewMgr.instance:isOpen(ViewName.StoryFrontView) then
		return false
	end

	return true
end

function slot0._onOpenGameView(slot0, slot1)
	if slot1 ~= ViewName.LanShouPaGameView and slot1 == ViewName.StoryFrontView then
		-- Nothing
	end
end

function slot0.onOpen(slot0)
	slot0:playAmbientAudio()
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseGameView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenGameView, slot0)
end

function slot0.playAmbientAudio(slot0)
end

function slot0.closeAmbientSound(slot0)
	if slot0._ambientAudioId then
		AudioMgr.instance:stopPlayingID(slot0._ambientAudioId)

		slot0._ambientAudioId = nil
	end
end

function slot0.onClose(slot0)
end

return slot0
