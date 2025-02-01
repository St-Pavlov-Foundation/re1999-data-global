module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateMapAudioView", package.seeall)

slot0 = class("EliminateMapAudioView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(EliminateMapController.instance, EliminateMapEvent.OnSelectChapterChange, slot0.onSelectChapterChange, slot0)
end

function slot0._onCloseView(slot0, slot1)
end

function slot0._onOpenView(slot0, slot1)
end

function slot0.onOpen(slot0)
	slot0:playAmbientAudio()
end

function slot0.playAmbientAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
end

function slot0.onSelectChapterChange(slot0)
	slot0:playAmbientAudio()
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
end

return slot0
