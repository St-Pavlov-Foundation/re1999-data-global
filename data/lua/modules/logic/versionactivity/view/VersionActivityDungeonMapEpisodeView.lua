module("modules.logic.versionactivity.view.VersionActivityDungeonMapEpisodeView", package.seeall)

slot0 = class("VersionActivityDungeonMapEpisodeView", VersionActivityDungeonBaseEpisodeView)

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
	if ServerTime.now() < VersionActivityConfig.instance:getAct113DungeonChapterOpenTimeStamp(VersionActivityEnum.DungeonChapterId.LeiMiTeBeiHard) then
		slot3 = slot1 - slot2

		if Mathf.Floor(slot3 / TimeUtil.OneDaySecond) == 0 and Mathf.Floor(slot3 % TimeUtil.OneDaySecond / TimeUtil.OneHourSecond) == 0 then
			slot0._txtunlocktime.text = string.format(luaLang("lei_mi_te_bei_dungeon_time2"), Mathf.Ceil(slot5 % TimeUtil.OneHourSecond / TimeUtil.OneMinuteSecond))
		else
			slot0._txtunlocktime.text = string.format(luaLang("lei_mi_te_bei_dungeon_time1"), slot4, slot6)
		end

		gohelper.setActive(slot0._gohardmodelock, true)
		gohelper.setActive(slot0._gohardmodeNormal, true)
		gohelper.setActive(slot0._gohardmodeSelect, false)

		return
	end

	slot3, slot4 = DungeonModel.instance:chapterIsUnLock(slot0.activityDungeonMo.activityDungeonConfig.hardChapterId)

	if not slot3 then
		slot0._txtunlocktime.text = string.format(luaLang("lei_mi_te_bei_dungeon"), DungeonConfig.instance:getEpisodeLevelIndexByEpisodeId(slot4))

		gohelper.setActive(slot0._gohardmodelock, true)
		gohelper.setActive(slot0._gohardmodeNormal, true)
		gohelper.setActive(slot0._gohardmodeSelect, false)

		return
	end

	gohelper.setActive(slot0._gohardmodelock, false)
end

return slot0
