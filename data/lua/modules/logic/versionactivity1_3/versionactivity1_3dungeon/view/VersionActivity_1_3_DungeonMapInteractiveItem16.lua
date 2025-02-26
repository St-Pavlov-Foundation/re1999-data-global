module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity_1_3_DungeonMapInteractiveItem16", package.seeall)

slot0 = class("VersionActivity_1_3_DungeonMapInteractiveItem16", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "rotate/layout/top/reward/#go_rewarditem")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "rotate/layout/top/title/#txt_title")
	slot0._gobg = gohelper.findChild(slot0.viewGO, "rotate/#go_bg")
	slot0._gopagelist = gohelper.findChild(slot0.viewGO, "rotate/#go_pagelist")
	slot0._simagebgimag = gohelper.findChildSingleImage(slot0.viewGO, "rotate/#go_bg/bgimag")
	slot0._txtinfo = gohelper.findChildText(slot0.viewGO, "rotate/#go_bg/#txt_info")
	slot0._gomask = gohelper.findChild(slot0.viewGO, "rotate/#go_bg/#go_mask")
	slot0._goscroll = gohelper.findChild(slot0.viewGO, "rotate/#go_bg/#go_mask/#go_scroll")
	slot0._gochatarea = gohelper.findChild(slot0.viewGO, "rotate/#go_bg/#go_chatarea")
	slot0._gochatitem = gohelper.findChild(slot0.viewGO, "rotate/#go_bg/#go_chatarea/#go_chatitem")
	slot0._goimportanttips = gohelper.findChild(slot0.viewGO, "rotate/#go_bg/#go_importanttips")
	slot0._txttipsinfo = gohelper.findChildText(slot0.viewGO, "rotate/#go_bg/#go_importanttips/bg/#txt_tipsinfo")
	slot0._gofighttip = gohelper.findChild(slot0.viewGO, "rotate/#go_fighttip")
	slot0._txtfighttip = gohelper.findChildText(slot0.viewGO, "rotate/#go_fighttip/#txt_fighttip")
	slot0._btnclosetip = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#btn_closetip")
	slot0._txtfightnumdesc = gohelper.findChildText(slot0.viewGO, "rotate/right/fighttip/fightnum/#txt_fightnumdesc")
	slot0._btnshowtip = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/right/fighttip/fightnum/#txt_fightnumdesc/#btn_showtip")
	slot0._gofight = gohelper.findChild(slot0.viewGO, "rotate/right/#go_fight")
	slot0._txtcost = gohelper.findChildText(slot0.viewGO, "rotate/right/#go_fight/cost/#txt_cost")
	slot0._simagecosticon = gohelper.findChildSingleImage(slot0.viewGO, "rotate/right/#go_fight/cost/#simage_costicon")
	slot0._btnfight = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/right/#go_fight/#btn_fight")
	slot0._gorewardContent = gohelper.findChild(slot0.viewGO, "rotate/reward/#go_rewardContent")
	slot0._goactivityrewarditem = gohelper.findChild(slot0.viewGO, "rotate/reward/#go_rewardContent/#go_activityrewarditem")
	slot0._gorare1 = gohelper.findChild(slot0.viewGO, "rotate/reward/#go_rewardContent/#go_activityrewarditem/rare/#go_rare1")
	slot0._gorare2 = gohelper.findChild(slot0.viewGO, "rotate/reward/#go_rewardContent/#go_activityrewarditem/rare/#go_rare2")
	slot0._gorare3 = gohelper.findChild(slot0.viewGO, "rotate/reward/#go_rewardContent/#go_activityrewarditem/rare/#go_rare3")
	slot0._gorare4 = gohelper.findChild(slot0.viewGO, "rotate/reward/#go_rewardContent/#go_activityrewarditem/rare/#go_rare4")
	slot0._btnright = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#btn_right")
	slot0._btnleft = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#btn_left")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclosetip:AddClickListener(slot0._btnclosetipOnClick, slot0)
	slot0._btnshowtip:AddClickListener(slot0._btnshowtipOnClick, slot0)
	slot0._btnfight:AddClickListener(slot0._btnfightOnClick, slot0)
	slot0._btnright:AddClickListener(slot0._btnrightOnClick, slot0)
	slot0._btnleft:AddClickListener(slot0._btnleftOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclosetip:RemoveClickListener()
	slot0._btnshowtip:RemoveClickListener()
	slot0._btnfight:RemoveClickListener()
	slot0._btnright:RemoveClickListener()
	slot0._btnleft:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btnclosetipOnClick(slot0)
	if slot0._showFightTips == true then
		gohelper.setActive(slot0._gofighttip, false)
	end
end

function slot0._btnrightOnClick(slot0)
	slot0._curEpisodeIndex = slot0._curEpisodeIndex + 1

	slot0:_updateBtns()
end

function slot0._btnleftOnClick(slot0)
	slot0._curEpisodeIndex = slot0._curEpisodeIndex - 1

	slot0:_updateBtns()
end

function slot0._updateBtns(slot0)
	gohelper.setActive(slot0._btnright, slot0._curEpisodeIndex < slot0._episodeLen)
	gohelper.setActive(slot0._btnleft, slot0._curEpisodeIndex > 1)
	gohelper.setSibling(slot0._selectedStar, slot0._curEpisodeIndex)
	slot0:_updateEpisodeInfo()
	slot0:_refreshEpisodeInfo()
end

function slot0._btncloseOnClick(slot0)
	SLFramework.AnimatorPlayer.Get(slot0.viewGO):Play("close", slot0.DESTROYSELF, slot0)
end

function slot0._btnshowtipOnClick(slot0)
	slot0._showFightTips = not slot0._showFightTips

	gohelper.setActive(slot0._gofighttip, slot0._showFightTips)
end

function slot0._btnfightOnClick(slot0)
	slot1 = slot0._episodeConfig.id

	if slot0._episodeMO.todayTotalNum then
		if Activity126Model.instance:getDailyPassNum() < slot0._episodeMO.todayTotalNum then
			if DungeonConfig.instance:getEpisodeCO(slot1) then
				DungeonFightController.instance:enterFight(slot3.chapterId, slot1)
			end
		else
			GameFacade.showToast(ToastEnum.Act114InsufficientChallengeCount)
		end
	end
end

function slot0.onRefreshViewParam(slot0, slot1)
	slot0._config = slot1
end

function slot0.onOpen(slot0)
	slot0._simagebgimag:LoadImage(ResUrl.getV1A3DungeonIcon("v1a3_dungeoninteractive_panelbg"))
	slot0._simagecosticon:LoadImage(ResUrl.getCurrencyItemIcon("204"))

	slot0.rewardItems = slot0:getUserDataTb_()
	slot0._episodeList, slot0._isAll = Activity126Model.instance:getOpenDailyEpisodeList()
	slot0._episodeLen = #slot0._episodeList
	slot1, slot2 = Activity126Model.instance:getRemainNum()

	if slot0._isAll and slot1 > 0 and PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3DailyTip), 0) == 0 then
		PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3DailyTip), 1)
		GameFacade.showToast(ToastEnum.Activity126_tip1)
	end

	slot0:_initPageList()

	slot0._curEpisodeIndex = tabletool.indexOf(slot0._episodeList, DungeonModel.instance:getEpisodeInfo(tonumber(slot0._config.param))) or 1

	slot0:_updateBtns()
	gohelper.setActive(slot0._gofighttip, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
	VersionActivity1_3DungeonController.instance:dispatchEvent(VersionActivity1_3DungeonEvent.OpenDailyInteractiveItem)
end

function slot0._initPageList(slot0)
	slot1 = slot0._episodeLen > 1

	gohelper.setActive(slot0._gopagelist, slot1)

	if slot1 then
		slot0._selectedStar = gohelper.findChild(slot0._gopagelist, "star_select")

		gohelper.setActive(slot0._selectedStar, true)

		for slot6 = 1, slot0._episodeLen - 1 do
			gohelper.setActive(gohelper.cloneInPlace(gohelper.findChild(slot0._gopagelist, "star")), true)
		end
	end
end

function slot0._updateEpisodeInfo(slot0)
	slot0._episodeMO = slot0._episodeList[slot0._curEpisodeIndex]
	slot0._episodeId = slot0._episodeMO.episodeId
	slot0._episodeConfig = DungeonConfig.instance:getEpisodeCO(slot0._episodeId)

	Activity126Model.instance:changeShowDailyId(slot0._episodeId)
	VersionActivity1_3DungeonController.instance:dispatchEvent(VersionActivity1_3DungeonEvent.SelectChangeDaily, slot0._episodeId)
end

function slot0._refreshEpisodeInfo(slot0)
	slot1 = 0

	if not string.nilorempty(slot0._episodeConfig.cost) then
		slot1 = string.splitToNumber(slot0._episodeConfig.cost, "#")[3]
	end

	slot0._txtcost.text = "-" .. slot1

	if slot1 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtcost, "#070706")
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtcost, "#800015")
	end

	slot0._txtinfo.text = slot0._episodeConfig.desc

	if slot0._episodeMO.todayTotalNum then
		slot0._txtfightnumdesc.text = formatLuaLang("left_challenge_count", slot0._episodeMO.todayTotalNum - Activity126Model.instance:getDailyPassNum())
		slot0._txtfighttip.text = ServerTime.ReplaceUTCStr(luaLang("activity_1_3_daily_refresh_rule"))
	else
		slot0._txtfightnumdesc.text = ""
		slot0._txtfighttip.text = ""
	end

	if slot0._episodeMO.todayTotalNum <= slot2 then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._gofight.gameObject:GetComponent(gohelper.Type_Image), "#9c9c9c")
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._gofight.gameObject:GetComponent(gohelper.Type_Image), "#FFFFFF")
	end

	slot0:refreshReward()

	slot0._txttitle.text = slot0._episodeConfig.name
end

function slot0.refreshReward(slot0)
	gohelper.setActive(slot0._goactivityrewarditem, false)

	slot1 = {}
	slot2 = 0
	slot3 = 0

	if slot0._episodeMO and slot0._episodeMO.star ~= DungeonEnum.StarType.Advanced then
		tabletool.addValues(slot1, DungeonModel.instance:getEpisodeAdvancedBonus(slot0._episodeConfig.id))

		slot3 = #slot1
	end

	if slot0._episodeMO and slot0._episodeMO.star == DungeonEnum.StarType.None then
		tabletool.addValues(slot1, DungeonModel.instance:getEpisodeFirstBonus(slot0._episodeConfig.id))

		slot2 = #slot1
	end

	tabletool.addValues(slot1, DungeonModel.instance:getEpisodeRewardDisplayList(slot0._episodeConfig.id))

	if #slot1 == 0 then
		gohelper.setActive(slot0._gorewardcontent, false)

		return
	end

	slot6, slot7 = nil

	for slot11 = 1, math.min(#slot1, 3) do
		if not slot0.rewardItems[slot11] then
			slot7 = slot0:getUserDataTb_()
			slot7.go = gohelper.cloneInPlace(slot0._goactivityrewarditem, "item" .. slot11)
			slot7.iconItem = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot7.go, "itemicon"))
			slot7.gonormal = gohelper.findChild(slot7.go, "rare/#go_rare1")
			slot7.gofirst = gohelper.findChild(slot7.go, "rare/#go_rare2")
			slot7.goadvance = gohelper.findChild(slot7.go, "rare/#go_rare3")
			slot7.gofirsthard = gohelper.findChild(slot7.go, "rare/#go_rare4")
			slot7.txtnormal = gohelper.findChildText(slot7.go, "rare/#go_rare1/txt")

			table.insert(slot0.rewardItems, slot7)
		end

		gohelper.setActive(slot7.gonormal, false)
		gohelper.setActive(slot7.gofirst, false)
		gohelper.setActive(slot7.goadvance, false)
		gohelper.setActive(slot7.gofirsthard, false)

		slot12, slot13 = nil
		slot14 = slot1[slot11][3]
		slot15 = true
		slot12 = slot7.gofirst

		if slot11 <= slot3 then
			gohelper.setActive(slot7.goadvance, true)
		elseif slot11 <= slot2 then
			gohelper.setActive(slot12, true)
		else
			gohelper.setActive(slot7.gonormal, true)

			slot7.txtnormal.text = luaLang("dungeon_prob_flag" .. slot6[3])

			if #slot6 >= 4 then
				slot14 = slot6[4]
			else
				slot15 = false
			end
		end

		slot7.iconItem:setMOValue(slot6[1], slot6[2], slot14, nil, true)
		slot7.iconItem:setCountFontSize(0)
		slot7.iconItem:setHideLvAndBreakFlag(true)
		slot7.iconItem:hideEquipLvAndBreak(true)
		slot7.iconItem:isShowCount(false)
		slot7.iconItem:customOnClickCallback(slot0._onRewardItemClick, slot0)
		gohelper.setActive(slot7.go, true)
	end

	for slot11 = slot5 + 1, #slot0.rewardItems do
		gohelper.setActive(slot0.rewardItems[slot11].go, false)
	end
end

function slot0._onRewardItemClick(slot0)
	DungeonController.instance:openDungeonRewardView(slot0._episodeConfig)
end

function slot0._showCurrency(slot0)
	slot0:com_loadAsset(CurrencyView.prefabPath, slot0._onCurrencyLoaded)
end

function slot0._onCurrencyLoaded(slot0, slot1)
	slot6 = slot0:openSubView(CurrencyView, gohelper.clone(slot1:GetResource(), slot0._topRight), nil, {
		CurrencyEnum.CurrencyType.Power
	})
	slot6.foreShowBtn = true

	slot6:_hideAddBtn()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebgimag:UnLoadImage()
	slot0._simagecosticon:UnLoadImage()
end

return slot0
