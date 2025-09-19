module("modules.logic.versionactivity2_8.dungeonboss.view.VersionActivity2_8BossActEnterView", package.seeall)

local var_0_0 = class("VersionActivity2_8BossActEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._simagelangtxt = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/versionactivity/right/title/#simage_langtxt")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/title/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._txtactivitydesc = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/content/#txt_activitydesc")
	arg_1_0._goswitch = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch")
	arg_1_0._gotype1 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type1")
	arg_1_0._gotype2 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type2")
	arg_1_0._gotype3 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type3")
	arg_1_0._gotype4 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type4")
	arg_1_0._gotype0 = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#go_type0")
	arg_1_0._btnleftarrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_leftarrow")
	arg_1_0._btnrightarrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_rightarrow")
	arg_1_0._gorightarrow = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_rightarrow/#go_right_arrow")
	arg_1_0._gorightarrowdisable = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/content/#go_switch/#btn_rightarrow/#go_right_arrow_disable")
	arg_1_0._btnactivityreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/go_rewards/#btn_activityreward")
	arg_1_0._scrollrewards = gohelper.findChildScrollRect(arg_1_0.viewGO, "anim/versionactivity/right/go_rewards/#scroll_rewards")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/go_rewards/#scroll_rewards/Viewport/#go_rewards")
	arg_1_0._goactivityrewarditem = gohelper.findChild(arg_1_0.viewGO, "anim/versionactivity/right/go_rewards/#scroll_rewards/Viewport/#go_rewards/#go_activityrewarditem")
	arg_1_0._btnnormalStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_normalStart")
	arg_1_0._btnlockedStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_lockedStart")
	arg_1_0._txtlocked = gohelper.findChildText(arg_1_0.viewGO, "anim/versionactivity/right/startBtn/#btn_lockedStart/#txt_locked")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "anim/#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnleftarrow:AddClickListener(arg_2_0._btnleftarrowOnClick, arg_2_0)
	arg_2_0._btnrightarrow:AddClickListener(arg_2_0._btnrightarrowOnClick, arg_2_0)
	arg_2_0._btnactivityreward:AddClickListener(arg_2_0._btnactivityrewardOnClick, arg_2_0)
	arg_2_0._btnnormalStart:AddClickListener(arg_2_0._btnnormalStartOnClick, arg_2_0)
	arg_2_0._btnlockedStart:AddClickListener(arg_2_0._btnlockedStartOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnleftarrow:RemoveClickListener()
	arg_3_0._btnrightarrow:RemoveClickListener()
	arg_3_0._btnactivityreward:RemoveClickListener()
	arg_3_0._btnnormalStart:RemoveClickListener()
	arg_3_0._btnlockedStart:RemoveClickListener()
end

function var_0_0._btnleftarrowOnClick(arg_4_0)
	arg_4_0._index = arg_4_0._index - 1

	arg_4_0:_updateBtnStatus()
	arg_4_0:_showEpisodeInfo()
end

function var_0_0._btnrightarrowOnClick(arg_5_0)
	if not arg_5_0._rightInteractable then
		GameFacade.showToast(ToastEnum.ToughBattleDiffcultLock)

		return
	end

	arg_5_0._index = arg_5_0._index + 1

	arg_5_0:_updateBtnStatus()
	arg_5_0:_showEpisodeInfo()
end

function var_0_0._btnactivityrewardOnClick(arg_6_0)
	return
end

function var_0_0._btnnormalStartOnClick(arg_7_0)
	local var_7_0 = arg_7_0._episodeList[arg_7_0._index]

	DungeonFightController.instance:enterFight(var_7_0.chapterId, var_7_0.id)
end

function var_0_0._btnlockedStartOnClick(arg_8_0)
	return
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0:_initChapterList()
	gohelper.setActive(arg_9_0._goactivityrewarditem, false)
	gohelper.setActive(arg_9_0._gotype0, false)
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:_selectTargetEpisode()
	arg_11_0:_unlockEpisode()
	arg_11_0:_updateBtnStatus()
	arg_11_0:_initEpisodeOpenTime()
	arg_11_0:_showEpisodeInfo()
end

function var_0_0._selectTargetEpisode(arg_12_0)
	local var_12_0 = arg_12_0.viewParam and arg_12_0.viewParam.episodeId

	if not var_12_0 then
		local var_12_1 = VersionActivity2_8DungeonBossController.getPrefsString(VersionActivity2_8BossEnum.PrefsKey.BossActSelected)

		var_12_0 = tonumber(var_12_1)
	end

	if var_12_0 then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0._episodeList) do
			if iter_12_1.id == var_12_0 then
				arg_12_0._index = iter_12_0

				break
			end
		end
	end
end

function var_0_0._unlockEpisode(arg_13_0)
	local var_13_0 = false

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._episodeList) do
		if iter_13_0 ~= 1 and DungeonModel.instance:hasPassLevel(iter_13_1.preEpisode) and not VersionActivity2_8DungeonBossController.hasOnceActionKey(VersionActivity2_8BossEnum.PrefsKey.BossActUnlock, iter_13_1.id) then
			VersionActivity2_8DungeonBossController.setOnceActionKey(VersionActivity2_8BossEnum.PrefsKey.BossActUnlock, iter_13_1.id)

			arg_13_0._index = iter_13_0
			var_13_0 = true
		end

		if DungeonModel.instance:hasPassLevel(iter_13_1.id) then
			arg_13_0._maxIndex = math.min(iter_13_0 + 1, #arg_13_0._episodeList)
		end
	end

	if var_13_0 then
		VersionActivity2_8DungeonBossController.instance:checkBossActReddot()
		GameFacade.showToast(ToastEnum.ToughBattleDiffcultUnLock, luaLang("p_versionactivitydungeonmaplevelview_type" .. arg_13_0._index))
		TaskDispatcher.cancelTask(arg_13_0._playUnlockAnim, arg_13_0)
		TaskDispatcher.runDelay(arg_13_0._playUnlockAnim, arg_13_0, 0.6)
	end
end

function var_0_0._playUnlockAnim(arg_14_0)
	gohelper.setActive(arg_14_0._gotype0, true)
	arg_14_0._gotype0:GetComponent("Animator"):Play("unlock", 0, 0)
end

function var_0_0._initEpisodeOpenTime(arg_15_0)
	arg_15_0._singleModeEpisodeConfig = lua_single_mode_episode.configDict[VersionActivity2_8BossEnum.BossActChapterId]

	local var_15_0 = ActivityModel.instance:getActStartTime(VersionActivity2_8Enum.ActivityId.DungeonBoss) / 1000
	local var_15_1 = ActivityModel.instance:getActEndTime(VersionActivity2_8Enum.ActivityId.DungeonBoss) / 1000

	arg_15_0._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(var_15_1 - ServerTime.now())

	local var_15_2 = 0
	local var_15_3 = var_15_2 + tonumber(lua_boss_fight_mode_const.configDict[1].value)
	local var_15_4 = var_15_2 + tonumber(lua_boss_fight_mode_const.configDict[2].value)

	arg_15_0._openTimeList = {
		var_15_0 + var_15_2 * TimeUtil.OneDaySecond,
		var_15_0 + var_15_3 * TimeUtil.OneDaySecond,
		var_15_0 + var_15_4 * TimeUtil.OneDaySecond
	}
end

function var_0_0._initChapterList(arg_16_0)
	arg_16_0._episodeList = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity2_8BossEnum.BossActChapterId)
	arg_16_0._index = 1
	arg_16_0._maxIndex = 1
	arg_16_0._totalIndex = #arg_16_0._episodeList
end

function var_0_0._updateBtnStatus(arg_17_0)
	gohelper.setActive(arg_17_0._btnleftarrow, arg_17_0._index ~= 1)
	gohelper.setActive(arg_17_0._btnrightarrow, arg_17_0._index ~= arg_17_0._totalIndex)

	local var_17_0 = arg_17_0._index < arg_17_0._maxIndex

	gohelper.setActive(arg_17_0._gorightarrow, var_17_0)
	gohelper.setActive(arg_17_0._gorightarrowdisable, not var_17_0)

	arg_17_0._rightInteractable = var_17_0
end

function var_0_0._showEpisodeInfo(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._checkOpen, arg_18_0)

	local var_18_0 = arg_18_0._episodeList[arg_18_0._index]

	arg_18_0._txtactivitydesc.text = var_18_0.desc

	for iter_18_0 = 1, 4 do
		gohelper.setActive(arg_18_0["_gotype" .. iter_18_0], false)
	end

	gohelper.setActive(arg_18_0["_gotype" .. arg_18_0._index], true)
	arg_18_0:_showRewards(var_18_0)

	local var_18_1 = arg_18_0._openTimeList[arg_18_0._index] <= ServerTime.now()

	gohelper.setActive(arg_18_0._btnnormalStart, var_18_1)
	gohelper.setActive(arg_18_0._btnlockedStart, not var_18_1)
	TaskDispatcher.cancelTask(arg_18_0._updateCountDownTxt, arg_18_0)

	if not var_18_1 then
		TaskDispatcher.runRepeat(arg_18_0._updateCountDownTxt, arg_18_0, 1)
		arg_18_0:_updateCountDownTxt()

		local var_18_2 = arg_18_0._openTimeList[arg_18_0._index] - ServerTime.now()

		TaskDispatcher.runDelay(arg_18_0._checkOpen, arg_18_0, var_18_2)
	end

	VersionActivity2_8DungeonBossController.setPrefsString(VersionActivity2_8BossEnum.PrefsKey.BossActSelected, var_18_0.id)
end

function var_0_0._updateCountDownTxt(arg_19_0)
	local var_19_0 = arg_19_0._openTimeList[arg_19_0._index] - ServerTime.now()
	local var_19_1 = TimeUtil.SecondToActivityTimeFormat(var_19_0)

	arg_19_0._txtlocked.text = formatLuaLang("test_task_unlock_time", var_19_1)
end

function var_0_0._checkOpen(arg_20_0)
	arg_20_0:_showEpisodeInfo()
end

function var_0_0._showRewards(arg_21_0, arg_21_1)
	if arg_21_0._itemList then
		for iter_21_0, iter_21_1 in ipairs(arg_21_0._itemList) do
			gohelper.setActive(iter_21_1, false)
		end
	end

	local var_21_0 = DungeonConfig.instance:getRewardItems(arg_21_1.firstBonus)
	local var_21_1 = DungeonModel.instance:hasPassLevel(arg_21_1.id)

	for iter_21_2, iter_21_3 in ipairs(var_21_0) do
		local var_21_2 = arg_21_0:_getItemGo(iter_21_2)

		gohelper.setActive(var_21_2, true)

		local var_21_3 = gohelper.findChild(var_21_2, "go_receive")

		gohelper.setActive(var_21_3, var_21_1)

		local var_21_4 = gohelper.findChild(var_21_2, "go_icon")

		gohelper.destroyAllChildren(var_21_4)

		local var_21_5 = IconMgr.instance:getCommonItemIcon(var_21_4)

		gohelper.setAsFirstSibling(var_21_5.go)
		var_21_5:setMOValue(iter_21_3[1], iter_21_3[2], iter_21_3[3], nil, true)
		var_21_5:setCountFontSize(32)
		var_21_5:showStackableNum()

		local var_21_6 = var_21_5:getCountBg()

		recthelper.setAnchorY(var_21_6.transform, 50)
	end

	arg_21_0._scrollrewards.horizontalNormalizedPosition = 0
end

function var_0_0._getItemGo(arg_22_0, arg_22_1)
	arg_22_0._itemList = arg_22_0._itemList or arg_22_0:getUserDataTb_()

	if not arg_22_0._itemList[arg_22_1] then
		local var_22_0 = gohelper.cloneInPlace(arg_22_0._goactivityrewarditem, arg_22_1)

		arg_22_0._itemList[arg_22_1] = var_22_0
	end

	return arg_22_0._itemList[arg_22_1]
end

function var_0_0.onClose(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._checkOpen, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._playUnlockAnim, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._updateCountDownTxt, arg_23_0)
end

function var_0_0.onDestroyView(arg_24_0)
	return
end

return var_0_0
