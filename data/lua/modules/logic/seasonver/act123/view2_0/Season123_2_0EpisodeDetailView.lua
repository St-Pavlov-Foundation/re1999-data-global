module("modules.logic.seasonver.act123.view2_0.Season123_2_0EpisodeDetailView", package.seeall)

slot0 = class("Season123_2_0EpisodeDetailView", BaseView)

function slot0.onInitView(slot0)
	slot0._goinfo = gohelper.findChild(slot0.viewGO, "#go_info")
	slot0._simagestageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_info/left/#simage_stageicon")
	slot0._animatorRight = gohelper.findChildComponent(slot0.viewGO, "#go_info/right", typeof(UnityEngine.Animator))
	slot0._txtlevelnamecn = gohelper.findChildText(slot0.viewGO, "#go_info/left/#txt_levelnamecn")
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
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_info/right/btns/#btn_reset")
	slot0._btnReplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_info/right/btns/#btn_storyreplay")
	slot0._gopart = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/#go_part")
	slot0._gostage = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/#go_part/#go_stage")
	slot0._gostagelvlitem = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/#go_part/#go_stage/list/#go_stagelvlitem")
	slot0._gounlocktype1 = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype1")
	slot0._gounlocktype2 = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype2")
	slot0._gounlocktype3 = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_unlocktype3")
	slot0._scrollrewards = gohelper.findChildScrollRect(slot0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/root/mask/#scroll_rewards/Viewport/Content/#go_rewarditem")
	slot0._godecorate = gohelper.findChild(slot0.viewGO, "#go_info/right/decorate")
	slot0._gocenter = gohelper.findChild(slot0.viewGO, "#go_info/right/position/center")
	slot0._gopartempty = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/#go_partempty")
	slot0._simageempty = gohelper.findChildSingleImage(slot0.viewGO, "#go_info/right/layout/#go_partempty/#simage_empty")
	slot0._goleftscrolltopmask = gohelper.findChild(slot0.viewGO, "#go_info/left/Scroll View/mask2")
	slot0._goreset = gohelper.findChild(slot0.viewGO, "#go_info/right/layout/#go_reset")
	slot0._txtresettime = gohelper.findChildText(slot0.viewGO, "#go_info/right/layout/#go_reset/#txt_title/#txt_time")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnlast:AddClickListener(slot0._btnlastOnClick, slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlast:RemoveClickListener()
	slot0._btnnext:RemoveClickListener()
	slot0._btnstart:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gostagelvlitem, false)

	slot0._txtseasondesc = gohelper.findChildText(slot0.viewGO, "#go_info/left/Scroll View/Viewport/Content/#go_descitem/txt_desc")
end

function slot0.onDestroyView(slot0)
	Season123EpisodeDetailController.instance:onCloseView()
	slot0._simagestageicon:UnLoadImage()

	if slot0._showLvItems then
		for slot4, slot5 in pairs(slot0._showLvItems) do
			slot5:destroy()
		end

		slot0._showLvItems = nil
	end
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.DetailSwitchLayer, slot0.handleDetailSwitchLayer, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.RefreshDetailView, slot0.refreshShowInfo, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.ResetStageFinished, slot0.closeThis, slot0)
	Season123EpisodeDetailController.instance:onOpenView(slot0.viewParam.actId, slot0.viewParam.stage, slot0.viewParam.layer)

	if not ActivityModel.instance:getActMO(slot0.viewParam.actId) or not slot1:isOpen() or slot1:isExpired() then
		return
	end

	slot2 = Season123EpisodeDetailModel.instance.layer

	slot0:resetData()
	slot0:noAudioShowInfoByOpen()
	slot0._simageempty:LoadImage(Season123Controller.getSeasonIcon("kongzhuangtai.png", slot0.viewParam.actId))
end

function slot0.onOpenFinish(slot0)
	ViewMgr.instance:closeView(Season123Controller.instance:getEpisodeLoadingViewName(), true)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._delayShowInfo, slot0)
end

function slot0.handleDetailSwitchLayer(slot0, slot1)
	slot2 = slot1.isNext

	slot0._animatorRight:Play(UIAnimationName.Switch, 0, 0)
	slot0._animScroll:Play(UIAnimationName.Switch, 0, 0)
	TaskDispatcher.cancelTask(slot0._delayShowInfo, slot0)
	TaskDispatcher.runDelay(slot0._delayShowInfo, slot0, 0.2)
end

function slot0._delayShowInfo(slot0)
	slot0:_showInfo()
end

function slot0.refreshShowInfo(slot0)
	slot0:_showInfo()
end

function slot0._btnstartOnClick(slot0)
	slot4 = Season123Config.instance:getSeasonEpisodeCo(Season123EpisodeDetailModel.instance.activityId, Season123EpisodeDetailModel.instance.stage, Season123EpisodeDetailModel.instance.layer).episodeId

	Season123EpisodeDetailController.instance:checkEnterFightScene()
end

function slot0.resetData(slot0)
	slot0._showLvItems = {}
	slot0._showStageItems = {}
	slot0._infoStageItems = {}
	slot0._equipReward = {}
	slot0._rewardItems = {}
	slot0._partStageItems = {}
end

function slot0.noAudioShowInfoByOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	gohelper.setActive(slot0._goinfo, true)
	slot0:_showInfo()
end

function slot0._showInfo(slot0)
	slot0:_setInfo()
	slot0:_setParts()
	slot0:_setButton()
	slot0:_setResetInfo()
end

function slot0._setButton(slot0)
	slot1 = Season123EpisodeDetailController.instance:isStageNeedClean() or Season123EpisodeDetailController.instance:isNextLayersNeedClean()

	gohelper.setActive(slot0._btnreset, slot1)
	gohelper.setActive(slot0._btnstart, not slot1)
end

function slot0._setResetInfo(slot0)
	slot1 = Season123EpisodeDetailController.instance:isStageNeedClean() or Season123EpisodeDetailController.instance:isNextLayersNeedClean()

	gohelper.setActive(slot0._goreset, slot1)
	gohelper.setActive(slot0._txtresettime, slot1)

	if slot1 then
		if Season123EpisodeDetailModel.instance:getCurFinishRound() and slot2 > 0 then
			slot0._txtresettime.text = string.format(Season123Controller.instance:isReduceRound(Season123EpisodeDetailModel.instance.activityId, Season123EpisodeDetailModel.instance.stage, Season123EpisodeDetailModel.instance.layer) and "<color=#eecd8c>%s</color>" or "%s", tostring(slot2))
		else
			slot0._txtresettime.text = "--"
		end
	end
end

slot0.NomalStageTagPos = Vector2(46.3, 2.7)
slot0.NewStageTagPos = Vector2(4.37, 2.7)

function slot0._setInfo(slot0)
	if not Season123Config.instance:getSeasonEpisodeCo(Season123EpisodeDetailModel.instance.activityId, Season123EpisodeDetailModel.instance.stage, Season123EpisodeDetailModel.instance.layer) then
		return
	end

	gohelper.setActive(slot0._btnReplay, Season123Model.instance:isEpisodeAfterStory(slot1, slot2, slot3) and slot4.afterStoryId and slot4.afterStoryId ~= 0 or false)

	slot0._txtlevelnamecn.text = slot4.layerName
	slot0._txtseasondesc.text = slot4.desc
	slot0._txtdesc.text = DungeonConfig.instance:getEpisodeCO(slot4.episodeId).desc
	slot0._txtcurindex.text = string.format("%02d", slot3)
	slot0._txtmaxindex.text = string.format("%02d", Season123ProgressUtils.getMaxLayer(slot1, slot2))
	slot7 = Season123EpisodeDetailModel.instance:isNextLayerNewStarGroup(slot3)

	gohelper.setActive(slot0._godecorate, slot7)

	slot8 = slot7 and uv0.NewStageTagPos or uv0.NomalStageTagPos

	recthelper.setAnchor(slot0._gocenter.transform, slot8.x, slot8.y)

	if not string.nilorempty(ResUrl.getSeason123LayerDetailBg(Season123Model.instance:getSingleBgFolder(), slot4.layerPicture)) then
		slot0._simagestageicon:LoadImage(slot10)
	end

	gohelper.setActive(slot0._gorewarditem, false)

	slot15 = #DungeonModel.instance:getEpisodeFirstBonus(slot4.episodeId)

	for slot15 = 2, math.max(#slot0._rewardItems - 1, slot15) + 1 do
		slot0:refreshRewardItem(slot0._rewardItems[slot15] or slot0:createRewardItem(slot15), slot11[slot15 - 1])
	end

	slot0:refreshEquipCardItem()

	slot0._btnlast.button.interactable = slot3 > 1
	slot0._btnnext.button.interactable = slot3 < Season123EpisodeDetailModel.instance:getCurrentChallengeLayer()
end

function slot0.refreshEquipCardItem(slot0)
	if not slot0._rewardItems[1] then
		slot0._rewardItems[1] = slot0:createRewardItem(1)
	end

	gohelper.setActive(slot0._rewardItems[1].go, Season123Config.instance:getSeasonEpisodeCo(Season123EpisodeDetailModel.instance.activityId, Season123EpisodeDetailModel.instance.stage, Season123EpisodeDetailModel.instance.layer).firstPassEquipId and slot4.firstPassEquipId > 0)

	if slot4.firstPassEquipId and slot4.firstPassEquipId > 0 then
		if not slot0._rewardItems[1].itemIcon then
			slot0._rewardItems[1].itemIcon = Season123_2_0CelebrityCardItem.New()

			slot0._rewardItems[1].itemIcon:setColorDark(slot3 < Season123EpisodeDetailModel.instance:getCurrentChallengeLayer() or Season123EpisodeDetailModel.instance:alreadyPassEpisode(slot3))
			slot0._rewardItems[1].itemIcon:init(slot0._rewardItems[1].cardParent, slot4.firstPassEquipId)
		else
			slot0._rewardItems[1].itemIcon:setColorDark(slot5)
			slot0._rewardItems[1].itemIcon:reset(slot4.firstPassEquipId)
		end

		gohelper.setActive(slot0._rewardItems[1].cardParent, true)
		gohelper.setActive(slot0._rewardItems[1].itemParent, false)
		gohelper.setActive(slot0._rewardItems[1].receive, slot5)
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

	slot4 = Season123EpisodeDetailModel.instance.layer < Season123EpisodeDetailModel.instance:getCurrentChallengeLayer() or Season123EpisodeDetailModel.instance:alreadyPassEpisode(slot3)

	gohelper.setActive(slot1.receive, slot4)
	slot1.itemIcon:setItemColor(slot4 and "#7b7b7b" or "#ffffff")
end

function slot0._setParts(slot0)
	slot3 = Season123EpisodeDetailModel.instance.layer
	slot0._txtenemylv.text = HeroConfig.instance:getCommonLevelDisplay(Season123Config.instance:getSeasonEpisodeCo(Season123EpisodeDetailModel.instance.activityId, Season123EpisodeDetailModel.instance.stage, slot3).level)

	if slot3 < Season123EpisodeDetailModel.instance:getCurrentChallengeLayer() or Season123ProgressUtils.getMaxLayer(slot1, slot2) < slot3 then
		gohelper.setActive(slot0._gopart, false)
		gohelper.setActive(slot0._gopartempty, true)
		gohelper.setActive(slot0._gounlocktype1, false)
		gohelper.setActive(slot0._gounlocktype2, false)
		gohelper.setActive(slot0._gounlocktype3, false)
	else
		slot5 = Season123EpisodeDetailModel.instance:isNextLayerNewStarGroup(slot3)

		gohelper.setActive(slot0._gostage, slot5)

		if slot5 then
			slot0:_showPartStarGroupItem(Season123EpisodeDetailModel.instance:getCurStarGroup(slot1, slot3) + 1)
		end

		if #string.splitToNumber(slot4.unlockEquipIndex, "#") > 0 then
			gohelper.setActive(slot0._gounlocktype1, Season123HeroGroupUtils.getUnlockIndexSlot(slot6[1]) == 1)
			gohelper.setActive(slot0._gounlocktype2, Season123HeroGroupUtils.getUnlockIndexSlot(slot7) == 2)
			gohelper.setActive(slot0._gounlocktype3, Season123HeroGroupUtils.getUnlockIndexSlot(slot7) == 3)
		else
			gohelper.setActive(slot0._gounlocktype1, false)
			gohelper.setActive(slot0._gounlocktype2, false)
			gohelper.setActive(slot0._gounlocktype3, false)
		end

		gohelper.setActive(slot0._gopart, slot5 or #slot6 > 0)
		gohelper.setActive(slot0._gopartempty, not slot5 and #slot6 <= 0)
	end
end

slot0.UnLockStageItemAlpha = 1
slot0.LockStageItemAlpha = 0.3

function slot0._showPartStarGroupItem(slot0, slot1)
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

function slot0._btnlastOnClick(slot0)
	if Season123EpisodeDetailController.instance:canSwitchLayer(false) then
		Season123EpisodeDetailController.instance:switchLayer(false)
	end
end

function slot0._btnnextOnClick(slot0)
	if Season123EpisodeDetailController.instance:canSwitchLayer(true) then
		Season123EpisodeDetailController.instance:switchLayer(true)
	end
end

function slot0._btnresetOnClick(slot0)
	Season123Controller.instance:openResetView({
		actId = Season123EpisodeDetailModel.instance.activityId,
		stage = Season123EpisodeDetailModel.instance.stage,
		layer = Season123EpisodeDetailModel.instance.layer
	})
end

return slot0
