module("modules.logic.season.view3_0.Season3_0SpecialMarketView", package.seeall)

local var_0_0 = class("Season3_0SpecialMarketView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "#go_info")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_info/bg/#simage_bg1")
	arg_1_0._simagepage = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_info/left/#simage_page")
	arg_1_0._simagestageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_info/left/#simage_stageicon")
	arg_1_0._txtlevelnamecn = gohelper.findChildText(arg_1_0.viewGO, "#go_info/left/#txt_levelnamecn")
	arg_1_0._descScroll = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/Scroll View")
	arg_1_0._animScroll = arg_1_0._descScroll:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._descContent = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/Scroll View/Viewport/Content")
	arg_1_0._goDescItem = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/Scroll View/Viewport/Content/#go_descitem")
	arg_1_0._txtcurindex = gohelper.findChildText(arg_1_0.viewGO, "#go_info/right/position/center/#txt_curindex")
	arg_1_0._txtmaxindex = gohelper.findChildText(arg_1_0.viewGO, "#go_info/right/position/center/#txt_maxindex")
	arg_1_0._btnlast = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/right/position/#btn_last")
	arg_1_0._btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/right/position/#btn_next")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_info/right/#txt_desc")
	arg_1_0._txtenemylv = gohelper.findChildText(arg_1_0.viewGO, "#go_info/right/enemylv/enemylv/#txt_enemylv")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/right/btns/#btn_start")
	arg_1_0._gopart = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/#go_part")
	arg_1_0._gostage = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/#go_part/#go_stage")
	arg_1_0._gostagelvlitem = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/#go_part/#go_stage/list/#go_stagelvlitem")
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlock")
	arg_1_0._gounlocktype1 = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlock/#go_unlocktype1")
	arg_1_0._gounlocktype2 = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlock/#go_unlocktype2")
	arg_1_0._gounlocktype3 = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlock/#go_unlocktype3")
	arg_1_0._scrollrewards = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_rewarditem")
	arg_1_0._golevel = gohelper.findChild(arg_1_0.viewGO, "#go_level")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_level/#simage_bg")
	arg_1_0._simageleveldecorate = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_level/decorate/#simage_leveldecorate")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_level/decorate/#simage_line")
	arg_1_0._goscrolllv = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_scrolllv")
	arg_1_0._goscrolllvcontent = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_scrolllv/Viewport/Content")
	arg_1_0._gofront = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_front")
	arg_1_0._golvitem = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#go_line")
	arg_1_0._goselectedpass = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#go_selectedpass")
	arg_1_0._txtselectpassindex = gohelper.findChildText(arg_1_0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#go_selectedpass/#txt_selectpassindex")
	arg_1_0._gopass = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#go_pass")
	arg_1_0._txtpassindex = gohelper.findChildText(arg_1_0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#go_pass/#txt_passindex")
	arg_1_0._gounpass = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#go_unpass")
	arg_1_0._txtunpassindex = gohelper.findChildText(arg_1_0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#go_unpass/#txt_unpassindex")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#btn_click")
	arg_1_0._gorear = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_rear")
	arg_1_0._gostagelvitem1 = gohelper.findChild(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem1")
	arg_1_0._gostagelvitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem2")
	arg_1_0._gostagelvitem3 = gohelper.findChild(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem3")
	arg_1_0._gostagelvitem4 = gohelper.findChild(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem4")
	arg_1_0._gostagelvitem5 = gohelper.findChild(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem5")
	arg_1_0._gostagelvitem6 = gohelper.findChild(arg_1_0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem6")
	arg_1_0._btnlvstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_level/#btn_lvstart")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gopartempty = gohelper.findChild(arg_1_0.viewGO, "#go_info/right/layout/#go_partempty")
	arg_1_0._simageempty = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_info/right/layout/#go_partempty/#simage_empty")
	arg_1_0._goleftscrolltopmask = gohelper.findChild(arg_1_0.viewGO, "#go_info/left/Scroll View/mask2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlast:AddClickListener(arg_2_0._btnlastOnClick, arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnlvstart:AddClickListener(arg_2_0._btnlvstartOnClick, arg_2_0)
	arg_2_0:addEventCb(Activity104Controller.instance, Activity104Event.StartAct104BattleReply, arg_2_0._onBattleReply, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlast:RemoveClickListener()
	arg_3_0._btnnext:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnlvstart:RemoveClickListener()
	arg_3_0:removeEventCb(Activity104Controller.instance, Activity104Event.StartAct104BattleReply, arg_3_0._onBattleReply, arg_3_0)
end

function var_0_0._onBattleReply(arg_4_0, arg_4_1)
	Activity104Model.instance:onStartAct104BattleReply(arg_4_1)
end

function var_0_0._btnlvstartOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._goinfo, true)
	gohelper.setActive(arg_5_0._golevel, false)
	arg_5_0:_refreshInfo()
end

function var_0_0._btnlastOnClick(arg_6_0)
	local var_6_0 = arg_6_0._layer - 1

	if var_6_0 < 1 then
		return
	end

	local var_6_1 = Activity104Model.instance:getCurSeasonId()
	local var_6_2, var_6_3 = Activity104Model.instance:isSpecialLayerOpen(var_6_1, var_6_0)

	if not var_6_2 then
		local var_6_4 = math.ceil(var_6_3 / TimeUtil.OneDaySecond)
		local var_6_5 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("season166_unlockHardEpisodeTime"), var_6_4)

		GameFacade.showToastString(var_6_5)

		return
	end

	arg_6_0._layer = var_6_0

	arg_6_0._animScroll:Play(UIAnimationName.Switch, 0, 0)
	arg_6_0:_refreshInfo()
end

function var_0_0._btnnextOnClick(arg_7_0)
	local var_7_0 = Activity104Model.instance:getMaxSpecialLayer()
	local var_7_1 = arg_7_0._layer + 1

	if var_7_0 < var_7_1 then
		return
	end

	local var_7_2 = Activity104Model.instance:getCurSeasonId()
	local var_7_3, var_7_4 = Activity104Model.instance:isSpecialLayerOpen(var_7_2, var_7_1)

	if not var_7_3 then
		local var_7_5 = math.ceil(var_7_4 / TimeUtil.OneDaySecond)
		local var_7_6 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("season166_unlockHardEpisodeTime"), var_7_5)

		GameFacade.showToastString(var_7_6)

		return
	end

	arg_7_0._layer = var_7_1

	arg_7_0._animScroll:Play(UIAnimationName.Switch, 0, 0)
	arg_7_0:_refreshInfo()
end

function var_0_0._btnstartOnClick(arg_8_0)
	local var_8_0 = Activity104Model.instance:getCurSeasonId()
	local var_8_1 = SeasonConfig.instance:getSeasonSpecialCo(var_8_0, arg_8_0._layer).episodeId

	Activity104Model.instance:enterAct104Battle(var_8_1, arg_8_0._layer)
end

function var_0_0._btnclickOnClick(arg_9_0)
	return
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._simagebg:LoadImage(ResUrl.getSeasonIcon("full/img_bg.png"))
	arg_10_0._simagepage:LoadImage(SeasonViewHelper.getSeasonIcon("shuye.png"))
	arg_10_0._simageempty:LoadImage(SeasonViewHelper.getSeasonIcon("kongzhuangtai.png"))
	arg_10_0._simageline:LoadImage(ResUrl.getSeasonIcon("img_circle.png"))
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	gohelper.setActive(arg_12_0._golevel, true)
	gohelper.setActive(arg_12_0._goinfo, false)
	arg_12_0:addEventCb(Activity104Controller.instance, Activity104Event.SwitchSpecialEpisode, arg_12_0._onSwitchEpisode, arg_12_0)

	arg_12_0._showLvItems = {}
	arg_12_0._rewardItems = {}

	local var_12_0
	local var_12_1

	if arg_12_0.viewParam then
		var_12_0 = arg_12_0.viewParam.defaultSelectLayer

		if arg_12_0.viewParam.directOpenLayer then
			var_12_1 = true
		end
	end

	arg_12_0._layer = var_12_0 or Activity104Model.instance:getAct104SpecialInitLayer()

	arg_12_0:_refreshLevel()

	if var_12_1 then
		arg_12_0:_btnlvstartOnClick()
	else
		arg_12_0:gotoScroll()
	end
end

function var_0_0.gotoScroll(arg_13_0)
	local var_13_0 = arg_13_0._goscrolllvcontent.transform

	ZProj.UGUIHelper.RebuildLayout(var_13_0)

	local var_13_1 = arg_13_0._layer
	local var_13_2 = arg_13_0._showLvItems[var_13_1]

	if var_13_2 then
		local var_13_3 = recthelper.getAnchorX(var_13_2.transform) - 50
		local var_13_4 = recthelper.getWidth(var_13_0) - recthelper.getWidth(arg_13_0._goscrolllv.transform)
		local var_13_5 = math.max(0, var_13_4)
		local var_13_6 = math.min(var_13_5, var_13_3)

		recthelper.setAnchorX(var_13_0, -var_13_6)
	end
end

function var_0_0.onClose(arg_14_0)
	arg_14_0:removeEventCb(Activity104Controller.instance, Activity104Event.SwitchSpecialEpisode, arg_14_0._onSwitchEpisode, arg_14_0)
end

function var_0_0._onSwitchEpisode(arg_15_0, arg_15_1)
	arg_15_0._layer = arg_15_1

	arg_15_0:_refreshLevel()
end

function var_0_0._refreshLevel(arg_16_0)
	local var_16_0 = Activity104Model.instance:getMaxSpecialLayer()

	for iter_16_0 = 1, var_16_0 do
		if not arg_16_0._showLvItems[iter_16_0] then
			local var_16_1 = gohelper.cloneInPlace(arg_16_0._golvitem)

			arg_16_0._showLvItems[iter_16_0] = Season3_0SpecialMarketShowLevelItem.New()

			arg_16_0._showLvItems[iter_16_0]:init(var_16_1)
		end

		arg_16_0._showLvItems[iter_16_0]:reset(iter_16_0, arg_16_0._layer, var_16_0)
	end

	gohelper.setAsLastSibling(arg_16_0._gorear)

	local var_16_2 = SeasonConfig.instance:getSeasonSpecialCo(Activity104Model.instance:getCurSeasonId(), arg_16_0._layer)

	arg_16_0._simageleveldecorate:LoadImage(SeasonViewHelper.getSeasonIcon(string.format("icon/ty_chatu_%s.png", var_16_2.icon)))
end

function var_0_0._refreshInfo(arg_17_0)
	local var_17_0 = SeasonConfig.instance:getSeasonSpecialCo(Activity104Model.instance:getCurSeasonId(), arg_17_0._layer)

	arg_17_0._txtlevelnamecn.text = var_17_0.name
	arg_17_0._txtcurindex.text = string.format("%02d", arg_17_0._layer)

	local var_17_1 = Activity104Model.instance:getMaxSpecialLayer()

	arg_17_0._txtmaxindex.text = string.format("%02d", var_17_1)
	arg_17_0._txtenemylv.text = HeroConfig.instance:getCommonLevelDisplay(var_17_0.level)

	arg_17_0._simagestageicon:LoadImage(SeasonViewHelper.getSeasonIcon(string.format("icon/a_chatu_%s.png", var_17_0.icon)))

	local var_17_2 = DungeonConfig.instance:getEpisodeCO(var_17_0.episodeId)

	arg_17_0._txtdesc.text = var_17_2.desc

	gohelper.setActive(arg_17_0._gorewarditem, false)

	local var_17_3 = DungeonModel.instance:getEpisodeFirstBonus(var_17_0.episodeId)

	for iter_17_0 = 1, math.max(#arg_17_0._rewardItems, #var_17_3) do
		local var_17_4 = arg_17_0._rewardItems[iter_17_0] or arg_17_0:createRewardItem(iter_17_0)

		arg_17_0:refreshRewardItem(var_17_4, var_17_3[iter_17_0])
	end

	gohelper.setActive(arg_17_0._gopart, false)
	gohelper.setActive(arg_17_0._gopartempty, true)

	arg_17_0._btnlast.button.interactable = arg_17_0._layer > 1
	arg_17_0._btnnext.button.interactable = arg_17_0._layer < Activity104Model.instance:getMaxSpecialLayer()

	arg_17_0:updateLeftDesc()
end

function var_0_0.createRewardItem(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getUserDataTb_()
	local var_18_1 = gohelper.cloneInPlace(arg_18_0._gorewarditem, "reward_" .. tostring(arg_18_1))

	var_18_0.go = var_18_1
	var_18_0.itemParent = gohelper.findChild(var_18_1, "go_prop")
	var_18_0.cardParent = gohelper.findChild(var_18_1, "go_card")
	var_18_0.receive = gohelper.findChild(var_18_1, "go_receive")
	arg_18_0._rewardItems[arg_18_1] = var_18_0

	return var_18_0
end

function var_0_0.refreshRewardItem(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_2 then
		gohelper.setActive(arg_19_1.go, false)

		return
	end

	if not arg_19_1.itemIcon then
		arg_19_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_19_1.itemParent)
	end

	arg_19_1.itemIcon:setMOValue(tonumber(arg_19_2[1]), tonumber(arg_19_2[2]), tonumber(arg_19_2[3]), nil, true)
	arg_19_1.itemIcon:isShowCount(tonumber(arg_19_2[1]) ~= MaterialEnum.MaterialType.Hero)
	arg_19_1.itemIcon:setCountFontSize(40)
	arg_19_1.itemIcon:showStackableNum2()
	arg_19_1.itemIcon:setHideLvAndBreakFlag(true)
	arg_19_1.itemIcon:hideEquipLvAndBreak(true)
	gohelper.setActive(arg_19_1.go, true)
	gohelper.setActive(arg_19_1.receive, Activity104Model.instance:isSpecialLayerPassed(arg_19_0._layer))
end

function var_0_0.updateLeftDesc(arg_20_0)
	if not arg_20_0.descItems then
		arg_20_0.descItems = {}
	end

	local var_20_0 = SeasonConfig.instance:getSeasonSpecialCos(Activity104Model.instance:getCurSeasonId())
	local var_20_1 = {}

	if var_20_0 then
		for iter_20_0, iter_20_1 in pairs(var_20_0) do
			table.insert(var_20_1, iter_20_1)
		end

		table.sort(var_20_1, function(arg_21_0, arg_21_1)
			return arg_21_0.layer < arg_21_1.layer
		end)
	end

	arg_20_0._curDescItem = nil

	for iter_20_2 = 1, math.max(#var_20_1, #arg_20_0.descItems) do
		local var_20_2 = arg_20_0.descItems[iter_20_2]

		if not var_20_2 then
			var_20_2 = arg_20_0:createLeftDescItem(iter_20_2)
			arg_20_0.descItems[iter_20_2] = var_20_2
		end

		arg_20_0:updateLeftDescItem(var_20_2, var_20_1[iter_20_2])
	end

	gohelper.setActive(arg_20_0._goleftscrolltopmask, arg_20_0._curDescItem.index ~= 1)
	TaskDispatcher.runDelay(arg_20_0.moveToCurDesc, arg_20_0, 0.02)
end

function var_0_0.createLeftDescItem(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getUserDataTb_()

	var_22_0.index = arg_22_1
	var_22_0.go = gohelper.cloneInPlace(arg_22_0._goDescItem, "desc" .. arg_22_1)
	var_22_0.txt = gohelper.findChildTextMesh(var_22_0.go, "txt_desc")
	var_22_0.goLine = gohelper.findChild(var_22_0.go, "go_underline")

	return var_22_0
end

function var_0_0.updateLeftDescItem(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_2 then
		gohelper.setActive(arg_23_1.go, false)

		return
	end

	gohelper.setActive(arg_23_1.go, true)

	local var_23_0 = arg_23_2.desc

	if arg_23_2.layer == arg_23_0._layer then
		gohelper.setActive(arg_23_1.goLine, true)

		arg_23_1.txt.text = var_23_0
		arg_23_1.txt.lineSpacing = 49.75

		ZProj.UGUIHelper.SetColorAlpha(arg_23_1.txt, 1)

		arg_23_0._curDescItem = arg_23_1
	else
		gohelper.setActive(arg_23_1.goLine, false)

		arg_23_1.txt.text = var_23_0
		arg_23_1.txt.lineSpacing = -12.5

		ZProj.UGUIHelper.SetColorAlpha(arg_23_1.txt, 0.7)
	end
end

function var_0_0.moveToCurDesc(arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0.moveToCurDesc, arg_24_0)

	local var_24_0 = arg_24_0._curDescItem

	if not var_24_0 then
		return
	end

	local var_24_1 = var_24_0.txt.preferredHeight
	local var_24_2 = recthelper.getHeight(arg_24_0._descScroll.transform)
	local var_24_3 = math.max(0, recthelper.getHeight(arg_24_0._descContent.transform) - var_24_2)
	local var_24_4 = (var_24_2 - var_24_1) * 0.5
	local var_24_5 = recthelper.getAnchorY(var_24_0.go.transform) + var_24_4

	recthelper.setAnchorY(arg_24_0._descContent.transform, Mathf.Clamp(-var_24_5, 0, -var_24_5))
end

function var_0_0.onDestroyView(arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0.moveToCurDesc, arg_25_0)
	arg_25_0._simagebg:UnLoadImage()
	arg_25_0._simagestageicon:UnLoadImage()
	arg_25_0._simageleveldecorate:UnLoadImage()
	arg_25_0._simagepage:UnLoadImage()
	arg_25_0._simageline:UnLoadImage()

	if arg_25_0._showLvItems then
		for iter_25_0, iter_25_1 in pairs(arg_25_0._showLvItems) do
			iter_25_1:destroy()
		end

		arg_25_0._showLvItems = nil
	end
end

return var_0_0
