module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonMapEpisodeView", package.seeall)

local var_0_0 = class("VersionActivity1_3DungeonMapEpisodeView", VersionActivity1_3DungeonBaseEpisodeView)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0._txtunlocktime = gohelper.findChildText(arg_1_0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#go_hardModeLock/#txt_unlockTime")
	arg_1_0.goScrollRect = gohelper.findChild(arg_1_0.viewGO, "#scroll_content")

	recthelper.setAnchorY(arg_1_0.goScrollRect.transform, -240)
end

function var_0_0.refreshModeNode(arg_2_0)
	var_0_0.super.refreshModeNode(arg_2_0)
	arg_2_0:refreshModeLockText()
end

function var_0_0.refreshModeLockText(arg_3_0)
	local var_3_0 = VersionActivityConfig.instance:getAct113DungeonChapterOpenTimeStamp(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard)
	local var_3_1 = ServerTime.now()

	if var_3_1 < var_3_0 then
		local var_3_2 = var_3_0 - var_3_1
		local var_3_3 = Mathf.Floor(var_3_2 / TimeUtil.OneDaySecond)
		local var_3_4 = var_3_2 % TimeUtil.OneDaySecond
		local var_3_5 = Mathf.Floor(var_3_4 / TimeUtil.OneHourSecond)
		local var_3_6 = ActivityModel.instance:getActivityInfo()[VersionActivity1_3Enum.ActivityId.Dungeon]

		if var_3_3 > 0 then
			local var_3_7 = var_3_6:getRemainTimeStr2(var_3_2)

			if var_3_5 > 0 then
				var_3_7 = var_3_7 .. var_3_5 .. luaLang("time_hour2")
			end

			arg_3_0._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), var_3_7)
		else
			arg_3_0._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), var_3_6:getRemainTimeStr2(var_3_2))
		end

		gohelper.setActive(arg_3_0._gohardmodelock, true)
		gohelper.setActive(arg_3_0._gohardmodeNormal, true)
		gohelper.setActive(arg_3_0._gohardmodeSelect, false)

		return
	end

	local var_3_8, var_3_9 = DungeonModel.instance:chapterIsUnLock(arg_3_0.activityDungeonMo.activityDungeonConfig.hardChapterId)

	if not var_3_8 then
		local var_3_10 = DungeonConfig.instance:getEpisodeCO(var_3_9)

		arg_3_0._txtunlocktime.text = string.format(luaLang("versionactivity1_3_hardlocktip"), "JMP-" .. DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_3_10.chapterId, var_3_9))

		gohelper.setActive(arg_3_0._gohardmodelock, true)
		gohelper.setActive(arg_3_0._gohardmodeNormal, true)
		gohelper.setActive(arg_3_0._gohardmodeSelect, false)

		return
	end

	gohelper.setActive(arg_3_0._gohardmodelock, false)
end

return var_0_0
