module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonMapEpisodeView", package.seeall)

slot0 = class("VersionActivity1_3DungeonMapEpisodeView", VersionActivity1_3DungeonBaseEpisodeView)

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0._txtunlocktime = gohelper.findChildText(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#go_hardModeLock/#txt_unlockTime")
	slot0.goScrollRect = gohelper.findChild(slot0.viewGO, "#scroll_content")

	recthelper.setAnchorY(slot0.goScrollRect.transform, -240)
end

function slot0.refreshModeNode(slot0)
	uv0.super.refreshModeNode(slot0)
	slot0:refreshModeLockText()
end

function slot0.refreshModeLockText(slot0)
	if ServerTime.now() < VersionActivityConfig.instance:getAct113DungeonChapterOpenTimeStamp(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard) then
		slot3 = slot1 - slot2
		slot6 = Mathf.Floor(slot3 % TimeUtil.OneDaySecond / TimeUtil.OneHourSecond)

		if Mathf.Floor(slot3 / TimeUtil.OneDaySecond) > 0 then
			if slot6 > 0 then
				slot8 = ActivityModel.instance:getActivityInfo()[VersionActivity1_3Enum.ActivityId.Dungeon]:getRemainTimeStr2(slot3) .. slot6 .. luaLang("time_hour2")
			end

			slot0._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), slot8)
		else
			slot0._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), slot7:getRemainTimeStr2(slot3))
		end

		gohelper.setActive(slot0._gohardmodelock, true)
		gohelper.setActive(slot0._gohardmodeNormal, true)
		gohelper.setActive(slot0._gohardmodeSelect, false)

		return
	end

	slot3, slot4 = DungeonModel.instance:chapterIsUnLock(slot0.activityDungeonMo.activityDungeonConfig.hardChapterId)

	if not slot3 then
		slot0._txtunlocktime.text = string.format(luaLang("versionactivity1_3_hardlocktip"), "JMP-" .. DungeonConfig.instance:getChapterEpisodeIndexWithSP(DungeonConfig.instance:getEpisodeCO(slot4).chapterId, slot4))

		gohelper.setActive(slot0._gohardmodelock, true)
		gohelper.setActive(slot0._gohardmodeNormal, true)
		gohelper.setActive(slot0._gohardmodeSelect, false)

		return
	end

	gohelper.setActive(slot0._gohardmodelock, false)
end

return slot0
