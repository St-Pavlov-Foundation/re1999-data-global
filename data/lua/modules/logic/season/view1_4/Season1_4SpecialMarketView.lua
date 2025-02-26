module("modules.logic.season.view1_4.Season1_4SpecialMarketView", package.seeall)

slot0 = class("Season1_4SpecialMarketView", BaseView)

function slot0.onInitView(slot0)
	slot0._goinfo = gohelper.findChild(slot0.viewGO, "#go_info")
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_info/bg/#simage_bg1")
	slot0._simagepage = gohelper.findChildSingleImage(slot0.viewGO, "#go_info/left/#simage_page")
	slot0._simagestageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_info/left/#simage_stageicon")
	slot0._txtlevelnamecn = gohelper.findChildText(slot0.viewGO, "#go_info/left/#txt_levelnamecn")
	slot0._gostageinfoitem1 = gohelper.findChild(slot0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem1")
	slot0._gostageinfoitem2 = gohelper.findChild(slot0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem2")
	slot0._gostageinfoitem3 = gohelper.findChild(slot0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem3")
	slot0._gostageinfoitem4 = gohelper.findChild(slot0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem4")
	slot0._gostageinfoitem5 = gohelper.findChild(slot0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem5")
	slot0._gostageinfoitem6 = gohelper.findChild(slot0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem6")
	slot0._descScroll = gohelper.findChild(slot0.viewGO, "#go_info/left/Scroll View")
	slot0._animScroll = slot0._descScroll:GetComponent(typeof(UnityEngine.Animator))
	slot0._descContent = gohelper.findChild(slot0.viewGO, "#go_info/left/Scroll View/Viewport/Content")
	slot0._goDescItem = gohelper.findChild(slot0.viewGO, "#go_info/left/Scroll View/Viewport/Content/#go_descitem")
	slot0._txtcurindex = gohelper.findChildText(slot0.viewGO, "#go_info/right/position/center/#txt_curindex")
	slot0._txtmaxindex = gohelper.findChildText(slot0.viewGO, "#go_info/right/position/center/#txt_maxindex")
	slot0._btnlast = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_info/right/position/#btn_last")
	slot0._btnnext = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_info/right/position/#btn_next")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#go_info/right/#txt_desc")
	slot0._txtenemylv = gohelper.findChildText(slot0.viewGO, "#go_info/right/enemylv/enemylv/#txt_enemylv")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_info/right/btns/#btn_start")
	slot0._gopart = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/#go_part")
	slot0._gostage = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/#go_part/#go_stage")
	slot0._gostagelvlitem = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/#go_part/#go_stage/list/#go_stagelvlitem")
	slot0._gounlock = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlock")
	slot0._gounlocktype1 = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlock/#go_unlocktype1")
	slot0._gounlocktype2 = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlock/#go_unlocktype2")
	slot0._gounlocktype3 = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlock/#go_unlocktype3")
	slot0._scrollrewards = gohelper.findChildScrollRect(slot0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_rewarditem")
	slot0._golevel = gohelper.findChild(slot0.viewGO, "#go_level")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_level/#simage_bg")
	slot0._simageleveldecorate = gohelper.findChildSingleImage(slot0.viewGO, "#go_level/decorate/#simage_leveldecorate")
	slot0._simageline = gohelper.findChildSingleImage(slot0.viewGO, "#go_level/decorate/#simage_line")
	slot0._goscrolllv = gohelper.findChild(slot0.viewGO, "#go_level/#go_scrolllv")
	slot0._gofront = gohelper.findChild(slot0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_front")
	slot0._golvitem = gohelper.findChild(slot0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem")
	slot0._goline = gohelper.findChild(slot0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#go_line")
	slot0._goselectedpass = gohelper.findChild(slot0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#go_selectedpass")
	slot0._txtselectpassindex = gohelper.findChildText(slot0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#go_selectedpass/#txt_selectpassindex")
	slot0._gopass = gohelper.findChild(slot0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#go_pass")
	slot0._txtpassindex = gohelper.findChildText(slot0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#go_pass/#txt_passindex")
	slot0._gounpass = gohelper.findChild(slot0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#go_unpass")
	slot0._txtunpassindex = gohelper.findChildText(slot0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#go_unpass/#txt_unpassindex")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_lvitem/#btn_click")
	slot0._gorear = gohelper.findChild(slot0.viewGO, "#go_level/#go_scrolllv/Viewport/Content/#go_rear")
	slot0._gostagelvitem1 = gohelper.findChild(slot0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem1")
	slot0._gostagelvitem2 = gohelper.findChild(slot0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem2")
	slot0._gostagelvitem3 = gohelper.findChild(slot0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem3")
	slot0._gostagelvitem4 = gohelper.findChild(slot0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem4")
	slot0._gostagelvitem5 = gohelper.findChild(slot0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem5")
	slot0._gostagelvitem6 = gohelper.findChild(slot0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem6")
	slot0._btnlvstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_level/#btn_lvstart")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._gopartempty = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/#go_partempty")
	slot0._simageempty = gohelper.findChildSingleImage(slot0.viewGO, "#go_info/right/layout/#go_partempty/#simage_empty")
	slot0._goleftscrolltopmask = gohelper.findChild(slot0.viewGO, "#go_info/left/Scroll View/mask2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnlast:AddClickListener(slot0._btnlastOnClick, slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnlvstart:AddClickListener(slot0._btnlvstartOnClick, slot0)
	slot0:addEventCb(Activity104Controller.instance, Activity104Event.StartAct104BattleReply, slot0._onBattleReply, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlast:RemoveClickListener()
	slot0._btnnext:RemoveClickListener()
	slot0._btnstart:RemoveClickListener()
	slot0._btnclick:RemoveClickListener()
	slot0._btnlvstart:RemoveClickListener()
	slot0:removeEventCb(Activity104Controller.instance, Activity104Event.StartAct104BattleReply, slot0._onBattleReply, slot0)
end

function slot0._onBattleReply(slot0, slot1)
	Activity104Model.instance:onStartAct104BattleReply(slot1)
end

function slot0._btnlvstartOnClick(slot0)
	gohelper.setActive(slot0._goinfo, true)
	gohelper.setActive(slot0._golevel, false)
	slot0:_refreshInfo()
end

function slot0._btnlastOnClick(slot0)
	if slot0._layer < 2 then
		return
	end

	slot0._layer = slot0._layer - 1

	slot0._animScroll:Play(UIAnimationName.Switch, 0, 0)
	slot0:_refreshInfo()
end

function slot0._btnnextOnClick(slot0)
	if Activity104Model.instance:getMaxSpecialLayer() <= slot0._layer then
		return
	end

	slot0._layer = slot0._layer + 1

	slot0._animScroll:Play(UIAnimationName.Switch, 0, 0)
	slot0:_refreshInfo()
end

function slot0._btnstartOnClick(slot0)
	slot1 = Activity104Model.instance:getCurSeasonId()

	Activity104Rpc.instance:sendBeforeStartAct104BattleRequest(slot1, slot0._layer, SeasonConfig.instance:getSeasonSpecialCo(slot1, slot0._layer).episodeId)
end

function slot0._btnclickOnClick(slot0)
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getSeasonIcon("full/img_bg.png"))
	slot0._simagepage:LoadImage(SeasonViewHelper.getSeasonIcon("shuye.png"))
	slot0._simageempty:LoadImage(SeasonViewHelper.getSeasonIcon("kongzhuangtai.png"))
	slot0._simageline:LoadImage(ResUrl.getSeasonIcon("img_circle.png"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._golevel, true)
	gohelper.setActive(slot0._goinfo, false)
	slot0:addEventCb(Activity104Controller.instance, Activity104Event.SwitchSpecialEpisode, slot0._onSwitchEpisode, slot0)

	slot0._showLvItems = {}
	slot0._showStageItems = {}
	slot0._infoStageItems = {}
	slot0._rewardItems = {}
	slot1, slot2 = nil

	if slot0.viewParam then
		slot1 = slot0.viewParam.defaultSelectLayer

		if slot0.viewParam.directOpenLayer then
			slot2 = true
		end
	end

	slot0._layer = slot1 or Activity104Model.instance:getAct104SpecialInitLayer()

	slot0:_refreshLevel()

	if slot2 then
		slot0:_btnlvstartOnClick()
	end

	slot0:updateLeftDesc()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(Activity104Controller.instance, Activity104Event.SwitchSpecialEpisode, slot0._onSwitchEpisode, slot0)
end

function slot0._onSwitchEpisode(slot0, slot1)
	slot0._layer = slot1

	slot0:_refreshLevel()
end

function slot0._refreshLevel(slot0)
	for slot5 = 1, Activity104Model.instance:getMaxSpecialLayer() do
		if not slot0._showLvItems[slot5] then
			slot0._showLvItems[slot5] = Season1_4SpecialMarketShowLevelItem.New()

			slot0._showLvItems[slot5]:init(gohelper.cloneInPlace(slot0._golvitem))
		end

		slot0._showLvItems[slot5]:reset(slot5, slot0._layer, slot1)
	end

	gohelper.setAsLastSibling(slot0._gorear)
	slot0._simageleveldecorate:LoadImage(SeasonViewHelper.getSeasonIcon(string.format("icon/ty_chatu_%s.png", SeasonConfig.instance:getSeasonSpecialCo(Activity104Model.instance:getCurSeasonId(), slot0._layer).icon)))
end

function slot0._refreshInfo(slot0)
	slot1 = SeasonConfig.instance:getSeasonSpecialCo(Activity104Model.instance:getCurSeasonId(), slot0._layer)
	slot0._txtlevelnamecn.text = slot1.name
	slot0._txtcurindex.text = string.format("%02d", slot0._layer)
	slot0._txtmaxindex.text = string.format("%02d", Activity104Model.instance:getMaxSpecialLayer())
	slot0._txtenemylv.text = HeroConfig.instance:getCommonLevelDisplay(slot1.level)

	slot0._simagestageicon:LoadImage(SeasonViewHelper.getSeasonIcon(string.format("icon/a_chatu_%s.png", slot1.icon)))

	slot0._txtdesc.text = DungeonConfig.instance:getEpisodeCO(slot1.episodeId).desc

	gohelper.setActive(slot0._gorewarditem, false)

	slot8 = #DungeonModel.instance:getEpisodeFirstBonus(slot1.episodeId)

	for slot8 = 1, math.max(#slot0._rewardItems, slot8) do
		slot0:refreshRewardItem(slot0._rewardItems[slot8] or slot0:createRewardItem(slot8), slot4[slot8])
	end

	gohelper.setActive(slot0._gopart, false)
	gohelper.setActive(slot0._gopartempty, true)

	slot0._btnlast.button.interactable = slot0._layer > 1
	slot0._btnnext.button.interactable = slot0._layer < Activity104Model.instance:getMaxSpecialLayer()

	slot0:updateLeftDesc()
end

function slot0.createRewardItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot3 = gohelper.cloneInPlace(slot0._gorewarditem, "reward_" .. tostring(slot1))
	slot2.go = slot3
	slot2.itemParent = gohelper.findChild(slot3, "go_prop")
	slot2.cardParent = gohelper.findChild(slot3, "go_card")
	slot2.receive = gohelper.findChild(slot3, "go_receive")
	slot0._rewardItems[slot1] = slot2

	return slot2
end

function slot0.refreshRewardItem(slot0, slot1, slot2)
	if not slot2 then
		gohelper.setActive(slot1.go, false)

		return
	end

	if not slot1.itemIcon then
		slot1.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot1.itemParent)
	end

	slot1.itemIcon:setMOValue(tonumber(slot2[1]), tonumber(slot2[2]), tonumber(slot2[3]), nil, true)
	slot1.itemIcon:isShowCount(tonumber(slot2[1]) ~= MaterialEnum.MaterialType.Hero)
	slot1.itemIcon:setCountFontSize(40)
	slot1.itemIcon:showStackableNum2()
	slot1.itemIcon:setHideLvAndBreakFlag(true)
	slot1.itemIcon:hideEquipLvAndBreak(true)
	gohelper.setActive(slot1.go, true)
	gohelper.setActive(slot1.receive, Activity104Model.instance:isSpecialLayerPassed(slot0._layer))
end

function slot0.updateLeftDesc(slot0)
	if not slot0.descItems then
		slot0.descItems = {}
	end

	slot2 = {}

	if SeasonConfig.instance:getSeasonSpecialCos(Activity104Model.instance:getCurSeasonId()) then
		for slot6, slot7 in pairs(slot1) do
			table.insert(slot2, slot7)
		end

		table.sort(slot2, function (slot0, slot1)
			return slot0.layer < slot1.layer
		end)
	end

	slot0._curDescItem = nil
	slot6 = #slot0.descItems

	for slot6 = 1, math.max(#slot2, slot6) do
		if not slot0.descItems[slot6] then
			slot0.descItems[slot6] = slot0:createLeftDescItem(slot6)
		end

		slot0:updateLeftDescItem(slot7, slot2[slot6])
	end

	gohelper.setActive(slot0._goleftscrolltopmask, slot0._curDescItem.index ~= 1)
	TaskDispatcher.runDelay(slot0.moveToCurDesc, slot0, 0.02)
end

function slot0.createLeftDescItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.index = slot1
	slot2.go = gohelper.cloneInPlace(slot0._goDescItem, "desc" .. slot1)
	slot2.txt = gohelper.findChildTextMesh(slot2.go, "txt_desc")
	slot2.goLine = gohelper.findChild(slot2.go, "go_underline")

	return slot2
end

function slot0.updateLeftDescItem(slot0, slot1, slot2)
	if not slot2 then
		gohelper.setActive(slot1.go, false)

		return
	end

	gohelper.setActive(slot1.go, true)

	if slot2.layer == slot0._layer then
		gohelper.setActive(slot1.goLine, true)

		slot1.txt.text = slot2.desc
		slot1.txt.lineSpacing = 49.75

		ZProj.UGUIHelper.SetColorAlpha(slot1.txt, 1)

		slot0._curDescItem = slot1
	else
		gohelper.setActive(slot1.goLine, false)

		slot1.txt.text = slot3
		slot1.txt.lineSpacing = -12.5

		ZProj.UGUIHelper.SetColorAlpha(slot1.txt, 0.7)
	end
end

function slot0.moveToCurDesc(slot0)
	TaskDispatcher.cancelTask(slot0.moveToCurDesc, slot0)

	if not slot0._curDescItem then
		return
	end

	slot3 = recthelper.getHeight(slot0._descScroll.transform)
	slot4 = math.max(0, recthelper.getHeight(slot0._descContent.transform) - slot3)
	slot6 = recthelper.getAnchorY(slot1.go.transform) + (slot3 - slot1.txt.preferredHeight) * 0.5

	recthelper.setAnchorY(slot0._descContent.transform, Mathf.Clamp(-slot6, 0, -slot6))
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.moveToCurDesc, slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagestageicon:UnLoadImage()
	slot0._simageleveldecorate:UnLoadImage()
	slot0._simagepage:UnLoadImage()
	slot0._simageline:UnLoadImage()

	if slot0._showLvItems then
		for slot4, slot5 in pairs(slot0._showLvItems) do
			slot5:destroy()
		end

		slot0._showLvItems = nil
	end
end

return slot0
