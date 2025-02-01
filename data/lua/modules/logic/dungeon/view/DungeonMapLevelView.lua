module("modules.logic.dungeon.view.DungeonMapLevelView", package.seeall)

slot0 = class("DungeonMapLevelView", BaseView)
slot1 = {
	isJumpOpen = 6
}
slot2 = 10606
slot3 = 20604
slot4 = 190906

function slot0._setTitle_overseas(slot0, slot1, slot2)
	slot3 = LangSettings.instance:isJp()

	recthelper.setHeight(slot0._txttitle1.transform, (slot0._episodeId == uv0 or slot0._episodeId == uv1) and slot3 and 110 or 140)

	if slot3 and slot0._episodeId == uv2 then
		slot0._txttitle1.text = string.format("<size=74>%s</size>%s", slot1, slot2)
	elseif slot4 then
		slot0._txttitle1.text = string.format("<size=60>%s</size>%s", slot1, slot2)
	end
end

function slot0.onInitView(slot0)
	slot0._btncloseview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeview")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "anim/right/#go_normal")
	slot0._btnhardmode = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/right/#go_hard/go/#btn_hardmode")
	slot0._btnhardmodetip = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/right/#go_hard/go/#btn_hardmodetip")
	slot0._gohard = gohelper.findChild(slot0.viewGO, "anim/right/#go_hard")
	slot0._simagenormalbg = gohelper.findChildSingleImage(slot0.viewGO, "anim/bgmask/#simage_normalbg")
	slot0._simagehardbg = gohelper.findChildSingleImage(slot0.viewGO, "anim/bgmask/#simage_hardbg")
	slot0._imagehardstatus = gohelper.findChildImage(slot0.viewGO, "anim/right/#go_hard/#image_hardstatus")
	slot0._btnnormalmode = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/right/#go_normal/#btn_normalmode")
	slot0._txtpower = gohelper.findChildText(slot0.viewGO, "anim/right/power/#txt_power")
	slot0._simagepower1 = gohelper.findChildSingleImage(slot0.viewGO, "anim/right/power/#simage_power1")
	slot0._txtrule = gohelper.findChildText(slot0.viewGO, "anim/right/condition/#go_additionRule/#txt_rule")
	slot0._goruletemp = gohelper.findChild(slot0.viewGO, "anim/right/condition/#go_additionRule/#go_ruletemp")
	slot0._imagetagicon = gohelper.findChildImage(slot0.viewGO, "anim/right/condition/#go_additionRule/#go_ruletemp/#image_tagicon")
	slot0._gorulelist = gohelper.findChild(slot0.viewGO, "anim/right/condition/#go_additionRule/#go_rulelist")
	slot0._godefault = gohelper.findChild(slot0.viewGO, "anim/right/condition/#go_default")
	slot0._scrollreward = gohelper.findChildScrollRect(slot0.viewGO, "anim/right/reward/#scroll_reward")
	slot0._gooperation = gohelper.findChild(slot0.viewGO, "anim/right/#go_operation")
	slot0._gostart = gohelper.findChild(slot0.viewGO, "anim/right/#go_operation/#go_start")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/right/#go_operation/#go_start/#btn_start")
	slot0._btnequip = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/right/#go_equipmap/#btn_equip")
	slot0._txtchallengecountlimit = gohelper.findChildText(slot0.viewGO, "anim/right/#go_operation/#go_start/#txt_challengecountlimit")
	slot0._gonormal2 = gohelper.findChild(slot0.viewGO, "anim/right/#go_operation/#go_normal2")
	slot0._goticket = gohelper.findChild(slot0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket")
	slot0._btnshowtickets = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#btn_showtickets")
	slot0._goticketlist = gohelper.findChild(slot0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketlist")
	slot0._goticketItem = gohelper.findChild(slot0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem")
	slot0._goticketinfo = gohelper.findChild(slot0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_ticketinfo")
	slot0._simageticket = gohelper.findChildSingleImage(slot0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_ticketinfo/#simage_ticket")
	slot0._txtticket = gohelper.findChildText(slot0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_ticketinfo/#txt_ticket")
	slot0._gonoticket = gohelper.findChild(slot0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_noticket")
	slot0._txtnoticket1 = gohelper.findChildText(slot0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_noticket/#txt_noticket1")
	slot0._txtnoticket2 = gohelper.findChildText(slot0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_noticket/#txt_noticket2")
	slot0._golock = gohelper.findChild(slot0.viewGO, "anim/right/#go_operation/#go_lock")
	slot0._goequipmap = gohelper.findChild(slot0.viewGO, "anim/right/#go_equipmap")
	slot0._txtcostcount = gohelper.findChildText(slot0.viewGO, "anim/right/#go_equipmap/#btn_equip/#txt_num")
	slot0._gofightcountbg = gohelper.findChild(slot0.viewGO, "anim/right/#go_equipmap/fightcount/#go_fightcountbg")
	slot0._txtfightcount = gohelper.findChildText(slot0.viewGO, "anim/right/#go_equipmap/fightcount/#txt_fightcount")
	slot0._btnlock = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/right/#go_operation/#go_lock/#btn_lock")
	slot0._btnstory = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/right/#btn_story")
	slot0._btnviewstory = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/right/#btn_viewstory")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "anim/#go_righttop")
	slot0.titleList = {}
	slot1 = slot0:getUserDataTb_()
	slot1._go = gohelper.findChild(slot0.viewGO, "anim/right/title")
	slot1._txttitle1 = gohelper.findChildText(slot0.viewGO, "anim/right/title/#txt_title1")
	slot1._txttitle3 = gohelper.findChildText(slot0.viewGO, "anim/right/title/#txt_title1/#txt_title3")
	slot1._txtchapterindex = gohelper.findChildText(slot0.viewGO, "anim/right/title/#txt_title1/#txt_title3/#txt_chapterindex")
	slot1._txttitle4 = gohelper.findChildText(slot0.viewGO, "anim/right/title/#txt_title1/#txt_title4")
	slot1._gostar = gohelper.findChild(slot0.viewGO, "anim/right/title/#go_star")
	slot0.titleList[1] = slot1
	slot0._scrolldesc = gohelper.findChild(slot0.viewGO, "anim/right/#scrolldesc")
	slot2 = slot0:getUserDataTb_()
	slot2._go = gohelper.findChild(slot0.viewGO, "anim/right/title2")
	slot2._txttitle1 = gohelper.findChildText(slot0.viewGO, "anim/right/title2/#txt_title1")
	slot2._txttitle3 = gohelper.findChildText(slot0.viewGO, "anim/right/title2/#txt_title3")
	slot2._txtchapterindex = gohelper.findChildText(slot0.viewGO, "anim/right/title2/#txt_title3/#txt_chapterindex")
	slot2._txttitle4 = gohelper.findChildText(slot0.viewGO, "anim/right/title2/#txt_title1/#txt_title4")
	slot2._gostar = gohelper.findChild(slot0.viewGO, "anim/right/title2/#go_star")
	slot0.titleList[2] = slot2
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "anim/right/#scrolldesc/viewport/#txt_desc")
	slot0._gorecommond = gohelper.findChild(slot0.viewGO, "anim/right/recommend")
	slot0._txtrecommondlv = gohelper.findChildText(slot0.viewGO, "anim/right/recommend/#txt_recommendlv")
	slot0._simagepower2 = gohelper.findChildSingleImage(slot0.viewGO, "anim/right/#go_operation/#go_start/#go_startnormal/#simage_power2")
	slot0._txtusepower = gohelper.findChildText(slot0.viewGO, "anim/right/#go_operation/#go_start/#go_startnormal/#txt_usepower")
	slot0._simagepower3 = gohelper.findChildSingleImage(slot0.viewGO, "anim/right/#go_operation/#go_start/#go_starthard/#simage_power3")
	slot0._txtusepowerhard = gohelper.findChildText(slot0.viewGO, "anim/right/#go_operation/#go_start/#go_starthard/#txt_usepowerhard")
	slot0._gostartnormal = gohelper.findChild(slot0.viewGO, "anim/right/#go_operation/#go_start/#go_startnormal")
	slot0._gostarthard = gohelper.findChild(slot0.viewGO, "anim/right/#go_operation/#go_start/#go_starthard")
	slot0._gohardmodedecorate = gohelper.findChild(slot0.viewGO, "anim/right/title/#txt_title1/#go_hardmodedecorate")
	slot0._gostoryline = gohelper.findChild(slot0.viewGO, "anim/right/#go_storyline")
	slot0._goselecthardbg = gohelper.findChild(slot0.viewGO, "anim/right/#go_hard/go/#go_selecthardbg")
	slot0._gounselecthardbg = gohelper.findChild(slot0.viewGO, "anim/right/#go_hard/go/#go_unselecthardbg")
	slot0._goselectnormalbg = gohelper.findChild(slot0.viewGO, "anim/right/#go_normal/#go_selectnormalbg")
	slot0._gounselectnormalbg = gohelper.findChild(slot0.viewGO, "anim/right/#go_normal/#go_unselectnormalbg")
	slot0._golockbg = gohelper.findChild(slot0.viewGO, "anim/right/#go_hard/go/#go_lockbg")
	slot0._txtLockTime = gohelper.findChildTextMesh(slot0.viewGO, "anim/right/#go_hard/go/#go_lockbg/#txt_locktime")
	slot0._gonormallackpower = gohelper.findChild(slot0.viewGO, "anim/right/#go_operation/#go_start/#go_startnormal/#go_normallackpower")
	slot0._gohardlackpower = gohelper.findChild(slot0.viewGO, "anim/right/#go_operation/#go_start/#go_starthard/#go_hardlackpower")
	slot0._goboss = gohelper.findChild(slot0.viewGO, "anim/right/#go_boss")
	slot0._gonormaleye = gohelper.findChild(slot0.viewGO, "anim/right/#go_boss/#go_normaleye")
	slot0._gohardeye = gohelper.findChild(slot0.viewGO, "anim/right/#go_boss/#go_hardeye")
	slot0._godoubletimes = gohelper.findChild(slot0.viewGO, "anim/right/#go_doubletimes")
	slot0._txtdoubletimes = gohelper.findChildTextMesh(slot0.viewGO, "anim/right/#go_doubletimes/#txt_doubletimes")
	slot0._goswitch = gohelper.findChild(slot0.viewGO, "anim/right/#go_switch")
	slot0._gostory = gohelper.findChild(slot0.viewGO, "anim/right/#go_switch/#go_story")
	slot0._btnSimpleClick = gohelper.findChildButton(slot0.viewGO, "anim/right/#go_switch/#go_story/clickarea")
	slot0._goselectstorybg = gohelper.findChild(slot0.viewGO, "anim/right/#go_switch/#go_story/#go_selectstorybg")
	slot0._gounselectstorybg = gohelper.findChild(slot0.viewGO, "anim/right/#go_switch/#go_story/#go_unselectstorybg")
	slot0._gonormalN = gohelper.findChild(slot0.viewGO, "anim/right/#go_switch/#go_normal")
	slot0._btnNormalClick = gohelper.findChildButton(slot0.viewGO, "anim/right/#go_switch/#go_normal/clickarea")
	slot0._goselectnormalbgN = gohelper.findChild(slot0.viewGO, "anim/right/#go_switch/#go_normal/#go_selectnormalbg")
	slot0._gounselectnormalbgr = gohelper.findChild(slot0.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_right")
	slot0._gounselectnormalbgl = gohelper.findChild(slot0.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_left")
	slot0._gohardN = gohelper.findChild(slot0.viewGO, "anim/right/#go_switch/#go_hard")
	slot0._btnHardClick = gohelper.findChildButton(slot0.viewGO, "anim/right/#go_switch/#go_hard/clickarea")
	slot0._goselecthardbgN = gohelper.findChild(slot0.viewGO, "anim/right/#go_switch/#go_hard/#go_selecthardbg")
	slot0._gounselecthardbgN = gohelper.findChild(slot0.viewGO, "anim/right/#go_switch/#go_hard/#go_unselecthardbg")
	slot0._golockbgN = gohelper.findChild(slot0.viewGO, "anim/right/#go_switch/#go_hard/#go_lockbg")
	slot0._txtLockTimeN = gohelper.findChildTextMesh(slot0.viewGO, "anim/right/#go_switch/#go_hard/#go_lockbg/#txt_locktime")
	slot0._imgstorystar1s = gohelper.findChildImage(slot0.viewGO, "anim/right/#go_switch/#go_story/#go_selectstorybg/star1")
	slot0._imgstorystar1u = gohelper.findChildImage(slot0.viewGO, "anim/right/#go_switch/#go_story/#go_unselectstorybg/star1")
	slot0._imgnormalstar1s = gohelper.findChildImage(slot0.viewGO, "anim/right/#go_switch/#go_normal/#go_selectnormalbg/star1")
	slot0._imgnormalstar2s = gohelper.findChildImage(slot0.viewGO, "anim/right/#go_switch/#go_normal/#go_selectnormalbg/star2")
	slot0._imgnormalstar1ru = gohelper.findChildImage(slot0.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_right/star1")
	slot0._imgnormalstar2ru = gohelper.findChildImage(slot0.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_right/star2")
	slot0._imgnormalstar1lu = gohelper.findChildImage(slot0.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_left/star1")
	slot0._imgnormalstar2lu = gohelper.findChildImage(slot0.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_left/star2")
	slot0._imghardstar1s = gohelper.findChildImage(slot0.viewGO, "anim/right/#go_switch/#go_hard/#go_selecthardbg/star1")
	slot0._imghardstar2s = gohelper.findChildImage(slot0.viewGO, "anim/right/#go_switch/#go_hard/#go_selecthardbg/star2")
	slot0._imghardstar1u = gohelper.findChildImage(slot0.viewGO, "anim/right/#go_switch/#go_hard/#go_unselecthardbg/star1")
	slot0._imghardstar2u = gohelper.findChildImage(slot0.viewGO, "anim/right/#go_switch/#go_hard/#go_unselecthardbg/star2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncloseview:AddClickListener(slot0._btncloseviewOnClick, slot0)
	slot0._btnhardmode:AddClickListener(slot0._btnhardmodeOnClick, slot0)
	slot0._btnhardmodetip:AddClickListener(slot0._btnhardmodetipOnClick, slot0)
	slot0._btnnormalmode:AddClickListener(slot0._btnnormalmodeOnClick, slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
	slot0._btnequip:AddClickListener(slot0._btnequipOnClick, slot0)
	slot0._btnshowtickets:AddClickListener(slot0._btnshowticketsOnClick, slot0)
	slot0._btnlock:AddClickListener(slot0._btnlockOnClick, slot0)
	slot0._btnstory:AddClickListener(slot0._btnstoryOnClick, slot0)
	slot0._btnSimpleClick:AddClickListener(slot0._btnSimpleOnClick, slot0)
	slot0._btnNormalClick:AddClickListener(slot0._btnNormalOnClick, slot0)
	slot0._btnHardClick:AddClickListener(slot0._btnHardOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncloseview:RemoveClickListener()
	slot0._btnhardmode:RemoveClickListener()
	slot0._btnhardmodetip:RemoveClickListener()
	slot0._btnnormalmode:RemoveClickListener()
	slot0._btnstart:RemoveClickListener()
	slot0._btnequip:RemoveClickListener()
	slot0._btnshowtickets:RemoveClickListener()
	slot0._btnlock:RemoveClickListener()
	slot0._btnstory:RemoveClickListener()
	slot0._btnSimpleClick:RemoveClickListener()
	slot0._btnNormalClick:RemoveClickListener()
	slot0._btnHardClick:RemoveClickListener()
end

slot0.AudioConfig = {
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

function slot0._btncloseviewOnClick(slot0)
	TaskDispatcher.runDelay(slot0.closeThis, slot0, 0)
end

function slot0._btnshowrewardOnClick(slot0)
	DungeonController.instance:openDungeonRewardView(slot0._config)
end

function slot0._btnhardmodeOnClick(slot0)
	if slot0._chapterType == DungeonEnum.ChapterType.Hard then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.HardDungeon))

		return
	end

	if DungeonConfig.instance:getHardEpisode(slot0._enterConfig.id) and DungeonModel.instance:episodeIsInLockTime(slot1.id) then
		GameFacade.showToastString(slot0._txtLockTime.text)

		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(slot0._enterConfig.id) or slot0._episodeInfo.star < DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.PassLevelAndStory)

		return
	end

	slot0._config = slot0._hardEpisode

	slot0:_showEpisodeMode(true, true)
end

function slot0._btnhardmodetipOnClick(slot0)
	if slot0._config == slot0._hardEpisode then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		GameFacade.showToast(ToastEnum.DungeonMapLevel, DungeonConfig.instance:getEpisodeDisplay(lua_open.configDict[OpenEnum.UnlockFunc.HardDungeon].episodeId))

		return
	end

	if DungeonConfig.instance:getHardEpisode(slot0._enterConfig.id) and DungeonModel.instance:episodeIsInLockTime(slot1.id) then
		GameFacade.showToastString(slot0._txtLockTime.text)

		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(slot0._config.id) or slot0._episodeInfo.star < DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.PassLevelAndStory)

		return
	end
end

function slot0._btnnormalmodeOnClick(slot0)
	if slot0._chapterType == DungeonEnum.ChapterType.Normal then
		return
	end

	slot0._config = slot0._enterConfig

	slot0:_showEpisodeMode(false, true)
end

function slot0._showEpisodeMode(slot0, slot1, slot2)
	slot0._episodeItemParam.index = slot0._levelIndex
	slot0._episodeItemParam.isHardMode = slot1
	slot0._episodeItemParam.episodeConfig = slot0._config
	slot0._episodeItemParam.immediately = not slot2

	DungeonController.instance:dispatchEvent(DungeonEvent.SwitchHardMode, slot0._episodeItemParam)
	slot0:_updateEpisodeInfo()
	slot0:onUpdate(slot1, slot2)

	if slot2 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_switch)
	end
end

function slot0._updateEpisodeInfo(slot0)
	slot0._episodeInfo = DungeonModel.instance:getEpisodeInfo(slot0._config.id)
	slot0._curSpeed = 1
end

function slot0._btnlockOnClick(slot0)
	if DungeonModel.instance:getCantChallengeToast(slot0._config) then
		GameFacade.showToast(ToastEnum.CantChallengeToast, slot1)
	end
end

function slot0._btnstoryOnClick(slot0)
	slot1 = DungeonModel.instance:hasPassLevelAndStory(slot0._config.id)

	StoryController.instance:playStory(slot0._config.afterStory, {
		mark = true,
		episodeId = slot0._config.id
	}, function ()
		uv0:onStoryStatus()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)

		DungeonMapModel.instance.playAfterStory = true

		if DungeonModel.instance:hasPassLevelAndStory(uv0._config.id) and slot0 ~= uv1 then
			DungeonController.instance:showUnlockContentToast(uv0._config.id)
		end

		ViewMgr.instance:closeView(uv0.viewName)
	end, slot0)
end

function slot0._showStoryPlayBackBtn(slot0, slot1, slot2, slot3)
	slot4 = slot1 > 0 and StoryModel.instance:isStoryFinished(slot1)

	gohelper.setActive(slot2, slot4)

	if slot4 then
		DungeonLevelItem.showEpisodeName(slot0._config, slot0._chapterIndex, slot0._levelIndex, slot3)
	end
end

function slot0._showMiddleStoryPlayBackBtn(slot0, slot1, slot2)
	slot4 = #StoryConfig.instance:getEpisodeFightStory(slot0._config) > 0

	for slot8, slot9 in ipairs(slot3) do
		if not StoryModel.instance:isStoryFinished(slot9) then
			slot4 = false

			break
		end
	end

	gohelper.setActive(slot1, slot4)

	if slot4 then
		DungeonLevelItem.showEpisodeName(slot0._config, slot0._chapterIndex, slot0._levelIndex, slot2)
	end
end

function slot0._btnshowticketsOnClick(slot0)
end

function slot0._playMainStory(slot0)
	DungeonRpc.instance:sendStartDungeonRequest(slot0._config.chapterId, slot0._config.id)

	if DungeonConfig.instance:getExtendStory(slot0._config.id) then
		StoryController.instance:playStories({
			slot0._config.beforeStory,
			slot2
		}, {
			mark = true,
			episodeId = slot0._config.id
		}, slot0.onStoryFinished, slot0)
	else
		StoryController.instance:playStory(slot0._config.beforeStory, slot1, slot0.onStoryFinished, slot0)
	end
end

function slot0.onStoryFinished(slot0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(slot0._config.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	ViewMgr.instance:closeView(slot0.viewName)
end

function slot0._btnequipOnClick(slot0)
	slot0:_enterFight()
end

function slot0._btnstartOnClick(slot0)
	if slot0._config.type == DungeonEnum.EpisodeType.Story then
		slot0:_playMainStory()

		return
	end

	slot1, slot2, slot3 = DungeonModel.instance:getEpisodeChallengeCount(slot0._episodeId)

	if slot1 > 0 and slot2 > 0 and slot2 <= slot3 then
		slot4 = ""

		GameFacade.showToast(ToastEnum.DungeonMapLevel3, (slot1 ~= DungeonEnum.ChallengeCountLimitType.Daily or luaLang("time_day2")) and (slot1 ~= DungeonEnum.ChallengeCountLimitType.Weekly or luaLang("time_week")) and luaLang("time_month"))

		return
	end

	if slot0._chapterType == DungeonEnum.ChapterType.Normal and slot1 > 0 and slot2 > 0 and slot2 < slot3 then
		GameFacade.showToast(ToastEnum.DungeonMapLevel4)

		return
	end

	if DungeonConfig.instance:getChapterCO(slot0._config.chapterId).type == DungeonEnum.ChapterType.RoleStory then
		slot0:_startRoleStory()

		return
	end

	if slot0._config.beforeStory > 0 then
		if slot0._config.afterStory > 0 then
			if not StoryModel.instance:isStoryFinished(slot0._config.afterStory) then
				slot0:_playStoryAndEnterFight(slot0._config.beforeStory)

				return
			end
		elseif slot0._episodeInfo.star <= DungeonEnum.StarType.None then
			slot0:_playStoryAndEnterFight(slot0._config.beforeStory)

			return
		end
	end

	slot0:_enterFight()
end

function slot0._startRoleStory(slot0)
	if slot0._config.beforeStory > 0 then
		slot0:_playStoryAndEnterFight(slot0._config.beforeStory, true)

		return
	end

	slot0:_enterFight()
end

function slot0._playStoryAndEnterFight(slot0, slot1, slot2)
	if not slot2 and StoryModel.instance:isStoryFinished(slot1) then
		slot0:_enterFight()

		return
	end

	StoryController.instance:playStory(slot1, {
		mark = true,
		episodeId = slot0._config.id
	}, slot0._enterFight, slot0)
end

function slot0._enterFight(slot0)
	if slot0._enterConfig then
		DungeonModel.instance:setLastSelectMode(slot0._chapterType, slot0._enterConfig.id)
	end

	DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot0._episodeId).chapterId, slot0._episodeId, slot0._curSpeed)
end

function slot0._editableInitView(slot0)
	slot0._animator = gohelper.findChild(slot0.viewGO, "anim") and slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._simageList = slot0:getUserDataTb_()

	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0._simagenormalbg:LoadImage(ResUrl.getDungeonIcon("fubenxinxi_di_putong"))
	slot0._simagehardbg:LoadImage(ResUrl.getDungeonIcon("fubenxinxi_di_kunnan"))

	slot0._rulesimageList = slot0:getUserDataTb_()
	slot0._rulesimagelineList = slot0:getUserDataTb_()
	slot0._rewarditems = slot0:getUserDataTb_()
	slot0._enemyitems = slot0:getUserDataTb_()
	slot0._episodeItemParam = slot0:getUserDataTb_()

	gohelper.removeUIClickAudio(slot0._btncloseview.gameObject)
	gohelper.removeUIClickAudio(slot0._btnnormalmode.gameObject)
	gohelper.removeUIClickAudio(slot0._btnhardmode.gameObject)
	gohelper.addUIClickAudio(slot0._btnstart.gameObject, AudioEnum.HeroGroupUI.Play_UI_Action_Mainstart)
end

function slot0._initStar(slot0)
	gohelper.setActive(slot0._gostar, true)

	slot0._starImgList = slot0:getUserDataTb_()

	for slot6 = 1, slot0._gostar.transform.childCount do
		table.insert(slot0._starImgList, slot1:GetChild(slot6 - 1):GetComponent(gohelper.Type_Image))
	end
end

function slot0.showStatus(slot0)
	slot2 = DungeonModel.instance:isOpenHardDungeon(slot0._config.chapterId)
	slot7 = DungeonConfig.instance:getHardEpisode(slot0._config.id) and DungeonModel.instance:getEpisodeInfo(slot6.id)

	slot0:_setStar(slot0._starImgList[1], DungeonEnum.StarType.Normal <= slot0._episodeInfo.star and (slot0._config.id and DungeonModel.instance:hasPassLevelAndStory(slot1)), 1)

	if not string.nilorempty(DungeonConfig.instance:getEpisodeAdvancedConditionText(slot1)) then
		slot0:_setStar(slot0._starImgList[2], DungeonEnum.StarType.Advanced <= slot5.star and slot3, 2)

		if slot6 then
			slot11 = DungeonModel.instance:episodeIsInLockTime(slot6.id)

			gohelper.setActive(slot0._starImgList[3], not slot11)
			gohelper.setActive(slot0._starImgList[4], not slot11)
		end

		if slot7 and DungeonEnum.StarType.Advanced <= slot5.star and slot2 and slot3 then
			slot0:_setStar(slot9, DungeonEnum.StarType.Normal <= slot7.star, 3)
			slot0:_setStar(slot8, DungeonEnum.StarType.Advanced <= slot7.star, 4)
		end
	end

	if slot0._simpleConfig then
		slot11 = DungeonEnum.StarType.Normal <= slot5.star and slot3

		slot0._setStarN(slot0._imgnormalstar1s, slot11, 2)
		slot0._setStarN(slot0._imgnormalstar1ru, slot11, 2)
		slot0._setStarN(slot0._imgnormalstar1lu, slot11, 2)

		slot12 = DungeonEnum.StarType.Advanced <= slot5.star and slot3

		slot0._setStarN(slot0._imgnormalstar2s, slot12, 2)
		slot0._setStarN(slot0._imgnormalstar2ru, slot12, 2)
		slot0._setStarN(slot0._imgnormalstar2lu, slot12, 2)

		slot13 = DungeonModel.instance:hasPassLevelAndStory(slot0._simpleConfig.id)

		slot0._setStarN(slot0._imgstorystar1s, slot13, 1)
		slot0._setStarN(slot0._imgstorystar1u, slot13, 1)

		if slot6 then
			slot14 = DungeonModel.instance:episodeIsInLockTime(slot6.id)

			gohelper.setActive(slot0._imghardstar1s, not slot14)
			gohelper.setActive(slot0._imghardstar1u, not slot14)
			gohelper.setActive(slot0._imghardstar2s, not slot14)
			gohelper.setActive(slot0._imghardstar2u, not slot14)

			if DungeonModel.instance:getEpisodeInfo(slot6.id) and DungeonEnum.StarType.Advanced <= slot5.star and slot2 and slot3 then
				slot16 = DungeonEnum.StarType.Normal <= slot15.star
				slot17 = DungeonEnum.StarType.Advanced <= slot15.star

				slot0._setStarN(slot0._imghardstar1s, slot16, 3)
				slot0._setStarN(slot0._imghardstar1u, slot16, 3)
				slot0._setStarN(slot0._imghardstar2s, slot17, 3)
				slot0._setStarN(slot0._imghardstar2u, slot17, 3)
			else
				slot0._setStarN(slot0._imghardstar1s, false, 3)
				slot0._setStarN(slot0._imghardstar1u, false, 3)
				slot0._setStarN(slot0._imghardstar2s, false, 3)
				slot0._setStarN(slot0._imghardstar2u, false, 3)
			end
		end
	end
end

function slot0._setStar(slot0, slot1, slot2, slot3)
	slot4 = "#9B9B9B"

	if slot2 then
		slot4 = slot3 > 2 and "#FF4343" or "#F97142"
		slot1.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot1, slot4)
end

function slot0._onCurrencyChange(slot0, slot1)
	if not slot1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	slot0:refreshCostPower()
end

function slot0.onUpdateParam(slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
	slot0:_initInfo()
	slot0.viewContainer:refreshHelp()
	slot0:showStatus()
	slot0:_doUpdate()
	slot0:checkSendGuideEvent()
end

function slot0._addRuleItem(slot0, slot1, slot2)
	slot3 = gohelper.clone(slot0._goruletemp, slot0._gorulelist, slot1.id)

	gohelper.setActive(slot3, true)
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot3, "#image_tagicon"), "wz_" .. slot2)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(gohelper.findChildImage(slot3, ""), slot1.icon)
end

function slot0._setRuleDescItem(slot0, slot1, slot2)
	slot4 = gohelper.clone(slot0._goruleitem, slot0._goruleDescList, slot1.id)

	gohelper.setActive(slot4, true)
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(gohelper.findChildImage(slot4, "icon"), slot1.icon)
	table.insert(slot0._rulesimagelineList, gohelper.findChild(slot4, "line"))
	UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot4, "tag"), "wz_" .. slot2)

	gohelper.findChildText(slot4, "desc").text = SkillConfig.instance:fmtTagDescColor(luaLang("dungeon_add_rule_target_" .. slot2), slot1.desc, ({
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	})[slot2])
end

function slot0.onOpen(slot0)
	slot0:_initInfo()
	slot0:showStatus()
	slot0:_doUpdate()
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUnlockNewChapter, slot0._OnUnlockNewChapter, slot0)
	slot0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, slot0.viewContainer.refreshHelp, slot0.viewContainer)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, slot0._onUpdateDungeonInfo, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshDoubleDropInfo, slot0.showDoubleDrop, slot0)
	NavigateMgr.instance:addEscape(ViewName.DungeonMapLevelView, slot0._btncloseOnClick, slot0)

	if not slot0.viewParam[uv0.isJumpOpen] then
		slot0:checkSendGuideEvent()
	end
end

function slot0._onUpdateDungeonInfo(slot0)
	slot0:showFree(DungeonConfig.instance:getChapterCO(slot0._config.chapterId))
end

function slot0._OnUnlockNewChapter(slot0)
	ViewMgr.instance:closeView(ViewName.DungeonMapLevelView)
end

function slot0._doUpdate(slot0)
	slot2, slot3 = DungeonModel.instance:getLastSelectMode()

	if slot0.viewParam[5] or slot2 == DungeonEnum.ChapterType.Hard then
		if slot0._episodeInfo.star == DungeonEnum.StarType.Advanced then
			slot0._hardEpisode = DungeonConfig.instance:getHardEpisode(slot0._enterConfig.id)

			if slot0._hardEpisode then
				slot0._config = slot0._hardEpisode

				slot0:_showEpisodeMode(true, false)
				slot0._animator:Play("dungeonlevel_in_hard", 0, 0)

				return
			end
		end
	elseif slot2 == DungeonEnum.ChapterType.Simple and slot0._simpleConfig then
		slot0._config = slot0._simpleConfig

		slot0:_showEpisodeMode(false, false)
		slot0._animator:Play("dungeonlevel_in_nomal", 0, 0)

		return
	end

	if slot0._simpleConfig and slot0:checkFirstDisplay() and DungeonModel.instance:getLastFightEpisodePassMode(slot0._enterConfig) == DungeonEnum.ChapterType.Simple then
		slot0._config = slot0._simpleConfig

		slot0:_showEpisodeMode(false, false)
		slot0._animator:Play("dungeonlevel_in_nomal", 0, 0)

		return
	end

	slot0:onUpdate()
	slot0._animator:Play("dungeonlevel_in_nomal", 0, 0)
end

function slot0._initInfo(slot0)
	slot0._enterConfig = slot0.viewParam[1]
	slot0._simpleConfig = DungeonConfig.instance:getSimpleEpisode(slot0._enterConfig)
	slot0._hardEpisode = DungeonConfig.instance:getHardEpisode(slot0._enterConfig.id)
	slot0._config = slot0._enterConfig
	slot0._chapterIndex = slot0.viewParam[3]
	slot0._levelIndex = DungeonConfig.instance:getChapterEpisodeIndexWithSP(slot0._config.chapterId, slot0._config.id)

	slot0:_updateEpisodeInfo()

	if slot0.viewParam[uv0.isJumpOpen] then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnJumpChangeFocusEpisodeItem, slot0._config.id)
	end

	slot0:refreshTitleField()
end

slot0.BtnOutScreenTime = 0.3

function slot0.onUpdate(slot0, slot1, slot2)
	if slot0._chapterType ~= slot4 and slot0._animator then
		slot0._animator:Play(DungeonConfig.instance:getChapterCO(slot0._config.chapterId).type == DungeonEnum.ChapterType.Hard and "hard" or "normal", 0, 0)
		slot0._animator:Update(0)
	end

	slot0._chapterType = slot4

	slot0._gonormal2:SetActive(false)

	if slot2 then
		TaskDispatcher.cancelTask(slot0._delayToSwitchStartBtn, slot0)
		TaskDispatcher.runDelay(slot0._delayToSwitchStartBtn, slot0, uv0.BtnOutScreenTime)
	else
		slot0:_delayToSwitchStartBtn()
	end

	gohelper.setActive(slot0._goselectstorybg, slot4 == DungeonEnum.ChapterType.Simple)
	gohelper.setActive(slot0._gounselectstorybg, slot4 ~= DungeonEnum.ChapterType.Simple)
	gohelper.setActive(slot0._goselectnormalbgN, slot4 == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(slot0._gounselectnormalbgr, slot4 == DungeonEnum.ChapterType.Simple)
	gohelper.setActive(slot0._gounselectnormalbgl, slot4 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(slot0._goselecthardbgN, slot4 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(slot0._gounselecthardbgN, slot4 ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(slot0._simagenormalbg, slot4 ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(slot0._simagehardbg, slot4 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(slot0._gohardmodedecorate, slot4 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(slot0._goselecthardbg, slot4 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(slot0._gounselecthardbg, slot4 == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(slot0._goselectnormalbg, slot4 == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(slot0._gounselectnormalbg, slot4 == DungeonEnum.ChapterType.Hard)

	slot0._episodeId = slot0._config.id
	slot7 = ResUrl.getCurrencyItemIcon(CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power).icon .. "_btn")

	slot0._simagepower2:LoadImage(slot7)
	slot0._simagepower3:LoadImage(slot7)
	gohelper.setActive(slot0._goboss, slot0:_isBossTypeEpisode(slot5))
	gohelper.setActive(slot0._gonormaleye, not slot5)
	gohelper.setActive(slot0._gohardeye, slot5)

	if slot0._config.battleId ~= 0 then
		gohelper.setActive(slot0._gorecommond, true)

		if DungeonHelper.getEpisodeRecommendLevel(slot0._episodeId, slot4 == DungeonEnum.ChapterType.Simple) ~= 0 then
			gohelper.setActive(slot0._gorecommond, true)

			slot0._txtrecommondlv.text = HeroConfig.instance:getLevelDisplayVariant(slot9)
		else
			gohelper.setActive(slot0._gorecommond, false)
		end
	else
		gohelper.setActive(slot0._gorecommond, false)
	end

	slot0:setTitleDesc()
	slot0:showFree(slot3)
	slot0:showDoubleDrop()

	slot0._txttitle3.text = string.format("%02d", slot0._levelIndex)
	slot0._txtchapterindex.text = slot3.chapterIndex

	if slot2 then
		TaskDispatcher.cancelTask(slot0.refreshCostPower, slot0)
		TaskDispatcher.runDelay(slot0.refreshCostPower, slot0, uv0.BtnOutScreenTime)
	else
		slot0:refreshCostPower()
	end

	slot0:refreshChallengeLimit()
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, slot0.refreshChallengeLimit, slot0)
	slot0:onStoryStatus()
end

function slot0._isBossTypeEpisode(slot0, slot1)
	if slot1 then
		if slot0._config.preEpisode then
			return DungeonConfig.instance:getEpisodeCO(slot0._config.preEpisode).displayMark == 1
		end

		return slot0._config.displayMark == 1
	else
		return slot0._config.displayMark == 1
	end
end

function slot0._delayToSwitchStartBtn(slot0)
	slot1 = slot0._chapterType == DungeonEnum.ChapterType.Hard

	gohelper.setActive(slot0._gostartnormal, not slot1)
	gohelper.setActive(slot0._gostarthard, slot1)
end

function slot0.showDoubleDrop(slot0)
	if not slot0._config then
		return
	end

	slot1 = DungeonConfig.instance:getChapterCO(slot0._config.chapterId)
	slot2, slot3, slot4 = DoubleDropModel.instance:isShowDoubleByEpisode(slot0._config.id, true)

	gohelper.setActive(slot0._godoubletimes, slot2)

	if slot2 then
		slot0._txtdoubletimes.text = GameUtil.getSubPlaceholderLuaLang(luaLang("double_drop_remain_times"), {
			slot3,
			slot4
		})

		recthelper.setAnchorY(slot0._gooperation.transform, -20)
		recthelper.setAnchorY(slot0._btnequip.transform, -410)
	else
		recthelper.setAnchorY(slot0._gooperation.transform, 0)
		recthelper.setAnchorY(slot0._btnequip.transform, -390)
	end
end

function slot0.showFree(slot0, slot1)
	slot2 = slot1.enterAfterFreeLimit > 0

	gohelper.setActive(slot0._gorighttop, not slot2)

	slot0._enterAfterFreeLimit = slot2

	if not slot2 then
		return
	end

	if DungeonModel.instance:getChapterRemainingNum(slot1.type) <= 0 then
		slot2 = false
	end

	gohelper.setActive(slot0._goequipmap, slot2)
	gohelper.setActive(slot0._gooperation, not slot2)
	gohelper.setActive(slot0._gorighttop, not slot2)

	slot0._enterAfterFreeLimit = slot2

	if not slot2 then
		return
	end

	slot0._txtfightcount.text = slot3 == 0 and string.format("<color=#b3afac>%s</color>", slot3) or slot3

	gohelper.setActive(slot0._gofightcountbg, slot3 ~= 0)
	slot0:_refreshFreeCost()
end

function slot0._refreshFreeCost(slot0)
	slot0._txtcostcount.text = -1 * slot0._curSpeed
end

function slot0.showViewStory(slot0)
	slot2 = false

	for slot6, slot7 in ipairs(StoryConfig.instance:getEpisodeStoryIds(slot0._config)) do
		if StoryModel.instance:isStoryFinished(slot7) then
			slot2 = true

			break
		end
	end

	if not slot2 then
		return
	end
end

function slot0.refreshChallengeLimit(slot0)
	slot1, slot2, slot3 = DungeonModel.instance:getEpisodeChallengeCount(slot0._episodeId)

	if slot1 > 0 and slot2 > 0 then
		slot4 = ""
		slot0._txtchallengecountlimit.text = string.format("%s%s (%d/%d)", (slot1 ~= DungeonEnum.ChallengeCountLimitType.Daily or luaLang("daily")) and (slot1 ~= DungeonEnum.ChallengeCountLimitType.Weekly or luaLang("weekly")) and luaLang("monthly"), luaLang("times"), math.max(0, slot2 - slot0._episodeInfo.challengeCount), slot2)
	else
		slot0._txtchallengecountlimit.text = ""
	end

	slot0._isCanChallenge, slot0._challengeLockCode = DungeonModel.instance:isCanChallenge(slot0._config)

	gohelper.setActive(slot0._gostart, slot0._isCanChallenge)
	gohelper.setActive(slot0._golock, not slot0._isCanChallenge)
end

function slot0.onStoryStatus(slot0)
	slot1 = false
	slot2 = DungeonConfig.instance:getChapterCO(slot0._config.chapterId)

	if slot0._config.afterStory > 0 and not StoryModel.instance:isStoryFinished(slot0._config.afterStory) and DungeonEnum.StarType.None < slot0._episodeInfo.star then
		slot1 = true
	end

	gohelper.setActive(slot0._gooperation, not slot1 and not slot0._enterAfterFreeLimit)
	gohelper.setActive(slot0._btnstory, slot1)

	slot3 = slot0._chapterType == DungeonEnum.ChapterType.Hard

	if slot1 then
		slot0:refreshHardMode()
		slot0._btnhardmode.gameObject:SetActive(false)
	elseif not slot3 then
		slot0:refreshHardMode()
	else
		slot0._btnHardModeActive = false

		TaskDispatcher.cancelTask(slot0._delaySetActive, slot0)
		TaskDispatcher.runDelay(slot0._delaySetActive, slot0, 0.2)
	end

	slot0:showViewStory()

	slot4, slot5, slot6 = DungeonModel.instance:getChapterListTypes()
	slot8 = (not slot4 or slot0._config.type ~= DungeonEnum.EpisodeType.Story) and not slot5 and not slot6 and not DungeonModel.instance:chapterListIsRoleStory()

	gohelper.setActive(slot0._goswitch, slot0._simpleConfig and slot8)
	gohelper.setActive(slot0._gonormal, not slot0._simpleConfig and slot8)
	gohelper.setActive(slot0._gohard, not slot0._simpleConfig and slot8)
	gohelper.setActive(slot0._gostar, not slot0._simpleConfig and slot8)
	recthelper.setAnchorY(slot0._scrolldesc.transform, slot8 and 8 or 65)
	recthelper.setAnchorY(slot0._gorecommond.transform, slot8 and 87.3 or 168.4)
	TaskDispatcher.cancelTask(slot0._checkLockTime, slot0)
	TaskDispatcher.runRepeat(slot0._checkLockTime, slot0, 1)
end

function slot0._checkLockTime(slot0)
	slot2 = slot0.isInLockTime and true or false

	if DungeonConfig.instance:getHardEpisode(slot0._enterConfig.id) and DungeonModel.instance:episodeIsInLockTime(slot1.id) then
		slot0.isInLockTime = true
	else
		slot0.isInLockTime = false
	end

	if slot2 ~= slot0.isInLockTime then
		slot0:showStatus()
		slot0:onStoryStatus()
	elseif slot0.isInLockTime then
		slot3 = ServerTime.now()
		slot0._txtLockTime.text = formatLuaLang("seasonmainview_timeopencondition", string.format("%s%s", TimeUtil.secondToRoughTime2(string.splitToNumber(slot1.lockTime, "#")[2] / 1000 - ServerTime.now())))
	end
end

function slot0.refreshHardMode(slot0)
	slot0._hardEpisode = DungeonConfig.instance:getHardEpisode(slot0._enterConfig.id)
	slot1 = false

	if slot0._episodeInfo.star == DungeonEnum.StarType.Advanced then
		slot1 = slot0._hardEpisode ~= nil and DungeonModel.instance:isOpenHardDungeon(slot0._config.chapterId)
	end

	if slot0._hardEpisode and DungeonModel.instance:episodeIsInLockTime(slot0._hardEpisode.id) then
		slot1 = false

		gohelper.setActive(slot0._txtLockTime, true)

		slot2 = ServerTime.now()
		slot0._txtLockTime.text = formatLuaLang("seasonmainview_timeopencondition", string.format("%s%s", TimeUtil.secondToRoughTime2(string.splitToNumber(slot0._hardEpisode.lockTime, "#")[2] / 1000 - ServerTime.now())))
		slot0._golockbg:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	else
		gohelper.setActive(slot0._txtLockTime, false)

		slot0._golockbg:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0.1
	end

	slot0._btnhardmode.gameObject:SetActive(slot1)
	gohelper.setActive(slot0._golockbg, not slot1)

	slot0._gohard:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = slot1 and 1 or 0.3
	slot0._btnHardModeActive = slot1
end

function slot0._delaySetActive(slot0)
	slot0._btnhardmode.gameObject:SetActive(slot0._btnHardModeActive)
end

function slot0.refreshCostPower(slot0)
	slot3 = tonumber(string.split(string.split(slot0._config.cost, "|")[1], "#")[3] or 0) * slot0._curSpeed
	slot0._txtusepower.text = "-" .. slot3
	slot0._txtusepowerhard.text = "-" .. slot3

	if slot3 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtusepower, "#070706")
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtusepowerhard, "#FFEAEA")
		gohelper.setActive(slot0._gonormallackpower, false)
		gohelper.setActive(slot0._gohardlackpower, false)
	else
		slot4 = slot0._chapterType == DungeonEnum.ChapterType.Hard

		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtusepower, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtusepowerhard, "#C44945")
		gohelper.setActive(slot0._gonormallackpower, not slot4)
		gohelper.setActive(slot0._gohardlackpower, slot4)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
	AudioMgr.instance:trigger(slot0:getCurrentChapterListTypeAudio().onClose)

	slot0._episodeItemParam.isHardMode = false

	DungeonController.instance:dispatchEvent(DungeonEvent.SwitchHardMode, slot0._episodeItemParam)

	if slot0._rewarditems then
		for slot4, slot5 in ipairs(slot0._rewarditems) do
			TaskDispatcher.cancelTask(slot5.refreshLimitTime, slot5)
		end
	end

	slot0._chapterType = nil
end

function slot0.onCloseFinish(slot0)
end

function slot0.clearRuleList(slot0)
	slot0._simageList = slot0:getUserDataTb_()

	for slot4, slot5 in pairs(slot0._rulesimageList) do
		slot5:UnLoadImage()
	end

	slot0._rulesimageList = slot0:getUserDataTb_()
	slot0._rulesimagelineList = slot0:getUserDataTb_()

	gohelper.destroyAllChildren(slot0._gorulelist)
	gohelper.destroyAllChildren(slot0._goruleDescList)
end

function slot0.onDestroyView(slot0)
	slot0._simagepower2:UnLoadImage()
	slot0._simagepower3:UnLoadImage()
	slot0._simagenormalbg:UnLoadImage()
	slot0._simagehardbg:UnLoadImage()

	for slot4, slot5 in pairs(slot0._rulesimageList) do
		slot5:UnLoadImage()
	end

	for slot4 = 1, #slot0._enemyitems do
		slot0._enemyitems[slot4].simagemonsterhead:UnLoadImage()
	end

	TaskDispatcher.cancelTask(slot0._delaySetActive, slot0)
	TaskDispatcher.cancelTask(slot0._delayToSwitchStartBtn, slot0)
	TaskDispatcher.cancelTask(slot0.refreshCostPower, slot0)
	TaskDispatcher.cancelTask(slot0._checkLockTime, slot0)
end

function slot0.refreshTitleField(slot0)
	if (GameUtil.utf8len(slot0._config.name) > 7 and slot0.titleList[2] or slot0.titleList[1]) == slot0.curTitleItem then
		return
	end

	for slot6, slot7 in ipairs(slot0.titleList) do
		gohelper.setActive(slot7._go, slot7 == slot2)
	end

	slot0.curTitleItem = slot2
	slot0._txttitle1 = slot2._txttitle1
	slot0._txttitle3 = slot2._txttitle3
	slot0._txtchapterindex = slot2._txtchapterindex
	slot0._txttitle4 = slot2._txttitle4
	slot0._gostar = slot2._gostar

	slot0:_initStar()
end

function slot0.setTitleDesc(slot0)
	slot0:refreshTitleField()

	slot1 = nil
	slot1 = (DungeonConfig.instance:getChapterTypeByEpisodeId(slot0._config.id) ~= DungeonEnum.ChapterType.Hard or DungeonConfig.instance:getEpisodeCO(slot0._config.preEpisode)) and (slot2 ~= DungeonEnum.ChapterType.Simple or DungeonConfig.instance:getEpisodeCO(slot0._config.normalEpisodeId)) and slot0._config
	slot0._txtdesc.text = slot1.desc
	slot0._txttitle4.text = slot1.name_En
	slot3 = GameUtil.utf8sub(slot1.name, 1, 1)
	slot4 = ""
	slot5 = nil

	if GameUtil.utf8len(slot1.name) >= 2 then
		slot4 = string.format("%s", GameUtil.utf8sub(slot1.name, 2, GameUtil.utf8len(slot1.name) - 1))
	end

	slot0._txttitle1.text = string.format("<size=100>%s</size>%s", slot3, slot4)

	ZProj.UGUIHelper.RebuildLayout(slot0._txttitle1.transform)
	ZProj.UGUIHelper.RebuildLayout(slot0._txttitle4.transform)

	slot5 = GameUtil.utf8len(slot0._config.name) > 2 and recthelper.getAnchorX(slot0._txttitle1.transform) + recthelper.getWidth(slot0._txttitle1.transform) or recthelper.getAnchorX(slot0._txttitle1.transform) + recthelper.getWidth(slot0._txttitle1.transform) + recthelper.getAnchorX(slot0._txttitle4.transform)

	slot0:_setTitle_overseas(slot3, slot4)
end

function slot0.getCurrentChapterListTypeAudio(slot0)
	slot1, slot2, slot3 = DungeonModel.instance:getChapterListTypes()
	slot4 = nil

	return (not slot1 or uv0.AudioConfig[DungeonEnum.ChapterListType.Story]) and (not slot2 or uv0.AudioConfig[DungeonEnum.ChapterListType.Resource]) and (not slot3 or uv0.AudioConfig[DungeonEnum.ChapterListType.Insight]) and uv0.AudioConfig[DungeonEnum.ChapterListType.Story]
end

function slot0._setStarN(slot0, slot1, slot2)
	slot3 = "#9B9B9B"

	if slot1 then
		slot3 = slot2 == 1 and "#efb974" or slot2 == 2 and "#F97142" or "#FF4343"
		slot0.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot0, slot3)
end

function slot0._btnHardOnClick(slot0)
	if slot0._chapterType == DungeonEnum.ChapterType.Hard then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.HardDungeon))

		return
	end

	if DungeonConfig.instance:getHardEpisode(slot0._enterConfig.id) and DungeonModel.instance:episodeIsInLockTime(slot1.id) then
		GameFacade.showToastString(slot0._txtLockTime.text)

		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(slot0._enterConfig.id) or DungeonModel.instance:getEpisodeInfo(slot0._enterConfig.id).star < DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.PassLevelAndStory)

		return
	end

	slot0._config = slot0._hardEpisode

	slot0:_showEpisodeMode(true, true)
end

function slot0._btnNormalOnClick(slot0)
	if slot0._chapterType == DungeonEnum.ChapterType.Normal then
		return
	end

	slot0._config = slot0._enterConfig

	slot0:_showEpisodeMode(false, true)
end

function slot0._btnSimpleOnClick(slot0)
	if slot0._chapterType == DungeonEnum.ChapterType.Simple then
		return
	end

	slot0._config = slot0._simpleConfig

	slot0:_showEpisodeMode(false, true)
end

function slot0.checkSendGuideEvent(slot0)
	if not slot0._config then
		return
	end

	slot2 = DungeonConfig.instance:getEpisodeBattleId(slot0._config.id)

	if DungeonConfig.instance:getChapterCO(slot0._config.chapterId).type == DungeonEnum.ChapterType.Normal and not DungeonModel.instance:hasPassLevelAndStory(slot0._config.id) and slot2 and slot2 ~= 0 then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnOpenUnPassLevelGuide)
	end
end

function slot0.checkFirstDisplay(slot0)
	if PlayerPrefsHelper.getNumber(PlayerPrefsKey.DungeonMapLevelFirstShow .. slot0._simpleConfig.id .. PlayerModel.instance:getMyUserId(), 0) == 0 then
		PlayerPrefsHelper.setNumber(slot2, 1)

		return true
	end

	return false
end

return slot0
