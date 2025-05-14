module("modules.logic.dungeon.view.DungeonMapLevelView_bake", package.seeall)

local var_0_0 = class("DungeonMapLevelView_bake", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btncloseview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeview")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_normal")
	arg_1_0._btnhardmode = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/right/#go_hard/go/#btn_hardmode")
	arg_1_0._btnhardmodetip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/right/#go_hard/go/#btn_hardmodetip")
	arg_1_0._gohard = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_hard")
	arg_1_0._simagenormalbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/bgmask/#simage_normalbg")
	arg_1_0._simagehardbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/bgmask/#simage_hardbg")
	arg_1_0._imagehardstatus = gohelper.findChildImage(arg_1_0.viewGO, "anim/right/#go_hard/#image_hardstatus")
	arg_1_0._btnnormalmode = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/right/#go_normal/#btn_normalmode")
	arg_1_0._txtpower = gohelper.findChildText(arg_1_0.viewGO, "anim/right/power/#txt_power")
	arg_1_0._simagepower1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/right/power/#simage_power1")
	arg_1_0._txtrule = gohelper.findChildText(arg_1_0.viewGO, "anim/right/condition/#go_additionRule/#txt_rule")
	arg_1_0._goruletemp = gohelper.findChild(arg_1_0.viewGO, "anim/right/condition/#go_additionRule/#go_ruletemp")
	arg_1_0._imagetagicon = gohelper.findChildImage(arg_1_0.viewGO, "anim/right/condition/#go_additionRule/#go_ruletemp/#image_tagicon")
	arg_1_0._gorulelist = gohelper.findChild(arg_1_0.viewGO, "anim/right/condition/#go_additionRule/#go_rulelist")
	arg_1_0._godefault = gohelper.findChild(arg_1_0.viewGO, "anim/right/condition/#go_default")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "anim/right/reward/#scroll_reward")
	arg_1_0._gooperation = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation")
	arg_1_0._gostart = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_start")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/right/#go_operation/#go_start/#btn_start")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/right/#go_equipmap/#btn_equip")
	arg_1_0._txtchallengecountlimit = gohelper.findChildText(arg_1_0.viewGO, "anim/right/#go_operation/#go_start/#txt_challengecountlimit")
	arg_1_0._gonormal2 = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2")
	arg_1_0._goticket = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket")
	arg_1_0._btnshowtickets = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#btn_showtickets")
	arg_1_0._goticketlist = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketlist")
	arg_1_0._goticketItem = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem")
	arg_1_0._goticketinfo = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_ticketinfo")
	arg_1_0._simageticket = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_ticketinfo/#simage_ticket")
	arg_1_0._txtticket = gohelper.findChildText(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_ticketinfo/#txt_ticket")
	arg_1_0._gonoticket = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_noticket")
	arg_1_0._txtnoticket1 = gohelper.findChildText(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_noticket/#txt_noticket1")
	arg_1_0._txtnoticket2 = gohelper.findChildText(arg_1_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_noticket/#txt_noticket2")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_lock")
	arg_1_0._goequipmap = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_equipmap")
	arg_1_0._txtcostcount = gohelper.findChildText(arg_1_0.viewGO, "anim/right/#go_equipmap/#btn_equip/#txt_num")
	arg_1_0._gofightcountbg = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_equipmap/fightcount/#go_fightcountbg")
	arg_1_0._txtfightcount = gohelper.findChildText(arg_1_0.viewGO, "anim/right/#go_equipmap/fightcount/#txt_fightcount")
	arg_1_0._btnlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/right/#go_operation/#go_lock/#btn_lock")
	arg_1_0._btnstory = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/right/#btn_story")
	arg_1_0._btnviewstory = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/right/#btn_viewstory")
	arg_1_0._txtget = gohelper.findChildText(arg_1_0.viewGO, "anim/right/reward_container/#go_reward/#txt_get")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "anim/#go_righttop")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "anim/right/reward_container/#go_rewarditem")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "anim/right/reward_container/#go_reward")
	arg_1_0._gorewardList = gohelper.findChild(arg_1_0.viewGO, "anim/right/reward_container/#go_reward/rewardList")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/right/reward_container/#go_reward/#btn_reward")
	arg_1_0._txttitle1 = gohelper.findChildText(arg_1_0.viewGO, "anim/right/title/#txt_title1")
	arg_1_0._txttitle3 = gohelper.findChildText(arg_1_0.viewGO, "anim/right/title/#txt_title3")
	arg_1_0._txtchapterindex = gohelper.findChildText(arg_1_0.viewGO, "anim/right/title/#txt_title3/#txt_chapterindex")
	arg_1_0._txttitle4 = gohelper.findChildText(arg_1_0.viewGO, "anim/right/title/#txt_title1/#txt_title4")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "anim/right/#txt_desc")
	arg_1_0._gorecommond = gohelper.findChild(arg_1_0.viewGO, "anim/right/recommend")
	arg_1_0._txtrecommondlv = gohelper.findChildText(arg_1_0.viewGO, "anim/right/recommend/#txt_recommendlv")
	arg_1_0._simagepower2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/right/#go_operation/#go_start/#go_startnormal/#simage_power2")
	arg_1_0._txtusepower = gohelper.findChildText(arg_1_0.viewGO, "anim/right/#go_operation/#go_start/#go_startnormal/#txt_usepower")
	arg_1_0._simagepower3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/right/#go_operation/#go_start/#go_starthard/#simage_power3")
	arg_1_0._txtusepowerhard = gohelper.findChildText(arg_1_0.viewGO, "anim/right/#go_operation/#go_start/#go_starthard/#txt_usepowerhard")
	arg_1_0._gostartnormal = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_start/#go_startnormal")
	arg_1_0._gostarthard = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_start/#go_starthard")
	arg_1_0._gohardmodedecorate = gohelper.findChild(arg_1_0.viewGO, "anim/right/title/#txt_title1/#go_hardmodedecorate")
	arg_1_0._gostar = gohelper.findChild(arg_1_0.viewGO, "anim/right/title/#go_star")
	arg_1_0._gonoreward = gohelper.findChild(arg_1_0.viewGO, "anim/right/reward_container/#go_noreward")
	arg_1_0._gostoryline = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_storyline")
	arg_1_0._goselecthardbg = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_hard/go/#go_selecthardbg")
	arg_1_0._gounselecthardbg = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_hard/go/#go_unselecthardbg")
	arg_1_0._goselectnormalbg = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_normal/#go_selectnormalbg")
	arg_1_0._gounselectnormalbg = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_normal/#go_unselectnormalbg")
	arg_1_0._golockbg = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_hard/go/#go_lockbg")
	arg_1_0._txtLockTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "anim/right/#go_hard/go/#go_lockbg/#txt_locktime")
	arg_1_0._gonormalrewardbg = gohelper.findChild(arg_1_0.viewGO, "anim/right/reward_container/#go_reward/#go_normalrewardbg")
	arg_1_0._gohardrewardbg = gohelper.findChild(arg_1_0.viewGO, "anim/right/reward_container/#go_reward/#go_hardrewardbg")
	arg_1_0._gonormallackpower = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_start/#go_startnormal/#go_normallackpower")
	arg_1_0._gohardlackpower = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_operation/#go_start/#go_starthard/#go_hardlackpower")
	arg_1_0._goboss = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_boss")
	arg_1_0._gonormaleye = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_boss/#go_normaleye")
	arg_1_0._gohardeye = gohelper.findChild(arg_1_0.viewGO, "anim/right/#go_boss/#go_hardeye")
	arg_1_0._goTurnBackAddition = gohelper.findChild(arg_1_0.viewGO, "anim/right/turnback_tips")
	arg_1_0._txtTurnBackAdditionTips = gohelper.findChildText(arg_1_0.viewGO, "anim/right/turnback_tips/#txt_des")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloseview:AddClickListener(arg_2_0._btncloseviewOnClick, arg_2_0)
	arg_2_0._btnhardmode:AddClickListener(arg_2_0._btnhardmodeOnClick, arg_2_0)
	arg_2_0._btnhardmodetip:AddClickListener(arg_2_0._btnhardmodetipOnClick, arg_2_0)
	arg_2_0._btnnormalmode:AddClickListener(arg_2_0._btnnormalmodeOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._btnequipOnClick, arg_2_0)
	arg_2_0._btnshowtickets:AddClickListener(arg_2_0._btnshowticketsOnClick, arg_2_0)
	arg_2_0._btnlock:AddClickListener(arg_2_0._btnlockOnClick, arg_2_0)
	arg_2_0._btnstory:AddClickListener(arg_2_0._btnstoryOnClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0._onRefreshActivityState, arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0._onDailyRefresh, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, arg_2_0._refreshTurnBack, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloseview:RemoveClickListener()
	arg_3_0._btnhardmode:RemoveClickListener()
	arg_3_0._btnhardmodetip:RemoveClickListener()
	arg_3_0._btnnormalmode:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnequip:RemoveClickListener()
	arg_3_0._btnshowtickets:RemoveClickListener()
	arg_3_0._btnlock:RemoveClickListener()
	arg_3_0._btnstory:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_3_0._onRefreshActivityState, arg_3_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, arg_3_0._refreshTurnBack, arg_3_0)
end

var_0_0.AudioConfig = {
	[DungeonEnum.ChapterListType.Story] = {
		onOpen = AudioEnum.UI.play_ui_checkpoint_pagesopen,
		onClose = AudioEnum.UI.UI_role_introduce_close
	},
	[DungeonEnum.ChapterListType.Resource] = {
		onOpen = AudioEnum.UI.play_ui_checkpoint_sources_open,
		onClose = AudioEnum.UI.UI_role_introduce_close
	},
	[DungeonEnum.ChapterListType.Insight] = {
		onOpen = AudioEnum.UI.UI_checkpoint_Insight_open,
		onClose = AudioEnum.UI.UI_role_introduce_close
	}
}

function var_0_0._btncloseviewOnClick(arg_4_0)
	TaskDispatcher.runDelay(arg_4_0.closeThis, arg_4_0, 0)
end

function var_0_0._btnrewardOnClick(arg_5_0)
	DungeonController.instance:openDungeonRewardView(arg_5_0._config)
end

function var_0_0._btnshowrewardOnClick(arg_6_0)
	DungeonController.instance:openDungeonRewardView(arg_6_0._config)
end

function var_0_0._btnhardmodeOnClick(arg_7_0)
	arg_7_0:_showHardMode(true, true)
end

function var_0_0._btnhardmodetipOnClick(arg_8_0)
	if arg_8_0._config == arg_8_0._hardEpisode then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		local var_8_0 = lua_open.configDict[OpenEnum.UnlockFunc.HardDungeon].episodeId
		local var_8_1 = DungeonConfig.instance:getEpisodeDisplay(var_8_0)

		GameFacade.showToast(ToastEnum.DungeonMapLevel, var_8_1)

		return
	end

	local var_8_2 = DungeonConfig.instance:getHardEpisode(arg_8_0._episodeId)

	if var_8_2 and DungeonModel.instance:episodeIsInLockTime(var_8_2.id) then
		GameFacade.showToastString(arg_8_0._txtLockTime.text)

		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(arg_8_0._config.id) or arg_8_0._episodeInfo.star < DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.PassLevelAndStory)

		return
	end
end

function var_0_0._btnnormalmodeOnClick(arg_9_0)
	arg_9_0:_showHardMode(false, true)
end

function var_0_0._showHardMode(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 then
		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
			GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.HardDungeon))

			return
		end

		arg_10_0._config = arg_10_0._hardEpisode
	else
		if not arg_10_0._hardEpisode then
			return
		end

		arg_10_0._config = DungeonConfig.instance:getEpisodeCO(arg_10_0._hardEpisode.preEpisode)
	end

	arg_10_0._episodeItemParam.index = arg_10_0._levelIndex
	arg_10_0._episodeItemParam.isHardMode = arg_10_1

	DungeonController.instance:dispatchEvent(DungeonEvent.SwitchHardMode, arg_10_0._episodeItemParam)
	arg_10_0:_updateEpisodeInfo()
	arg_10_0:onUpdate(arg_10_1, arg_10_2)

	if arg_10_2 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_switch)
	end
end

function var_0_0._updateEpisodeInfo(arg_11_0)
	arg_11_0._episodeInfo = DungeonModel.instance:getEpisodeInfo(arg_11_0._config.id)
	arg_11_0._curSpeed = 1
end

function var_0_0._btnlockOnClick(arg_12_0)
	local var_12_0 = DungeonModel.instance:getCantChallengeToast(arg_12_0._config)

	if var_12_0 then
		GameFacade.showToast(ToastEnum.CantChallengeToast, var_12_0)
	end
end

function var_0_0._btnstoryOnClick(arg_13_0)
	local var_13_0 = DungeonModel.instance:hasPassLevelAndStory(arg_13_0._config.id)
	local var_13_1 = {}

	var_13_1.mark = true
	var_13_1.episodeId = arg_13_0._config.id

	StoryController.instance:playStory(arg_13_0._config.afterStory, var_13_1, function()
		arg_13_0:onStoryStatus()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)

		DungeonMapModel.instance.playAfterStory = true

		local var_14_0 = DungeonModel.instance:hasPassLevelAndStory(arg_13_0._config.id)

		if var_14_0 and var_14_0 ~= var_13_0 then
			DungeonController.instance:showUnlockContentToast(arg_13_0._config.id)
		end

		ViewMgr.instance:closeView(arg_13_0.viewName)
	end, arg_13_0)
end

function var_0_0._showStoryPlayBackBtn(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_1 > 0 and StoryModel.instance:isStoryFinished(arg_15_1)

	gohelper.setActive(arg_15_2, var_15_0)

	if var_15_0 then
		DungeonLevelItem.showEpisodeName(arg_15_0._config, arg_15_0._chapterIndex, arg_15_0._levelIndex, arg_15_3)
	end
end

function var_0_0._showMiddleStoryPlayBackBtn(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = StoryConfig.instance:getEpisodeFightStory(arg_16_0._config)
	local var_16_1 = #var_16_0 > 0

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if not StoryModel.instance:isStoryFinished(iter_16_1) then
			var_16_1 = false

			break
		end
	end

	gohelper.setActive(arg_16_1, var_16_1)

	if var_16_1 then
		DungeonLevelItem.showEpisodeName(arg_16_0._config, arg_16_0._chapterIndex, arg_16_0._levelIndex, arg_16_2)
	end
end

function var_0_0._btnshowticketsOnClick(arg_17_0)
	return
end

function var_0_0._playMainStory(arg_18_0)
	DungeonRpc.instance:sendStartDungeonRequest(arg_18_0._config.chapterId, arg_18_0._config.id)

	local var_18_0 = {}

	var_18_0.mark = true
	var_18_0.episodeId = arg_18_0._config.id

	StoryController.instance:playStory(arg_18_0._config.beforeStory, var_18_0, arg_18_0.onStoryFinished, arg_18_0)
end

function var_0_0.onStoryFinished(arg_19_0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(arg_19_0._config.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	ViewMgr.instance:closeView(arg_19_0.viewName)
end

function var_0_0._btnequipOnClick(arg_20_0)
	arg_20_0:_enterFight()
end

function var_0_0._btnstartOnClick(arg_21_0)
	if arg_21_0._config.type == DungeonEnum.EpisodeType.Story then
		arg_21_0:_playMainStory()

		return
	end

	local var_21_0, var_21_1, var_21_2 = DungeonModel.instance:getEpisodeChallengeCount(arg_21_0._episodeId)

	if var_21_0 > 0 and var_21_1 > 0 and var_21_1 <= var_21_2 then
		local var_21_3 = ""

		if var_21_0 == DungeonEnum.ChallengeCountLimitType.Daily then
			var_21_3 = luaLang("time_day2")
		elseif var_21_0 == DungeonEnum.ChallengeCountLimitType.Weekly then
			var_21_3 = luaLang("time_week")
		else
			var_21_3 = luaLang("time_month")
		end

		GameFacade.showToast(ToastEnum.DungeonMapLevel3, var_21_3)

		return
	end

	if not arg_21_0._hardMode and var_21_0 > 0 and var_21_1 > 0 and var_21_1 < var_21_2 then
		GameFacade.showToast(ToastEnum.DungeonMapLevel4)

		return
	end

	if DungeonConfig.instance:getChapterCO(arg_21_0._config.chapterId).type == DungeonEnum.ChapterType.RoleStory then
		arg_21_0:_startRoleStory()

		return
	end

	if arg_21_0._config.beforeStory > 0 then
		if arg_21_0._config.afterStory > 0 then
			if not StoryModel.instance:isStoryFinished(arg_21_0._config.afterStory) then
				arg_21_0:_playStoryAndEnterFight(arg_21_0._config.beforeStory)

				return
			end
		elseif arg_21_0._episodeInfo.star <= DungeonEnum.StarType.None then
			arg_21_0:_playStoryAndEnterFight(arg_21_0._config.beforeStory)

			return
		end
	end

	arg_21_0:_enterFight()
end

function var_0_0._startRoleStory(arg_22_0)
	if arg_22_0._config.beforeStory > 0 then
		arg_22_0:_playStoryAndEnterFight(arg_22_0._config.beforeStory, true)

		return
	end

	arg_22_0:_enterFight()
end

function var_0_0._playStoryAndEnterFight(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_2 and StoryModel.instance:isStoryFinished(arg_23_1) then
		arg_23_0:_enterFight()

		return
	end

	local var_23_0 = {}

	var_23_0.mark = true
	var_23_0.episodeId = arg_23_0._config.id

	StoryController.instance:playStory(arg_23_1, var_23_0, arg_23_0._enterFight, arg_23_0)
end

function var_0_0._enterFight(arg_24_0)
	if arg_24_0._enterConfig then
		DungeonModel.instance:setLastSelectMode(arg_24_0._hardMode, arg_24_0._enterConfig.id)
	end

	local var_24_0 = DungeonConfig.instance:getEpisodeCO(arg_24_0._episodeId)

	if arg_24_0._hardMode then
		DungeonFightController.instance:enterFight(var_24_0.chapterId, arg_24_0._episodeId, arg_24_0._curSpeed)
	else
		DungeonFightController.instance:enterFight(var_24_0.chapterId, arg_24_0._episodeId, arg_24_0._curSpeed)
	end
end

function var_0_0._editableInitView(arg_25_0)
	arg_25_0._hardMode = false

	local var_25_0 = gohelper.findChild(arg_25_0.viewGO, "anim")

	arg_25_0._animator = var_25_0 and var_25_0:GetComponent(typeof(UnityEngine.Animator))
	arg_25_0._simageList = arg_25_0:getUserDataTb_()

	arg_25_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_25_0._onCurrencyChange, arg_25_0)
	arg_25_0._simagenormalbg:LoadImage(ResUrl.getDungeonIcon("fubenxinxi_di_putong"))
	arg_25_0._simagehardbg:LoadImage(ResUrl.getDungeonIcon("fubenxinxi_di_kunnan"))

	arg_25_0._rulesimageList = arg_25_0:getUserDataTb_()
	arg_25_0._rulesimagelineList = arg_25_0:getUserDataTb_()

	gohelper.setActive(arg_25_0._gorewarditem, false)

	arg_25_0._rewarditems = arg_25_0:getUserDataTb_()
	arg_25_0._enemyitems = arg_25_0:getUserDataTb_()
	arg_25_0._episodeItemParam = arg_25_0:getUserDataTb_()

	gohelper.removeUIClickAudio(arg_25_0._btncloseview.gameObject)
	gohelper.removeUIClickAudio(arg_25_0._btnnormalmode.gameObject)
	gohelper.removeUIClickAudio(arg_25_0._btnhardmode.gameObject)
	gohelper.addUIClickAudio(arg_25_0._btnstart.gameObject, AudioEnum.HeroGroupUI.Play_UI_Action_Mainstart)
	gohelper.addUIClickAudio(arg_25_0._btnreward.gameObject, AudioEnum.UI.Play_UI_General_OK)
	arg_25_0:_initStar()
end

function var_0_0._initStar(arg_26_0)
	gohelper.setActive(arg_26_0._gostar, true)

	arg_26_0._starImgList = arg_26_0:getUserDataTb_()

	local var_26_0 = arg_26_0._gostar.transform
	local var_26_1 = var_26_0.childCount

	for iter_26_0 = 1, var_26_1 do
		local var_26_2 = var_26_0:GetChild(iter_26_0 - 1):GetComponent(gohelper.Type_Image)

		table.insert(arg_26_0._starImgList, var_26_2)
	end
end

function var_0_0.showStatus(arg_27_0)
	local var_27_0 = arg_27_0._config.id
	local var_27_1 = DungeonModel.instance:isOpenHardDungeon(arg_27_0._config.chapterId)
	local var_27_2 = var_27_0 and DungeonModel.instance:hasPassLevelAndStory(var_27_0)
	local var_27_3 = DungeonConfig.instance:getEpisodeAdvancedConditionText(var_27_0)
	local var_27_4 = arg_27_0._episodeInfo
	local var_27_5 = DungeonConfig.instance:getHardEpisode(arg_27_0._config.id)
	local var_27_6 = var_27_5 and DungeonModel.instance:getEpisodeInfo(var_27_5.id)
	local var_27_7 = arg_27_0._starImgList[4]
	local var_27_8 = arg_27_0._starImgList[3]
	local var_27_9 = arg_27_0._starImgList[2]

	arg_27_0:_setStar(arg_27_0._starImgList[1], var_27_4.star >= DungeonEnum.StarType.Normal and var_27_2, 1)

	if not string.nilorempty(var_27_3) then
		arg_27_0:_setStar(var_27_9, var_27_4.star >= DungeonEnum.StarType.Advanced and var_27_2, 2)

		if var_27_5 then
			local var_27_10 = DungeonModel.instance:episodeIsInLockTime(var_27_5.id)

			gohelper.setActive(var_27_8, not var_27_10)
			gohelper.setActive(var_27_7, not var_27_10)
		end

		if var_27_6 and var_27_4.star >= DungeonEnum.StarType.Advanced and var_27_1 and var_27_2 then
			arg_27_0:_setStar(var_27_8, var_27_6.star >= DungeonEnum.StarType.Normal, 3)
			arg_27_0:_setStar(var_27_7, var_27_6.star >= DungeonEnum.StarType.Advanced, 4)
		end
	end
end

function var_0_0._setStar(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = "#9B9B9B"

	if arg_28_2 then
		var_28_0 = arg_28_3 > 2 and "#FF4343" or "#F97142"
		arg_28_1.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_28_1, var_28_0)
end

function var_0_0._onCurrencyChange(arg_29_0, arg_29_1)
	if not arg_29_1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	arg_29_0:refreshCostPower()
end

function var_0_0.onUpdateParam(arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0.closeThis, arg_30_0)
	arg_30_0:_initInfo()
	arg_30_0.viewContainer:refreshHelp()
	arg_30_0:showStatus()
	arg_30_0:_doUpdate()
end

function var_0_0._addRuleItem(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = gohelper.clone(arg_31_0._goruletemp, arg_31_0._gorulelist, arg_31_1.id)

	gohelper.setActive(var_31_0, true)

	local var_31_1 = gohelper.findChildImage(var_31_0, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(var_31_1, "wz_" .. arg_31_2)

	local var_31_2 = gohelper.findChildImage(var_31_0, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_31_2, arg_31_1.icon)
end

function var_0_0._setRuleDescItem(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local var_32_1 = gohelper.clone(arg_32_0._goruleitem, arg_32_0._goruleDescList, arg_32_1.id)

	gohelper.setActive(var_32_1, true)

	local var_32_2 = gohelper.findChildImage(var_32_1, "icon")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_32_2, arg_32_1.icon)

	local var_32_3 = gohelper.findChild(var_32_1, "line")

	table.insert(arg_32_0._rulesimagelineList, var_32_3)

	local var_32_4 = gohelper.findChildImage(var_32_1, "tag")

	UISpriteSetMgr.instance:setCommonSprite(var_32_4, "wz_" .. arg_32_2)

	local var_32_5 = gohelper.findChildText(var_32_1, "desc")
	local var_32_6 = luaLang("dungeon_add_rule_target_" .. arg_32_2)

	var_32_5.text = SkillConfig.instance:fmtTagDescColor(var_32_6, arg_32_1.desc, var_32_0[arg_32_2])
end

function var_0_0.onOpen(arg_33_0)
	arg_33_0:_initInfo()
	arg_33_0:showStatus()
	arg_33_0:_doUpdate()
	arg_33_0:addEventCb(DungeonController.instance, DungeonEvent.OnUnlockNewChapter, arg_33_0._OnUnlockNewChapter, arg_33_0)
	arg_33_0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_33_0.viewContainer.refreshHelp, arg_33_0.viewContainer)
	arg_33_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_33_0._onUpdateDungeonInfo, arg_33_0)
	NavigateMgr.instance:addEscape(ViewName.DungeonMapLevelView, arg_33_0._btncloseOnClick, arg_33_0)
end

function var_0_0._onUpdateDungeonInfo(arg_34_0)
	local var_34_0 = DungeonConfig.instance:getChapterCO(arg_34_0._config.chapterId)

	arg_34_0:showFree(var_34_0)
end

function var_0_0._OnUnlockNewChapter(arg_35_0)
	ViewMgr.instance:closeView(ViewName.DungeonMapLevelView_bake)
end

function var_0_0._doUpdate(arg_36_0)
	local var_36_0 = arg_36_0.viewParam[5]

	if var_36_0 == nil then
		local var_36_1, var_36_2 = DungeonModel.instance:getLastSelectMode()

		if arg_36_0._enterConfig and var_36_2 == arg_36_0._enterConfig.id then
			var_36_0 = DungeonModel.instance:getLastSelectMode()
		end
	end

	DungeonModel.instance:setLastSelectMode(nil, nil)

	if var_36_0 and arg_36_0._episodeInfo.star == DungeonEnum.StarType.Advanced then
		arg_36_0._hardEpisode = DungeonConfig.instance:getHardEpisode(arg_36_0._config.id)

		if arg_36_0._hardEpisode then
			arg_36_0:_showHardMode(true)
			arg_36_0._animator:Play("dungeonlevel_in_hard", 0, 0)

			return
		end
	end

	arg_36_0:onUpdate()
	arg_36_0._animator:Play("dungeonlevel_in_nomal", 0, 0)
end

function var_0_0._initInfo(arg_37_0)
	arg_37_0._hardEpisode = nil
	arg_37_0._enterConfig = arg_37_0.viewParam[1]
	arg_37_0._config = arg_37_0.viewParam[1]
	arg_37_0._chapterIndex = arg_37_0.viewParam[3]
	arg_37_0._levelIndex = DungeonConfig.instance:getChapterEpisodeIndexWithSP(arg_37_0._config.chapterId, arg_37_0._config.id)

	arg_37_0:_updateEpisodeInfo()

	if arg_37_0.viewParam[6] then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnJumpChangeFocusEpisodeItem, arg_37_0._config.id)
	end
end

var_0_0.BtnOutScreenTime = 0.3

function var_0_0.onUpdate(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = DungeonConfig.instance:getChapterCO(arg_38_0._config.chapterId)
	local var_38_1 = var_38_0.type == DungeonEnum.ChapterType.Hard

	if arg_38_0._hardMode ~= var_38_1 and arg_38_0._animator then
		local var_38_2 = var_38_1 and "hard" or "normal"

		arg_38_0._animator:Play(var_38_2, 0, 0)
		arg_38_0._animator:Update(0)
	end

	arg_38_0._hardMode = var_38_1

	arg_38_0._gonormal2:SetActive(false)

	if arg_38_2 then
		TaskDispatcher.cancelTask(arg_38_0._delayToSwitchStartBtn, arg_38_0)
		TaskDispatcher.runDelay(arg_38_0._delayToSwitchStartBtn, arg_38_0, var_0_0.BtnOutScreenTime)
	else
		arg_38_0:_delayToSwitchStartBtn()
	end

	gohelper.setActive(arg_38_0._simagenormalbg.gameObject, not arg_38_0._hardMode)
	gohelper.setActive(arg_38_0._simagehardbg.gameObject, arg_38_0._hardMode)
	gohelper.setActive(arg_38_0._gohardmodedecorate, arg_38_0._hardMode)
	gohelper.setActive(arg_38_0._goselecthardbg, arg_38_0._hardMode)
	gohelper.setActive(arg_38_0._gounselecthardbg, not arg_38_0._hardMode)
	gohelper.setActive(arg_38_0._goselectnormalbg, not arg_38_0._hardMode)
	gohelper.setActive(arg_38_0._gounselectnormalbg, arg_38_0._hardMode)
	gohelper.setActive(arg_38_0._gonormalrewardbg, not arg_38_0._hardMode)
	gohelper.setActive(arg_38_0._gohardrewardbg, arg_38_0._hardMode)

	arg_38_0._episodeId = arg_38_0._config.id

	local var_38_3 = CurrencyModel.instance:getPower()
	local var_38_4 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local var_38_5 = ResUrl.getCurrencyItemIcon(var_38_4.icon .. "_btn")

	arg_38_0._simagepower2:LoadImage(var_38_5)
	arg_38_0._simagepower3:LoadImage(var_38_5)
	gohelper.setActive(arg_38_0._goboss, arg_38_0:_isBossTypeEpisode())
	gohelper.setActive(arg_38_0._gonormaleye, not arg_38_0._hardMode)
	gohelper.setActive(arg_38_0._gohardeye, arg_38_0._hardMode)

	if arg_38_0._config.battleId ~= 0 then
		gohelper.setActive(arg_38_0._gorecommond.gameObject, true)

		local var_38_6 = FightHelper.getEpisodeRecommendLevel(arg_38_0._episodeId)

		if var_38_6 ~= 0 then
			gohelper.setActive(arg_38_0._gorecommond.gameObject, true)

			arg_38_0._txtrecommondlv.text = HeroConfig.instance:getLevelDisplayVariant(var_38_6)
		else
			gohelper.setActive(arg_38_0._gorecommond.gameObject, false)
		end
	else
		gohelper.setActive(arg_38_0._gorecommond.gameObject, false)
	end

	arg_38_0:setTitle()
	arg_38_0:showFree(var_38_0)

	arg_38_0._txttitle3.text = string.format("%02d", arg_38_0._levelIndex)
	arg_38_0._txtchapterindex.text = var_38_0.chapterIndex
	arg_38_0._txtdesc.text = arg_38_0._config.desc or ""

	if arg_38_2 then
		TaskDispatcher.cancelTask(arg_38_0.refreshCostPower, arg_38_0)
		TaskDispatcher.runDelay(arg_38_0.refreshCostPower, arg_38_0, var_0_0.BtnOutScreenTime)
	else
		arg_38_0:refreshCostPower()
	end

	arg_38_0:refreshChallengeLimit()
	arg_38_0:refreshTurnBackAdditionTips()
	arg_38_0:showReward()
	arg_38_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_38_0.refreshChallengeLimit, arg_38_0)
	arg_38_0:onStoryStatus()
end

function var_0_0._isBossTypeEpisode(arg_39_0)
	if arg_39_0._hardMode then
		if arg_39_0._config.preEpisode then
			local var_39_0 = arg_39_0._config.preEpisode

			return DungeonConfig.instance:getEpisodeCO(var_39_0).displayMark == 1
		end

		return arg_39_0._config.displayMark == 1
	else
		return arg_39_0._config.displayMark == 1
	end
end

function var_0_0._delayToSwitchStartBtn(arg_40_0)
	gohelper.setActive(arg_40_0._gostartnormal, not arg_40_0._hardMode)
	gohelper.setActive(arg_40_0._gostarthard, arg_40_0._hardMode)
end

function var_0_0.showFree(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_1.enterAfterFreeLimit > 0

	gohelper.setActive(arg_41_0._gorighttop, not var_41_0)

	arg_41_0._enterAfterFreeLimit = var_41_0

	if not var_41_0 then
		return
	end

	local var_41_1 = DungeonModel.instance:getChapterRemainingNum(arg_41_1.type)

	if var_41_1 <= 0 then
		var_41_0 = false
	end

	gohelper.setActive(arg_41_0._goequipmap, var_41_0)
	gohelper.setActive(arg_41_0._gooperation, not var_41_0)
	gohelper.setActive(arg_41_0._gorighttop, not var_41_0)

	arg_41_0._enterAfterFreeLimit = var_41_0

	if not var_41_0 then
		return
	end

	arg_41_0._txtfightcount.text = var_41_1 == 0 and string.format("<color=#b3afac>%s</color>", var_41_1) or var_41_1

	gohelper.setActive(arg_41_0._gofightcountbg, var_41_1 ~= 0)
	arg_41_0:_refreshFreeCost()
end

function var_0_0._refreshFreeCost(arg_42_0)
	arg_42_0._txtcostcount.text = -1 * arg_42_0._curSpeed
end

function var_0_0.showViewStory(arg_43_0)
	local var_43_0 = StoryConfig.instance:getEpisodeStoryIds(arg_43_0._config)
	local var_43_1 = false

	for iter_43_0, iter_43_1 in ipairs(var_43_0) do
		if StoryModel.instance:isStoryFinished(iter_43_1) then
			var_43_1 = true

			break
		end
	end

	if not var_43_1 then
		return
	end
end

function var_0_0.refreshChallengeLimit(arg_44_0)
	local var_44_0, var_44_1, var_44_2 = DungeonModel.instance:getEpisodeChallengeCount(arg_44_0._episodeId)

	if var_44_0 > 0 and var_44_1 > 0 then
		local var_44_3 = ""

		if var_44_0 == DungeonEnum.ChallengeCountLimitType.Daily then
			var_44_3 = luaLang("daily")
		elseif var_44_0 == DungeonEnum.ChallengeCountLimitType.Weekly then
			var_44_3 = luaLang("weekly")
		else
			var_44_3 = luaLang("monthly")
		end

		arg_44_0._txtchallengecountlimit.text = string.format("%s%s (%d/%d)", var_44_3, luaLang("times"), math.max(0, var_44_1 - arg_44_0._episodeInfo.challengeCount), var_44_1)
	else
		arg_44_0._txtchallengecountlimit.text = ""
	end

	arg_44_0._isCanChallenge, arg_44_0._challengeLockCode = DungeonModel.instance:isCanChallenge(arg_44_0._config)

	gohelper.setActive(arg_44_0._gostart, arg_44_0._isCanChallenge)
	gohelper.setActive(arg_44_0._golock, not arg_44_0._isCanChallenge)
end

function var_0_0.refreshTurnBackAdditionTips(arg_45_0)
	local var_45_0 = TurnbackModel.instance:isShowTurnBackAddition(arg_45_0._config.chapterId)

	if var_45_0 then
		local var_45_1, var_45_2 = TurnbackModel.instance:getAdditionCountInfo()
		local var_45_3 = string.format("%s/%s", var_45_1, var_45_2)

		arg_45_0._txtTurnBackAdditionTips.text = formatLuaLang("turnback_addition_times", var_45_3)
	end

	gohelper.setActive(arg_45_0._goTurnBackAddition, var_45_0)
end

function var_0_0.onStoryStatus(arg_46_0)
	local var_46_0 = false
	local var_46_1 = DungeonConfig.instance:getChapterCO(arg_46_0._config.chapterId)

	if arg_46_0._config.afterStory > 0 and not StoryModel.instance:isStoryFinished(arg_46_0._config.afterStory) and arg_46_0._episodeInfo.star > DungeonEnum.StarType.None then
		var_46_0 = true
	end

	arg_46_0._gooperation:SetActive(not var_46_0 and not arg_46_0._enterAfterFreeLimit)
	arg_46_0._btnstory.gameObject:SetActive(var_46_0)

	if var_46_0 then
		arg_46_0:refreshHardMode()
		arg_46_0._btnhardmode.gameObject:SetActive(false)
	elseif not arg_46_0._hardMode then
		arg_46_0:refreshHardMode()
	else
		arg_46_0._btnHardModeActive = false

		TaskDispatcher.cancelTask(arg_46_0._delaySetActive, arg_46_0)
		TaskDispatcher.runDelay(arg_46_0._delaySetActive, arg_46_0, 0.2)
	end

	arg_46_0:showViewStory()

	local var_46_2, var_46_3, var_46_4 = DungeonModel.instance:getChapterListTypes()
	local var_46_5 = DungeonModel.instance:chapterListIsRoleStory()
	local var_46_6 = (not var_46_2 or arg_46_0._config.type ~= DungeonEnum.EpisodeType.Story) and not var_46_3 and not var_46_4 and not var_46_5

	gohelper.setActive(arg_46_0._gonormal, var_46_6)
	gohelper.setActive(arg_46_0._gohard, var_46_6)
	gohelper.setActive(arg_46_0._gostar, var_46_6)
	recthelper.setAnchorY(arg_46_0._txtdesc.transform, var_46_6 and 56.6 or 129.1)
	recthelper.setAnchorY(arg_46_0._gorecommond.transform, var_46_6 and 87.3 or 168.4)
	TaskDispatcher.cancelTask(arg_46_0._checkLockTime, arg_46_0)
	TaskDispatcher.runRepeat(arg_46_0._checkLockTime, arg_46_0, 1)
end

function var_0_0._checkLockTime(arg_47_0)
	local var_47_0 = DungeonConfig.instance:getHardEpisode(arg_47_0._episodeId)
	local var_47_1 = arg_47_0.isInLockTime and true or false

	if var_47_0 and DungeonModel.instance:episodeIsInLockTime(var_47_0.id) then
		arg_47_0.isInLockTime = true
	else
		arg_47_0.isInLockTime = false
	end

	if var_47_1 ~= arg_47_0.isInLockTime then
		arg_47_0:showStatus()
		arg_47_0:onStoryStatus()
	elseif arg_47_0.isInLockTime then
		local var_47_2 = ServerTime.now()
		local var_47_3 = string.splitToNumber(var_47_0.lockTime, "#")

		arg_47_0._txtLockTime.text = formatLuaLang("seasonmainview_timeopencondition", string.format("%s%s", TimeUtil.secondToRoughTime2(var_47_3[2] / 1000 - ServerTime.now())))
	end
end

function var_0_0.refreshHardMode(arg_48_0)
	if arg_48_0._hardMode then
		return
	end

	arg_48_0._hardEpisode = DungeonConfig.instance:getHardEpisode(arg_48_0._episodeId)

	local var_48_0 = false

	if arg_48_0._episodeInfo.star == DungeonEnum.StarType.Advanced then
		local var_48_1 = DungeonModel.instance:isOpenHardDungeon(arg_48_0._config.chapterId)

		var_48_0 = arg_48_0._hardEpisode ~= nil and var_48_1
	end

	if arg_48_0._hardEpisode and DungeonModel.instance:episodeIsInLockTime(arg_48_0._hardEpisode.id) then
		var_48_0 = false

		gohelper.setActive(arg_48_0._txtLockTime, true)

		local var_48_2 = ServerTime.now()
		local var_48_3 = string.splitToNumber(arg_48_0._hardEpisode.lockTime, "#")

		arg_48_0._txtLockTime.text = formatLuaLang("seasonmainview_timeopencondition", string.format("%s%s", TimeUtil.secondToRoughTime2(var_48_3[2] / 1000 - ServerTime.now())))
		arg_48_0._golockbg:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	else
		gohelper.setActive(arg_48_0._txtLockTime, false)

		arg_48_0._golockbg:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0.1
	end

	arg_48_0._btnhardmode.gameObject:SetActive(var_48_0)
	gohelper.setActive(arg_48_0._golockbg, not var_48_0)

	arg_48_0._gohard:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = var_48_0 and 1 or 0.3
	arg_48_0._btnHardModeActive = var_48_0
end

function var_0_0._delaySetActive(arg_49_0)
	arg_49_0._btnhardmode.gameObject:SetActive(arg_49_0._btnHardModeActive)
end

function var_0_0.refreshCostPower(arg_50_0)
	local var_50_0 = string.split(arg_50_0._config.cost, "|")
	local var_50_1 = string.split(var_50_0[1], "#")
	local var_50_2 = tonumber(var_50_1[3] or 0) * arg_50_0._curSpeed

	arg_50_0._txtusepower.text = "-" .. var_50_2
	arg_50_0._txtusepowerhard.text = "-" .. var_50_2

	if var_50_2 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(arg_50_0._txtusepower, "#070706")
		SLFramework.UGUI.GuiHelper.SetColor(arg_50_0._txtusepowerhard, "#FFEAEA")
		gohelper.setActive(arg_50_0._gonormallackpower, false)
		gohelper.setActive(arg_50_0._gohardlackpower, false)
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_50_0._txtusepower, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(arg_50_0._txtusepowerhard, "#C44945")
		gohelper.setActive(arg_50_0._gonormallackpower, not arg_50_0._hardMode)
		gohelper.setActive(arg_50_0._gohardlackpower, arg_50_0._hardMode)
	end
end

function var_0_0.showReward(arg_51_0)
	local var_51_0 = arg_51_0._episodeInfo
	local var_51_1 = {}
	local var_51_2 = 0
	local var_51_3 = 0

	arg_51_0.listenerActDict = nil

	if var_51_0.star == DungeonEnum.StarType.None then
		local var_51_4, var_51_5 = Activity135Model.instance:getActivityShowReward(arg_51_0._episodeId)

		arg_51_0.listenerActDict = var_51_5

		if var_51_4 and #var_51_4 > 0 then
			tabletool.addValues(var_51_1, var_51_4)
		end
	end

	if var_51_0.star ~= DungeonEnum.StarType.Advanced then
		tabletool.addValues(var_51_1, DungeonModel.instance:getEpisodeAdvancedBonus(arg_51_0._episodeId))

		var_51_3 = #var_51_1
	end

	if var_51_0.star == DungeonEnum.StarType.None then
		tabletool.addValues(var_51_1, DungeonModel.instance:getEpisodeFirstBonus(arg_51_0._episodeId))

		var_51_2 = #var_51_1
	end

	local var_51_6 = #var_51_1
	local var_51_7
	local var_51_8 = DungeonConfig.instance:getChapterCO(arg_51_0._config.chapterId)

	if var_51_8.enterAfterFreeLimit > 0 and DungeonModel.instance:getChapterRemainingNum(var_51_8.type) > 0 then
		tabletool.addValues(var_51_1, DungeonModel.instance:getEpisodeFreeDisplayList(arg_51_0._episodeId))

		var_51_7 = true
	end

	arg_51_0._txtget.text = luaLang(var_51_7 and "p_dungeonmaplevelview_specialdrop" or "p_dungeonmaplevelview_get")

	local var_51_9 = {}
	local var_51_10 = var_51_8.type == DungeonEnum.ChapterType.Gold or var_51_8.type == DungeonEnum.ChapterType.Exp

	if var_51_10 then
		var_51_9 = DungeonModel.instance:getEpisodeBonus(arg_51_0._episodeId)

		tabletool.addValues(var_51_1, var_51_9)
	else
		var_51_9 = DungeonModel.instance:getEpisodeRewardDisplayList(arg_51_0._episodeId)

		tabletool.addValues(var_51_1, var_51_9)
	end

	if TurnbackModel.instance:isShowTurnBackAddition(arg_51_0._config.chapterId) then
		local var_51_11 = TurnbackModel.instance:getAdditionRewardList(var_51_9)

		tabletool.addValues(var_51_1, var_51_11)
	end

	gohelper.setActive(arg_51_0._gonoreward, #var_51_1 == 0)

	local var_51_12 = math.min(#var_51_1, 3)

	for iter_51_0 = 1, var_51_12 do
		local var_51_13 = arg_51_0._rewarditems[iter_51_0]
		local var_51_14 = var_51_1[iter_51_0]

		if not var_51_13 then
			var_51_13 = arg_51_0:getUserDataTb_()
			var_51_13.go = gohelper.clone(arg_51_0._gorewarditem, arg_51_0._gorewardList, "item" .. iter_51_0)
			var_51_13.txtcount = gohelper.findChildText(var_51_13.go, "countbg/count")
			var_51_13.gofirst = gohelper.findChild(var_51_13.go, "rare/#go_rare2")
			var_51_13.goadvance = gohelper.findChild(var_51_13.go, "rare/#go_rare3")
			var_51_13.gofirsthard = gohelper.findChild(var_51_13.go, "rare/#go_rare4")
			var_51_13.gonormal = gohelper.findChild(var_51_13.go, "rare/#go_rare1")
			var_51_13.txtnormal = gohelper.findChildText(var_51_13.go, "rare/#go_rare1/txt")
			var_51_13.goAddition = gohelper.findChild(var_51_13.go, "turnback")
			var_51_13.gocount = gohelper.findChild(var_51_13.go, "countbg")
			var_51_13.itemIconGO = gohelper.findChild(var_51_13.go, "itemicon")
			var_51_13.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_51_13.itemIconGO)

			var_51_13.itemIcon:isShowAddition(false)

			var_51_13.golimitfirst = gohelper.findChild(var_51_13.go, "limitfirst")
			var_51_13.txtlimittime = gohelper.findChildText(var_51_13.go, "limitfirst/#txt_time")

			function var_51_13.refreshLimitTime(arg_52_0)
				if arg_52_0.rewardData.isLimitFirstReward then
					local var_52_0 = ActivityModel.instance:getActMO(arg_52_0.rewardData.activityId)

					if var_52_0 then
						local var_52_1 = var_52_0:getRealEndTimeStamp() - ServerTime.now()

						arg_52_0.txtlimittime.text = formatLuaLang("remain", string.format("%s%s", TimeUtil.secondToRoughTime(var_52_1)))
					end
				else
					TaskDispatcher.cancelTask(arg_52_0.refreshLimitTime, arg_52_0)
				end
			end

			table.insert(arg_51_0._rewarditems, var_51_13)
		end

		var_51_13.rewardData = var_51_14

		var_51_13.itemIcon:setMOValue(var_51_14[1], var_51_14[2], var_51_14[3], nil, true)
		gohelper.setActive(var_51_13.gofirst, false)
		gohelper.setActive(var_51_13.goadvance, false)
		gohelper.setActive(var_51_13.gofirsthard, false)
		gohelper.setActive(var_51_13.gonormal, false)
		gohelper.setActive(var_51_13.goAddition, false)
		gohelper.setActive(var_51_13.golimitfirst, false)
		TaskDispatcher.cancelTask(var_51_13.refreshLimitTime, var_51_13)

		if iter_51_0 <= var_51_6 or var_51_10 and not var_51_7 then
			if var_51_14.isLimitFirstReward then
				gohelper.setActive(var_51_13.golimitfirst, true)
			elseif iter_51_0 <= var_51_3 then
				gohelper.setActive(var_51_13.goadvance, true)
			elseif iter_51_0 <= var_51_2 then
				gohelper.setActive(var_51_13.gofirst, not arg_51_0._hardMode)
				gohelper.setActive(var_51_13.gofirsthard, arg_51_0._hardMode)
			end

			gohelper.setActive(var_51_13.gocount, true)

			if var_51_13.itemIcon:isEquipIcon() then
				var_51_13.itemIcon:ShowEquipCount(var_51_13.gocount, var_51_13.txtcount)
			else
				var_51_13.itemIcon:showStackableNum2(var_51_13.gocount, var_51_13.txtcount)
			end

			gohelper.setActive(var_51_13.goAddition, var_51_14.isAddition)
			TaskDispatcher.runRepeat(var_51_13.refreshLimitTime, var_51_13, 1)
			var_51_13:refreshLimitTime()
		else
			if not var_51_14.isAddition then
				local var_51_15 = var_51_14[3]

				gohelper.setActive(var_51_13.gonormal, true)

				var_51_13.txtnormal.text = luaLang("dungeon_prob_flag" .. var_51_15)
			end

			gohelper.setActive(var_51_13.gocount, false)
		end

		gohelper.setActive(var_51_13.goAddition, var_51_14.isAddition)
		var_51_13.itemIcon:isShowEquipAndItemCount(false)
		var_51_13.itemIcon:setHideLvAndBreakFlag(true)
		var_51_13.itemIcon:setShowCountFlag(false)
		var_51_13.itemIcon:hideEquipLvAndBreak(true)
		gohelper.setActive(var_51_13.go, true)
	end

	for iter_51_1 = var_51_12 + 1, #arg_51_0._rewarditems do
		gohelper.setActive(arg_51_0._rewarditems[iter_51_1].go)
	end

	gohelper.setActive(arg_51_0._goreward, var_51_12 > 0)
end

function var_0_0.onClose(arg_53_0)
	TaskDispatcher.cancelTask(arg_53_0.closeThis, arg_53_0)
	AudioMgr.instance:trigger(arg_53_0:getCurrentChapterListTypeAudio().onClose)

	arg_53_0._episodeItemParam.isHardMode = false

	DungeonController.instance:dispatchEvent(DungeonEvent.SwitchHardMode, arg_53_0._episodeItemParam)

	if arg_53_0._rewarditems then
		for iter_53_0, iter_53_1 in ipairs(arg_53_0._rewarditems) do
			TaskDispatcher.cancelTask(iter_53_1.refreshLimitTime, iter_53_1)
		end
	end
end

function var_0_0.onCloseFinish(arg_54_0)
	return
end

function var_0_0.clearRuleList(arg_55_0)
	arg_55_0._simageList = arg_55_0:getUserDataTb_()

	for iter_55_0, iter_55_1 in pairs(arg_55_0._rulesimageList) do
		iter_55_1:UnLoadImage()
	end

	arg_55_0._rulesimageList = arg_55_0:getUserDataTb_()
	arg_55_0._rulesimagelineList = arg_55_0:getUserDataTb_()

	gohelper.destroyAllChildren(arg_55_0._gorulelist)
	gohelper.destroyAllChildren(arg_55_0._goruleDescList)
end

function var_0_0.onDestroyView(arg_56_0)
	arg_56_0._simagepower2:UnLoadImage()
	arg_56_0._simagepower3:UnLoadImage()
	arg_56_0._simagenormalbg:UnLoadImage()
	arg_56_0._simagehardbg:UnLoadImage()

	for iter_56_0, iter_56_1 in pairs(arg_56_0._rulesimageList) do
		iter_56_1:UnLoadImage()
	end

	for iter_56_2 = 1, #arg_56_0._enemyitems do
		arg_56_0._enemyitems[iter_56_2].simagemonsterhead:UnLoadImage()
	end

	TaskDispatcher.cancelTask(arg_56_0._delaySetActive, arg_56_0)
	TaskDispatcher.cancelTask(arg_56_0._delayToSwitchStartBtn, arg_56_0)
	TaskDispatcher.cancelTask(arg_56_0.refreshCostPower, arg_56_0)
	TaskDispatcher.cancelTask(arg_56_0._checkLockTime, arg_56_0)
end

function var_0_0.setTitle(arg_57_0)
	arg_57_0._txttitle4.text = arg_57_0._config.name_En

	local var_57_0 = GameUtil.utf8sub(arg_57_0._config.name, 1, 1)
	local var_57_1 = ""
	local var_57_2

	if GameUtil.utf8len(arg_57_0._config.name) >= 2 then
		var_57_1 = string.format("<size=80>%s</size>", GameUtil.utf8sub(arg_57_0._config.name, 2, GameUtil.utf8len(arg_57_0._config.name) - 1))
	end

	arg_57_0._txttitle1.text = var_57_0 .. var_57_1

	ZProj.UGUIHelper.RebuildLayout(arg_57_0._txttitle1.transform)
	ZProj.UGUIHelper.RebuildLayout(arg_57_0._txttitle4.transform)

	if GameUtil.utf8len(arg_57_0._config.name) > 2 then
		var_57_2 = recthelper.getAnchorX(arg_57_0._txttitle1.transform) + recthelper.getWidth(arg_57_0._txttitle1.transform)
	else
		var_57_2 = recthelper.getAnchorX(arg_57_0._txttitle1.transform) + recthelper.getWidth(arg_57_0._txttitle1.transform) + recthelper.getAnchorX(arg_57_0._txttitle4.transform)
	end

	recthelper.setAnchorX(arg_57_0._txttitle3.transform, var_57_2)
end

function var_0_0.getCurrentChapterListTypeAudio(arg_58_0)
	local var_58_0, var_58_1, var_58_2 = DungeonModel.instance:getChapterListTypes()
	local var_58_3

	if var_58_0 then
		var_58_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Story]
	elseif var_58_1 then
		var_58_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Resource]
	elseif var_58_2 then
		var_58_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Insight]
	else
		var_58_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Story]
	end

	return var_58_3
end

function var_0_0._onRefreshActivityState(arg_59_0, arg_59_1)
	if not arg_59_0.listenerActDict or not arg_59_0.listenerActDict[arg_59_1] then
		return
	end

	arg_59_0:showReward()
end

function var_0_0._onDailyRefresh(arg_60_0)
	arg_60_0:_refreshTurnBack()
end

function var_0_0._refreshTurnBack(arg_61_0)
	arg_61_0:refreshTurnBackAdditionTips()
	arg_61_0:showReward()
end

return var_0_0
