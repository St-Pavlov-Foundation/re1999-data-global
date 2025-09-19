module("modules.logic.dungeon.view.DungeonMapLevelView", package.seeall)

local var_0_0 = class("DungeonMapLevelView", BaseView)
local var_0_1 = {
	isJumpOpen = 6
}
local var_0_2 = 10606
local var_0_3 = 20604
local var_0_4 = 190906

function var_0_0._setTitle_overseas(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = LangSettings.instance:isJp()
	local var_1_1 = (arg_1_0._episodeId == var_0_2 or arg_1_0._episodeId == var_0_3) and var_1_0

	recthelper.setHeight(arg_1_0._txttitle1.transform, var_1_1 and 110 or 140)

	if var_1_0 and arg_1_0._episodeId == var_0_4 then
		arg_1_0._txttitle1.text = string.format("<size=74>%s</size>%s", arg_1_1, arg_1_2)
	elseif var_1_1 then
		arg_1_0._txttitle1.text = string.format("<size=60>%s</size>%s", arg_1_1, arg_1_2)
	end
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._btncloseview = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#btn_closeview")
	arg_2_0._gonormal = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_normal")
	arg_2_0._btnhardmode = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "anim/right/#go_hard/go/#btn_hardmode")
	arg_2_0._btnhardmodetip = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "anim/right/#go_hard/go/#btn_hardmodetip")
	arg_2_0._gohard = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_hard")
	arg_2_0._simagenormalbg = gohelper.findChildSingleImage(arg_2_0.viewGO, "anim/bgmask/#simage_normalbg")
	arg_2_0._simagehardbg = gohelper.findChildSingleImage(arg_2_0.viewGO, "anim/bgmask/#simage_hardbg")
	arg_2_0._imagehardstatus = gohelper.findChildImage(arg_2_0.viewGO, "anim/right/#go_hard/#image_hardstatus")
	arg_2_0._btnnormalmode = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "anim/right/#go_normal/#btn_normalmode")
	arg_2_0._txtpower = gohelper.findChildText(arg_2_0.viewGO, "anim/right/power/#txt_power")
	arg_2_0._simagepower1 = gohelper.findChildSingleImage(arg_2_0.viewGO, "anim/right/power/#simage_power1")
	arg_2_0._txtrule = gohelper.findChildText(arg_2_0.viewGO, "anim/right/condition/#go_additionRule/#txt_rule")
	arg_2_0._goruletemp = gohelper.findChild(arg_2_0.viewGO, "anim/right/condition/#go_additionRule/#go_ruletemp")
	arg_2_0._imagetagicon = gohelper.findChildImage(arg_2_0.viewGO, "anim/right/condition/#go_additionRule/#go_ruletemp/#image_tagicon")
	arg_2_0._gorulelist = gohelper.findChild(arg_2_0.viewGO, "anim/right/condition/#go_additionRule/#go_rulelist")
	arg_2_0._godefault = gohelper.findChild(arg_2_0.viewGO, "anim/right/condition/#go_default")
	arg_2_0._scrollreward = gohelper.findChildScrollRect(arg_2_0.viewGO, "anim/right/reward/#scroll_reward")
	arg_2_0._gooperation = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_operation")
	arg_2_0._gostart = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_operation/#go_start")
	arg_2_0._btnstart = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "anim/right/#go_operation/#go_start/#btn_start")
	arg_2_0._btnequip = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "anim/right/#go_equipmap/#btn_equip")
	arg_2_0._txtchallengecountlimit = gohelper.findChildText(arg_2_0.viewGO, "anim/right/#go_operation/#go_start/#txt_challengecountlimit")
	arg_2_0._gonormal2 = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_operation/#go_normal2")
	arg_2_0._goticket = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket")
	arg_2_0._btnshowtickets = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#btn_showtickets")
	arg_2_0._goticketlist = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketlist")
	arg_2_0._goticketItem = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem")
	arg_2_0._goticketinfo = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_ticketinfo")
	arg_2_0._simageticket = gohelper.findChildSingleImage(arg_2_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_ticketinfo/#simage_ticket")
	arg_2_0._txtticket = gohelper.findChildText(arg_2_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_ticketinfo/#txt_ticket")
	arg_2_0._gonoticket = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_noticket")
	arg_2_0._txtnoticket1 = gohelper.findChildText(arg_2_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_noticket/#txt_noticket1")
	arg_2_0._txtnoticket2 = gohelper.findChildText(arg_2_0.viewGO, "anim/right/#go_operation/#go_normal2/#go_ticket/#go_ticketItem/#go_noticket/#txt_noticket2")
	arg_2_0._golock = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_operation/#go_lock")
	arg_2_0._goequipmap = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_equipmap")
	arg_2_0._txtcostcount = gohelper.findChildText(arg_2_0.viewGO, "anim/right/#go_equipmap/#btn_equip/#txt_num")
	arg_2_0._gofightcountbg = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_equipmap/fightcount/#go_fightcountbg")
	arg_2_0._txtfightcount = gohelper.findChildText(arg_2_0.viewGO, "anim/right/#go_equipmap/fightcount/#txt_fightcount")
	arg_2_0._btnlock = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "anim/right/#go_operation/#go_lock/#btn_lock")
	arg_2_0._btnstory = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "anim/right/#btn_story")
	arg_2_0._btnviewstory = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "anim/right/#btn_viewstory")
	arg_2_0._gorighttop = gohelper.findChild(arg_2_0.viewGO, "anim/#go_righttop")
	arg_2_0.titleList = {}

	local var_2_0 = arg_2_0:getUserDataTb_()

	var_2_0._go = gohelper.findChild(arg_2_0.viewGO, "anim/right/title")
	var_2_0._txttitle1 = gohelper.findChildText(arg_2_0.viewGO, "anim/right/title/#txt_title1")
	var_2_0._txttitle3 = gohelper.findChildText(arg_2_0.viewGO, "anim/right/title/#txt_title1/#txt_title3")
	var_2_0._txtchapterindex = gohelper.findChildText(arg_2_0.viewGO, "anim/right/title/#txt_title1/#txt_title3/#txt_chapterindex")
	var_2_0._txttitle4 = gohelper.findChildText(arg_2_0.viewGO, "anim/right/title/#txt_title1/#txt_title4")
	var_2_0._gostar = gohelper.findChild(arg_2_0.viewGO, "anim/right/title/#go_star")
	arg_2_0.titleList[1] = var_2_0
	arg_2_0._scrolldesc = gohelper.findChild(arg_2_0.viewGO, "anim/right/#scrolldesc")

	local var_2_1 = arg_2_0:getUserDataTb_()

	var_2_1._go = gohelper.findChild(arg_2_0.viewGO, "anim/right/title2")
	var_2_1._txttitle1 = gohelper.findChildText(arg_2_0.viewGO, "anim/right/title2/#txt_title1")
	var_2_1._txttitle3 = gohelper.findChildText(arg_2_0.viewGO, "anim/right/title2/#txt_title3")
	var_2_1._txtchapterindex = gohelper.findChildText(arg_2_0.viewGO, "anim/right/title2/#txt_title3/#txt_chapterindex")
	var_2_1._txttitle4 = gohelper.findChildText(arg_2_0.viewGO, "anim/right/title2/#txt_title1/#txt_title4")
	var_2_1._gostar = gohelper.findChild(arg_2_0.viewGO, "anim/right/title2/#go_star")
	arg_2_0.titleList[2] = var_2_1
	arg_2_0._txtdesc = gohelper.findChildText(arg_2_0.viewGO, "anim/right/#scrolldesc/viewport/#txt_desc")
	arg_2_0._gorecommond = gohelper.findChild(arg_2_0.viewGO, "anim/right/recommend")
	arg_2_0._txtrecommondlv = gohelper.findChildText(arg_2_0.viewGO, "anim/right/recommend/#txt_recommendlv")
	arg_2_0._simagepower2 = gohelper.findChildSingleImage(arg_2_0.viewGO, "anim/right/#go_operation/#go_start/#go_startnormal/#simage_power2")
	arg_2_0._txtusepower = gohelper.findChildText(arg_2_0.viewGO, "anim/right/#go_operation/#go_start/#go_startnormal/#txt_usepower")
	arg_2_0._simagepower3 = gohelper.findChildSingleImage(arg_2_0.viewGO, "anim/right/#go_operation/#go_start/#go_starthard/#simage_power3")
	arg_2_0._txtusepowerhard = gohelper.findChildText(arg_2_0.viewGO, "anim/right/#go_operation/#go_start/#go_starthard/#txt_usepowerhard")
	arg_2_0._gostartnormal = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_operation/#go_start/#go_startnormal")
	arg_2_0._gostarthard = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_operation/#go_start/#go_starthard")
	arg_2_0._gohardmodedecorate = gohelper.findChild(arg_2_0.viewGO, "anim/right/title/#txt_title1/#go_hardmodedecorate")
	arg_2_0._gostoryline = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_storyline")
	arg_2_0._goselecthardbg = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_hard/go/#go_selecthardbg")
	arg_2_0._gounselecthardbg = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_hard/go/#go_unselecthardbg")
	arg_2_0._goselectnormalbg = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_normal/#go_selectnormalbg")
	arg_2_0._gounselectnormalbg = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_normal/#go_unselectnormalbg")
	arg_2_0._golockbg = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_hard/go/#go_lockbg")
	arg_2_0._txtLockTime = gohelper.findChildTextMesh(arg_2_0.viewGO, "anim/right/#go_hard/go/#go_lockbg/#txt_locktime")
	arg_2_0._gonormallackpower = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_operation/#go_start/#go_startnormal/#go_normallackpower")
	arg_2_0._gohardlackpower = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_operation/#go_start/#go_starthard/#go_hardlackpower")
	arg_2_0._goboss = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_boss")
	arg_2_0._gonormaleye = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_boss/#go_normaleye")
	arg_2_0._gohardeye = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_boss/#go_hardeye")
	arg_2_0._godoubletimes = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_doubletimes")
	arg_2_0._txtdoubletimes = gohelper.findChildTextMesh(arg_2_0.viewGO, "anim/right/#go_doubletimes/#txt_doubletimes")
	arg_2_0._goswitch = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_switch")
	arg_2_0._gostory = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_switch/#go_story")
	arg_2_0._btnSimpleClick = gohelper.findChildButton(arg_2_0.viewGO, "anim/right/#go_switch/#go_story/clickarea")
	arg_2_0._goselectstorybg = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_switch/#go_story/#go_selectstorybg")
	arg_2_0._gounselectstorybg = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_switch/#go_story/#go_unselectstorybg")
	arg_2_0._gonormalN = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_switch/#go_normal")
	arg_2_0._btnNormalClick = gohelper.findChildButton(arg_2_0.viewGO, "anim/right/#go_switch/#go_normal/clickarea")
	arg_2_0._goselectnormalbgN = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_switch/#go_normal/#go_selectnormalbg")
	arg_2_0._gounselectnormalbgr = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_right")
	arg_2_0._gounselectnormalbgl = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_left")
	arg_2_0._gohardN = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_switch/#go_hard")
	arg_2_0._btnHardClick = gohelper.findChildButton(arg_2_0.viewGO, "anim/right/#go_switch/#go_hard/clickarea")
	arg_2_0._goselecthardbgN = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_switch/#go_hard/#go_selecthardbg")
	arg_2_0._gounselecthardbgN = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_switch/#go_hard/#go_unselecthardbg")
	arg_2_0._golockbgN = gohelper.findChild(arg_2_0.viewGO, "anim/right/#go_switch/#go_hard/#go_lockbg")
	arg_2_0._txtLockTimeN = gohelper.findChildTextMesh(arg_2_0.viewGO, "anim/right/#go_switch/#go_hard/#go_lockbg/#txt_locktime")
	arg_2_0._imgstorystar1s = gohelper.findChildImage(arg_2_0.viewGO, "anim/right/#go_switch/#go_story/#go_selectstorybg/star1")
	arg_2_0._imgstorystar1u = gohelper.findChildImage(arg_2_0.viewGO, "anim/right/#go_switch/#go_story/#go_unselectstorybg/star1")
	arg_2_0._imgnormalstar1s = gohelper.findChildImage(arg_2_0.viewGO, "anim/right/#go_switch/#go_normal/#go_selectnormalbg/star1")
	arg_2_0._imgnormalstar2s = gohelper.findChildImage(arg_2_0.viewGO, "anim/right/#go_switch/#go_normal/#go_selectnormalbg/star2")
	arg_2_0._imgnormalstar1ru = gohelper.findChildImage(arg_2_0.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_right/star1")
	arg_2_0._imgnormalstar2ru = gohelper.findChildImage(arg_2_0.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_right/star2")
	arg_2_0._imgnormalstar1lu = gohelper.findChildImage(arg_2_0.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_left/star1")
	arg_2_0._imgnormalstar2lu = gohelper.findChildImage(arg_2_0.viewGO, "anim/right/#go_switch/#go_normal/#go_unselectnormalbg_left/star2")
	arg_2_0._imghardstar1s = gohelper.findChildImage(arg_2_0.viewGO, "anim/right/#go_switch/#go_hard/#go_selecthardbg/star1")
	arg_2_0._imghardstar2s = gohelper.findChildImage(arg_2_0.viewGO, "anim/right/#go_switch/#go_hard/#go_selecthardbg/star2")
	arg_2_0._imghardstar1u = gohelper.findChildImage(arg_2_0.viewGO, "anim/right/#go_switch/#go_hard/#go_unselecthardbg/star1")
	arg_2_0._imghardstar2u = gohelper.findChildImage(arg_2_0.viewGO, "anim/right/#go_switch/#go_hard/#go_unselecthardbg/star2")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btncloseview:AddClickListener(arg_3_0._btncloseviewOnClick, arg_3_0)
	arg_3_0._btnhardmode:AddClickListener(arg_3_0._btnhardmodeOnClick, arg_3_0)
	arg_3_0._btnhardmodetip:AddClickListener(arg_3_0._btnhardmodetipOnClick, arg_3_0)
	arg_3_0._btnnormalmode:AddClickListener(arg_3_0._btnnormalmodeOnClick, arg_3_0)
	arg_3_0._btnstart:AddClickListener(arg_3_0._btnstartOnClick, arg_3_0)
	arg_3_0._btnequip:AddClickListener(arg_3_0._btnequipOnClick, arg_3_0)
	arg_3_0._btnshowtickets:AddClickListener(arg_3_0._btnshowticketsOnClick, arg_3_0)
	arg_3_0._btnlock:AddClickListener(arg_3_0._btnlockOnClick, arg_3_0)
	arg_3_0._btnstory:AddClickListener(arg_3_0._btnstoryOnClick, arg_3_0)
	arg_3_0._btnSimpleClick:AddClickListener(arg_3_0._btnSimpleOnClick, arg_3_0)
	arg_3_0._btnNormalClick:AddClickListener(arg_3_0._btnNormalOnClick, arg_3_0)
	arg_3_0._btnHardClick:AddClickListener(arg_3_0._btnHardOnClick, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btncloseview:RemoveClickListener()
	arg_4_0._btnhardmode:RemoveClickListener()
	arg_4_0._btnhardmodetip:RemoveClickListener()
	arg_4_0._btnnormalmode:RemoveClickListener()
	arg_4_0._btnstart:RemoveClickListener()
	arg_4_0._btnequip:RemoveClickListener()
	arg_4_0._btnshowtickets:RemoveClickListener()
	arg_4_0._btnlock:RemoveClickListener()
	arg_4_0._btnstory:RemoveClickListener()
	arg_4_0._btnSimpleClick:RemoveClickListener()
	arg_4_0._btnNormalClick:RemoveClickListener()
	arg_4_0._btnHardClick:RemoveClickListener()
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

function var_0_0._btncloseviewOnClick(arg_5_0)
	TaskDispatcher.runDelay(arg_5_0.closeThis, arg_5_0, 0)
end

function var_0_0._btnshowrewardOnClick(arg_6_0)
	DungeonController.instance:openDungeonRewardView(arg_6_0._config)
end

function var_0_0._btnhardmodeOnClick(arg_7_0)
	if arg_7_0._chapterType == DungeonEnum.ChapterType.Hard then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		arg_7_0:_showHardDungeonOpenTip()

		return
	end

	local var_7_0 = DungeonConfig.instance:getHardEpisode(arg_7_0._enterConfig.id)

	if var_7_0 and DungeonModel.instance:episodeIsInLockTime(var_7_0.id) then
		GameFacade.showToastString(arg_7_0._txtLockTime.text)

		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(arg_7_0._enterConfig.id) or arg_7_0._episodeInfo.star < DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.PassLevelAndStory)

		return
	end

	arg_7_0._config = arg_7_0._hardEpisode

	arg_7_0:_showEpisodeMode(true, true)
end

function var_0_0._showHardDungeonOpenTip(arg_8_0)
	local var_8_0 = lua_open.configDict[OpenEnum.UnlockFunc.HardDungeon].episodeId
	local var_8_1 = DungeonConfig.instance:getEpisodeDisplay(var_8_0)

	GameFacade.showToast(ToastEnum.DungeonMapLevel, var_8_1)
end

function var_0_0._btnhardmodetipOnClick(arg_9_0)
	if arg_9_0._config == arg_9_0._hardEpisode then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		arg_9_0:_showHardDungeonOpenTip()

		return
	end

	local var_9_0 = DungeonConfig.instance:getHardEpisode(arg_9_0._enterConfig.id)

	if var_9_0 and DungeonModel.instance:episodeIsInLockTime(var_9_0.id) then
		GameFacade.showToastString(arg_9_0._txtLockTime.text)

		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(arg_9_0._config.id) or arg_9_0._episodeInfo.star < DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.PassLevelAndStory)

		return
	end
end

function var_0_0._btnnormalmodeOnClick(arg_10_0)
	if arg_10_0._chapterType == DungeonEnum.ChapterType.Normal then
		return
	end

	arg_10_0._config = arg_10_0._enterConfig

	arg_10_0:_showEpisodeMode(false, true)
end

function var_0_0._showEpisodeMode(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._episodeItemParam.index = arg_11_0._levelIndex
	arg_11_0._episodeItemParam.isHardMode = arg_11_1
	arg_11_0._episodeItemParam.episodeConfig = arg_11_0._config
	arg_11_0._episodeItemParam.immediately = not arg_11_2

	DungeonController.instance:dispatchEvent(DungeonEvent.SwitchHardMode, arg_11_0._episodeItemParam)
	arg_11_0:_updateEpisodeInfo()
	arg_11_0:onUpdate(arg_11_1, arg_11_2)

	if arg_11_2 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_switch)
	end
end

function var_0_0._updateEpisodeInfo(arg_12_0)
	arg_12_0._episodeInfo = DungeonModel.instance:getEpisodeInfo(arg_12_0._config.id)
	arg_12_0._curSpeed = 1
end

function var_0_0._btnlockOnClick(arg_13_0)
	local var_13_0 = DungeonModel.instance:getCantChallengeToast(arg_13_0._config)

	if var_13_0 then
		GameFacade.showToast(ToastEnum.CantChallengeToast, var_13_0)
	end
end

function var_0_0._btnstoryOnClick(arg_14_0)
	local var_14_0 = DungeonModel.instance:hasPassLevelAndStory(arg_14_0._config.id)
	local var_14_1 = {}

	var_14_1.mark = true
	var_14_1.episodeId = arg_14_0._config.id

	StoryController.instance:playStory(arg_14_0._config.afterStory, var_14_1, function()
		arg_14_0:onStoryStatus()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)

		DungeonMapModel.instance.playAfterStory = true

		local var_15_0 = DungeonModel.instance:hasPassLevelAndStory(arg_14_0._config.id)

		if var_15_0 and var_15_0 ~= var_14_0 then
			DungeonController.instance:showUnlockContentToast(arg_14_0._config.id)
		end

		ViewMgr.instance:closeView(arg_14_0.viewName)
	end, arg_14_0)
end

function var_0_0._showStoryPlayBackBtn(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_1 > 0 and StoryModel.instance:isStoryFinished(arg_16_1)

	gohelper.setActive(arg_16_2, var_16_0)

	if var_16_0 then
		DungeonLevelItem.showEpisodeName(arg_16_0._config, arg_16_0._chapterIndex, arg_16_0._levelIndex, arg_16_3)
	end
end

function var_0_0._showMiddleStoryPlayBackBtn(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = StoryConfig.instance:getEpisodeFightStory(arg_17_0._config)
	local var_17_1 = #var_17_0 > 0

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		if not StoryModel.instance:isStoryFinished(iter_17_1) then
			var_17_1 = false

			break
		end
	end

	gohelper.setActive(arg_17_1, var_17_1)

	if var_17_1 then
		DungeonLevelItem.showEpisodeName(arg_17_0._config, arg_17_0._chapterIndex, arg_17_0._levelIndex, arg_17_2)
	end
end

function var_0_0._btnshowticketsOnClick(arg_18_0)
	return
end

function var_0_0._playMainStory(arg_19_0)
	DungeonRpc.instance:sendStartDungeonRequest(arg_19_0._config.chapterId, arg_19_0._config.id)

	local var_19_0 = {}

	var_19_0.mark = true
	var_19_0.episodeId = arg_19_0._config.id

	local var_19_1 = DungeonConfig.instance:getExtendStory(arg_19_0._config.id)

	if var_19_1 then
		local var_19_2 = {
			arg_19_0._config.beforeStory,
			var_19_1
		}

		StoryController.instance:playStories(var_19_2, var_19_0, arg_19_0.onStoryFinished, arg_19_0)
	else
		StoryController.instance:playStory(arg_19_0._config.beforeStory, var_19_0, arg_19_0.onStoryFinished, arg_19_0)
	end
end

function var_0_0.onStoryFinished(arg_20_0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(arg_20_0._config.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	ViewMgr.instance:closeView(arg_20_0.viewName)
end

function var_0_0._btnequipOnClick(arg_21_0)
	if arg_21_0:_checkEquipOverflow() then
		return
	end

	arg_21_0:_enterFight()
end

function var_0_0._checkEquipOverflow(arg_22_0)
	if arg_22_0._chapterType == DungeonEnum.ChapterType.Equip then
		local var_22_0 = EquipModel.instance:getEquips()

		if tabletool.len(var_22_0) >= EquipConfig.instance:getEquipBackpackMaxCount() then
			MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.EquipOverflow, MsgBoxEnum.BoxType.Yes_No, luaLang("p_equipdecompose_decompose"), "DISSOCIATION", nil, nil, arg_22_0._onChooseDecompose, arg_22_0._onCancelDecompose, nil, arg_22_0, arg_22_0, nil)

			return true
		end
	end
end

function var_0_0._onChooseDecompose(arg_23_0)
	EquipController.instance:openEquipDecomposeView()
end

function var_0_0._onCancelDecompose(arg_24_0)
	arg_24_0:_enterFight()
end

function var_0_0._btnstartOnClick(arg_25_0)
	if DungeonEnum.MazeGamePlayEpisode[arg_25_0._config.id] then
		arg_25_0:_playStoryAndOpenMazePlayView()

		return
	end

	if arg_25_0._config.type == DungeonEnum.EpisodeType.Story then
		arg_25_0:_playMainStory()

		return
	end

	local var_25_0, var_25_1, var_25_2 = DungeonModel.instance:getEpisodeChallengeCount(arg_25_0._episodeId)

	if var_25_0 > 0 and var_25_1 > 0 and var_25_1 <= var_25_2 then
		local var_25_3 = ""

		if var_25_0 == DungeonEnum.ChallengeCountLimitType.Daily then
			var_25_3 = luaLang("time_day2")
		elseif var_25_0 == DungeonEnum.ChallengeCountLimitType.Weekly then
			var_25_3 = luaLang("time_week")
		else
			var_25_3 = luaLang("time_month")
		end

		GameFacade.showToast(ToastEnum.DungeonMapLevel3, var_25_3)

		return
	end

	if arg_25_0._chapterType == DungeonEnum.ChapterType.Normal and var_25_0 > 0 and var_25_1 > 0 and var_25_1 < var_25_2 then
		GameFacade.showToast(ToastEnum.DungeonMapLevel4)

		return
	end

	if DungeonConfig.instance:getChapterCO(arg_25_0._config.chapterId).type == DungeonEnum.ChapterType.RoleStory then
		arg_25_0:_startRoleStory()

		return
	end

	if arg_25_0._config.beforeStory > 0 then
		if arg_25_0._config.afterStory > 0 then
			if not StoryModel.instance:isStoryFinished(arg_25_0._config.afterStory) then
				arg_25_0:_playStoryAndEnterFight(arg_25_0._config.beforeStory)

				return
			end
		elseif arg_25_0._episodeInfo.star <= DungeonEnum.StarType.None then
			arg_25_0:_playStoryAndEnterFight(arg_25_0._config.beforeStory)

			return
		end
	end

	if arg_25_0:_checkEquipOverflow() then
		return
	end

	arg_25_0:_enterFight()
end

function var_0_0._playStoryAndOpenMazePlayView(arg_26_0)
	local var_26_0 = arg_26_0._config.beforeStory

	DungeonRpc.instance:sendStartDungeonRequest(arg_26_0._config.chapterId, arg_26_0._config.id)

	if DungeonMazeModel.instance:HasLocalProgress() then
		arg_26_0:_openMazePlayView(true)

		return
	end

	local var_26_1 = {}

	var_26_1.mark = true
	var_26_1.episodeId = arg_26_0._config.id

	StoryController.instance:playStory(var_26_0, var_26_1, arg_26_0._openMazePlayView, arg_26_0)
end

function var_0_0._openMazePlayView(arg_27_0, arg_27_1)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(arg_27_0._config.id)

	local var_27_0 = {
		episodeCfg = arg_27_0._config,
		existProgress = arg_27_1
	}

	DungeonMazeController.instance:openMazeGameView(var_27_0)
end

function var_0_0._startRoleStory(arg_28_0)
	if arg_28_0._config.beforeStory > 0 then
		arg_28_0:_playStoryAndEnterFight(arg_28_0._config.beforeStory, true)

		return
	end

	arg_28_0:_enterFight()
end

function var_0_0._playStoryAndEnterFight(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_2 and StoryModel.instance:isStoryFinished(arg_29_1) then
		arg_29_0:_enterFight()

		return
	end

	local var_29_0 = {}

	var_29_0.mark = true
	var_29_0.episodeId = arg_29_0._config.id

	StoryController.instance:playStory(arg_29_1, var_29_0, arg_29_0._enterFight, arg_29_0)
end

function var_0_0._enterFight(arg_30_0)
	if arg_30_0._enterConfig then
		DungeonModel.instance:setLastSelectMode(arg_30_0._chapterType, arg_30_0._enterConfig.id)
	end

	local var_30_0 = DungeonConfig.instance:getEpisodeCO(arg_30_0._episodeId)

	DungeonFightController.instance:enterFight(var_30_0.chapterId, arg_30_0._episodeId, arg_30_0._curSpeed)
end

function var_0_0._editableInitView(arg_31_0)
	local var_31_0 = gohelper.findChild(arg_31_0.viewGO, "anim")

	arg_31_0._animator = var_31_0 and var_31_0:GetComponent(typeof(UnityEngine.Animator))
	arg_31_0._simageList = arg_31_0:getUserDataTb_()

	arg_31_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_31_0._onCurrencyChange, arg_31_0)
	arg_31_0._simagenormalbg:LoadImage(ResUrl.getDungeonIcon("fubenxinxi_di_putong"))
	arg_31_0._simagehardbg:LoadImage(ResUrl.getDungeonIcon("fubenxinxi_di_kunnan"))

	arg_31_0._rulesimageList = arg_31_0:getUserDataTb_()
	arg_31_0._rulesimagelineList = arg_31_0:getUserDataTb_()
	arg_31_0._rewarditems = arg_31_0:getUserDataTb_()
	arg_31_0._enemyitems = arg_31_0:getUserDataTb_()
	arg_31_0._episodeItemParam = arg_31_0:getUserDataTb_()

	gohelper.removeUIClickAudio(arg_31_0._btncloseview.gameObject)
	gohelper.removeUIClickAudio(arg_31_0._btnnormalmode.gameObject)
	gohelper.removeUIClickAudio(arg_31_0._btnhardmode.gameObject)
	gohelper.addUIClickAudio(arg_31_0._btnstart.gameObject, AudioEnum.HeroGroupUI.Play_UI_Action_Mainstart)
end

function var_0_0._initStar(arg_32_0)
	gohelper.setActive(arg_32_0._gostar, true)

	arg_32_0._starImgList = arg_32_0:getUserDataTb_()

	local var_32_0 = arg_32_0._gostar.transform
	local var_32_1 = var_32_0.childCount

	for iter_32_0 = 1, var_32_1 do
		local var_32_2 = var_32_0:GetChild(iter_32_0 - 1):GetComponent(gohelper.Type_Image)

		table.insert(arg_32_0._starImgList, var_32_2)
	end
end

function var_0_0.showStatus(arg_33_0)
	local var_33_0 = arg_33_0._config.id
	local var_33_1 = DungeonModel.instance:isOpenHardDungeon(arg_33_0._config.chapterId)
	local var_33_2 = var_33_0 and DungeonModel.instance:hasPassLevelAndStory(var_33_0)
	local var_33_3 = DungeonConfig.instance:getEpisodeAdvancedConditionText(var_33_0)
	local var_33_4 = arg_33_0._episodeInfo
	local var_33_5 = DungeonConfig.instance:getHardEpisode(arg_33_0._config.id)
	local var_33_6 = var_33_5 and DungeonModel.instance:getEpisodeInfo(var_33_5.id)
	local var_33_7 = arg_33_0._starImgList[4]
	local var_33_8 = arg_33_0._starImgList[3]
	local var_33_9 = arg_33_0._starImgList[2]

	arg_33_0:_setStar(arg_33_0._starImgList[1], var_33_4.star >= DungeonEnum.StarType.Normal and var_33_2, 1)

	if not string.nilorempty(var_33_3) then
		arg_33_0:_setStar(var_33_9, var_33_4.star >= DungeonEnum.StarType.Advanced and var_33_2, 2)

		if var_33_5 then
			local var_33_10 = DungeonModel.instance:episodeIsInLockTime(var_33_5.id)

			gohelper.setActive(var_33_8, not var_33_10)
			gohelper.setActive(var_33_7, not var_33_10)
		end

		if var_33_6 and var_33_4.star >= DungeonEnum.StarType.Advanced and var_33_1 and var_33_2 then
			arg_33_0:_setStar(var_33_8, var_33_6.star >= DungeonEnum.StarType.Normal, 3)
			arg_33_0:_setStar(var_33_7, var_33_6.star >= DungeonEnum.StarType.Advanced, 4)
		end
	end

	if arg_33_0._simpleConfig then
		local var_33_11 = var_33_4.star >= DungeonEnum.StarType.Normal and var_33_2

		arg_33_0._setStarN(arg_33_0._imgnormalstar1s, var_33_11, 2)
		arg_33_0._setStarN(arg_33_0._imgnormalstar1ru, var_33_11, 2)
		arg_33_0._setStarN(arg_33_0._imgnormalstar1lu, var_33_11, 2)

		local var_33_12 = var_33_4.star >= DungeonEnum.StarType.Advanced and var_33_2

		arg_33_0._setStarN(arg_33_0._imgnormalstar2s, var_33_12, 2)
		arg_33_0._setStarN(arg_33_0._imgnormalstar2ru, var_33_12, 2)
		arg_33_0._setStarN(arg_33_0._imgnormalstar2lu, var_33_12, 2)

		local var_33_13 = DungeonModel.instance:hasPassLevelAndStory(arg_33_0._simpleConfig.id)

		arg_33_0._setStarN(arg_33_0._imgstorystar1s, var_33_13, 1)
		arg_33_0._setStarN(arg_33_0._imgstorystar1u, var_33_13, 1)

		if var_33_5 then
			local var_33_14 = DungeonModel.instance:episodeIsInLockTime(var_33_5.id)

			gohelper.setActive(arg_33_0._imghardstar1s, not var_33_14)
			gohelper.setActive(arg_33_0._imghardstar1u, not var_33_14)
			gohelper.setActive(arg_33_0._imghardstar2s, not var_33_14)
			gohelper.setActive(arg_33_0._imghardstar2u, not var_33_14)

			local var_33_15 = DungeonModel.instance:getEpisodeInfo(var_33_5.id)

			if var_33_15 and var_33_4.star >= DungeonEnum.StarType.Advanced and var_33_1 and var_33_2 then
				local var_33_16 = var_33_15.star >= DungeonEnum.StarType.Normal
				local var_33_17 = var_33_15.star >= DungeonEnum.StarType.Advanced

				arg_33_0._setStarN(arg_33_0._imghardstar1s, var_33_16, 3)
				arg_33_0._setStarN(arg_33_0._imghardstar1u, var_33_16, 3)
				arg_33_0._setStarN(arg_33_0._imghardstar2s, var_33_17, 3)
				arg_33_0._setStarN(arg_33_0._imghardstar2u, var_33_17, 3)
			else
				arg_33_0._setStarN(arg_33_0._imghardstar1s, false, 3)
				arg_33_0._setStarN(arg_33_0._imghardstar1u, false, 3)
				arg_33_0._setStarN(arg_33_0._imghardstar2s, false, 3)
				arg_33_0._setStarN(arg_33_0._imghardstar2u, false, 3)
			end
		end
	end
end

function var_0_0._setStar(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = "#9B9B9B"

	if arg_34_2 then
		var_34_0 = arg_34_3 > 2 and "#FF4343" or "#F97142"
		arg_34_1.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_34_1, var_34_0)
end

function var_0_0._onCurrencyChange(arg_35_0, arg_35_1)
	if not arg_35_1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	arg_35_0:refreshCostPower()
end

function var_0_0.onUpdateParam(arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0.closeThis, arg_36_0)
	arg_36_0:_initInfo()
	arg_36_0.viewContainer:refreshHelp()
	arg_36_0:showStatus()
	arg_36_0:_doUpdate()
	arg_36_0:checkSendGuideEvent()
end

function var_0_0._addRuleItem(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = gohelper.clone(arg_37_0._goruletemp, arg_37_0._gorulelist, arg_37_1.id)

	gohelper.setActive(var_37_0, true)

	local var_37_1 = gohelper.findChildImage(var_37_0, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(var_37_1, "wz_" .. arg_37_2)

	local var_37_2 = gohelper.findChildImage(var_37_0, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_37_2, arg_37_1.icon)
end

function var_0_0._setRuleDescItem(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local var_38_1 = gohelper.clone(arg_38_0._goruleitem, arg_38_0._goruleDescList, arg_38_1.id)

	gohelper.setActive(var_38_1, true)

	local var_38_2 = gohelper.findChildImage(var_38_1, "icon")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_38_2, arg_38_1.icon)

	local var_38_3 = gohelper.findChild(var_38_1, "line")

	table.insert(arg_38_0._rulesimagelineList, var_38_3)

	local var_38_4 = gohelper.findChildImage(var_38_1, "tag")

	UISpriteSetMgr.instance:setCommonSprite(var_38_4, "wz_" .. arg_38_2)

	gohelper.findChildText(var_38_1, "desc").text = SkillConfig.instance:fmtTagDescColor(luaLang("dungeon_add_rule_target_" .. arg_38_2), arg_38_1.desc, var_38_0[arg_38_2])
end

function var_0_0.onOpen(arg_39_0)
	arg_39_0:_initInfo()
	arg_39_0:showStatus()
	arg_39_0:_doUpdate()
	arg_39_0:addEventCb(DungeonController.instance, DungeonEvent.OnUnlockNewChapter, arg_39_0._OnUnlockNewChapter, arg_39_0)
	arg_39_0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_39_0.viewContainer.refreshHelp, arg_39_0.viewContainer)
	arg_39_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_39_0._onUpdateDungeonInfo, arg_39_0)
	arg_39_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshDoubleDropInfo, arg_39_0.showDoubleDrop, arg_39_0)
	NavigateMgr.instance:addEscape(ViewName.DungeonMapLevelView, arg_39_0._btncloseOnClick, arg_39_0)

	if not arg_39_0.viewParam[var_0_1.isJumpOpen] then
		arg_39_0:checkSendGuideEvent()
	end
end

function var_0_0._onUpdateDungeonInfo(arg_40_0)
	local var_40_0 = DungeonConfig.instance:getChapterCO(arg_40_0._config.chapterId)

	arg_40_0:showFree(var_40_0)
end

function var_0_0._OnUnlockNewChapter(arg_41_0)
	ViewMgr.instance:closeView(ViewName.DungeonMapLevelView)
end

function var_0_0._doUpdate(arg_42_0)
	local var_42_0 = arg_42_0.viewParam[5]
	local var_42_1, var_42_2 = DungeonModel.instance:getLastSelectMode()

	if var_42_0 or var_42_1 == DungeonEnum.ChapterType.Hard then
		if arg_42_0._episodeInfo.star == DungeonEnum.StarType.Advanced then
			arg_42_0._hardEpisode = DungeonConfig.instance:getHardEpisode(arg_42_0._enterConfig.id)

			if arg_42_0._hardEpisode then
				arg_42_0._config = arg_42_0._hardEpisode

				arg_42_0:_showEpisodeMode(true, false)
				arg_42_0._animator:Play("dungeonlevel_in_hard", 0, 0)

				return
			end
		end
	elseif var_42_1 == DungeonEnum.ChapterType.Simple and arg_42_0._simpleConfig then
		arg_42_0._config = arg_42_0._simpleConfig

		arg_42_0:_showEpisodeMode(false, false)
		arg_42_0._animator:Play("dungeonlevel_in_nomal", 0, 0)

		return
	end

	if arg_42_0._simpleConfig and arg_42_0:checkFirstDisplay() and DungeonModel.instance:getLastFightEpisodePassMode(arg_42_0._enterConfig) == DungeonEnum.ChapterType.Simple then
		arg_42_0._config = arg_42_0._simpleConfig

		arg_42_0:_showEpisodeMode(false, false)
		arg_42_0._animator:Play("dungeonlevel_in_nomal", 0, 0)

		return
	end

	arg_42_0:onUpdate()
	arg_42_0._animator:Play("dungeonlevel_in_nomal", 0, 0)
end

function var_0_0._initInfo(arg_43_0)
	arg_43_0._enterConfig = arg_43_0.viewParam[1]
	arg_43_0._simpleConfig = DungeonConfig.instance:getSimpleEpisode(arg_43_0._enterConfig)
	arg_43_0._hardEpisode = DungeonConfig.instance:getHardEpisode(arg_43_0._enterConfig.id)
	arg_43_0._config = arg_43_0._enterConfig
	arg_43_0._chapterIndex = arg_43_0.viewParam[3]
	arg_43_0._levelIndex = DungeonConfig.instance:getChapterEpisodeIndexWithSP(arg_43_0._config.chapterId, arg_43_0._config.id)

	arg_43_0:_updateEpisodeInfo()

	if arg_43_0.viewParam[var_0_1.isJumpOpen] then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnJumpChangeFocusEpisodeItem, arg_43_0._config.id)
	end

	arg_43_0:refreshTitleField()
end

var_0_0.BtnOutScreenTime = 0.3

function var_0_0.onUpdate(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = DungeonConfig.instance:getChapterCO(arg_44_0._config.chapterId)
	local var_44_1 = var_44_0.type
	local var_44_2 = var_44_1 == DungeonEnum.ChapterType.Hard

	if arg_44_0._chapterType ~= var_44_1 and arg_44_0._animator then
		local var_44_3 = var_44_2 and "hard" or "normal"

		arg_44_0._animator:Play(var_44_3, 0, 0)
		arg_44_0._animator:Update(0)
	end

	arg_44_0._chapterType = var_44_1

	arg_44_0._gonormal2:SetActive(false)

	if arg_44_2 then
		TaskDispatcher.cancelTask(arg_44_0._delayToSwitchStartBtn, arg_44_0)
		TaskDispatcher.runDelay(arg_44_0._delayToSwitchStartBtn, arg_44_0, var_0_0.BtnOutScreenTime)
	else
		arg_44_0:_delayToSwitchStartBtn()
	end

	gohelper.setActive(arg_44_0._goselectstorybg, var_44_1 == DungeonEnum.ChapterType.Simple)
	gohelper.setActive(arg_44_0._gounselectstorybg, var_44_1 ~= DungeonEnum.ChapterType.Simple)
	gohelper.setActive(arg_44_0._goselectnormalbgN, var_44_1 == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(arg_44_0._gounselectnormalbgr, var_44_1 == DungeonEnum.ChapterType.Simple)
	gohelper.setActive(arg_44_0._gounselectnormalbgl, var_44_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_44_0._goselecthardbgN, var_44_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_44_0._gounselecthardbgN, var_44_1 ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_44_0._simagenormalbg, var_44_1 ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_44_0._simagehardbg, var_44_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_44_0._gohardmodedecorate, var_44_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_44_0._goselecthardbg, var_44_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_44_0._gounselecthardbg, var_44_1 == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(arg_44_0._goselectnormalbg, var_44_1 == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(arg_44_0._gounselectnormalbg, var_44_1 == DungeonEnum.ChapterType.Hard)

	arg_44_0._episodeId = arg_44_0._config.id

	local var_44_4 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local var_44_5 = ResUrl.getCurrencyItemIcon(var_44_4.icon .. "_btn")

	arg_44_0._simagepower2:LoadImage(var_44_5)
	arg_44_0._simagepower3:LoadImage(var_44_5)
	gohelper.setActive(arg_44_0._goboss, arg_44_0:_isBossTypeEpisode(var_44_2))
	gohelper.setActive(arg_44_0._gonormaleye, not var_44_2)
	gohelper.setActive(arg_44_0._gohardeye, var_44_2)

	if arg_44_0._config.battleId ~= 0 then
		gohelper.setActive(arg_44_0._gorecommond, true)

		local var_44_6 = var_44_1 == DungeonEnum.ChapterType.Simple
		local var_44_7 = DungeonHelper.getEpisodeRecommendLevel(arg_44_0._episodeId, var_44_6)

		if var_44_7 ~= 0 then
			gohelper.setActive(arg_44_0._gorecommond, true)

			arg_44_0._txtrecommondlv.text = HeroConfig.instance:getLevelDisplayVariant(var_44_7)
		else
			gohelper.setActive(arg_44_0._gorecommond, false)
		end
	else
		gohelper.setActive(arg_44_0._gorecommond, false)
	end

	arg_44_0:setTitleDesc()
	arg_44_0:showFree(var_44_0)
	arg_44_0:showDoubleDrop()

	arg_44_0._txttitle3.text = string.format("%02d", arg_44_0._levelIndex)
	arg_44_0._txtchapterindex.text = var_44_0.chapterIndex

	if arg_44_2 then
		TaskDispatcher.cancelTask(arg_44_0.refreshCostPower, arg_44_0)
		TaskDispatcher.runDelay(arg_44_0.refreshCostPower, arg_44_0, var_0_0.BtnOutScreenTime)
	else
		arg_44_0:refreshCostPower()
	end

	arg_44_0:refreshChallengeLimit()
	arg_44_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_44_0.refreshChallengeLimit, arg_44_0)
	arg_44_0:onStoryStatus()
end

function var_0_0._isBossTypeEpisode(arg_45_0, arg_45_1)
	if arg_45_1 then
		if arg_45_0._config.preEpisode then
			local var_45_0 = arg_45_0._config.preEpisode

			return DungeonConfig.instance:getEpisodeCO(var_45_0).displayMark == 1
		end

		return arg_45_0._config.displayMark == 1
	else
		return arg_45_0._config.displayMark == 1
	end
end

function var_0_0._delayToSwitchStartBtn(arg_46_0)
	local var_46_0 = arg_46_0._chapterType == DungeonEnum.ChapterType.Hard

	gohelper.setActive(arg_46_0._gostartnormal, not var_46_0)
	gohelper.setActive(arg_46_0._gostarthard, var_46_0)
end

function var_0_0.showDoubleDrop(arg_47_0)
	if not arg_47_0._config then
		return
	end

	local var_47_0 = DungeonConfig.instance:getChapterCO(arg_47_0._config.chapterId)
	local var_47_1, var_47_2, var_47_3 = DoubleDropModel.instance:isShowDoubleByEpisode(arg_47_0._config.id, true)

	gohelper.setActive(arg_47_0._godoubletimes, var_47_1)

	if var_47_1 then
		local var_47_4 = {
			var_47_2,
			var_47_3
		}

		arg_47_0._txtdoubletimes.text = GameUtil.getSubPlaceholderLuaLang(luaLang("double_drop_remain_times"), var_47_4)

		recthelper.setAnchorY(arg_47_0._gooperation.transform, -20)
		recthelper.setAnchorY(arg_47_0._btnequip.transform, -410)
	else
		recthelper.setAnchorY(arg_47_0._gooperation.transform, 0)
		recthelper.setAnchorY(arg_47_0._btnequip.transform, -390)
	end
end

function var_0_0.showFree(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_1.enterAfterFreeLimit > 0

	gohelper.setActive(arg_48_0._gorighttop, not var_48_0)

	arg_48_0._enterAfterFreeLimit = var_48_0

	if not var_48_0 then
		return
	end

	local var_48_1 = DungeonModel.instance:getChapterRemainingNum(arg_48_1.type)

	if var_48_1 <= 0 then
		var_48_0 = false
	end

	gohelper.setActive(arg_48_0._goequipmap, var_48_0)
	gohelper.setActive(arg_48_0._gooperation, not var_48_0)
	gohelper.setActive(arg_48_0._gorighttop, not var_48_0)

	arg_48_0._enterAfterFreeLimit = var_48_0

	if not var_48_0 then
		return
	end

	arg_48_0._txtfightcount.text = var_48_1 == 0 and string.format("<color=#b3afac>%s</color>", var_48_1) or var_48_1

	gohelper.setActive(arg_48_0._gofightcountbg, var_48_1 ~= 0)
	arg_48_0:_refreshFreeCost()
end

function var_0_0._refreshFreeCost(arg_49_0)
	arg_49_0._txtcostcount.text = -1 * arg_49_0._curSpeed
end

function var_0_0.showViewStory(arg_50_0)
	local var_50_0 = StoryConfig.instance:getEpisodeStoryIds(arg_50_0._config)
	local var_50_1 = false

	for iter_50_0, iter_50_1 in ipairs(var_50_0) do
		if StoryModel.instance:isStoryFinished(iter_50_1) then
			var_50_1 = true

			break
		end
	end

	if not var_50_1 then
		return
	end
end

function var_0_0.refreshChallengeLimit(arg_51_0)
	local var_51_0, var_51_1, var_51_2 = DungeonModel.instance:getEpisodeChallengeCount(arg_51_0._episodeId)

	if var_51_0 > 0 and var_51_1 > 0 then
		local var_51_3 = ""

		if var_51_0 == DungeonEnum.ChallengeCountLimitType.Daily then
			var_51_3 = luaLang("daily")
		elseif var_51_0 == DungeonEnum.ChallengeCountLimitType.Weekly then
			var_51_3 = luaLang("weekly")
		else
			var_51_3 = luaLang("monthly")
		end

		arg_51_0._txtchallengecountlimit.text = string.format("%s%s (%d/%d)", var_51_3, luaLang("times"), math.max(0, var_51_1 - arg_51_0._episodeInfo.challengeCount), var_51_1)
	else
		arg_51_0._txtchallengecountlimit.text = ""
	end

	arg_51_0._isCanChallenge, arg_51_0._challengeLockCode = DungeonModel.instance:isCanChallenge(arg_51_0._config)

	gohelper.setActive(arg_51_0._gostart, arg_51_0._isCanChallenge)
	gohelper.setActive(arg_51_0._golock, not arg_51_0._isCanChallenge)
end

function var_0_0.onStoryStatus(arg_52_0)
	local var_52_0 = false
	local var_52_1 = DungeonConfig.instance:getChapterCO(arg_52_0._config.chapterId)

	if arg_52_0._config.afterStory > 0 and not StoryModel.instance:isStoryFinished(arg_52_0._config.afterStory) and arg_52_0._episodeInfo.star > DungeonEnum.StarType.None then
		var_52_0 = true
	end

	gohelper.setActive(arg_52_0._gooperation, not var_52_0 and not arg_52_0._enterAfterFreeLimit)
	gohelper.setActive(arg_52_0._btnstory, var_52_0)

	local var_52_2 = arg_52_0._chapterType == DungeonEnum.ChapterType.Hard

	if var_52_0 then
		arg_52_0:refreshHardMode()
		arg_52_0._btnhardmode.gameObject:SetActive(false)
	elseif not var_52_2 then
		arg_52_0:refreshHardMode()
	else
		arg_52_0._btnHardModeActive = false

		TaskDispatcher.cancelTask(arg_52_0._delaySetActive, arg_52_0)
		TaskDispatcher.runDelay(arg_52_0._delaySetActive, arg_52_0, 0.2)
	end

	arg_52_0:showViewStory()

	local var_52_3, var_52_4, var_52_5 = DungeonModel.instance:getChapterListTypes()
	local var_52_6 = DungeonModel.instance:chapterListIsRoleStory()
	local var_52_7 = (not var_52_3 or arg_52_0._config.type ~= DungeonEnum.EpisodeType.Story) and not var_52_4 and not var_52_5 and not var_52_6

	gohelper.setActive(arg_52_0._goswitch, arg_52_0._simpleConfig and var_52_7)
	gohelper.setActive(arg_52_0._gonormal, not arg_52_0._simpleConfig and var_52_7)
	gohelper.setActive(arg_52_0._gohard, not arg_52_0._simpleConfig and var_52_7)
	gohelper.setActive(arg_52_0._gostar, not arg_52_0._simpleConfig and var_52_7)
	recthelper.setAnchorY(arg_52_0._scrolldesc.transform, var_52_7 and 8 or 65)
	recthelper.setAnchorY(arg_52_0._gorecommond.transform, var_52_7 and 87.3 or 168.4)
	TaskDispatcher.cancelTask(arg_52_0._checkLockTime, arg_52_0)
	TaskDispatcher.runRepeat(arg_52_0._checkLockTime, arg_52_0, 1)
end

function var_0_0._checkLockTime(arg_53_0)
	local var_53_0 = DungeonConfig.instance:getHardEpisode(arg_53_0._enterConfig.id)
	local var_53_1 = arg_53_0.isInLockTime and true or false

	if var_53_0 and DungeonModel.instance:episodeIsInLockTime(var_53_0.id) then
		arg_53_0.isInLockTime = true
	else
		arg_53_0.isInLockTime = false
	end

	if var_53_1 ~= arg_53_0.isInLockTime then
		arg_53_0:showStatus()
		arg_53_0:onStoryStatus()
	elseif arg_53_0.isInLockTime then
		local var_53_2 = ServerTime.now()
		local var_53_3 = string.splitToNumber(var_53_0.lockTime, "#")

		arg_53_0._txtLockTime.text = formatLuaLang("seasonmainview_timeopencondition", string.format("%s%s", TimeUtil.secondToRoughTime2(var_53_3[2] / 1000 - ServerTime.now())))
	end
end

function var_0_0.refreshHardMode(arg_54_0)
	arg_54_0._hardEpisode = DungeonConfig.instance:getHardEpisode(arg_54_0._enterConfig.id)

	local var_54_0 = false

	if arg_54_0._episodeInfo.star == DungeonEnum.StarType.Advanced then
		local var_54_1 = DungeonModel.instance:isOpenHardDungeon(arg_54_0._config.chapterId)

		var_54_0 = arg_54_0._hardEpisode ~= nil and var_54_1
	end

	if arg_54_0._hardEpisode and DungeonModel.instance:episodeIsInLockTime(arg_54_0._hardEpisode.id) then
		var_54_0 = false

		gohelper.setActive(arg_54_0._txtLockTime, true)

		local var_54_2 = ServerTime.now()
		local var_54_3 = string.splitToNumber(arg_54_0._hardEpisode.lockTime, "#")

		arg_54_0._txtLockTime.text = formatLuaLang("seasonmainview_timeopencondition", string.format("%s%s", TimeUtil.secondToRoughTime2(var_54_3[2] / 1000 - ServerTime.now())))
		arg_54_0._golockbg:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	else
		gohelper.setActive(arg_54_0._txtLockTime, false)

		arg_54_0._golockbg:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0.1
	end

	arg_54_0._btnhardmode.gameObject:SetActive(var_54_0)
	gohelper.setActive(arg_54_0._golockbg, not var_54_0)

	arg_54_0._gohard:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = var_54_0 and 1 or 0.3
	arg_54_0._btnHardModeActive = var_54_0
end

function var_0_0._delaySetActive(arg_55_0)
	arg_55_0._btnhardmode.gameObject:SetActive(arg_55_0._btnHardModeActive)
end

function var_0_0.refreshCostPower(arg_56_0)
	local var_56_0 = string.split(arg_56_0._config.cost, "|")
	local var_56_1 = string.split(var_56_0[1], "#")
	local var_56_2 = tonumber(var_56_1[3] or 0) * arg_56_0._curSpeed

	arg_56_0._txtusepower.text = "-" .. var_56_2
	arg_56_0._txtusepowerhard.text = "-" .. var_56_2

	if var_56_2 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(arg_56_0._txtusepower, "#070706")
		SLFramework.UGUI.GuiHelper.SetColor(arg_56_0._txtusepowerhard, "#FFEAEA")
		gohelper.setActive(arg_56_0._gonormallackpower, false)
		gohelper.setActive(arg_56_0._gohardlackpower, false)
	else
		local var_56_3 = arg_56_0._chapterType == DungeonEnum.ChapterType.Hard

		SLFramework.UGUI.GuiHelper.SetColor(arg_56_0._txtusepower, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(arg_56_0._txtusepowerhard, "#C44945")
		gohelper.setActive(arg_56_0._gonormallackpower, not var_56_3)
		gohelper.setActive(arg_56_0._gohardlackpower, var_56_3)
	end
end

function var_0_0.onClose(arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0.closeThis, arg_57_0)
	AudioMgr.instance:trigger(arg_57_0:getCurrentChapterListTypeAudio().onClose)

	arg_57_0._episodeItemParam.isHardMode = false

	DungeonController.instance:dispatchEvent(DungeonEvent.SwitchHardMode, arg_57_0._episodeItemParam)

	if arg_57_0._rewarditems then
		for iter_57_0, iter_57_1 in ipairs(arg_57_0._rewarditems) do
			TaskDispatcher.cancelTask(iter_57_1.refreshLimitTime, iter_57_1)
		end
	end

	arg_57_0._chapterType = nil
end

function var_0_0.onCloseFinish(arg_58_0)
	return
end

function var_0_0.clearRuleList(arg_59_0)
	arg_59_0._simageList = arg_59_0:getUserDataTb_()

	for iter_59_0, iter_59_1 in pairs(arg_59_0._rulesimageList) do
		iter_59_1:UnLoadImage()
	end

	arg_59_0._rulesimageList = arg_59_0:getUserDataTb_()
	arg_59_0._rulesimagelineList = arg_59_0:getUserDataTb_()

	gohelper.destroyAllChildren(arg_59_0._gorulelist)
	gohelper.destroyAllChildren(arg_59_0._goruleDescList)
end

function var_0_0.onDestroyView(arg_60_0)
	arg_60_0._simagepower2:UnLoadImage()
	arg_60_0._simagepower3:UnLoadImage()
	arg_60_0._simagenormalbg:UnLoadImage()
	arg_60_0._simagehardbg:UnLoadImage()

	for iter_60_0, iter_60_1 in pairs(arg_60_0._rulesimageList) do
		iter_60_1:UnLoadImage()
	end

	for iter_60_2 = 1, #arg_60_0._enemyitems do
		arg_60_0._enemyitems[iter_60_2].simagemonsterhead:UnLoadImage()
	end

	TaskDispatcher.cancelTask(arg_60_0._delaySetActive, arg_60_0)
	TaskDispatcher.cancelTask(arg_60_0._delayToSwitchStartBtn, arg_60_0)
	TaskDispatcher.cancelTask(arg_60_0.refreshCostPower, arg_60_0)
	TaskDispatcher.cancelTask(arg_60_0._checkLockTime, arg_60_0)
end

function var_0_0.refreshTitleField(arg_61_0)
	local var_61_0 = GameUtil.utf8len(arg_61_0._config.name) > 7 and arg_61_0.titleList[2] or arg_61_0.titleList[1]

	if var_61_0 == arg_61_0.curTitleItem then
		return
	end

	for iter_61_0, iter_61_1 in ipairs(arg_61_0.titleList) do
		gohelper.setActive(iter_61_1._go, iter_61_1 == var_61_0)
	end

	arg_61_0.curTitleItem = var_61_0
	arg_61_0._txttitle1 = var_61_0._txttitle1
	arg_61_0._txttitle3 = var_61_0._txttitle3
	arg_61_0._txtchapterindex = var_61_0._txtchapterindex
	arg_61_0._txttitle4 = var_61_0._txttitle4
	arg_61_0._gostar = var_61_0._gostar

	arg_61_0:_initStar()
end

function var_0_0.setTitleDesc(arg_62_0)
	arg_62_0:refreshTitleField()

	local var_62_0
	local var_62_1 = DungeonConfig.instance:getChapterTypeByEpisodeId(arg_62_0._config.id)

	if var_62_1 == DungeonEnum.ChapterType.Hard then
		var_62_0 = DungeonConfig.instance:getEpisodeCO(arg_62_0._config.preEpisode)
	elseif var_62_1 == DungeonEnum.ChapterType.Simple then
		var_62_0 = DungeonConfig.instance:getEpisodeCO(arg_62_0._config.normalEpisodeId)
	else
		var_62_0 = arg_62_0._config
	end

	arg_62_0._txtdesc.text = var_62_0.desc
	arg_62_0._txttitle4.text = var_62_0.name_En

	local var_62_2 = GameUtil.utf8sub(var_62_0.name, 1, 1)
	local var_62_3 = ""
	local var_62_4

	if GameUtil.utf8len(var_62_0.name) >= 2 then
		var_62_3 = string.format("%s", GameUtil.utf8sub(var_62_0.name, 2, GameUtil.utf8len(var_62_0.name) - 1))
	end

	arg_62_0._txttitle1.text = string.format("<size=100>%s</size>%s", var_62_2, var_62_3)

	ZProj.UGUIHelper.RebuildLayout(arg_62_0._txttitle1.transform)
	ZProj.UGUIHelper.RebuildLayout(arg_62_0._txttitle4.transform)

	if GameUtil.utf8len(arg_62_0._config.name) > 2 then
		local var_62_5 = recthelper.getAnchorX(arg_62_0._txttitle1.transform) + recthelper.getWidth(arg_62_0._txttitle1.transform)
	else
		local var_62_6 = recthelper.getAnchorX(arg_62_0._txttitle1.transform) + recthelper.getWidth(arg_62_0._txttitle1.transform) + recthelper.getAnchorX(arg_62_0._txttitle4.transform)
	end

	arg_62_0:_setTitle_overseas(var_62_2, var_62_3)
end

function var_0_0.getCurrentChapterListTypeAudio(arg_63_0)
	local var_63_0, var_63_1, var_63_2 = DungeonModel.instance:getChapterListTypes()
	local var_63_3

	if var_63_0 then
		var_63_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Story]
	elseif var_63_1 then
		var_63_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Resource]
	elseif var_63_2 then
		var_63_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Insight]
	else
		var_63_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Story]
	end

	return var_63_3
end

function var_0_0._setStarN(arg_64_0, arg_64_1, arg_64_2)
	local var_64_0 = "#9B9B9B"

	if arg_64_1 then
		var_64_0 = arg_64_2 == 1 and "#efb974" or arg_64_2 == 2 and "#F97142" or "#FF4343"
		arg_64_0.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_64_0, var_64_0)
end

function var_0_0._btnHardOnClick(arg_65_0)
	if arg_65_0._chapterType == DungeonEnum.ChapterType.Hard then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		arg_65_0:_showHardDungeonOpenTip()

		return
	end

	local var_65_0 = DungeonConfig.instance:getHardEpisode(arg_65_0._enterConfig.id)

	if var_65_0 and DungeonModel.instance:episodeIsInLockTime(var_65_0.id) then
		GameFacade.showToastString(arg_65_0._txtLockTime.text)

		return
	end

	local var_65_1 = DungeonModel.instance:getEpisodeInfo(arg_65_0._enterConfig.id)

	if not DungeonModel.instance:hasPassLevelAndStory(arg_65_0._enterConfig.id) or var_65_1.star < DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.PassLevelAndStory)

		return
	end

	arg_65_0._config = arg_65_0._hardEpisode

	arg_65_0:_showEpisodeMode(true, true)
end

function var_0_0._btnNormalOnClick(arg_66_0)
	if arg_66_0._chapterType == DungeonEnum.ChapterType.Normal then
		return
	end

	arg_66_0._config = arg_66_0._enterConfig

	arg_66_0:_showEpisodeMode(false, true)
end

function var_0_0._btnSimpleOnClick(arg_67_0)
	if arg_67_0._chapterType == DungeonEnum.ChapterType.Simple then
		return
	end

	arg_67_0._config = arg_67_0._simpleConfig

	arg_67_0:_showEpisodeMode(false, true)
end

function var_0_0.checkSendGuideEvent(arg_68_0)
	if not arg_68_0._config then
		return
	end

	local var_68_0 = DungeonModel.instance:hasPassLevelAndStory(arg_68_0._config.id)
	local var_68_1 = DungeonConfig.instance:getEpisodeBattleId(arg_68_0._config.id)
	local var_68_2 = arg_68_0._config.chapterId

	if DungeonConfig.instance:getChapterCO(var_68_2).type == DungeonEnum.ChapterType.Normal and not var_68_0 and var_68_1 and var_68_1 ~= 0 then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnOpenUnPassLevelGuide)
	end
end

function var_0_0.checkFirstDisplay(arg_69_0)
	local var_69_0 = PlayerModel.instance:getMyUserId()
	local var_69_1 = PlayerPrefsKey.DungeonMapLevelFirstShow .. arg_69_0._simpleConfig.id .. var_69_0

	if PlayerPrefsHelper.getNumber(var_69_1, 0) == 0 then
		PlayerPrefsHelper.setNumber(var_69_1, 1)

		return true
	end

	return false
end

return var_0_0
