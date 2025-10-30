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
	var_2_0._txttitle3 = gohelper.findChildText(arg_2_0.viewGO, "anim/right/title/#txt_title3")
	var_2_0._txtchapterindex = gohelper.findChildText(arg_2_0.viewGO, "anim/right/title/#txt_title3/#txt_chapterindex")
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
	if CommandStationController.instance:chapterInCommandStation(arg_30_0._enterChapterId) then
		CommandStationController.instance:setRecordEpisodeId(arg_30_0._enterConfig.id)
	end

	if DungeonController.checkEpisodeFiveHero(arg_30_0._episodeId) then
		local var_30_0 = ModuleEnum.HeroGroupSnapshotType.FiveHero

		HeroGroupRpc.instance:sendGetHeroGroupSnapshotListRequest(var_30_0, arg_30_0._onRecvMsg, arg_30_0)
	else
		arg_30_0:_reallyEnterFight()
	end
end

function var_0_0._onRecvMsg(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if arg_31_2 == 0 then
		arg_31_0:_reallyEnterFight()
	end
end

function var_0_0._reallyEnterFight(arg_32_0)
	if arg_32_0._enterConfig then
		DungeonModel.instance:setLastSelectMode(arg_32_0._chapterType, arg_32_0._enterConfig.id)
	end

	local var_32_0 = DungeonConfig.instance:getEpisodeCO(arg_32_0._episodeId)

	DungeonFightController.instance:enterFight(var_32_0.chapterId, arg_32_0._episodeId, arg_32_0._curSpeed)
end

function var_0_0._editableInitView(arg_33_0)
	local var_33_0 = gohelper.findChild(arg_33_0.viewGO, "anim")

	arg_33_0._animator = var_33_0 and var_33_0:GetComponent(typeof(UnityEngine.Animator))
	arg_33_0._simageList = arg_33_0:getUserDataTb_()

	arg_33_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_33_0._onCurrencyChange, arg_33_0)
	arg_33_0._simagenormalbg:LoadImage(ResUrl.getDungeonIcon("fubenxinxi_di_putong"))
	arg_33_0._simagehardbg:LoadImage(ResUrl.getDungeonIcon("fubenxinxi_di_kunnan"))

	arg_33_0._rulesimageList = arg_33_0:getUserDataTb_()
	arg_33_0._rulesimagelineList = arg_33_0:getUserDataTb_()
	arg_33_0._rewarditems = arg_33_0:getUserDataTb_()
	arg_33_0._enemyitems = arg_33_0:getUserDataTb_()
	arg_33_0._episodeItemParam = arg_33_0:getUserDataTb_()

	gohelper.removeUIClickAudio(arg_33_0._btncloseview.gameObject)
	gohelper.removeUIClickAudio(arg_33_0._btnnormalmode.gameObject)
	gohelper.removeUIClickAudio(arg_33_0._btnhardmode.gameObject)
	gohelper.addUIClickAudio(arg_33_0._btnstart.gameObject, AudioEnum.HeroGroupUI.Play_UI_Action_Mainstart)
end

function var_0_0._initStar(arg_34_0)
	gohelper.setActive(arg_34_0._gostar, true)

	arg_34_0._starImgList = arg_34_0:getUserDataTb_()

	local var_34_0 = arg_34_0._gostar.transform
	local var_34_1 = var_34_0.childCount

	for iter_34_0 = 1, var_34_1 do
		local var_34_2 = var_34_0:GetChild(iter_34_0 - 1):GetComponent(gohelper.Type_Image)

		table.insert(arg_34_0._starImgList, var_34_2)
	end
end

function var_0_0.showStatus(arg_35_0)
	local var_35_0 = arg_35_0._config.id
	local var_35_1 = DungeonModel.instance:isOpenHardDungeon(arg_35_0._config.chapterId)
	local var_35_2 = var_35_0 and DungeonModel.instance:hasPassLevelAndStory(var_35_0)
	local var_35_3 = DungeonConfig.instance:getEpisodeAdvancedConditionText(var_35_0)
	local var_35_4 = arg_35_0._episodeInfo
	local var_35_5 = DungeonConfig.instance:getHardEpisode(arg_35_0._config.id)
	local var_35_6 = var_35_5 and DungeonModel.instance:getEpisodeInfo(var_35_5.id)
	local var_35_7 = arg_35_0._starImgList[4]
	local var_35_8 = arg_35_0._starImgList[3]
	local var_35_9 = arg_35_0._starImgList[2]

	arg_35_0:_setStar(arg_35_0._starImgList[1], var_35_4.star >= DungeonEnum.StarType.Normal and var_35_2, 1)

	if not string.nilorempty(var_35_3) then
		arg_35_0:_setStar(var_35_9, var_35_4.star >= DungeonEnum.StarType.Advanced and var_35_2, 2)

		if var_35_5 then
			local var_35_10 = DungeonModel.instance:episodeIsInLockTime(var_35_5.id)

			gohelper.setActive(var_35_8, not var_35_10)
			gohelper.setActive(var_35_7, not var_35_10)
		end

		if var_35_6 and var_35_4.star >= DungeonEnum.StarType.Advanced and var_35_1 and var_35_2 then
			arg_35_0:_setStar(var_35_8, var_35_6.star >= DungeonEnum.StarType.Normal, 3)
			arg_35_0:_setStar(var_35_7, var_35_6.star >= DungeonEnum.StarType.Advanced, 4)
		end
	end

	if arg_35_0._simpleConfig then
		local var_35_11 = var_35_4.star >= DungeonEnum.StarType.Normal and var_35_2

		arg_35_0._setStarN(arg_35_0._imgnormalstar1s, var_35_11, 2)
		arg_35_0._setStarN(arg_35_0._imgnormalstar1ru, var_35_11, 2)
		arg_35_0._setStarN(arg_35_0._imgnormalstar1lu, var_35_11, 2)

		local var_35_12 = var_35_4.star >= DungeonEnum.StarType.Advanced and var_35_2

		arg_35_0._setStarN(arg_35_0._imgnormalstar2s, var_35_12, 2)
		arg_35_0._setStarN(arg_35_0._imgnormalstar2ru, var_35_12, 2)
		arg_35_0._setStarN(arg_35_0._imgnormalstar2lu, var_35_12, 2)

		local var_35_13 = DungeonModel.instance:hasPassLevelAndStory(arg_35_0._simpleConfig.id)

		arg_35_0._setStarN(arg_35_0._imgstorystar1s, var_35_13, 1)
		arg_35_0._setStarN(arg_35_0._imgstorystar1u, var_35_13, 1)

		if var_35_5 then
			local var_35_14 = DungeonModel.instance:episodeIsInLockTime(var_35_5.id)

			gohelper.setActive(arg_35_0._imghardstar1s, not var_35_14)
			gohelper.setActive(arg_35_0._imghardstar1u, not var_35_14)
			gohelper.setActive(arg_35_0._imghardstar2s, not var_35_14)
			gohelper.setActive(arg_35_0._imghardstar2u, not var_35_14)

			local var_35_15 = DungeonModel.instance:getEpisodeInfo(var_35_5.id)

			if var_35_15 and var_35_4.star >= DungeonEnum.StarType.Advanced and var_35_1 and var_35_2 then
				local var_35_16 = var_35_15.star >= DungeonEnum.StarType.Normal
				local var_35_17 = var_35_15.star >= DungeonEnum.StarType.Advanced

				arg_35_0._setStarN(arg_35_0._imghardstar1s, var_35_16, 3)
				arg_35_0._setStarN(arg_35_0._imghardstar1u, var_35_16, 3)
				arg_35_0._setStarN(arg_35_0._imghardstar2s, var_35_17, 3)
				arg_35_0._setStarN(arg_35_0._imghardstar2u, var_35_17, 3)
			else
				arg_35_0._setStarN(arg_35_0._imghardstar1s, false, 3)
				arg_35_0._setStarN(arg_35_0._imghardstar1u, false, 3)
				arg_35_0._setStarN(arg_35_0._imghardstar2s, false, 3)
				arg_35_0._setStarN(arg_35_0._imghardstar2u, false, 3)
			end
		end
	end
end

function var_0_0._setStar(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = "#9B9B9B"

	if arg_36_2 then
		var_36_0 = arg_36_3 > 2 and "#FF4343" or "#F97142"
		arg_36_1.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_36_1, var_36_0)
end

function var_0_0._onCurrencyChange(arg_37_0, arg_37_1)
	if not arg_37_1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	arg_37_0:refreshCostPower()
end

function var_0_0.onUpdateParam(arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0.closeThis, arg_38_0)
	arg_38_0:_initInfo()
	arg_38_0.viewContainer:refreshHelp()
	arg_38_0:showStatus()
	arg_38_0:_doUpdate()
	arg_38_0:checkSendGuideEvent()
end

function var_0_0._addRuleItem(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = gohelper.clone(arg_39_0._goruletemp, arg_39_0._gorulelist, arg_39_1.id)

	gohelper.setActive(var_39_0, true)

	local var_39_1 = gohelper.findChildImage(var_39_0, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(var_39_1, "wz_" .. arg_39_2)

	local var_39_2 = gohelper.findChildImage(var_39_0, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_39_2, arg_39_1.icon)
end

function var_0_0._setRuleDescItem(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local var_40_1 = gohelper.clone(arg_40_0._goruleitem, arg_40_0._goruleDescList, arg_40_1.id)

	gohelper.setActive(var_40_1, true)

	local var_40_2 = gohelper.findChildImage(var_40_1, "icon")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_40_2, arg_40_1.icon)

	local var_40_3 = gohelper.findChild(var_40_1, "line")

	table.insert(arg_40_0._rulesimagelineList, var_40_3)

	local var_40_4 = gohelper.findChildImage(var_40_1, "tag")

	UISpriteSetMgr.instance:setCommonSprite(var_40_4, "wz_" .. arg_40_2)

	gohelper.findChildText(var_40_1, "desc").text = SkillConfig.instance:fmtTagDescColor(luaLang("dungeon_add_rule_target_" .. arg_40_2), arg_40_1.desc, var_40_0[arg_40_2])
end

function var_0_0.onOpen(arg_41_0)
	arg_41_0:_initInfo()
	arg_41_0:showStatus()
	arg_41_0:_doUpdate()
	arg_41_0:addEventCb(DungeonController.instance, DungeonEvent.OnUnlockNewChapter, arg_41_0._OnUnlockNewChapter, arg_41_0)
	arg_41_0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_41_0.viewContainer.refreshHelp, arg_41_0.viewContainer)
	arg_41_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_41_0._onUpdateDungeonInfo, arg_41_0)
	arg_41_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshDoubleDropInfo, arg_41_0.showDoubleDrop, arg_41_0)
	NavigateMgr.instance:addEscape(ViewName.DungeonMapLevelView, arg_41_0._btncloseOnClick, arg_41_0)

	if not arg_41_0.viewParam[var_0_1.isJumpOpen] then
		arg_41_0:checkSendGuideEvent()
	end
end

function var_0_0._onUpdateDungeonInfo(arg_42_0)
	local var_42_0 = DungeonConfig.instance:getChapterCO(arg_42_0._config.chapterId)

	arg_42_0:showFree(var_42_0)
end

function var_0_0._OnUnlockNewChapter(arg_43_0)
	ViewMgr.instance:closeView(ViewName.DungeonMapLevelView)
end

function var_0_0._doUpdate(arg_44_0)
	local var_44_0 = arg_44_0.viewParam[5]
	local var_44_1, var_44_2 = DungeonModel.instance:getLastSelectMode()

	if var_44_0 or var_44_1 == DungeonEnum.ChapterType.Hard then
		if arg_44_0._episodeInfo.star == DungeonEnum.StarType.Advanced then
			arg_44_0._hardEpisode = DungeonConfig.instance:getHardEpisode(arg_44_0._enterConfig.id)

			if arg_44_0._hardEpisode then
				arg_44_0._config = arg_44_0._hardEpisode

				arg_44_0:_showEpisodeMode(true, false)
				arg_44_0._animator:Play("dungeonlevel_in_hard", 0, 0)

				return
			end
		end
	elseif var_44_1 == DungeonEnum.ChapterType.Simple and arg_44_0._simpleConfig then
		arg_44_0._config = arg_44_0._simpleConfig

		arg_44_0:_showEpisodeMode(false, false)
		arg_44_0._animator:Play("dungeonlevel_in_nomal", 0, 0)

		return
	end

	if arg_44_0._simpleConfig and arg_44_0:checkFirstDisplay() and DungeonModel.instance:getLastFightEpisodePassMode(arg_44_0._enterConfig) == DungeonEnum.ChapterType.Simple then
		arg_44_0._config = arg_44_0._simpleConfig

		arg_44_0:_showEpisodeMode(false, false)
		arg_44_0._animator:Play("dungeonlevel_in_nomal", 0, 0)

		return
	end

	arg_44_0:onUpdate()
	arg_44_0._animator:Play("dungeonlevel_in_nomal", 0, 0)
end

function var_0_0._initInfo(arg_45_0)
	arg_45_0._enterConfig = arg_45_0.viewParam[1]
	arg_45_0._enterChapterId = arg_45_0._enterConfig.chapterId
	arg_45_0._simpleConfig = DungeonConfig.instance:getSimpleEpisode(arg_45_0._enterConfig)
	arg_45_0._hardEpisode = DungeonConfig.instance:getHardEpisode(arg_45_0._enterConfig.id)
	arg_45_0._config = arg_45_0._enterConfig
	arg_45_0._chapterIndex = arg_45_0.viewParam[3]
	arg_45_0._levelIndex = DungeonConfig.instance:getChapterEpisodeIndexWithSP(arg_45_0._config.chapterId, arg_45_0._config.id)

	arg_45_0:_updateEpisodeInfo()

	if arg_45_0.viewParam[var_0_1.isJumpOpen] then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnJumpChangeFocusEpisodeItem, arg_45_0._config.id)
	end

	arg_45_0:refreshTitleField()
end

var_0_0.BtnOutScreenTime = 0.3

function var_0_0.onUpdate(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = DungeonConfig.instance:getChapterCO(arg_46_0._config.chapterId)
	local var_46_1 = var_46_0.type
	local var_46_2 = var_46_1 == DungeonEnum.ChapterType.Hard

	if arg_46_0._chapterType ~= var_46_1 and arg_46_0._animator then
		local var_46_3 = var_46_2 and "hard" or "normal"

		arg_46_0._animator:Play(var_46_3, 0, 0)
		arg_46_0._animator:Update(0)
	end

	arg_46_0._chapterType = var_46_1

	arg_46_0._gonormal2:SetActive(false)

	if arg_46_2 then
		TaskDispatcher.cancelTask(arg_46_0._delayToSwitchStartBtn, arg_46_0)
		TaskDispatcher.runDelay(arg_46_0._delayToSwitchStartBtn, arg_46_0, var_0_0.BtnOutScreenTime)
	else
		arg_46_0:_delayToSwitchStartBtn()
	end

	gohelper.setActive(arg_46_0._goselectstorybg, var_46_1 == DungeonEnum.ChapterType.Simple)
	gohelper.setActive(arg_46_0._gounselectstorybg, var_46_1 ~= DungeonEnum.ChapterType.Simple)
	gohelper.setActive(arg_46_0._goselectnormalbgN, var_46_1 == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(arg_46_0._gounselectnormalbgr, var_46_1 == DungeonEnum.ChapterType.Simple)
	gohelper.setActive(arg_46_0._gounselectnormalbgl, var_46_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_46_0._goselecthardbgN, var_46_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_46_0._gounselecthardbgN, var_46_1 ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_46_0._simagenormalbg, var_46_1 ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_46_0._simagehardbg, var_46_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_46_0._gohardmodedecorate, var_46_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_46_0._goselecthardbg, var_46_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_46_0._gounselecthardbg, var_46_1 == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(arg_46_0._goselectnormalbg, var_46_1 == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(arg_46_0._gounselectnormalbg, var_46_1 == DungeonEnum.ChapterType.Hard)

	arg_46_0._episodeId = arg_46_0._config.id

	local var_46_4 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local var_46_5 = ResUrl.getCurrencyItemIcon(var_46_4.icon .. "_btn")

	arg_46_0._simagepower2:LoadImage(var_46_5)
	arg_46_0._simagepower3:LoadImage(var_46_5)
	gohelper.setActive(arg_46_0._goboss, arg_46_0:_isBossTypeEpisode(var_46_2))
	gohelper.setActive(arg_46_0._gonormaleye, not var_46_2)
	gohelper.setActive(arg_46_0._gohardeye, var_46_2)

	if arg_46_0._config.battleId ~= 0 then
		gohelper.setActive(arg_46_0._gorecommond, true)

		local var_46_6 = var_46_1 == DungeonEnum.ChapterType.Simple
		local var_46_7 = DungeonHelper.getEpisodeRecommendLevel(arg_46_0._episodeId, var_46_6)

		if var_46_7 ~= 0 then
			gohelper.setActive(arg_46_0._gorecommond, true)

			arg_46_0._txtrecommondlv.text = HeroConfig.instance:getLevelDisplayVariant(var_46_7)
		else
			gohelper.setActive(arg_46_0._gorecommond, false)
		end
	else
		gohelper.setActive(arg_46_0._gorecommond, false)
	end

	arg_46_0:setTitleDesc()
	arg_46_0:showFree(var_46_0)
	arg_46_0:showDoubleDrop()

	arg_46_0._txttitle3.text = string.format("%02d", arg_46_0._levelIndex)
	arg_46_0._txtchapterindex.text = var_46_0.chapterIndex

	if arg_46_2 then
		TaskDispatcher.cancelTask(arg_46_0.refreshCostPower, arg_46_0)
		TaskDispatcher.runDelay(arg_46_0.refreshCostPower, arg_46_0, var_0_0.BtnOutScreenTime)
	else
		arg_46_0:refreshCostPower()
	end

	arg_46_0:refreshChallengeLimit()
	arg_46_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_46_0.refreshChallengeLimit, arg_46_0)
	arg_46_0:onStoryStatus()
end

function var_0_0._isBossTypeEpisode(arg_47_0, arg_47_1)
	if arg_47_1 then
		if arg_47_0._config.preEpisode then
			local var_47_0 = arg_47_0._config.preEpisode

			return DungeonConfig.instance:getEpisodeCO(var_47_0).displayMark == 1
		end

		return arg_47_0._config.displayMark == 1
	else
		return arg_47_0._config.displayMark == 1
	end
end

function var_0_0._delayToSwitchStartBtn(arg_48_0)
	local var_48_0 = arg_48_0._chapterType == DungeonEnum.ChapterType.Hard

	gohelper.setActive(arg_48_0._gostartnormal, not var_48_0)
	gohelper.setActive(arg_48_0._gostarthard, var_48_0)
end

function var_0_0.showDoubleDrop(arg_49_0)
	if not arg_49_0._config then
		return
	end

	local var_49_0 = DungeonConfig.instance:getChapterCO(arg_49_0._config.chapterId)
	local var_49_1, var_49_2, var_49_3 = DoubleDropModel.instance:isShowDoubleByEpisode(arg_49_0._config.id, true)

	gohelper.setActive(arg_49_0._godoubletimes, var_49_1)

	if var_49_1 then
		local var_49_4 = {
			var_49_2,
			var_49_3
		}

		arg_49_0._txtdoubletimes.text = GameUtil.getSubPlaceholderLuaLang(luaLang("double_drop_remain_times"), var_49_4)

		recthelper.setAnchorY(arg_49_0._gooperation.transform, -20)
		recthelper.setAnchorY(arg_49_0._btnequip.transform, -410)
	else
		recthelper.setAnchorY(arg_49_0._gooperation.transform, 0)
		recthelper.setAnchorY(arg_49_0._btnequip.transform, -390)
	end
end

function var_0_0.showFree(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_1.enterAfterFreeLimit > 0

	gohelper.setActive(arg_50_0._gorighttop, not var_50_0)

	arg_50_0._enterAfterFreeLimit = var_50_0

	if not var_50_0 then
		return
	end

	local var_50_1 = DungeonModel.instance:getChapterRemainingNum(arg_50_1.type)

	if var_50_1 <= 0 then
		var_50_0 = false
	end

	gohelper.setActive(arg_50_0._goequipmap, var_50_0)
	gohelper.setActive(arg_50_0._gooperation, not var_50_0)
	gohelper.setActive(arg_50_0._gorighttop, not var_50_0)

	arg_50_0._enterAfterFreeLimit = var_50_0

	if not var_50_0 then
		return
	end

	arg_50_0._txtfightcount.text = var_50_1 == 0 and string.format("<color=#b3afac>%s</color>", var_50_1) or var_50_1

	gohelper.setActive(arg_50_0._gofightcountbg, var_50_1 ~= 0)
	arg_50_0:_refreshFreeCost()
end

function var_0_0._refreshFreeCost(arg_51_0)
	arg_51_0._txtcostcount.text = -1 * arg_51_0._curSpeed
end

function var_0_0.showViewStory(arg_52_0)
	local var_52_0 = StoryConfig.instance:getEpisodeStoryIds(arg_52_0._config)
	local var_52_1 = false

	for iter_52_0, iter_52_1 in ipairs(var_52_0) do
		if StoryModel.instance:isStoryFinished(iter_52_1) then
			var_52_1 = true

			break
		end
	end

	if not var_52_1 then
		return
	end
end

function var_0_0.refreshChallengeLimit(arg_53_0)
	local var_53_0, var_53_1, var_53_2 = DungeonModel.instance:getEpisodeChallengeCount(arg_53_0._episodeId)

	if var_53_0 > 0 and var_53_1 > 0 then
		local var_53_3 = ""

		if var_53_0 == DungeonEnum.ChallengeCountLimitType.Daily then
			var_53_3 = luaLang("daily")
		elseif var_53_0 == DungeonEnum.ChallengeCountLimitType.Weekly then
			var_53_3 = luaLang("weekly")
		else
			var_53_3 = luaLang("monthly")
		end

		arg_53_0._txtchallengecountlimit.text = string.format("%s%s (%d/%d)", var_53_3, luaLang("times"), math.max(0, var_53_1 - arg_53_0._episodeInfo.challengeCount), var_53_1)
	else
		arg_53_0._txtchallengecountlimit.text = ""
	end

	arg_53_0._isCanChallenge, arg_53_0._challengeLockCode = DungeonModel.instance:isCanChallenge(arg_53_0._config)

	gohelper.setActive(arg_53_0._gostart, arg_53_0._isCanChallenge)
	gohelper.setActive(arg_53_0._golock, not arg_53_0._isCanChallenge)
end

function var_0_0.onStoryStatus(arg_54_0)
	local var_54_0 = false
	local var_54_1 = DungeonConfig.instance:getChapterCO(arg_54_0._config.chapterId)

	if arg_54_0._config.afterStory > 0 and not StoryModel.instance:isStoryFinished(arg_54_0._config.afterStory) and arg_54_0._episodeInfo.star > DungeonEnum.StarType.None then
		var_54_0 = true
	end

	gohelper.setActive(arg_54_0._gooperation, not var_54_0 and not arg_54_0._enterAfterFreeLimit)
	gohelper.setActive(arg_54_0._btnstory, var_54_0)

	local var_54_2 = arg_54_0._chapterType == DungeonEnum.ChapterType.Hard

	if var_54_0 then
		arg_54_0:refreshHardMode()
		arg_54_0._btnhardmode.gameObject:SetActive(false)
	elseif not var_54_2 then
		arg_54_0:refreshHardMode()
	else
		arg_54_0._btnHardModeActive = false

		TaskDispatcher.cancelTask(arg_54_0._delaySetActive, arg_54_0)
		TaskDispatcher.runDelay(arg_54_0._delaySetActive, arg_54_0, 0.2)
	end

	arg_54_0:showViewStory()

	local var_54_3, var_54_4, var_54_5 = DungeonModel.instance:getChapterListTypes()
	local var_54_6 = DungeonModel.instance:chapterListIsRoleStory()
	local var_54_7 = (not var_54_3 or arg_54_0._config.type ~= DungeonEnum.EpisodeType.Story) and not var_54_4 and not var_54_5 and not var_54_6

	gohelper.setActive(arg_54_0._goswitch, arg_54_0._simpleConfig and var_54_7)
	gohelper.setActive(arg_54_0._gonormal, not arg_54_0._simpleConfig and var_54_7)
	gohelper.setActive(arg_54_0._gohard, not arg_54_0._simpleConfig and var_54_7)
	gohelper.setActive(arg_54_0._gostar, not arg_54_0._simpleConfig and var_54_7)
	recthelper.setAnchorY(arg_54_0._scrolldesc.transform, var_54_7 and 8 or 65)
	recthelper.setAnchorY(arg_54_0._gorecommond.transform, var_54_7 and 87.3 or 168.4)
	TaskDispatcher.cancelTask(arg_54_0._checkLockTime, arg_54_0)
	TaskDispatcher.runRepeat(arg_54_0._checkLockTime, arg_54_0, 1)
end

function var_0_0._checkLockTime(arg_55_0)
	local var_55_0 = DungeonConfig.instance:getHardEpisode(arg_55_0._enterConfig.id)
	local var_55_1 = arg_55_0.isInLockTime and true or false

	if var_55_0 and DungeonModel.instance:episodeIsInLockTime(var_55_0.id) then
		arg_55_0.isInLockTime = true
	else
		arg_55_0.isInLockTime = false
	end

	if var_55_1 ~= arg_55_0.isInLockTime then
		arg_55_0:showStatus()
		arg_55_0:onStoryStatus()
	elseif arg_55_0.isInLockTime then
		local var_55_2 = ServerTime.now()
		local var_55_3 = string.splitToNumber(var_55_0.lockTime, "#")

		arg_55_0._txtLockTime.text = formatLuaLang("seasonmainview_timeopencondition", string.format("%s%s", TimeUtil.secondToRoughTime2(var_55_3[2] / 1000 - ServerTime.now())))
	end
end

function var_0_0.refreshHardMode(arg_56_0)
	arg_56_0._hardEpisode = DungeonConfig.instance:getHardEpisode(arg_56_0._enterConfig.id)

	local var_56_0 = false

	if arg_56_0._episodeInfo.star == DungeonEnum.StarType.Advanced then
		local var_56_1 = DungeonModel.instance:isOpenHardDungeon(arg_56_0._config.chapterId)

		var_56_0 = arg_56_0._hardEpisode ~= nil and var_56_1
	end

	if arg_56_0._hardEpisode and DungeonModel.instance:episodeIsInLockTime(arg_56_0._hardEpisode.id) then
		var_56_0 = false

		gohelper.setActive(arg_56_0._txtLockTime, true)

		local var_56_2 = ServerTime.now()
		local var_56_3 = string.splitToNumber(arg_56_0._hardEpisode.lockTime, "#")

		arg_56_0._txtLockTime.text = formatLuaLang("seasonmainview_timeopencondition", string.format("%s%s", TimeUtil.secondToRoughTime2(var_56_3[2] / 1000 - ServerTime.now())))
		arg_56_0._golockbg:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	else
		gohelper.setActive(arg_56_0._txtLockTime, false)

		arg_56_0._golockbg:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0.1
	end

	arg_56_0._btnhardmode.gameObject:SetActive(var_56_0)
	gohelper.setActive(arg_56_0._golockbg, not var_56_0)

	arg_56_0._gohard:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = var_56_0 and 1 or 0.3
	arg_56_0._btnHardModeActive = var_56_0
end

function var_0_0._delaySetActive(arg_57_0)
	arg_57_0._btnhardmode.gameObject:SetActive(arg_57_0._btnHardModeActive)
end

function var_0_0.refreshCostPower(arg_58_0)
	local var_58_0 = string.split(arg_58_0._config.cost, "|")
	local var_58_1 = string.split(var_58_0[1], "#")
	local var_58_2 = tonumber(var_58_1[3] or 0) * arg_58_0._curSpeed

	arg_58_0._txtusepower.text = "-" .. var_58_2
	arg_58_0._txtusepowerhard.text = "-" .. var_58_2

	if var_58_2 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(arg_58_0._txtusepower, "#070706")
		SLFramework.UGUI.GuiHelper.SetColor(arg_58_0._txtusepowerhard, "#FFEAEA")
		gohelper.setActive(arg_58_0._gonormallackpower, false)
		gohelper.setActive(arg_58_0._gohardlackpower, false)
	else
		local var_58_3 = arg_58_0._chapterType == DungeonEnum.ChapterType.Hard

		SLFramework.UGUI.GuiHelper.SetColor(arg_58_0._txtusepower, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(arg_58_0._txtusepowerhard, "#C44945")
		gohelper.setActive(arg_58_0._gonormallackpower, not var_58_3)
		gohelper.setActive(arg_58_0._gohardlackpower, var_58_3)
	end
end

function var_0_0.onClose(arg_59_0)
	TaskDispatcher.cancelTask(arg_59_0.closeThis, arg_59_0)
	AudioMgr.instance:trigger(arg_59_0:getCurrentChapterListTypeAudio().onClose)

	arg_59_0._episodeItemParam.isHardMode = false

	DungeonController.instance:dispatchEvent(DungeonEvent.SwitchHardMode, arg_59_0._episodeItemParam)

	if arg_59_0._rewarditems then
		for iter_59_0, iter_59_1 in ipairs(arg_59_0._rewarditems) do
			TaskDispatcher.cancelTask(iter_59_1.refreshLimitTime, iter_59_1)
		end
	end

	arg_59_0._chapterType = nil
end

function var_0_0.onCloseFinish(arg_60_0)
	return
end

function var_0_0.clearRuleList(arg_61_0)
	arg_61_0._simageList = arg_61_0:getUserDataTb_()

	for iter_61_0, iter_61_1 in pairs(arg_61_0._rulesimageList) do
		iter_61_1:UnLoadImage()
	end

	arg_61_0._rulesimageList = arg_61_0:getUserDataTb_()
	arg_61_0._rulesimagelineList = arg_61_0:getUserDataTb_()

	gohelper.destroyAllChildren(arg_61_0._gorulelist)
	gohelper.destroyAllChildren(arg_61_0._goruleDescList)
end

function var_0_0.onDestroyView(arg_62_0)
	arg_62_0._simagepower2:UnLoadImage()
	arg_62_0._simagepower3:UnLoadImage()
	arg_62_0._simagenormalbg:UnLoadImage()
	arg_62_0._simagehardbg:UnLoadImage()

	for iter_62_0, iter_62_1 in pairs(arg_62_0._rulesimageList) do
		iter_62_1:UnLoadImage()
	end

	for iter_62_2 = 1, #arg_62_0._enemyitems do
		arg_62_0._enemyitems[iter_62_2].simagemonsterhead:UnLoadImage()
	end

	TaskDispatcher.cancelTask(arg_62_0._delaySetActive, arg_62_0)
	TaskDispatcher.cancelTask(arg_62_0._delayToSwitchStartBtn, arg_62_0)
	TaskDispatcher.cancelTask(arg_62_0.refreshCostPower, arg_62_0)
	TaskDispatcher.cancelTask(arg_62_0._checkLockTime, arg_62_0)
end

function var_0_0.refreshTitleField(arg_63_0)
	local var_63_0 = GameUtil.utf8len(arg_63_0._config.name) > 7 and arg_63_0.titleList[2] or arg_63_0.titleList[1]

	if var_63_0 == arg_63_0.curTitleItem then
		return
	end

	for iter_63_0, iter_63_1 in ipairs(arg_63_0.titleList) do
		gohelper.setActive(iter_63_1._go, iter_63_1 == var_63_0)
	end

	arg_63_0.curTitleItem = var_63_0
	arg_63_0._txttitle1 = var_63_0._txttitle1
	arg_63_0._txttitle3 = var_63_0._txttitle3
	arg_63_0._txtchapterindex = var_63_0._txtchapterindex
	arg_63_0._txttitle4 = var_63_0._txttitle4
	arg_63_0._gostar = var_63_0._gostar

	arg_63_0:_initStar()
end

function var_0_0.setTitleDesc(arg_64_0)
	arg_64_0:refreshTitleField()

	local var_64_0
	local var_64_1 = DungeonConfig.instance:getChapterTypeByEpisodeId(arg_64_0._config.id)

	if var_64_1 == DungeonEnum.ChapterType.Hard then
		var_64_0 = DungeonConfig.instance:getEpisodeCO(arg_64_0._config.preEpisode)
	elseif var_64_1 == DungeonEnum.ChapterType.Simple then
		var_64_0 = DungeonConfig.instance:getEpisodeCO(arg_64_0._config.normalEpisodeId)
	else
		var_64_0 = arg_64_0._config
	end

	arg_64_0._txtdesc.text = var_64_0.desc
	arg_64_0._txttitle4.text = var_64_0.name_En

	local var_64_2 = GameUtil.utf8sub(var_64_0.name, 1, 1)
	local var_64_3 = ""
	local var_64_4

	if GameUtil.utf8len(var_64_0.name) >= 2 then
		var_64_3 = string.format("%s", GameUtil.utf8sub(var_64_0.name, 2, GameUtil.utf8len(var_64_0.name) - 1))
	end

	arg_64_0._txttitle1.text = string.format("<size=100>%s</size>%s", var_64_2, var_64_3)

	ZProj.UGUIHelper.RebuildLayout(arg_64_0._txttitle1.transform)
	ZProj.UGUIHelper.RebuildLayout(arg_64_0._txttitle4.transform)

	if GameUtil.utf8len(arg_64_0._config.name) > 2 then
		local var_64_5 = recthelper.getAnchorX(arg_64_0._txttitle1.transform) + recthelper.getWidth(arg_64_0._txttitle1.transform)
	else
		local var_64_6 = recthelper.getAnchorX(arg_64_0._txttitle1.transform) + recthelper.getWidth(arg_64_0._txttitle1.transform) + recthelper.getAnchorX(arg_64_0._txttitle4.transform)
	end

	arg_64_0:_setTitle_overseas(var_64_2, var_64_3)
end

function var_0_0.getCurrentChapterListTypeAudio(arg_65_0)
	local var_65_0, var_65_1, var_65_2 = DungeonModel.instance:getChapterListTypes()
	local var_65_3

	if var_65_0 then
		var_65_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Story]
	elseif var_65_1 then
		var_65_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Resource]
	elseif var_65_2 then
		var_65_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Insight]
	else
		var_65_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Story]
	end

	return var_65_3
end

function var_0_0._setStarN(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0 = "#9B9B9B"

	if arg_66_1 then
		var_66_0 = arg_66_2 == 1 and "#efb974" or arg_66_2 == 2 and "#F97142" or "#FF4343"
		arg_66_0.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_66_0, var_66_0)
end

function var_0_0._btnHardOnClick(arg_67_0)
	if arg_67_0._chapterType == DungeonEnum.ChapterType.Hard then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		arg_67_0:_showHardDungeonOpenTip()

		return
	end

	local var_67_0 = DungeonConfig.instance:getHardEpisode(arg_67_0._enterConfig.id)

	if var_67_0 and DungeonModel.instance:episodeIsInLockTime(var_67_0.id) then
		GameFacade.showToastString(arg_67_0._txtLockTime.text)

		return
	end

	local var_67_1 = DungeonModel.instance:getEpisodeInfo(arg_67_0._enterConfig.id)

	if not DungeonModel.instance:hasPassLevelAndStory(arg_67_0._enterConfig.id) or var_67_1.star < DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.PassLevelAndStory)

		return
	end

	arg_67_0._config = arg_67_0._hardEpisode

	arg_67_0:_showEpisodeMode(true, true)
end

function var_0_0._btnNormalOnClick(arg_68_0)
	if arg_68_0._chapterType == DungeonEnum.ChapterType.Normal then
		return
	end

	arg_68_0._config = arg_68_0._enterConfig

	arg_68_0:_showEpisodeMode(false, true)
end

function var_0_0._btnSimpleOnClick(arg_69_0)
	if arg_69_0._chapterType == DungeonEnum.ChapterType.Simple then
		return
	end

	arg_69_0._config = arg_69_0._simpleConfig

	arg_69_0:_showEpisodeMode(false, true)
end

function var_0_0.checkSendGuideEvent(arg_70_0)
	if not arg_70_0._config then
		return
	end

	local var_70_0 = DungeonModel.instance:hasPassLevelAndStory(arg_70_0._config.id)
	local var_70_1 = DungeonConfig.instance:getEpisodeBattleId(arg_70_0._config.id)
	local var_70_2 = arg_70_0._config.chapterId

	if DungeonConfig.instance:getChapterCO(var_70_2).type == DungeonEnum.ChapterType.Normal and not var_70_0 and var_70_1 and var_70_1 ~= 0 then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnOpenUnPassLevelGuide)
	end
end

function var_0_0.checkFirstDisplay(arg_71_0)
	local var_71_0 = PlayerModel.instance:getMyUserId()
	local var_71_1 = PlayerPrefsKey.DungeonMapLevelFirstShow .. arg_71_0._simpleConfig.id .. var_71_0

	if PlayerPrefsHelper.getNumber(var_71_1, 0) == 0 then
		PlayerPrefsHelper.setNumber(var_71_1, 1)

		return true
	end

	return false
end

return var_0_0
