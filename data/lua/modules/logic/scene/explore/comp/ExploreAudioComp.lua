module("modules.logic.scene.explore.comp.ExploreAudioComp", package.seeall)

slot0 = class("ExploreAudioComp", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0.audioManagerGo = gohelper.find("AudioManager")
	slot0.focusGo = CameraMgr.instance:getFocusTrs().gameObject

	gohelper.enableAkListener(slot0.audioManagerGo, false)
	gohelper.enableAkListener(slot0.focusGo, true)

	slot0._allLoopAudioIds = {}
end

function slot0.onTriggerAudio(slot0, slot1, slot2)
	if not slot0._allLoopAudioIds[slot1] then
		slot0._allLoopAudioIds[slot1] = {}
	end

	slot0._allLoopAudioIds[slot1][slot2] = true
end

function slot0.stopAudioByUnit(slot0, slot1)
	if not slot0._allLoopAudioIds[slot1] then
		return
	end

	for slot5 in pairs(slot0._allLoopAudioIds[slot1]) do
		AudioMgr.instance:stopPlayingID(slot5)
	end

	slot0._allLoopAudioIds[slot1] = nil
end

function slot0.onSceneClose(slot0)
	for slot4 in pairs(slot0._allLoopAudioIds) do
		slot0:stopAudioByUnit(slot4)
	end

	slot0._allLoopAudioIds = {}

	gohelper.enableAkListener(slot0.audioManagerGo, true)
	gohelper.enableAkListener(slot0.focusGo, false)

	slot0.audioManagerGo = nil
	slot0.focusGo = nil
end

return slot0
