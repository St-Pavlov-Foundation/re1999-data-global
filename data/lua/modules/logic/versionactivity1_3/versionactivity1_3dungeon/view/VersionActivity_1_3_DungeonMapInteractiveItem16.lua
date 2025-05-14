module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity_1_3_DungeonMapInteractiveItem16", package.seeall)

local var_0_0 = class("VersionActivity_1_3_DungeonMapInteractiveItem16", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "rotate/layout/top/reward/#go_rewarditem")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "rotate/layout/top/title/#txt_title")
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_bg")
	arg_1_0._gopagelist = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_pagelist")
	arg_1_0._simagebgimag = gohelper.findChildSingleImage(arg_1_0.viewGO, "rotate/#go_bg/bgimag")
	arg_1_0._txtinfo = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_bg/#txt_info")
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_bg/#go_mask")
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_bg/#go_mask/#go_scroll")
	arg_1_0._gochatarea = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_bg/#go_chatarea")
	arg_1_0._gochatitem = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_bg/#go_chatarea/#go_chatitem")
	arg_1_0._goimportanttips = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_bg/#go_importanttips")
	arg_1_0._txttipsinfo = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_bg/#go_importanttips/bg/#txt_tipsinfo")
	arg_1_0._gofighttip = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_fighttip")
	arg_1_0._txtfighttip = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_fighttip/#txt_fighttip")
	arg_1_0._btnclosetip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#btn_closetip")
	arg_1_0._txtfightnumdesc = gohelper.findChildText(arg_1_0.viewGO, "rotate/right/fighttip/fightnum/#txt_fightnumdesc")
	arg_1_0._btnshowtip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/right/fighttip/fightnum/#txt_fightnumdesc/#btn_showtip")
	arg_1_0._gofight = gohelper.findChild(arg_1_0.viewGO, "rotate/right/#go_fight")
	arg_1_0._txtcost = gohelper.findChildText(arg_1_0.viewGO, "rotate/right/#go_fight/cost/#txt_cost")
	arg_1_0._simagecosticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "rotate/right/#go_fight/cost/#simage_costicon")
	arg_1_0._btnfight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/right/#go_fight/#btn_fight")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "rotate/reward/#go_rewardContent")
	arg_1_0._goactivityrewarditem = gohelper.findChild(arg_1_0.viewGO, "rotate/reward/#go_rewardContent/#go_activityrewarditem")
	arg_1_0._gorare1 = gohelper.findChild(arg_1_0.viewGO, "rotate/reward/#go_rewardContent/#go_activityrewarditem/rare/#go_rare1")
	arg_1_0._gorare2 = gohelper.findChild(arg_1_0.viewGO, "rotate/reward/#go_rewardContent/#go_activityrewarditem/rare/#go_rare2")
	arg_1_0._gorare3 = gohelper.findChild(arg_1_0.viewGO, "rotate/reward/#go_rewardContent/#go_activityrewarditem/rare/#go_rare3")
	arg_1_0._gorare4 = gohelper.findChild(arg_1_0.viewGO, "rotate/reward/#go_rewardContent/#go_activityrewarditem/rare/#go_rare4")
	arg_1_0._btnright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#btn_right")
	arg_1_0._btnleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#btn_left")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclosetip:AddClickListener(arg_2_0._btnclosetipOnClick, arg_2_0)
	arg_2_0._btnshowtip:AddClickListener(arg_2_0._btnshowtipOnClick, arg_2_0)
	arg_2_0._btnfight:AddClickListener(arg_2_0._btnfightOnClick, arg_2_0)
	arg_2_0._btnright:AddClickListener(arg_2_0._btnrightOnClick, arg_2_0)
	arg_2_0._btnleft:AddClickListener(arg_2_0._btnleftOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclosetip:RemoveClickListener()
	arg_3_0._btnshowtip:RemoveClickListener()
	arg_3_0._btnfight:RemoveClickListener()
	arg_3_0._btnright:RemoveClickListener()
	arg_3_0._btnleft:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnclosetipOnClick(arg_4_0)
	if arg_4_0._showFightTips == true then
		gohelper.setActive(arg_4_0._gofighttip, false)
	end
end

function var_0_0._btnrightOnClick(arg_5_0)
	arg_5_0._curEpisodeIndex = arg_5_0._curEpisodeIndex + 1

	arg_5_0:_updateBtns()
end

function var_0_0._btnleftOnClick(arg_6_0)
	arg_6_0._curEpisodeIndex = arg_6_0._curEpisodeIndex - 1

	arg_6_0:_updateBtns()
end

function var_0_0._updateBtns(arg_7_0)
	local var_7_0 = arg_7_0._curEpisodeIndex < arg_7_0._episodeLen

	gohelper.setActive(arg_7_0._btnright, var_7_0)

	local var_7_1 = arg_7_0._curEpisodeIndex > 1

	gohelper.setActive(arg_7_0._btnleft, var_7_1)
	gohelper.setSibling(arg_7_0._selectedStar, arg_7_0._curEpisodeIndex)
	arg_7_0:_updateEpisodeInfo()
	arg_7_0:_refreshEpisodeInfo()
end

function var_0_0._btncloseOnClick(arg_8_0)
	SLFramework.AnimatorPlayer.Get(arg_8_0.viewGO):Play("close", arg_8_0.DESTROYSELF, arg_8_0)
end

function var_0_0._btnshowtipOnClick(arg_9_0)
	arg_9_0._showFightTips = not arg_9_0._showFightTips

	gohelper.setActive(arg_9_0._gofighttip, arg_9_0._showFightTips)
end

function var_0_0._btnfightOnClick(arg_10_0)
	local var_10_0 = arg_10_0._episodeConfig.id
	local var_10_1 = Activity126Model.instance:getDailyPassNum()

	if arg_10_0._episodeMO.todayTotalNum then
		if var_10_1 < arg_10_0._episodeMO.todayTotalNum then
			local var_10_2 = DungeonConfig.instance:getEpisodeCO(var_10_0)

			if var_10_2 then
				DungeonFightController.instance:enterFight(var_10_2.chapterId, var_10_0)
			end
		else
			GameFacade.showToast(ToastEnum.Act114InsufficientChallengeCount)
		end
	end
end

function var_0_0.onRefreshViewParam(arg_11_0, arg_11_1)
	arg_11_0._config = arg_11_1
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._simagebgimag:LoadImage(ResUrl.getV1A3DungeonIcon("v1a3_dungeoninteractive_panelbg"))
	arg_12_0._simagecosticon:LoadImage(ResUrl.getCurrencyItemIcon("204"))

	arg_12_0.rewardItems = arg_12_0:getUserDataTb_()
	arg_12_0._episodeList, arg_12_0._isAll = Activity126Model.instance:getOpenDailyEpisodeList()
	arg_12_0._episodeLen = #arg_12_0._episodeList

	local var_12_0, var_12_1 = Activity126Model.instance:getRemainNum()

	if arg_12_0._isAll and var_12_0 > 0 and PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3DailyTip), 0) == 0 then
		PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityDungeon1_3DailyTip), 1)
		GameFacade.showToast(ToastEnum.Activity126_tip1)
	end

	arg_12_0:_initPageList()

	local var_12_2 = DungeonModel.instance:getEpisodeInfo(tonumber(arg_12_0._config.param))

	arg_12_0._curEpisodeIndex = tabletool.indexOf(arg_12_0._episodeList, var_12_2) or 1

	arg_12_0:_updateBtns()
	gohelper.setActive(arg_12_0._gofighttip, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
	VersionActivity1_3DungeonController.instance:dispatchEvent(VersionActivity1_3DungeonEvent.OpenDailyInteractiveItem)
end

function var_0_0._initPageList(arg_13_0)
	local var_13_0 = arg_13_0._episodeLen > 1

	gohelper.setActive(arg_13_0._gopagelist, var_13_0)

	if var_13_0 then
		local var_13_1 = gohelper.findChild(arg_13_0._gopagelist, "star")

		arg_13_0._selectedStar = gohelper.findChild(arg_13_0._gopagelist, "star_select")

		gohelper.setActive(arg_13_0._selectedStar, true)

		for iter_13_0 = 1, arg_13_0._episodeLen - 1 do
			local var_13_2 = gohelper.cloneInPlace(var_13_1)

			gohelper.setActive(var_13_2, true)
		end
	end
end

function var_0_0._updateEpisodeInfo(arg_14_0)
	arg_14_0._episodeMO = arg_14_0._episodeList[arg_14_0._curEpisodeIndex]
	arg_14_0._episodeId = arg_14_0._episodeMO.episodeId
	arg_14_0._episodeConfig = DungeonConfig.instance:getEpisodeCO(arg_14_0._episodeId)

	Activity126Model.instance:changeShowDailyId(arg_14_0._episodeId)
	VersionActivity1_3DungeonController.instance:dispatchEvent(VersionActivity1_3DungeonEvent.SelectChangeDaily, arg_14_0._episodeId)
end

function var_0_0._refreshEpisodeInfo(arg_15_0)
	local var_15_0 = 0

	if not string.nilorempty(arg_15_0._episodeConfig.cost) then
		var_15_0 = string.splitToNumber(arg_15_0._episodeConfig.cost, "#")[3]
	end

	arg_15_0._txtcost.text = "-" .. var_15_0

	if var_15_0 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(arg_15_0._txtcost, "#070706")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_15_0._txtcost, "#800015")
	end

	arg_15_0._txtinfo.text = arg_15_0._episodeConfig.desc

	local var_15_1 = Activity126Model.instance:getDailyPassNum()

	if arg_15_0._episodeMO.todayTotalNum then
		arg_15_0._txtfightnumdesc.text = formatLuaLang("left_challenge_count", arg_15_0._episodeMO.todayTotalNum - var_15_1)

		local var_15_2 = luaLang("activity_1_3_daily_refresh_rule")

		arg_15_0._txtfighttip.text = ServerTime.ReplaceUTCStr(var_15_2)
	else
		arg_15_0._txtfightnumdesc.text = ""
		arg_15_0._txtfighttip.text = ""
	end

	if var_15_1 >= arg_15_0._episodeMO.todayTotalNum then
		SLFramework.UGUI.GuiHelper.SetColor(arg_15_0._gofight.gameObject:GetComponent(gohelper.Type_Image), "#9c9c9c")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_15_0._gofight.gameObject:GetComponent(gohelper.Type_Image), "#FFFFFF")
	end

	arg_15_0:refreshReward()

	arg_15_0._txttitle.text = arg_15_0._episodeConfig.name
end

function var_0_0.refreshReward(arg_16_0)
	gohelper.setActive(arg_16_0._goactivityrewarditem, false)

	local var_16_0 = {}
	local var_16_1 = 0
	local var_16_2 = 0

	if arg_16_0._episodeMO and arg_16_0._episodeMO.star ~= DungeonEnum.StarType.Advanced then
		tabletool.addValues(var_16_0, DungeonModel.instance:getEpisodeAdvancedBonus(arg_16_0._episodeConfig.id))

		var_16_2 = #var_16_0
	end

	if arg_16_0._episodeMO and arg_16_0._episodeMO.star == DungeonEnum.StarType.None then
		tabletool.addValues(var_16_0, DungeonModel.instance:getEpisodeFirstBonus(arg_16_0._episodeConfig.id))

		var_16_1 = #var_16_0
	end

	tabletool.addValues(var_16_0, DungeonModel.instance:getEpisodeRewardDisplayList(arg_16_0._episodeConfig.id))

	if #var_16_0 == 0 then
		gohelper.setActive(arg_16_0._gorewardcontent, false)

		return
	end

	local var_16_3 = math.min(#var_16_0, 3)
	local var_16_4
	local var_16_5

	for iter_16_0 = 1, var_16_3 do
		local var_16_6 = arg_16_0.rewardItems[iter_16_0]

		if not var_16_6 then
			var_16_6 = arg_16_0:getUserDataTb_()
			var_16_6.go = gohelper.cloneInPlace(arg_16_0._goactivityrewarditem, "item" .. iter_16_0)
			var_16_6.iconItem = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(var_16_6.go, "itemicon"))
			var_16_6.gonormal = gohelper.findChild(var_16_6.go, "rare/#go_rare1")
			var_16_6.gofirst = gohelper.findChild(var_16_6.go, "rare/#go_rare2")
			var_16_6.goadvance = gohelper.findChild(var_16_6.go, "rare/#go_rare3")
			var_16_6.gofirsthard = gohelper.findChild(var_16_6.go, "rare/#go_rare4")
			var_16_6.txtnormal = gohelper.findChildText(var_16_6.go, "rare/#go_rare1/txt")

			table.insert(arg_16_0.rewardItems, var_16_6)
		end

		local var_16_7 = var_16_0[iter_16_0]

		gohelper.setActive(var_16_6.gonormal, false)
		gohelper.setActive(var_16_6.gofirst, false)
		gohelper.setActive(var_16_6.goadvance, false)
		gohelper.setActive(var_16_6.gofirsthard, false)

		local var_16_8
		local var_16_9
		local var_16_10 = var_16_7[3]
		local var_16_11 = true
		local var_16_12 = var_16_6.gofirst
		local var_16_13 = var_16_6.goadvance

		if iter_16_0 <= var_16_2 then
			gohelper.setActive(var_16_13, true)
		elseif iter_16_0 <= var_16_1 then
			gohelper.setActive(var_16_12, true)
		else
			gohelper.setActive(var_16_6.gonormal, true)

			var_16_6.txtnormal.text = luaLang("dungeon_prob_flag" .. var_16_7[3])

			if #var_16_7 >= 4 then
				var_16_10 = var_16_7[4]
			else
				local var_16_14 = false
			end
		end

		var_16_6.iconItem:setMOValue(var_16_7[1], var_16_7[2], var_16_10, nil, true)
		var_16_6.iconItem:setCountFontSize(0)
		var_16_6.iconItem:setHideLvAndBreakFlag(true)
		var_16_6.iconItem:hideEquipLvAndBreak(true)
		var_16_6.iconItem:isShowCount(false)
		var_16_6.iconItem:customOnClickCallback(arg_16_0._onRewardItemClick, arg_16_0)
		gohelper.setActive(var_16_6.go, true)
	end

	for iter_16_1 = var_16_3 + 1, #arg_16_0.rewardItems do
		gohelper.setActive(arg_16_0.rewardItems[iter_16_1].go, false)
	end
end

function var_0_0._onRewardItemClick(arg_17_0)
	DungeonController.instance:openDungeonRewardView(arg_17_0._episodeConfig)
end

function var_0_0._showCurrency(arg_18_0)
	arg_18_0:com_loadAsset(CurrencyView.prefabPath, arg_18_0._onCurrencyLoaded)
end

function var_0_0._onCurrencyLoaded(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1:GetResource()
	local var_19_1 = gohelper.clone(var_19_0, arg_19_0._topRight)
	local var_19_2 = CurrencyEnum.CurrencyType
	local var_19_3 = {
		var_19_2.Power
	}
	local var_19_4 = arg_19_0:openSubView(CurrencyView, var_19_1, nil, var_19_3)

	var_19_4.foreShowBtn = true

	var_19_4:_hideAddBtn()
end

function var_0_0.onClose(arg_20_0)
	return
end

function var_0_0.onDestroyView(arg_21_0)
	arg_21_0._simagebgimag:UnLoadImage()
	arg_21_0._simagecosticon:UnLoadImage()
end

return var_0_0
