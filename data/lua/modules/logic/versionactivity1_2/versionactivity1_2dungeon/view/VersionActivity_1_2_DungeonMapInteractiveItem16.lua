module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_DungeonMapInteractiveItem16", package.seeall)

local var_0_0 = class("VersionActivity_1_2_DungeonMapInteractiveItem16", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._topRight = gohelper.findChild(arg_1_0.viewGO, "topRight")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "rotate/layout/top/reward/#go_rewarditem")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "rotate/layout/top/title/#txt_title")
	arg_1_0._gofighttip = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_fighttip")
	arg_1_0._txtfighttip = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_fighttip/#txt_fighttip")
	arg_1_0._gotrap = gohelper.findChild(arg_1_0.viewGO, "rotate/right/fighttip/#go_trap")
	arg_1_0._gotraptip = gohelper.findChild(arg_1_0.viewGO, "rotate/right/fighttip/#go_trap/#go_traptip")
	arg_1_0._txtfightnumdesc = gohelper.findChildText(arg_1_0.viewGO, "rotate/right/fighttip/fightnum/#txt_fightnumdesc")
	arg_1_0._btnshowtip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/right/fighttip/fightnum/#txt_fightnumdesc/#btn_showtip")
	arg_1_0._gofight = gohelper.findChild(arg_1_0.viewGO, "rotate/right/#go_fight")
	arg_1_0._txtcost = gohelper.findChildText(arg_1_0.viewGO, "rotate/right/#go_fight/cost/#txt_cost")
	arg_1_0._simagecosticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "rotate/right/#go_fight/cost/#simage_costicon")
	arg_1_0._btnfight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/right/#go_fight/#btn_fight")
	arg_1_0._btnclosetip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#btn_closetip")
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_bg")
	arg_1_0._txtinfo = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_bg/content/#txt_info")
	arg_1_0._txtrecommendlv = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_bg/content/#txt_recommendlv")
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_bg/#go_mask")
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_bg/#go_mask/#go_scroll")
	arg_1_0._gochatarea = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_bg/#go_chatarea")
	arg_1_0._gochatitem = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_bg/#go_chatarea/#go_chatitem")
	arg_1_0._goimportanttips = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_bg/#go_importanttips")
	arg_1_0._txttipsinfo = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_bg/#go_importanttips/bg/#txt_tipsinfo")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "rotate/reward")
	arg_1_0._gorewardcontent = gohelper.findChild(arg_1_0.viewGO, "rotate/reward/#go_rewardContent")
	arg_1_0._goactivityrewarditem = gohelper.findChild(arg_1_0.viewGO, "rotate/reward/#go_rewardContent/#go_activityrewarditem")
	arg_1_0._simagebgimag = gohelper.findChildSingleImage(arg_1_0.viewGO, "rotate/#go_bg/bgimag")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnshowtip:AddClickListener(arg_2_0._btnshowtipOnClick, arg_2_0)
	arg_2_0._btnclosetip:AddClickListener(arg_2_0._btnclsoetipOnClick, arg_2_0)
	arg_2_0._btnfight:AddClickListener(arg_2_0._btnfightOnClick, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeChildElementView, arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnshowtip:RemoveClickListener()
	arg_3_0._btnclosetip:RemoveClickListener()
	arg_3_0._btnfight:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	SLFramework.AnimatorPlayer.Get(arg_4_0.viewGO):Play("close", arg_4_0.DESTROYSELF, arg_4_0)
end

function var_0_0._btnshowtipOnClick(arg_5_0)
	arg_5_0._showFightTips = not arg_5_0._showFightTips

	gohelper.setActive(arg_5_0._gofighttip, arg_5_0._showFightTips)
end

function var_0_0._btnclsoetipOnClick(arg_6_0)
	if arg_6_0._showFightTips == true then
		gohelper.setActive(arg_6_0._gofighttip, false)
	end
end

function var_0_0._btnfightOnClick(arg_7_0)
	local var_7_0 = arg_7_0._episodeConfig.id
	local var_7_1 = DungeonConfig.instance:getEpisodeCO(var_7_0)

	if var_7_1 then
		DungeonFightController.instance:enterFight(var_7_1.chapterId, var_7_0)
	end
end

function var_0_0.onRefreshViewParam(arg_8_0, arg_8_1)
	arg_8_0._config = arg_8_1
end

function var_0_0._getEpisodeConfig(arg_9_0)
	return VersionActivity1_2DungeonModel.instance:getDailyEpisodeConfigByElementId(arg_9_0._config.id)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._simagebgimag:LoadImage(ResUrl.getVersionActivityDungeon_1_2("tanchaung_di"))
	arg_10_0._simagecosticon:LoadImage(ResUrl.getCurrencyItemIcon("204"))
	gohelper.setActive(arg_10_0._gofighttip, false)

	arg_10_0._episodeConfig = arg_10_0:_getEpisodeConfig()
	arg_10_0._episodeMO = DungeonModel.instance:getEpisodeInfo(arg_10_0._episodeConfig.id)

	if not arg_10_0._episodeMO then
		arg_10_0._episodeMO = UserDungeonMO.New()

		arg_10_0._episodeMO:initFromManual(arg_10_0._episodeConfig.chapterId, arg_10_0._episodeConfig.id, 0, 0)
	end

	local var_10_0 = 0

	if not string.nilorempty(arg_10_0._episodeConfig.cost) then
		var_10_0 = string.splitToNumber(arg_10_0._episodeConfig.cost, "#")[3]
	end

	arg_10_0._txtcost.text = "-" .. var_10_0

	if var_10_0 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._txtcost, "#070706")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._txtcost, "#800015")
	end

	arg_10_0._txtinfo.text = arg_10_0._episodeConfig.desc
	arg_10_0._txtfightnumdesc.text = ""
	arg_10_0._txtfighttip.text = ""

	SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._gofight.gameObject:GetComponent(gohelper.Type_Image), "#FFFFFF")
	arg_10_0:refreshReward()
	gohelper.setActive(arg_10_0._gotrap, VersionActivity1_2DungeonModel.instance:getTrapPutting())

	arg_10_0._txttitle.text = arg_10_0._episodeConfig.name

	local var_10_1 = FightHelper.getEpisodeRecommendLevel(arg_10_0._episodeConfig.id)

	gohelper.setActive(arg_10_0._txtrecommendlv.gameObject, var_10_1 > 0)

	if var_10_1 > 0 then
		arg_10_0._txtrecommendlv.text = string.format("<color=#E99B56>%s</color>", luaLang("dungeon_recommend_lv") .. HeroConfig.instance:getCommonLevelDisplay(var_10_1))
	end
end

function var_0_0.onOpenFinish(arg_11_0)
	local var_11_0 = VersionActivity1_2DungeonModel.instance:getTrapPutting()
	local var_11_1 = var_11_0 and var_11_0 ~= 0

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onDailyEpisodeItemOpen, tostring(var_11_1))
end

function var_0_0.refreshReward(arg_12_0)
	gohelper.setActive(arg_12_0._goactivityrewarditem, false)

	local var_12_0 = {}
	local var_12_1 = 0
	local var_12_2 = 0

	arg_12_0.rewardItems = {}

	if arg_12_0._episodeMO and arg_12_0._episodeMO.star ~= DungeonEnum.StarType.Advanced then
		tabletool.addValues(var_12_0, DungeonModel.instance:getEpisodeAdvancedBonus(arg_12_0._episodeConfig.id))

		var_12_2 = #var_12_0
	end

	if arg_12_0._episodeMO and arg_12_0._episodeMO.star == DungeonEnum.StarType.None then
		tabletool.addValues(var_12_0, DungeonModel.instance:getEpisodeFirstBonus(arg_12_0._episodeConfig.id))

		var_12_1 = #var_12_0
	end

	tabletool.addValues(var_12_0, DungeonModel.instance:getEpisodeRewardDisplayList(arg_12_0._episodeConfig.id))

	if #var_12_0 == 0 then
		gohelper.setActive(arg_12_0._goreward, false)

		return
	end

	local var_12_3 = math.min(#var_12_0, 3)
	local var_12_4
	local var_12_5

	for iter_12_0 = 1, var_12_3 do
		local var_12_6 = arg_12_0.rewardItems[iter_12_0]

		if not var_12_6 then
			var_12_6 = arg_12_0:getUserDataTb_()
			var_12_6.go = gohelper.cloneInPlace(arg_12_0._goactivityrewarditem, "item" .. iter_12_0)
			var_12_6.iconItem = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(var_12_6.go, "itemicon"))
			var_12_6.gonormal = gohelper.findChild(var_12_6.go, "rare/#go_rare1")
			var_12_6.gofirst = gohelper.findChild(var_12_6.go, "rare/#go_rare2")
			var_12_6.goadvance = gohelper.findChild(var_12_6.go, "rare/#go_rare3")
			var_12_6.gofirsthard = gohelper.findChild(var_12_6.go, "rare/#go_rare4")
			var_12_6.txtnormal = gohelper.findChildText(var_12_6.go, "rare/#go_rare1/txt")
			var_12_6.count = gohelper.findChildText(var_12_6.go, "countbg/count")

			table.insert(arg_12_0.rewardItems, var_12_6)
		end

		local var_12_7 = var_12_0[iter_12_0]

		gohelper.setActive(var_12_6.gonormal, false)
		gohelper.setActive(var_12_6.gofirst, false)
		gohelper.setActive(var_12_6.goadvance, false)
		gohelper.setActive(var_12_6.gofirsthard, false)

		local var_12_8
		local var_12_9
		local var_12_10 = var_12_7[3]
		local var_12_11 = true
		local var_12_12 = var_12_6.gofirst
		local var_12_13 = var_12_6.goadvance

		if iter_12_0 <= var_12_2 then
			gohelper.setActive(var_12_13, true)
		elseif iter_12_0 <= var_12_1 then
			gohelper.setActive(var_12_12, true)
		else
			gohelper.setActive(var_12_6.gonormal, true)

			var_12_6.txtnormal.text = luaLang("dungeon_prob_flag" .. var_12_7[3])

			if #var_12_7 >= 4 then
				var_12_10 = var_12_7[4]
			else
				var_12_11 = false
			end
		end

		var_12_6.iconItem:setMOValue(var_12_7[1], var_12_7[2], var_12_10, nil, true)
		var_12_6.iconItem:setCountFontSize(0)
		var_12_6.iconItem:setHideLvAndBreakFlag(true)
		var_12_6.iconItem:hideEquipLvAndBreak(true)
		var_12_6.iconItem:isShowCount(var_12_11)
		var_12_6.iconItem:customOnClickCallback(arg_12_0._onRewardItemClick, arg_12_0)
		gohelper.setActive(var_12_6.count.gameObject, var_12_11)

		var_12_6.count.text = var_12_10

		gohelper.setActive(var_12_6.go, true)
	end

	for iter_12_1 = var_12_3 + 1, #arg_12_0.rewardItems do
		gohelper.setActive(arg_12_0.rewardItems[iter_12_1].go, false)
	end
end

function var_0_0._onRewardItemClick(arg_13_0)
	DungeonController.instance:openDungeonRewardView(arg_13_0._episodeConfig)
end

function var_0_0._showCurrency(arg_14_0)
	arg_14_0:com_loadAsset(CurrencyView.prefabPath, arg_14_0._onCurrencyLoaded)
end

function var_0_0._onCurrencyLoaded(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1:GetResource()
	local var_15_1 = gohelper.clone(var_15_0, arg_15_0._topRight)
	local var_15_2 = CurrencyEnum.CurrencyType
	local var_15_3 = {
		var_15_2.Power
	}
	local var_15_4 = arg_15_0:openSubView(CurrencyView, var_15_1, nil, var_15_3)

	var_15_4.foreShowBtn = true

	var_15_4:_hideAddBtn()
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	arg_17_0._simagebgimag:UnLoadImage()
	arg_17_0._simagecosticon:UnLoadImage()
end

return var_0_0
