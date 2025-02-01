module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchTalkTween", package.seeall)

slot0 = class("RoleStoryDispatchTalkTween", UserDataDispose)

function slot0.ctor(slot0)
	slot0:__onInit()
end

function slot0.playTalkTween(slot0, slot1)
	slot0:clearTween()

	slot0.talkList = slot1

	for slot5, slot6 in ipairs(slot0.talkList) do
		slot6:clearText()
	end

	slot0.playIndex = 0

	slot0:playNext()

	slot0.playingId = AudioMgr.instance:trigger(AudioEnum.UI.play_activitystorysfx_shiji_type)
end

function slot0.playNext(slot0)
	if slot0.talkList[slot0.playIndex + 1] then
		slot0.playIndex = slot1

		slot2:startTween(slot0.playNext, slot0)
	else
		slot0:finishTween()
	end
end

function slot0.finishTween(slot0)
	slot0:stopAudio()
end

function slot0.clearTween(slot0)
	if slot0.talkList then
		for slot4, slot5 in ipairs(slot0.talkList) do
			slot5:killTween()
		end
	end

	slot0:stopAudio()
end

function slot0.stopAudio(slot0)
	if slot0.playingId and slot0.playingId > 0 then
		AudioMgr.instance:stopPlayingID(slot0.playingId)

		slot0.playingId = nil
	end
end

function slot0.destroy(slot0)
	slot0:clearTween()
	slot0:__onDispose()
end

return slot0
