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
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.HardDungeon))

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

	local var_8_2 = DungeonConfig.instance:getHardEpisode(arg_8_0._enterConfig.id)

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
	if arg_9_0._chapterType == DungeonEnum.ChapterType.Normal then
		return
	end

	arg_9_0._config = arg_9_0._enterConfig

	arg_9_0:_showEpisodeMode(false, true)
end

function var_0_0._showEpisodeMode(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._episodeItemParam.index = arg_10_0._levelIndex
	arg_10_0._episodeItemParam.isHardMode = arg_10_1
	arg_10_0._episodeItemParam.episodeConfig = arg_10_0._config
	arg_10_0._episodeItemParam.immediately = not arg_10_2

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

	local var_18_1 = DungeonConfig.instance:getExtendStory(arg_18_0._config.id)

	if var_18_1 then
		local var_18_2 = {
			arg_18_0._config.beforeStory,
			var_18_1
		}

		StoryController.instance:playStories(var_18_2, var_18_0, arg_18_0.onStoryFinished, arg_18_0)
	else
		StoryController.instance:playStory(arg_18_0._config.beforeStory, var_18_0, arg_18_0.onStoryFinished, arg_18_0)
	end
end

function var_0_0.onStoryFinished(arg_19_0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(arg_19_0._config.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	ViewMgr.instance:closeView(arg_19_0.viewName)
end

function var_0_0._btnequipOnClick(arg_20_0)
	if arg_20_0:_checkEquipOverflow() then
		return
	end

	arg_20_0:_enterFight()
end

function var_0_0._checkEquipOverflow(arg_21_0)
	if arg_21_0._chapterType == DungeonEnum.ChapterType.Equip then
		local var_21_0 = EquipModel.instance:getEquips()

		if tabletool.len(var_21_0) >= EquipConfig.instance:getEquipBackpackMaxCount() then
			MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.EquipOverflow, MsgBoxEnum.BoxType.Yes_No, luaLang("p_equipdecompose_decompose"), "DISSOCIATION", nil, nil, arg_21_0._onChooseDecompose, arg_21_0._onCancelDecompose, nil, arg_21_0, arg_21_0, nil)

			return true
		end
	end
end

function var_0_0._onChooseDecompose(arg_22_0)
	EquipController.instance:openEquipDecomposeView()
end

function var_0_0._onCancelDecompose(arg_23_0)
	arg_23_0:_enterFight()
end

function var_0_0._btnstartOnClick(arg_24_0)
	if arg_24_0._config.type == DungeonEnum.EpisodeType.Story then
		arg_24_0:_playMainStory()

		return
	end

	local var_24_0, var_24_1, var_24_2 = DungeonModel.instance:getEpisodeChallengeCount(arg_24_0._episodeId)

	if var_24_0 > 0 and var_24_1 > 0 and var_24_1 <= var_24_2 then
		local var_24_3 = ""

		if var_24_0 == DungeonEnum.ChallengeCountLimitType.Daily then
			var_24_3 = luaLang("time_day2")
		elseif var_24_0 == DungeonEnum.ChallengeCountLimitType.Weekly then
			var_24_3 = luaLang("time_week")
		else
			var_24_3 = luaLang("time_month")
		end

		GameFacade.showToast(ToastEnum.DungeonMapLevel3, var_24_3)

		return
	end

	if arg_24_0._chapterType == DungeonEnum.ChapterType.Normal and var_24_0 > 0 and var_24_1 > 0 and var_24_1 < var_24_2 then
		GameFacade.showToast(ToastEnum.DungeonMapLevel4)

		return
	end

	if DungeonConfig.instance:getChapterCO(arg_24_0._config.chapterId).type == DungeonEnum.ChapterType.RoleStory then
		arg_24_0:_startRoleStory()

		return
	end

	if arg_24_0._config.beforeStory > 0 then
		if arg_24_0._config.afterStory > 0 then
			if not StoryModel.instance:isStoryFinished(arg_24_0._config.afterStory) then
				arg_24_0:_playStoryAndEnterFight(arg_24_0._config.beforeStory)

				return
			end
		elseif arg_24_0._episodeInfo.star <= DungeonEnum.StarType.None then
			arg_24_0:_playStoryAndEnterFight(arg_24_0._config.beforeStory)

			return
		end
	end

	if arg_24_0:_checkEquipOverflow() then
		return
	end

	arg_24_0:_enterFight()
end

function var_0_0._startRoleStory(arg_25_0)
	if arg_25_0._config.beforeStory > 0 then
		arg_25_0:_playStoryAndEnterFight(arg_25_0._config.beforeStory, true)

		return
	end

	arg_25_0:_enterFight()
end

function var_0_0._playStoryAndEnterFight(arg_26_0, arg_26_1, arg_26_2)
	if not arg_26_2 and StoryModel.instance:isStoryFinished(arg_26_1) then
		arg_26_0:_enterFight()

		return
	end

	local var_26_0 = {}

	var_26_0.mark = true
	var_26_0.episodeId = arg_26_0._config.id

	StoryController.instance:playStory(arg_26_1, var_26_0, arg_26_0._enterFight, arg_26_0)
end

function var_0_0._enterFight(arg_27_0)
	if arg_27_0._enterConfig then
		DungeonModel.instance:setLastSelectMode(arg_27_0._chapterType, arg_27_0._enterConfig.id)
	end

	local var_27_0 = DungeonConfig.instance:getEpisodeCO(arg_27_0._episodeId)

	DungeonFightController.instance:enterFight(var_27_0.chapterId, arg_27_0._episodeId, arg_27_0._curSpeed)
end

function var_0_0._editableInitView(arg_28_0)
	local var_28_0 = gohelper.findChild(arg_28_0.viewGO, "anim")

	arg_28_0._animator = var_28_0 and var_28_0:GetComponent(typeof(UnityEngine.Animator))
	arg_28_0._simageList = arg_28_0:getUserDataTb_()

	arg_28_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_28_0._onCurrencyChange, arg_28_0)
	arg_28_0._simagenormalbg:LoadImage(ResUrl.getDungeonIcon("fubenxinxi_di_putong"))
	arg_28_0._simagehardbg:LoadImage(ResUrl.getDungeonIcon("fubenxinxi_di_kunnan"))

	arg_28_0._rulesimageList = arg_28_0:getUserDataTb_()
	arg_28_0._rulesimagelineList = arg_28_0:getUserDataTb_()
	arg_28_0._rewarditems = arg_28_0:getUserDataTb_()
	arg_28_0._enemyitems = arg_28_0:getUserDataTb_()
	arg_28_0._episodeItemParam = arg_28_0:getUserDataTb_()

	gohelper.removeUIClickAudio(arg_28_0._btncloseview.gameObject)
	gohelper.removeUIClickAudio(arg_28_0._btnnormalmode.gameObject)
	gohelper.removeUIClickAudio(arg_28_0._btnhardmode.gameObject)
	gohelper.addUIClickAudio(arg_28_0._btnstart.gameObject, AudioEnum.HeroGroupUI.Play_UI_Action_Mainstart)
end

function var_0_0._initStar(arg_29_0)
	gohelper.setActive(arg_29_0._gostar, true)

	arg_29_0._starImgList = arg_29_0:getUserDataTb_()

	local var_29_0 = arg_29_0._gostar.transform
	local var_29_1 = var_29_0.childCount

	for iter_29_0 = 1, var_29_1 do
		local var_29_2 = var_29_0:GetChild(iter_29_0 - 1):GetComponent(gohelper.Type_Image)

		table.insert(arg_29_0._starImgList, var_29_2)
	end
end

function var_0_0.showStatus(arg_30_0)
	local var_30_0 = arg_30_0._config.id
	local var_30_1 = DungeonModel.instance:isOpenHardDungeon(arg_30_0._config.chapterId)
	local var_30_2 = var_30_0 and DungeonModel.instance:hasPassLevelAndStory(var_30_0)
	local var_30_3 = DungeonConfig.instance:getEpisodeAdvancedConditionText(var_30_0)
	local var_30_4 = arg_30_0._episodeInfo
	local var_30_5 = DungeonConfig.instance:getHardEpisode(arg_30_0._config.id)
	local var_30_6 = var_30_5 and DungeonModel.instance:getEpisodeInfo(var_30_5.id)
	local var_30_7 = arg_30_0._starImgList[4]
	local var_30_8 = arg_30_0._starImgList[3]
	local var_30_9 = arg_30_0._starImgList[2]

	arg_30_0:_setStar(arg_30_0._starImgList[1], var_30_4.star >= DungeonEnum.StarType.Normal and var_30_2, 1)

	if not string.nilorempty(var_30_3) then
		arg_30_0:_setStar(var_30_9, var_30_4.star >= DungeonEnum.StarType.Advanced and var_30_2, 2)

		if var_30_5 then
			local var_30_10 = DungeonModel.instance:episodeIsInLockTime(var_30_5.id)

			gohelper.setActive(var_30_8, not var_30_10)
			gohelper.setActive(var_30_7, not var_30_10)
		end

		if var_30_6 and var_30_4.star >= DungeonEnum.StarType.Advanced and var_30_1 and var_30_2 then
			arg_30_0:_setStar(var_30_8, var_30_6.star >= DungeonEnum.StarType.Normal, 3)
			arg_30_0:_setStar(var_30_7, var_30_6.star >= DungeonEnum.StarType.Advanced, 4)
		end
	end

	if arg_30_0._simpleConfig then
		local var_30_11 = var_30_4.star >= DungeonEnum.StarType.Normal and var_30_2

		arg_30_0._setStarN(arg_30_0._imgnormalstar1s, var_30_11, 2)
		arg_30_0._setStarN(arg_30_0._imgnormalstar1ru, var_30_11, 2)
		arg_30_0._setStarN(arg_30_0._imgnormalstar1lu, var_30_11, 2)

		local var_30_12 = var_30_4.star >= DungeonEnum.StarType.Advanced and var_30_2

		arg_30_0._setStarN(arg_30_0._imgnormalstar2s, var_30_12, 2)
		arg_30_0._setStarN(arg_30_0._imgnormalstar2ru, var_30_12, 2)
		arg_30_0._setStarN(arg_30_0._imgnormalstar2lu, var_30_12, 2)

		local var_30_13 = DungeonModel.instance:hasPassLevelAndStory(arg_30_0._simpleConfig.id)

		arg_30_0._setStarN(arg_30_0._imgstorystar1s, var_30_13, 1)
		arg_30_0._setStarN(arg_30_0._imgstorystar1u, var_30_13, 1)

		if var_30_5 then
			local var_30_14 = DungeonModel.instance:episodeIsInLockTime(var_30_5.id)

			gohelper.setActive(arg_30_0._imghardstar1s, not var_30_14)
			gohelper.setActive(arg_30_0._imghardstar1u, not var_30_14)
			gohelper.setActive(arg_30_0._imghardstar2s, not var_30_14)
			gohelper.setActive(arg_30_0._imghardstar2u, not var_30_14)

			local var_30_15 = DungeonModel.instance:getEpisodeInfo(var_30_5.id)

			if var_30_15 and var_30_4.star >= DungeonEnum.StarType.Advanced and var_30_1 and var_30_2 then
				local var_30_16 = var_30_15.star >= DungeonEnum.StarType.Normal
				local var_30_17 = var_30_15.star >= DungeonEnum.StarType.Advanced

				arg_30_0._setStarN(arg_30_0._imghardstar1s, var_30_16, 3)
				arg_30_0._setStarN(arg_30_0._imghardstar1u, var_30_16, 3)
				arg_30_0._setStarN(arg_30_0._imghardstar2s, var_30_17, 3)
				arg_30_0._setStarN(arg_30_0._imghardstar2u, var_30_17, 3)
			else
				arg_30_0._setStarN(arg_30_0._imghardstar1s, false, 3)
				arg_30_0._setStarN(arg_30_0._imghardstar1u, false, 3)
				arg_30_0._setStarN(arg_30_0._imghardstar2s, false, 3)
				arg_30_0._setStarN(arg_30_0._imghardstar2u, false, 3)
			end
		end
	end
end

function var_0_0._setStar(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = "#9B9B9B"

	if arg_31_2 then
		var_31_0 = arg_31_3 > 2 and "#FF4343" or "#F97142"
		arg_31_1.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_31_1, var_31_0)
end

function var_0_0._onCurrencyChange(arg_32_0, arg_32_1)
	if not arg_32_1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	arg_32_0:refreshCostPower()
end

function var_0_0.onUpdateParam(arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0.closeThis, arg_33_0)
	arg_33_0:_initInfo()
	arg_33_0.viewContainer:refreshHelp()
	arg_33_0:showStatus()
	arg_33_0:_doUpdate()
	arg_33_0:checkSendGuideEvent()
end

function var_0_0._addRuleItem(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = gohelper.clone(arg_34_0._goruletemp, arg_34_0._gorulelist, arg_34_1.id)

	gohelper.setActive(var_34_0, true)

	local var_34_1 = gohelper.findChildImage(var_34_0, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(var_34_1, "wz_" .. arg_34_2)

	local var_34_2 = gohelper.findChildImage(var_34_0, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_34_2, arg_34_1.icon)
end

function var_0_0._setRuleDescItem(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local var_35_1 = gohelper.clone(arg_35_0._goruleitem, arg_35_0._goruleDescList, arg_35_1.id)

	gohelper.setActive(var_35_1, true)

	local var_35_2 = gohelper.findChildImage(var_35_1, "icon")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(var_35_2, arg_35_1.icon)

	local var_35_3 = gohelper.findChild(var_35_1, "line")

	table.insert(arg_35_0._rulesimagelineList, var_35_3)

	local var_35_4 = gohelper.findChildImage(var_35_1, "tag")

	UISpriteSetMgr.instance:setCommonSprite(var_35_4, "wz_" .. arg_35_2)

	gohelper.findChildText(var_35_1, "desc").text = SkillConfig.instance:fmtTagDescColor(luaLang("dungeon_add_rule_target_" .. arg_35_2), arg_35_1.desc, var_35_0[arg_35_2])
end

function var_0_0.onOpen(arg_36_0)
	arg_36_0:_initInfo()
	arg_36_0:showStatus()
	arg_36_0:_doUpdate()
	arg_36_0:addEventCb(DungeonController.instance, DungeonEvent.OnUnlockNewChapter, arg_36_0._OnUnlockNewChapter, arg_36_0)
	arg_36_0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_36_0.viewContainer.refreshHelp, arg_36_0.viewContainer)
	arg_36_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_36_0._onUpdateDungeonInfo, arg_36_0)
	arg_36_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshDoubleDropInfo, arg_36_0.showDoubleDrop, arg_36_0)
	NavigateMgr.instance:addEscape(ViewName.DungeonMapLevelView, arg_36_0._btncloseOnClick, arg_36_0)

	if not arg_36_0.viewParam[var_0_1.isJumpOpen] then
		arg_36_0:checkSendGuideEvent()
	end
end

function var_0_0._onUpdateDungeonInfo(arg_37_0)
	local var_37_0 = DungeonConfig.instance:getChapterCO(arg_37_0._config.chapterId)

	arg_37_0:showFree(var_37_0)
end

function var_0_0._OnUnlockNewChapter(arg_38_0)
	ViewMgr.instance:closeView(ViewName.DungeonMapLevelView)
end

function var_0_0._doUpdate(arg_39_0)
	local var_39_0 = arg_39_0.viewParam[5]
	local var_39_1, var_39_2 = DungeonModel.instance:getLastSelectMode()

	if var_39_0 or var_39_1 == DungeonEnum.ChapterType.Hard then
		if arg_39_0._episodeInfo.star == DungeonEnum.StarType.Advanced then
			arg_39_0._hardEpisode = DungeonConfig.instance:getHardEpisode(arg_39_0._enterConfig.id)

			if arg_39_0._hardEpisode then
				arg_39_0._config = arg_39_0._hardEpisode

				arg_39_0:_showEpisodeMode(true, false)
				arg_39_0._animator:Play("dungeonlevel_in_hard", 0, 0)

				return
			end
		end
	elseif var_39_1 == DungeonEnum.ChapterType.Simple and arg_39_0._simpleConfig then
		arg_39_0._config = arg_39_0._simpleConfig

		arg_39_0:_showEpisodeMode(false, false)
		arg_39_0._animator:Play("dungeonlevel_in_nomal", 0, 0)

		return
	end

	if arg_39_0._simpleConfig and arg_39_0:checkFirstDisplay() and DungeonModel.instance:getLastFightEpisodePassMode(arg_39_0._enterConfig) == DungeonEnum.ChapterType.Simple then
		arg_39_0._config = arg_39_0._simpleConfig

		arg_39_0:_showEpisodeMode(false, false)
		arg_39_0._animator:Play("dungeonlevel_in_nomal", 0, 0)

		return
	end

	arg_39_0:onUpdate()
	arg_39_0._animator:Play("dungeonlevel_in_nomal", 0, 0)
end

function var_0_0._initInfo(arg_40_0)
	arg_40_0._enterConfig = arg_40_0.viewParam[1]
	arg_40_0._simpleConfig = DungeonConfig.instance:getSimpleEpisode(arg_40_0._enterConfig)
	arg_40_0._hardEpisode = DungeonConfig.instance:getHardEpisode(arg_40_0._enterConfig.id)
	arg_40_0._config = arg_40_0._enterConfig
	arg_40_0._chapterIndex = arg_40_0.viewParam[3]
	arg_40_0._levelIndex = DungeonConfig.instance:getChapterEpisodeIndexWithSP(arg_40_0._config.chapterId, arg_40_0._config.id)

	arg_40_0:_updateEpisodeInfo()

	if arg_40_0.viewParam[var_0_1.isJumpOpen] then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnJumpChangeFocusEpisodeItem, arg_40_0._config.id)
	end

	arg_40_0:refreshTitleField()
end

var_0_0.BtnOutScreenTime = 0.3

function var_0_0.onUpdate(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = DungeonConfig.instance:getChapterCO(arg_41_0._config.chapterId)
	local var_41_1 = var_41_0.type
	local var_41_2 = var_41_1 == DungeonEnum.ChapterType.Hard

	if arg_41_0._chapterType ~= var_41_1 and arg_41_0._animator then
		local var_41_3 = var_41_2 and "hard" or "normal"

		arg_41_0._animator:Play(var_41_3, 0, 0)
		arg_41_0._animator:Update(0)
	end

	arg_41_0._chapterType = var_41_1

	arg_41_0._gonormal2:SetActive(false)

	if arg_41_2 then
		TaskDispatcher.cancelTask(arg_41_0._delayToSwitchStartBtn, arg_41_0)
		TaskDispatcher.runDelay(arg_41_0._delayToSwitchStartBtn, arg_41_0, var_0_0.BtnOutScreenTime)
	else
		arg_41_0:_delayToSwitchStartBtn()
	end

	gohelper.setActive(arg_41_0._goselectstorybg, var_41_1 == DungeonEnum.ChapterType.Simple)
	gohelper.setActive(arg_41_0._gounselectstorybg, var_41_1 ~= DungeonEnum.ChapterType.Simple)
	gohelper.setActive(arg_41_0._goselectnormalbgN, var_41_1 == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(arg_41_0._gounselectnormalbgr, var_41_1 == DungeonEnum.ChapterType.Simple)
	gohelper.setActive(arg_41_0._gounselectnormalbgl, var_41_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_41_0._goselecthardbgN, var_41_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_41_0._gounselecthardbgN, var_41_1 ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_41_0._simagenormalbg, var_41_1 ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_41_0._simagehardbg, var_41_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_41_0._gohardmodedecorate, var_41_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_41_0._goselecthardbg, var_41_1 == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_41_0._gounselecthardbg, var_41_1 == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(arg_41_0._goselectnormalbg, var_41_1 == DungeonEnum.ChapterType.Normal)
	gohelper.setActive(arg_41_0._gounselectnormalbg, var_41_1 == DungeonEnum.ChapterType.Hard)

	arg_41_0._episodeId = arg_41_0._config.id

	local var_41_4 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local var_41_5 = ResUrl.getCurrencyItemIcon(var_41_4.icon .. "_btn")

	arg_41_0._simagepower2:LoadImage(var_41_5)
	arg_41_0._simagepower3:LoadImage(var_41_5)
	gohelper.setActive(arg_41_0._goboss, arg_41_0:_isBossTypeEpisode(var_41_2))
	gohelper.setActive(arg_41_0._gonormaleye, not var_41_2)
	gohelper.setActive(arg_41_0._gohardeye, var_41_2)

	if arg_41_0._config.battleId ~= 0 then
		gohelper.setActive(arg_41_0._gorecommond, true)

		local var_41_6 = var_41_1 == DungeonEnum.ChapterType.Simple
		local var_41_7 = DungeonHelper.getEpisodeRecommendLevel(arg_41_0._episodeId, var_41_6)

		if var_41_7 ~= 0 then
			gohelper.setActive(arg_41_0._gorecommond, true)

			arg_41_0._txtrecommondlv.text = HeroConfig.instance:getLevelDisplayVariant(var_41_7)
		else
			gohelper.setActive(arg_41_0._gorecommond, false)
		end
	else
		gohelper.setActive(arg_41_0._gorecommond, false)
	end

	arg_41_0:setTitleDesc()
	arg_41_0:showFree(var_41_0)
	arg_41_0:showDoubleDrop()

	arg_41_0._txttitle3.text = string.format("%02d", arg_41_0._levelIndex)
	arg_41_0._txtchapterindex.text = var_41_0.chapterIndex

	if arg_41_2 then
		TaskDispatcher.cancelTask(arg_41_0.refreshCostPower, arg_41_0)
		TaskDispatcher.runDelay(arg_41_0.refreshCostPower, arg_41_0, var_0_0.BtnOutScreenTime)
	else
		arg_41_0:refreshCostPower()
	end

	arg_41_0:refreshChallengeLimit()
	arg_41_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_41_0.refreshChallengeLimit, arg_41_0)
	arg_41_0:onStoryStatus()
end

function var_0_0._isBossTypeEpisode(arg_42_0, arg_42_1)
	if arg_42_1 then
		if arg_42_0._config.preEpisode then
			local var_42_0 = arg_42_0._config.preEpisode

			return DungeonConfig.instance:getEpisodeCO(var_42_0).displayMark == 1
		end

		return arg_42_0._config.displayMark == 1
	else
		return arg_42_0._config.displayMark == 1
	end
end

function var_0_0._delayToSwitchStartBtn(arg_43_0)
	local var_43_0 = arg_43_0._chapterType == DungeonEnum.ChapterType.Hard

	gohelper.setActive(arg_43_0._gostartnormal, not var_43_0)
	gohelper.setActive(arg_43_0._gostarthard, var_43_0)
end

function var_0_0.showDoubleDrop(arg_44_0)
	if not arg_44_0._config then
		return
	end

	local var_44_0 = DungeonConfig.instance:getChapterCO(arg_44_0._config.chapterId)
	local var_44_1, var_44_2, var_44_3 = DoubleDropModel.instance:isShowDoubleByEpisode(arg_44_0._config.id, true)

	gohelper.setActive(arg_44_0._godoubletimes, var_44_1)

	if var_44_1 then
		local var_44_4 = {
			var_44_2,
			var_44_3
		}

		arg_44_0._txtdoubletimes.text = GameUtil.getSubPlaceholderLuaLang(luaLang("double_drop_remain_times"), var_44_4)

		recthelper.setAnchorY(arg_44_0._gooperation.transform, -20)
		recthelper.setAnchorY(arg_44_0._btnequip.transform, -410)
	else
		recthelper.setAnchorY(arg_44_0._gooperation.transform, 0)
		recthelper.setAnchorY(arg_44_0._btnequip.transform, -390)
	end
end

function var_0_0.showFree(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_1.enterAfterFreeLimit > 0

	gohelper.setActive(arg_45_0._gorighttop, not var_45_0)

	arg_45_0._enterAfterFreeLimit = var_45_0

	if not var_45_0 then
		return
	end

	local var_45_1 = DungeonModel.instance:getChapterRemainingNum(arg_45_1.type)

	if var_45_1 <= 0 then
		var_45_0 = false
	end

	gohelper.setActive(arg_45_0._goequipmap, var_45_0)
	gohelper.setActive(arg_45_0._gooperation, not var_45_0)
	gohelper.setActive(arg_45_0._gorighttop, not var_45_0)

	arg_45_0._enterAfterFreeLimit = var_45_0

	if not var_45_0 then
		return
	end

	arg_45_0._txtfightcount.text = var_45_1 == 0 and string.format("<color=#b3afac>%s</color>", var_45_1) or var_45_1

	gohelper.setActive(arg_45_0._gofightcountbg, var_45_1 ~= 0)
	arg_45_0:_refreshFreeCost()
end

function var_0_0._refreshFreeCost(arg_46_0)
	arg_46_0._txtcostcount.text = -1 * arg_46_0._curSpeed
end

function var_0_0.showViewStory(arg_47_0)
	local var_47_0 = StoryConfig.instance:getEpisodeStoryIds(arg_47_0._config)
	local var_47_1 = false

	for iter_47_0, iter_47_1 in ipairs(var_47_0) do
		if StoryModel.instance:isStoryFinished(iter_47_1) then
			var_47_1 = true

			break
		end
	end

	if not var_47_1 then
		return
	end
end

function var_0_0.refreshChallengeLimit(arg_48_0)
	local var_48_0, var_48_1, var_48_2 = DungeonModel.instance:getEpisodeChallengeCount(arg_48_0._episodeId)

	if var_48_0 > 0 and var_48_1 > 0 then
		local var_48_3 = ""

		if var_48_0 == DungeonEnum.ChallengeCountLimitType.Daily then
			var_48_3 = luaLang("daily")
		elseif var_48_0 == DungeonEnum.ChallengeCountLimitType.Weekly then
			var_48_3 = luaLang("weekly")
		else
			var_48_3 = luaLang("monthly")
		end

		arg_48_0._txtchallengecountlimit.text = string.format("%s%s (%d/%d)", var_48_3, luaLang("times"), math.max(0, var_48_1 - arg_48_0._episodeInfo.challengeCount), var_48_1)
	else
		arg_48_0._txtchallengecountlimit.text = ""
	end

	arg_48_0._isCanChallenge, arg_48_0._challengeLockCode = DungeonModel.instance:isCanChallenge(arg_48_0._config)

	gohelper.setActive(arg_48_0._gostart, arg_48_0._isCanChallenge)
	gohelper.setActive(arg_48_0._golock, not arg_48_0._isCanChallenge)
end

function var_0_0.onStoryStatus(arg_49_0)
	local var_49_0 = false
	local var_49_1 = DungeonConfig.instance:getChapterCO(arg_49_0._config.chapterId)

	if arg_49_0._config.afterStory > 0 and not StoryModel.instance:isStoryFinished(arg_49_0._config.afterStory) and arg_49_0._episodeInfo.star > DungeonEnum.StarType.None then
		var_49_0 = true
	end

	gohelper.setActive(arg_49_0._gooperation, not var_49_0 and not arg_49_0._enterAfterFreeLimit)
	gohelper.setActive(arg_49_0._btnstory, var_49_0)

	local var_49_2 = arg_49_0._chapterType == DungeonEnum.ChapterType.Hard

	if var_49_0 then
		arg_49_0:refreshHardMode()
		arg_49_0._btnhardmode.gameObject:SetActive(false)
	elseif not var_49_2 then
		arg_49_0:refreshHardMode()
	else
		arg_49_0._btnHardModeActive = false

		TaskDispatcher.cancelTask(arg_49_0._delaySetActive, arg_49_0)
		TaskDispatcher.runDelay(arg_49_0._delaySetActive, arg_49_0, 0.2)
	end

	arg_49_0:showViewStory()

	local var_49_3, var_49_4, var_49_5 = DungeonModel.instance:getChapterListTypes()
	local var_49_6 = DungeonModel.instance:chapterListIsRoleStory()
	local var_49_7 = (not var_49_3 or arg_49_0._config.type ~= DungeonEnum.EpisodeType.Story) and not var_49_4 and not var_49_5 and not var_49_6

	gohelper.setActive(arg_49_0._goswitch, arg_49_0._simpleConfig and var_49_7)
	gohelper.setActive(arg_49_0._gonormal, not arg_49_0._simpleConfig and var_49_7)
	gohelper.setActive(arg_49_0._gohard, not arg_49_0._simpleConfig and var_49_7)
	gohelper.setActive(arg_49_0._gostar, not arg_49_0._simpleConfig and var_49_7)
	recthelper.setAnchorY(arg_49_0._scrolldesc.transform, var_49_7 and 8 or 65)
	recthelper.setAnchorY(arg_49_0._gorecommond.transform, var_49_7 and 87.3 or 168.4)
	TaskDispatcher.cancelTask(arg_49_0._checkLockTime, arg_49_0)
	TaskDispatcher.runRepeat(arg_49_0._checkLockTime, arg_49_0, 1)
end

function var_0_0._checkLockTime(arg_50_0)
	local var_50_0 = DungeonConfig.instance:getHardEpisode(arg_50_0._enterConfig.id)
	local var_50_1 = arg_50_0.isInLockTime and true or false

	if var_50_0 and DungeonModel.instance:episodeIsInLockTime(var_50_0.id) then
		arg_50_0.isInLockTime = true
	else
		arg_50_0.isInLockTime = false
	end

	if var_50_1 ~= arg_50_0.isInLockTime then
		arg_50_0:showStatus()
		arg_50_0:onStoryStatus()
	elseif arg_50_0.isInLockTime then
		local var_50_2 = ServerTime.now()
		local var_50_3 = string.splitToNumber(var_50_0.lockTime, "#")

		arg_50_0._txtLockTime.text = formatLuaLang("seasonmainview_timeopencondition", string.format("%s%s", TimeUtil.secondToRoughTime2(var_50_3[2] / 1000 - ServerTime.now())))
	end
end

function var_0_0.refreshHardMode(arg_51_0)
	arg_51_0._hardEpisode = DungeonConfig.instance:getHardEpisode(arg_51_0._enterConfig.id)

	local var_51_0 = false

	if arg_51_0._episodeInfo.star == DungeonEnum.StarType.Advanced then
		local var_51_1 = DungeonModel.instance:isOpenHardDungeon(arg_51_0._config.chapterId)

		var_51_0 = arg_51_0._hardEpisode ~= nil and var_51_1
	end

	if arg_51_0._hardEpisode and DungeonModel.instance:episodeIsInLockTime(arg_51_0._hardEpisode.id) then
		var_51_0 = false

		gohelper.setActive(arg_51_0._txtLockTime, true)

		local var_51_2 = ServerTime.now()
		local var_51_3 = string.splitToNumber(arg_51_0._hardEpisode.lockTime, "#")

		arg_51_0._txtLockTime.text = formatLuaLang("seasonmainview_timeopencondition", string.format("%s%s", TimeUtil.secondToRoughTime2(var_51_3[2] / 1000 - ServerTime.now())))
		arg_51_0._golockbg:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	else
		gohelper.setActive(arg_51_0._txtLockTime, false)

		arg_51_0._golockbg:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 0.1
	end

	arg_51_0._btnhardmode.gameObject:SetActive(var_51_0)
	gohelper.setActive(arg_51_0._golockbg, not var_51_0)

	arg_51_0._gohard:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = var_51_0 and 1 or 0.3
	arg_51_0._btnHardModeActive = var_51_0
end

function var_0_0._delaySetActive(arg_52_0)
	arg_52_0._btnhardmode.gameObject:SetActive(arg_52_0._btnHardModeActive)
end

function var_0_0.refreshCostPower(arg_53_0)
	local var_53_0 = string.split(arg_53_0._config.cost, "|")
	local var_53_1 = string.split(var_53_0[1], "#")
	local var_53_2 = tonumber(var_53_1[3] or 0) * arg_53_0._curSpeed

	arg_53_0._txtusepower.text = "-" .. var_53_2
	arg_53_0._txtusepowerhard.text = "-" .. var_53_2

	if var_53_2 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(arg_53_0._txtusepower, "#070706")
		SLFramework.UGUI.GuiHelper.SetColor(arg_53_0._txtusepowerhard, "#FFEAEA")
		gohelper.setActive(arg_53_0._gonormallackpower, false)
		gohelper.setActive(arg_53_0._gohardlackpower, false)
	else
		local var_53_3 = arg_53_0._chapterType == DungeonEnum.ChapterType.Hard

		SLFramework.UGUI.GuiHelper.SetColor(arg_53_0._txtusepower, "#800015")
		SLFramework.UGUI.GuiHelper.SetColor(arg_53_0._txtusepowerhard, "#C44945")
		gohelper.setActive(arg_53_0._gonormallackpower, not var_53_3)
		gohelper.setActive(arg_53_0._gohardlackpower, var_53_3)
	end
end

function var_0_0.onClose(arg_54_0)
	TaskDispatcher.cancelTask(arg_54_0.closeThis, arg_54_0)
	AudioMgr.instance:trigger(arg_54_0:getCurrentChapterListTypeAudio().onClose)

	arg_54_0._episodeItemParam.isHardMode = false

	DungeonController.instance:dispatchEvent(DungeonEvent.SwitchHardMode, arg_54_0._episodeItemParam)

	if arg_54_0._rewarditems then
		for iter_54_0, iter_54_1 in ipairs(arg_54_0._rewarditems) do
			TaskDispatcher.cancelTask(iter_54_1.refreshLimitTime, iter_54_1)
		end
	end

	arg_54_0._chapterType = nil
end

function var_0_0.onCloseFinish(arg_55_0)
	return
end

function var_0_0.clearRuleList(arg_56_0)
	arg_56_0._simageList = arg_56_0:getUserDataTb_()

	for iter_56_0, iter_56_1 in pairs(arg_56_0._rulesimageList) do
		iter_56_1:UnLoadImage()
	end

	arg_56_0._rulesimageList = arg_56_0:getUserDataTb_()
	arg_56_0._rulesimagelineList = arg_56_0:getUserDataTb_()

	gohelper.destroyAllChildren(arg_56_0._gorulelist)
	gohelper.destroyAllChildren(arg_56_0._goruleDescList)
end

function var_0_0.onDestroyView(arg_57_0)
	arg_57_0._simagepower2:UnLoadImage()
	arg_57_0._simagepower3:UnLoadImage()
	arg_57_0._simagenormalbg:UnLoadImage()
	arg_57_0._simagehardbg:UnLoadImage()

	for iter_57_0, iter_57_1 in pairs(arg_57_0._rulesimageList) do
		iter_57_1:UnLoadImage()
	end

	for iter_57_2 = 1, #arg_57_0._enemyitems do
		arg_57_0._enemyitems[iter_57_2].simagemonsterhead:UnLoadImage()
	end

	TaskDispatcher.cancelTask(arg_57_0._delaySetActive, arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0._delayToSwitchStartBtn, arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0.refreshCostPower, arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0._checkLockTime, arg_57_0)
end

function var_0_0.refreshTitleField(arg_58_0)
	local var_58_0 = GameUtil.utf8len(arg_58_0._config.name) > 7 and arg_58_0.titleList[2] or arg_58_0.titleList[1]

	if var_58_0 == arg_58_0.curTitleItem then
		return
	end

	for iter_58_0, iter_58_1 in ipairs(arg_58_0.titleList) do
		gohelper.setActive(iter_58_1._go, iter_58_1 == var_58_0)
	end

	arg_58_0.curTitleItem = var_58_0
	arg_58_0._txttitle1 = var_58_0._txttitle1
	arg_58_0._txttitle3 = var_58_0._txttitle3
	arg_58_0._txtchapterindex = var_58_0._txtchapterindex
	arg_58_0._txttitle4 = var_58_0._txttitle4
	arg_58_0._gostar = var_58_0._gostar

	arg_58_0:_initStar()
end

function var_0_0.setTitleDesc(arg_59_0)
	arg_59_0:refreshTitleField()

	local var_59_0
	local var_59_1 = DungeonConfig.instance:getChapterTypeByEpisodeId(arg_59_0._config.id)

	if var_59_1 == DungeonEnum.ChapterType.Hard then
		var_59_0 = DungeonConfig.instance:getEpisodeCO(arg_59_0._config.preEpisode)
	elseif var_59_1 == DungeonEnum.ChapterType.Simple then
		var_59_0 = DungeonConfig.instance:getEpisodeCO(arg_59_0._config.normalEpisodeId)
	else
		var_59_0 = arg_59_0._config
	end

	arg_59_0._txtdesc.text = var_59_0.desc
	arg_59_0._txttitle4.text = var_59_0.name_En

	local var_59_2 = GameUtil.utf8sub(var_59_0.name, 1, 1)
	local var_59_3 = ""
	local var_59_4

	if GameUtil.utf8len(var_59_0.name) >= 2 then
		var_59_3 = string.format("%s", GameUtil.utf8sub(var_59_0.name, 2, GameUtil.utf8len(var_59_0.name) - 1))
	end

	arg_59_0._txttitle1.text = string.format("<size=100>%s</size>%s", var_59_2, var_59_3)

	ZProj.UGUIHelper.RebuildLayout(arg_59_0._txttitle1.transform)
	ZProj.UGUIHelper.RebuildLayout(arg_59_0._txttitle4.transform)

	if GameUtil.utf8len(arg_59_0._config.name) > 2 then
		local var_59_5 = recthelper.getAnchorX(arg_59_0._txttitle1.transform) + recthelper.getWidth(arg_59_0._txttitle1.transform)
	else
		local var_59_6 = recthelper.getAnchorX(arg_59_0._txttitle1.transform) + recthelper.getWidth(arg_59_0._txttitle1.transform) + recthelper.getAnchorX(arg_59_0._txttitle4.transform)
	end

	arg_59_0:_setTitle_overseas(var_59_2, var_59_3)
end

function var_0_0.getCurrentChapterListTypeAudio(arg_60_0)
	local var_60_0, var_60_1, var_60_2 = DungeonModel.instance:getChapterListTypes()
	local var_60_3

	if var_60_0 then
		var_60_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Story]
	elseif var_60_1 then
		var_60_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Resource]
	elseif var_60_2 then
		var_60_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Insight]
	else
		var_60_3 = var_0_0.AudioConfig[DungeonEnum.ChapterListType.Story]
	end

	return var_60_3
end

function var_0_0._setStarN(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = "#9B9B9B"

	if arg_61_1 then
		var_61_0 = arg_61_2 == 1 and "#efb974" or arg_61_2 == 2 and "#F97142" or "#FF4343"
		arg_61_0.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_61_0, var_61_0)
end

function var_0_0._btnHardOnClick(arg_62_0)
	if arg_62_0._chapterType == DungeonEnum.ChapterType.Hard then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.HardDungeon) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.HardDungeon))

		return
	end

	local var_62_0 = DungeonConfig.instance:getHardEpisode(arg_62_0._enterConfig.id)

	if var_62_0 and DungeonModel.instance:episodeIsInLockTime(var_62_0.id) then
		GameFacade.showToastString(arg_62_0._txtLockTime.text)

		return
	end

	local var_62_1 = DungeonModel.instance:getEpisodeInfo(arg_62_0._enterConfig.id)

	if not DungeonModel.instance:hasPassLevelAndStory(arg_62_0._enterConfig.id) or var_62_1.star < DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.PassLevelAndStory)

		return
	end

	arg_62_0._config = arg_62_0._hardEpisode

	arg_62_0:_showEpisodeMode(true, true)
end

function var_0_0._btnNormalOnClick(arg_63_0)
	if arg_63_0._chapterType == DungeonEnum.ChapterType.Normal then
		return
	end

	arg_63_0._config = arg_63_0._enterConfig

	arg_63_0:_showEpisodeMode(false, true)
end

function var_0_0._btnSimpleOnClick(arg_64_0)
	if arg_64_0._chapterType == DungeonEnum.ChapterType.Simple then
		return
	end

	arg_64_0._config = arg_64_0._simpleConfig

	arg_64_0:_showEpisodeMode(false, true)
end

function var_0_0.checkSendGuideEvent(arg_65_0)
	if not arg_65_0._config then
		return
	end

	local var_65_0 = DungeonModel.instance:hasPassLevelAndStory(arg_65_0._config.id)
	local var_65_1 = DungeonConfig.instance:getEpisodeBattleId(arg_65_0._config.id)
	local var_65_2 = arg_65_0._config.chapterId

	if DungeonConfig.instance:getChapterCO(var_65_2).type == DungeonEnum.ChapterType.Normal and not var_65_0 and var_65_1 and var_65_1 ~= 0 then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnOpenUnPassLevelGuide)
	end
end

function var_0_0.checkFirstDisplay(arg_66_0)
	local var_66_0 = PlayerModel.instance:getMyUserId()
	local var_66_1 = PlayerPrefsKey.DungeonMapLevelFirstShow .. arg_66_0._simpleConfig.id .. var_66_0

	if PlayerPrefsHelper.getNumber(var_66_1, 0) == 0 then
		PlayerPrefsHelper.setNumber(var_66_1, 1)

		return true
	end

	return false
end

return var_0_0
