module("modules.logic.season.view1_3.Season1_3MarketView", package.seeall)

slot0 = class("Season1_3MarketView", BaseView)

function slot0.onInitView(slot0)
	slot0._goinfo = gohelper.findChild(slot0.viewGO, "#go_info")
	slot0._simagepage = gohelper.findChildSingleImage(slot0.viewGO, "#go_info/left/#simage_page")
	slot0._simagestageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_info/left/#simage_stageicon")
	slot0._animatorRight = gohelper.findChildComponent(slot0.viewGO, "#go_info/right", typeof(UnityEngine.Animator))
	slot0._txtlevelnamecn = gohelper.findChildText(slot0.viewGO, "#go_info/left/#txt_levelnamecn")
	slot0._txtlevelnameen = gohelper.findChildText(slot0.viewGO, "#go_info/left/#txt_levelnamecn/#txt_levelnameen")
	slot0._gostageinfoitem1 = gohelper.findChild(slot0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem1")
	slot0._gostageinfoitem2 = gohelper.findChild(slot0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem2")
	slot0._gostageinfoitem3 = gohelper.findChild(slot0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem3")
	slot0._gostageinfoitem4 = gohelper.findChild(slot0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem4")
	slot0._gostageinfoitem5 = gohelper.findChild(slot0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem5")
	slot0._gostageinfoitem6 = gohelper.findChild(slot0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem6")
	slot0._gostageinfoitem7 = gohelper.findChild(slot0.viewGO, "#go_info/left/#txt_levelnamecn/stage/#go_stageinfoitem7")
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
	slot0._btnReplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_info/right/btns/#btn_storyreplay")
	slot0._gopart = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/#go_part")
	slot0._gostage = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/#go_part/#go_stage")
	slot0._gostagelvlitem = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/#go_part/#go_stage/list/#go_stagelvlitem")

	gohelper.setActive(slot0._gostagelvlitem, false)

	slot0._gounlocktype1 = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype1")
	slot0._gounlocktype2 = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype2")
	slot0._gounlocktype3 = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype3")
	slot0._scrollrewards = gohelper.findChildScrollRect(slot0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_rewarditem")
	slot0._godecorate = gohelper.findChild(slot0.viewGO, "#go_info/right/decorate")
	slot0._gocenter = gohelper.findChild(slot0.viewGO, "#go_info/right/position/center")
	slot0._golevel = gohelper.findChild(slot0.viewGO, "#go_level")
	slot0._anilevel = slot0._golevel:GetComponent(typeof(UnityEngine.Animator))
	slot0._simagelvbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_level/#simage_lvbg")
	slot0._goScrollContent = gohelper.findChild(slot0.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content")
	slot0._golvitem = gohelper.findChild(slot0.viewGO, "#go_level/#go_scrollRoot/#go_scrolllv/Viewport/Content/#go_lvitem")
	slot0._simagedecorate = gohelper.findChildSingleImage(slot0.viewGO, "#go_level/center/backgrounds/#simage_decorate4")
	slot0._txtcurlevelnamecn = gohelper.findChildText(slot0.viewGO, "#go_level/center/#txt_curlevelnamecn")
	slot0._txtcurlevelnameen = gohelper.findChildText(slot0.viewGO, "#go_level/center/#txt_curlevelnamecn/#txt_curlevelnameen")
	slot0._gostagelvitem1 = gohelper.findChild(slot0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem1")
	slot0._gostagelvitem2 = gohelper.findChild(slot0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem2")
	slot0._gostagelvitem3 = gohelper.findChild(slot0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem3")
	slot0._gostagelvitem4 = gohelper.findChild(slot0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem4")
	slot0._gostagelvitem5 = gohelper.findChild(slot0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem5")
	slot0._gostagelvitem6 = gohelper.findChild(slot0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem6")
	slot0._gostagelvitem7 = gohelper.findChild(slot0.viewGO, "#go_level/center/#txt_curlevelnamecn/stage/#go_stagelvitem7")
	slot0._simageuttu = gohelper.findChildSingleImage(slot0.viewGO, "#go_level/bottom/#simage_uttu")
	slot0._simageleftinfobg = gohelper.findChildSingleImage(slot0.viewGO, "#go_level/#simage_leftinfobg")
	slot0._simagerightinfobg = gohelper.findChildSingleImage(slot0.viewGO, "#go_level/#simage_rightinfobg")
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
	slot0._btnReplay:AddClickListener(slot0._btnreplayOnClick, slot0)
	slot0:addEventCb(Activity104Controller.instance, Activity104Event.StartAct104BattleReply, slot0._onBattleReply, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlast:RemoveClickListener()
	slot0._btnnext:RemoveClickListener()
	slot0._btnstart:RemoveClickListener()
	slot0._btnReplay:RemoveClickListener()
	slot0:removeEventCb(Activity104Controller.instance, Activity104Event.StartAct104BattleReply, slot0._onBattleReply, slot0)
end

function slot0._onBattleReply(slot0, slot1)
	Activity104Model.instance:onStartAct104BattleReply(slot1)
end

function slot0._btnlastOnClick(slot0)
	if slot0._layer < 2 then
		return
	end

	slot0._animatorRight:Play(UIAnimationName.Switch, 0, 0)
	slot0._animScroll:Play(UIAnimationName.Switch, 0, 0)

	slot0._layer = slot0._layer - 1

	TaskDispatcher.cancelTask(slot0._delayShowInfo, slot0)
	TaskDispatcher.runDelay(slot0._delayShowInfo, slot0, 0.2)
end

function slot0._btnnextOnClick(slot0)
	if Activity104Model.instance:getAct104CurLayer() <= slot0._layer then
		return
	end

	slot0._animatorRight:Play(UIAnimationName.Switch, 0, 0)
	slot0._animScroll:Play(UIAnimationName.Switch, 0, 0)

	slot0._layer = slot0._layer + 1

	TaskDispatcher.cancelTask(slot0._delayShowInfo, slot0)
	TaskDispatcher.runDelay(slot0._delayShowInfo, slot0, 0.2)
end

function slot0._delayShowInfo(slot0)
	slot0:_showInfo()
	slot0:_setStages()
	slot0:updateLeftDesc()
end

function slot0._btnstartOnClick(slot0)
	slot1 = Activity104Model.instance:getCurSeasonId()

	Activity104Rpc.instance:sendBeforeStartAct104BattleRequest(slot1, slot0._layer, SeasonConfig.instance:getSeasonEpisodeCo(slot1, slot0._layer).episodeId)
end

function slot0._btnreplayOnClick(slot0)
	if not SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), slot0._layer) or slot2.afterStoryId == 0 then
		return
	end

	StoryController.instance:playStory(slot2.afterStoryId)
end

function slot0._editableInitView(slot0)
	slot0._simagepage:LoadImage(SeasonViewHelper.getSeasonIcon("shuye.png"))
	slot0._simageuttu:LoadImage(SeasonViewHelper.getSeasonIcon("uttu_zs.png"))
	slot0._simageleftinfobg:LoadImage(SeasonViewHelper.getSeasonIcon("msg_xia.png"))
	slot0._simagerightinfobg:LoadImage(SeasonViewHelper.getSeasonIcon("msg_shang.png"))
	slot0._simageempty:LoadImage(SeasonViewHelper.getSeasonIcon("kongzhuangtai.png"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._layer = slot0.viewParam and slot0.viewParam.tarLayer or Activity104Model.instance:getAct104CurLayer()

	slot0:resetData()
	TaskDispatcher.cancelTask(slot0._showInfoByOpen, slot0)

	if slot0:isShowLevel() then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain)
		gohelper.setActive(slot0._golevel, true)
		gohelper.setActive(slot0._goinfo, false)

		slot0._anilevel.speed = 0

		slot0:_setLevels()
		slot0:_setStages()
		Activity104Model.instance:setMakertLayerMark(Activity104Model.instance:getCurSeasonId(), slot0._layer)
		TaskDispatcher.runDelay(slot0._showInfoByOpen, slot0, 2)
	else
		slot0:noAudioShowInfoByOpen()
	end
end

function slot0.resetData(slot0)
	slot0._showLvItems = {}
	slot0._showStageItems = {}
	slot0._infoStageItems = {}
	slot0._equipReward = {}
	slot0._rewardItems = {}
	slot0._partStageItems = {}
end

function slot0.isShowLevel(slot0)
	return Activity104Model.instance:isCanPlayMakertLayerAnim(Activity104Model.instance:getCurSeasonId(), slot0._layer)
end

function slot0.noAudioShowInfoByOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	gohelper.setActive(slot0._golevel, false)
	gohelper.setActive(slot0._goinfo, true)
	slot0:_showInfo()
	slot0:_setStages()
	slot0:updateLeftDesc()
end

function slot0._showInfoByOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_chain_end)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	gohelper.setActive(slot0._golevel, false)
	gohelper.setActive(slot0._goinfo, true)
	slot0:_showInfo()
	slot0:_setStages()
	slot0:updateLeftDesc()
end

function slot0._setLevels(slot0)
	slot1 = SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), slot0._layer)
	slot0._txtcurlevelnamecn.text = slot1.stageName
	slot0._txtcurlevelnameen.text = slot1.stageNameEn
	slot2 = Activity104Model.instance:getMaxLayer()
	slot3 = Activity104Model.instance:getAct104CurLayer()

	if slot0._layer <= 4 then
		for slot7 = 1, 6 do
			slot0._showLvItems[slot7] = Season1_3MarketShowLevelItem.New()

			slot0._showLvItems[slot7]:init(gohelper.cloneInPlace(slot0._golvitem), slot7, slot3, slot2)
		end
	elseif slot0._layer >= slot2 - 3 then
		for slot7 = slot2 - 5, slot2 do
			slot0._showLvItems[slot7] = Season1_3MarketShowLevelItem.New()

			slot0._showLvItems[slot7]:init(gohelper.cloneInPlace(slot0._golvitem), slot7, slot3, slot2)
		end
	else
		for slot7 = slot0._layer - 4, slot0._layer + 4 do
			slot0._showLvItems[slot7] = Season1_3MarketShowLevelItem.New()

			slot0._showLvItems[slot7]:init(gohelper.cloneInPlace(slot0._golvitem), slot7, slot3, slot2)
		end
	end

	TaskDispatcher.runDelay(slot0._delayShowItem, slot0, 0.1)
end

function slot0._delayShowItem(slot0)
	if slot0._showLvItems[slot0._layer] then
		recthelper.setAnchorX(slot0._goScrollContent.transform, -(recthelper.getAnchorX(slot1.go.transform) - 105))
	end

	for slot5, slot6 in pairs(slot0._showLvItems) do
		slot6:show()
	end

	slot0._anilevel.speed = 1
end

function slot0._setStages(slot0)
	gohelper.setActive(slot0._gostageinfoitem7, SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), slot0._layer).stage == 7)
	gohelper.setActive(slot0._gostagelvitem7, slot2 == 7)

	for slot6 = 1, 7 do
		slot10 = gohelper.findChildImage(slot0["_gostagelvitem" .. slot6], "light")

		gohelper.setActive(gohelper.findChildImage(slot0["_gostageinfoitem" .. slot6], "light").gameObject, slot6 <= slot2)
		gohelper.setActive(gohelper.findChildImage(slot0["_gostageinfoitem" .. slot6], "dark").gameObject, slot2 < slot6)
		gohelper.setActive(slot10.gameObject, slot6 <= slot2)
		gohelper.setActive(gohelper.findChildImage(slot0["_gostagelvitem" .. slot6], "dark").gameObject, slot2 < slot6)
		SLFramework.UGUI.GuiHelper.SetColor(slot8, slot6 == 7 and "#B83838" or "#3E3E3D")
		SLFramework.UGUI.GuiHelper.SetColor(slot10, slot6 == 7 and "#B83838" or "#C1C1C2")
	end

	slot0._simagedecorate:LoadImage(ResUrl.getV1A3SeasonIcon(string.format("icon/b_chatu_%s.png", slot1.stagePicture)))
end

function slot0._showInfo(slot0)
	slot0:_setInfo()
	slot0:_setParts()
end

slot0.NomalStageTagPos = Vector2(46.3, 2.7)
slot0.NewStageTagPos = Vector2(4.37, 2.7)

function slot0._setInfo(slot0)
	if not SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), slot0._layer) then
		return
	end

	gohelper.setActive(slot0._btnReplay, Activity104Model.instance:isEpisodeAfterStory(Activity104Model.instance:getCurSeasonId(), slot0._layer) and slot1.afterStoryId ~= 0 or false)

	slot0._txtlevelnamecn.text = slot1.stageName
	slot0._txtlevelnameen.text = slot1.stageNameEn
	slot0._txtdesc.text = DungeonConfig.instance:getEpisodeCO(slot1.episodeId).desc
	slot0._txtcurindex.text = string.format("%02d", slot0._layer)
	slot0._txtmaxindex.text = string.format("%02d", Activity104Model.instance:getMaxLayer())
	slot4 = Activity104Model.instance:getAct104CurStage()
	slot5 = Activity104Model.instance:isNextLayerNewStage(slot0._layer)

	gohelper.setActive(slot0._godecorate, slot5)

	slot6 = slot5 and uv0.NewStageTagPos or uv0.NomalStageTagPos

	recthelper.setAnchor(slot0._gocenter.transform, slot6.x, slot6.y)
	slot0._simagestageicon:LoadImage(ResUrl.getV1A3SeasonIcon(string.format("icon/a_chatu_%s.png", slot1.stagePicture)))
	gohelper.setActive(slot0._gorewarditem, false)

	slot11 = #slot0._rewardItems - 1

	for slot11 = 2, math.max(slot11, #DungeonModel.instance:getEpisodeFirstBonus(slot1.episodeId)) + 1 do
		slot0:refreshRewardItem(slot0._rewardItems[slot11] or slot0:createRewardItem(slot11), slot7[slot11 - 1])
	end

	slot0:refreshEquipCardItem()

	slot0._btnlast.button.interactable = slot0._layer > 1
	slot0._btnnext.button.interactable = slot0._layer < Activity104Model.instance:getAct104CurLayer()
end

function slot0.refreshEquipCardItem(slot0)
	if not slot0._rewardItems[1] then
		slot0._rewardItems[1] = slot0:createRewardItem(1)
	end

	gohelper.setActive(slot0._rewardItems[1].go, SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), slot0._layer).firstPassEquipId > 0)

	if slot1.firstPassEquipId > 0 then
		if not slot0._rewardItems[1].itemIcon then
			slot0._rewardItems[1].itemIcon = Season1_3CelebrityCardItem.New()

			slot0._rewardItems[1].itemIcon:setColorDark(slot0._layer < Activity104Model.instance:getAct104CurLayer() or Activity104Model.instance:getEpisodeState(slot0._layer) > 0)
			slot0._rewardItems[1].itemIcon:init(slot0._rewardItems[1].cardParent, slot1.firstPassEquipId)
		else
			slot0._rewardItems[1].itemIcon:setColorDark(slot2)
			slot0._rewardItems[1].itemIcon:reset(slot1.firstPassEquipId)
		end

		gohelper.setActive(slot0._rewardItems[1].cardParent, true)
		gohelper.setActive(slot0._rewardItems[1].itemParent, false)
		gohelper.setActive(slot0._rewardItems[1].receive, slot2)
	end
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
	if not slot2 or not next(slot2) then
		gohelper.setActive(slot1.go, false)

		return
	end

	if not slot1.itemIcon then
		slot1.itemIcon = IconMgr.instance:getCommonPropItemIcon(slot1.itemParent)
	end

	gohelper.setActive(slot1.cardParent, false)
	gohelper.setActive(slot1.itemParent, true)
	slot1.itemIcon:setMOValue(tonumber(slot2[1]), tonumber(slot2[2]), tonumber(slot2[3]), nil, true)
	slot1.itemIcon:isShowCount(tonumber(slot2[1]) ~= MaterialEnum.MaterialType.Hero)
	slot1.itemIcon:setCountFontSize(40)
	slot1.itemIcon:showStackableNum2()
	slot1.itemIcon:setHideLvAndBreakFlag(true)
	slot1.itemIcon:hideEquipLvAndBreak(true)
	gohelper.setActive(slot1.go, true)

	slot3 = slot0._layer < Activity104Model.instance:getAct104CurLayer() or Activity104Model.instance:getEpisodeState(slot0._layer) > 0

	gohelper.setActive(slot1.receive, slot3)
	slot1.itemIcon:setItemColor(slot3 and "#7b7b7b" or "#ffffff")
end

function slot0._setParts(slot0)
	slot0._txtenemylv.text = HeroConfig.instance:getCommonLevelDisplay(SeasonConfig.instance:getSeasonEpisodeCo(Activity104Model.instance:getCurSeasonId(), slot0._layer).level)

	if slot0._layer < Activity104Model.instance:getAct104CurLayer() or Activity104Model.instance:getMaxLayer() <= slot0._layer then
		gohelper.setActive(slot0._gopart, false)
		gohelper.setActive(slot0._gopartempty, true)
		gohelper.setActive(slot0._gounlocktype1, false)
		gohelper.setActive(slot0._gounlocktype2, false)
		gohelper.setActive(slot0._gounlocktype3, false)
	else
		slot2 = Activity104Model.instance:isNextLayerNewStage(slot0._layer)

		gohelper.setActive(slot0._gostage, slot2)

		if slot2 then
			slot0:_showPartStageItem(Activity104Model.instance:getAct104CurStage() + 1)
		end

		if #string.splitToNumber(slot1.unlockEquipIndex, "#") > 0 then
			gohelper.setActive(slot0._gounlocktype1, slot3[1] < 5)
			gohelper.setActive(slot0._gounlocktype2, slot3[1] > 4 and slot3[1] < 9)
			gohelper.setActive(slot0._gounlocktype3, slot3[1] == 9)
		else
			gohelper.setActive(slot0._gounlocktype1, false)
			gohelper.setActive(slot0._gounlocktype2, false)
			gohelper.setActive(slot0._gounlocktype3, false)
		end

		gohelper.setActive(slot0._gopart, slot2 or #slot3 > 0)
		gohelper.setActive(slot0._gopartempty, not slot2 and #slot3 <= 0)
	end
end

slot0.UnLockStageItemAlpha = 1
slot0.LockStageItemAlpha = 0.3

function slot0._showPartStageItem(slot0, slot1)
	if slot1 < 7 then
		if slot0._partStageItems[7] then
			gohelper.setActive(slot0._partStageItems[7].go, false)
		end

		for slot5 = 1, 6 do
			if not slot0._partStageItems[slot5] then
				slot6 = slot0:getUserDataTb_()
				slot7 = gohelper.cloneInPlace(slot0._gostagelvlitem, "partstageitem_" .. tostring(slot5))
				slot6.go = slot7
				slot6.current = gohelper.findChild(slot7, "current")
				slot6.next = gohelper.findChild(slot7, "next")
				slot6.canvasgroup = gohelper.onceAddComponent(slot7, typeof(UnityEngine.CanvasGroup))
				slot0._partStageItems[slot5] = slot6
			end

			gohelper.setActive(slot0._partStageItems[slot5].go, true)
			gohelper.setActive(slot0._partStageItems[slot5].next, slot5 == slot1)
			gohelper.setActive(slot0._partStageItems[slot5].current, slot5 ~= slot1)

			slot0._partStageItems[slot5].canvasgroup.alpha = slot5 <= slot1 and uv0.UnLockStageItemAlpha or uv0.LockStageItemAlpha
		end
	else
		for slot5 = 1, 7 do
			if not slot0._partStageItems[slot5] then
				slot6 = slot0:getUserDataTb_()
				slot7 = gohelper.cloneInPlace(slot0._gostagelvlitem, "partstageitem_" .. tostring(slot5))
				slot6.go = slot7
				slot6.current = gohelper.findChild(slot7, "current")
				slot6.next = gohelper.findChild(slot7, "next")
				slot6.canvasgroup = gohelper.onceAddComponent(slot7, typeof(UnityEngine.CanvasGroup))
				slot0._partStageItems[slot5] = slot6
			end

			gohelper.setActive(slot0._partStageItems[slot5].go, true)
			gohelper.setActive(slot0._partStageItems[slot5].next, slot5 == slot1)
			gohelper.setActive(slot0._partStageItems[slot5].current, slot5 ~= slot1)

			slot0._partStageItems[slot5].canvasgroup.alpha = slot5 <= slot1 and uv0.UnLockStageItemAlpha or uv0.LockStageItemAlpha
		end
	end
end

function slot0.updateLeftDesc(slot0)
	if not slot0.descItems then
		slot0.descItems = {}
	end

	slot0._curDescItem = nil
	slot6 = #Activity104Model.instance:getStageEpisodeList(Activity104Model.instance:getAct104CurStage(Activity104Model.instance:getCurSeasonId(), slot0._layer))

	for slot6 = 1, math.max(slot6, #slot0.descItems) do
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

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._delayShowInfo, slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._showInfoByOpen, slot0)
	TaskDispatcher.cancelTask(slot0.moveToCurDesc, slot0)
	slot0._simagestageicon:UnLoadImage()
	slot0._simagepage:UnLoadImage()
	slot0._simageuttu:UnLoadImage()
	slot0._simageleftinfobg:UnLoadImage()
	slot0._simagerightinfobg:UnLoadImage()

	if slot0._showLvItems then
		for slot4, slot5 in pairs(slot0._showLvItems) do
			slot5:destroy()
		end

		slot0._showLvItems = nil
	end
end

return slot0
