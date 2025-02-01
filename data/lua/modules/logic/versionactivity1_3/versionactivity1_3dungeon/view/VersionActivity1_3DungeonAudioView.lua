module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonAudioView", package.seeall)

slot0 = class("VersionActivity1_3DungeonAudioView", BaseView)

function slot0.onInitView(slot0)
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.StoryView then
		-- Nothing
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.StoryView then
		-- Nothing
	end
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)
end

function slot0.onDestroyView(slot0)
end

return slot0
