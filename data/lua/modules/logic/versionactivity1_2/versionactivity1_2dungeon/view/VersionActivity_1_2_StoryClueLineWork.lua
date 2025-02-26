module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_StoryClueLineWork", package.seeall)

slot0 = class("VersionActivity_1_2_StoryClueLineWork", BaseWork)

function slot0.ctor(slot0, slot1, slot2, slot3, slot4)
	slot0._lineTransform = slot1
	slot0._toValue = slot2
	slot0._duration = slot3
	slot0._clueId = slot4
end

function slot0.onStart(slot0)
	VersionActivity1_2DungeonController.instance:registerCallback(VersionActivity1_2DungeonEvent.skipLineWork, slot0._skipLineWork, slot0)

	slot5 = slot0._onTweenEnd
	slot0._tweenId = ZProj.TweenHelper.DOWidth(slot0._lineTransform, slot0._toValue, slot0._duration, slot5, slot0)
	slot1 = nil

	for slot5 = 1, 4 do
		if VersionActivity_1_2_StoryCollectView._signTypeName[slot0._clueId] == VersionActivity_1_2_StoryCollectView._signTypeName[slot5] then
			slot1 = "play_ui_lvhu_clue_write_" .. slot5
		end
	end

	if slot1 then
		AudioMgr.instance:trigger(AudioEnum.UI[slot1])
	end
end

function slot0._skipLineWork(slot0)
	slot0:onDone(true)
	recthelper.setWidth(slot0._lineTransform, slot0._toValue)
end

function slot0._onTweenEnd(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	VersionActivity1_2DungeonController.instance:unregisterCallback(VersionActivity1_2DungeonEvent.skipLineWork, slot0._skipLineWork, slot0)

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

return slot0
