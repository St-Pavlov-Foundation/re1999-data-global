module("modules.logic.dungeon.view.map.DungeonMapEpisodeItem", package.seeall)

slot0 = class("DungeonMapEpisodeItem", BaseChildView)

function slot0.onInitView(slot0)
	slot0._goscale = gohelper.findChild(slot0.viewGO, "#go_scale")
	slot0._gostar = gohelper.findChild(slot0.viewGO, "#go_scale/#go_gray/#go_star")
	slot0._imagemapstate = gohelper.findChildImage(slot0.viewGO, "#go_scale/#go_gray/#go_star/#image_mapstate")
	slot0._gomapstatescale = gohelper.findChild(slot0.viewGO, "#go_scale/#go_gray/#go_star/#image_mapstate/#go_mapstatescale")
	slot0._imagemapbeselectedbg = gohelper.findChildImage(slot0.viewGO, "#go_scale/#go_gray/#go_star/#image_mapstate/#go_mapstatescale/#image_mapbeselectedbg")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_scale/#go_gray/#go_star/#image_mapstate/#go_mapstatescale/#btn_click")
	slot0._txtsection = gohelper.findChildText(slot0.viewGO, "#go_scale/#go_gray/#txt_section")
	slot0._txtsectionname = gohelper.findChildText(slot0.viewGO, "#go_scale/#go_gray/#txt_sectionname")
	slot0._gotipcontent = gohelper.findChild(slot0.viewGO, "#go_scale/#go_gray/#txt_sectionname/#go_tipcontent")
	slot0._gotipitem = gohelper.findChild(slot0.viewGO, "#go_scale/#go_gray/#txt_sectionname/#go_tipcontent/#go_tipitem")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "#go_scale/#go_gray/#txt_sectionname/#txt_nameen")
	slot0._goflag = gohelper.findChild(slot0.viewGO, "#go_scale/#go_gray/#go_flag")
	slot0._gofall = gohelper.findChild(slot0.viewGO, "#go_scale/#go_gray/#go_fall")
	slot0._gofallbg = gohelper.findChild(slot0._gofall, "#go_fallbg")
	slot0._simagefall = gohelper.findChildSingleImage(slot0._gofall, "#go_fallbg/#simage_fall")
	slot0._goraycast = gohelper.findChild(slot0.viewGO, "#go_scale/#go_raycast")
	slot0._gomaxpos = gohelper.findChild(slot0.viewGO, "#go_maxpos")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "#txt_time")
	slot0._txtlocktips = gohelper.findChildText(slot0.viewGO, "#txt_locktips")
	slot0._imagesuo = gohelper.findChildImage(slot0.viewGO, "#txt_locktips/#image_suo")
	slot0._gobeselected = gohelper.findChild(slot0.viewGO, "#go_beselected")
	slot0._golock = gohelper.findChild(slot0.viewGO, "#go_scale/#go_lock")
	slot0._goprogressitem = gohelper.findChild(slot0.viewGO, "#go_scale/#go_lock/interactiveprogress/#go_progressitem")
	slot0._gosimplestarbg = gohelper.findChild(slot0.viewGO, "#go_scale/#go_gray/#go_star/#go_atorystarbg")
	slot0._gonormalstarbg = gohelper.findChild(slot0.viewGO, "#go_scale/#go_gray/#go_star/#go_normalstarbg")
	slot0._gohardstarbg = gohelper.findChild(slot0.viewGO, "#go_scale/#go_gray/#go_star/#go_hardstarbg")
	slot0._gogray = gohelper.findChild(slot0.viewGO, "#go_scale/#go_gray")
	slot0._goboss = gohelper.findChild(slot0.viewGO, "#go_scale/#go_gray/#go_boss")
	slot0._gonormaleye = gohelper.findChild(slot0.viewGO, "#go_scale/#go_gray/#go_boss/#go_normaleye")
	slot0._gohardeye = gohelper.findChild(slot0.viewGO, "#go_scale/#go_gray/#go_boss/#go_hardeye")
	slot0._imagedecorate = gohelper.findChildImage(slot0.viewGO, "#go_scale/#go_gray/#image_decorate")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._onRefreshActivityState, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._onRefreshActivityState, slot0)
end

function slot0._btnclickOnClick(slot0)
end

function slot0._changeMap(slot0)
	if not slot0._mapIsUnlock then
		return
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeMap, {
		slot0._map,
		slot0._config
	})
end

function slot0._btnraycastOnClick(slot0)
end

function slot0.showUnlockAnim(slot0)
	if not slot0._unlockAnimation then
		slot0._unlockAnimation = slot0._goscale:GetComponent(typeof(UnityEngine.Animation))
	end

	slot0._unlockAnimation:Play()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_deblockingmap)
end

function slot0._editableInitView(slot0)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._click = gohelper.getClickWithAudio(slot0._goraycast, AudioEnum.UI.play_ui_checkpoint_pagesopen)
	slot0._lockClick = gohelper.getClick(gohelper.findChild(slot0._golock, "raycast"))
	slot0.elementItemList = {}

	slot0:_initStar()
	slot0:onUpdateParam()
	slot0:calcPosInContent()

	slot0._init = true

	gohelper.setActive(slot0._gonormaleye, true)
	gohelper.setActive(slot0._gohardeye, false)
	gohelper.setActive(slot0._gotipitem, false)
end

function slot0.calcPosInContent(slot0)
	recthelper.setAnchorX(slot0._gomaxpos.transform, slot0._maxWidth)

	slot0.scrollVisiblePosX = -recthelper.rectToRelativeAnchorPos(slot0._gomaxpos.transform.position, slot0._contentTransform).x
	slot0.scrollContentPosX = recthelper.rectToRelativeAnchorPos(slot0.viewGO.transform.position, slot0._contentTransform).x
end

function slot0.getEpisodeId(slot0)
	return slot0._config.id
end

function slot0.onUpdateParam(slot0)
	slot0._config = slot0.viewParam[1]
	slot0._info = slot0.viewParam[2]
	slot0._levelIndex = slot0.viewParam[4]
	slot0._contentTransform = slot0.viewParam[3]
	slot1 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(slot0._txtsectionname, slot0._config.name)
	slot0._txtsection.text = string.format("%02d", slot0._levelIndex)
	slot0._txtsectionname.text = slot0._config.name
	slot0._txtnameen.text = slot0._config.name_En

	if slot0._config.chainEpisode ~= 0 then
		gohelper.setActive(slot0._goflag, not DungeonModel.instance:hasPassLevelAndStory(slot2))
	else
		gohelper.setActive(slot0._goflag, not DungeonModel.instance:hasPassLevelAndStory(slot0._config.id))
	end

	slot0:_updateLock()
	slot0:_showMap()

	slot4 = slot0:refreshLockTip()
	slot0._isResourceTypeLock = DungeonModel.instance:chapterListIsResType(DungeonConfig.instance:getChapterCO(slot0._config.chapterId).type) and slot4

	slot0:_refreshUI(slot5, slot4)
	slot0:showStatus()
	slot0:_showAllElementTipView()
	slot0:refreshV1a7Fall()

	if DungeonModel.isBattleEpisode(slot0._config) and slot3.type == DungeonEnum.ChapterType.Normal then
		slot6 = string.splitToNumber(slot0._config.icon, "#")
		slot8 = slot6[2]
		slot9, slot10 = nil

		if slot6[1] and slot8 then
			slot9, slot10 = ItemModel.instance:getItemConfigAndIcon(slot7, slot8)
		end

		gohelper.setActive(slot0._gofallbg, true)
		slot0:setFallIconPos(GameUtil.utf8len(slot0._config.name))

		if not string.nilorempty(slot10) then
			slot0._simagefall:LoadImage(slot10)
		end
	end

	if not slot0._maxWidth then
		slot0._maxWidth = recthelper.getAnchorX(slot0._txtsectionname.transform) + slot0._txtsectionname.preferredWidth + 30
	end

	slot7 = recthelper.getWidth(slot0._simagefall.transform)

	if slot0._gofallbg.activeInHierarchy then
		if recthelper.getWidth(slot0._goraycast.transform) < slot1 + slot7 then
			recthelper.setWidth(slot0._goraycast.transform, slot1 + slot7)
		end
	elseif slot6 < slot1 then
		recthelper.setWidth(slot0._goraycast.transform, slot1)
	end
end

function slot0.refreshLockTip(slot0)
	if slot0:hasUnlockContent() then
		slot0:_showUnlockContent()
		slot0:_showBeUnlockEpisode()

		slot2 = slot0.hasUnlockContentText or slot0.hasUnlockEpisodeText

		gohelper.setActive(slot0._txtlocktips.gameObject, slot2)
		gohelper.setActive(slot0._txttime.gameObject, not slot2)
	else
		gohelper.setActive(slot0._txtlocktips.gameObject, false)
		gohelper.setActive(slot0._txttime.gameObject, true)
	end

	return slot1
end

function slot0.initV1a7Node(slot0)
	slot0.goV1a7Fall = slot0.goV1a7Fall or gohelper.findChild(slot0._gofall, "#go_v1a7fallbg")
	slot0.simageV1a7Icon = slot0.simageV1a7Icon or gohelper.findChildSingleImage(slot0._gofall, "#go_v1a7fallbg/#simage_fall")
	slot0.txtV1a7Time = slot0.txtV1a7Time or gohelper.findChildTextMesh(slot0._gofall, "#go_v1a7fallbg/#txt_time")
end

function slot0.refreshV1a7Fall(slot0)
	gohelper.setActive(slot0.goV1a7Fall, false)

	return

	TaskDispatcher.cancelTask(slot0.refreshV1a7Fall, slot0)

	if not slot0:_getDropActId() then
		gohelper.setActive(slot0.goV1a7Fall, false)

		return
	end

	if not string.splitToNumber(slot0._config.cost, "#")[3] or slot2 <= 0 then
		gohelper.setActive(slot0.goV1a7Fall, false)

		return
	end

	slot0:initV1a7Node()
	gohelper.setActive(slot0.goV1a7Fall, true)
	TaskDispatcher.runDelay(slot0.refreshV1a7Fall, slot0, TimeUtil.OneMinuteSecond)

	if ActivityModel.instance:getActMO(slot1) then
		slot5, slot6 = TimeUtil.secondToRoughTime(slot3:getRealEndTimeStamp() - ServerTime.now(), true)
		slot0.txtV1a7Time.text = string.format(slot5 .. slot6)
	end

	slot4, slot5 = CommonConfig.instance:getAct155EpisodeDisplay()
	slot6, slot7 = ItemModel.instance:getItemConfigAndIcon(slot4, slot5)

	if not string.nilorempty(slot7) then
		slot0.simageV1a7Icon:LoadImage(slot7)
	end
end

function slot0._getDropActId(slot0)
	for slot5, slot6 in ipairs(lua_activity155_drop.configList) do
		if slot0._config.chapterId == slot6.chapterId and ActivityHelper.getActivityStatus(slot6.activityId, true) == ActivityEnum.ActivityStatus.Normal then
			return slot7
		end
	end
end

function slot0._showAllElementTipView(slot0)
	if not slot0._map then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DungeonHideElementTip) then
		return
	end

	slot0._pass = DungeonModel.instance:hasPassLevelAndStory(slot0._config.chainEpisode ~= 0 and slot0._config.chainEpisode or slot0._config.id)

	if not DungeonConfig.instance:getMapElements(slot0._map.id) or #slot3 < 1 then
		gohelper.setActive(slot0._gotipcontent, false)

		slot0._showAllElementTip = false
	else
		slot5 = nil

		for slot9, slot10 in ipairs(slot3) do
			if DungeonMapModel.instance:elementIsFinished(slot10.id) then
				slot4 = 0 + 1
			end

			if ToughBattleConfig.instance:isActEleCo(slot10) then
				slot5 = slot10
			end
		end

		if slot5 then
			tabletool.removeValue(tabletool.copy(slot3), slot5)
		end

		slot6 = nil

		for slot10, slot11 in ipairs(slot3) do
			if not slot0.elementItemList[slot10] then
				slot6 = slot0:getUserDataTb_()
				slot6.go = gohelper.cloneInPlace(slot0._gotipitem)
				slot6.goNotFinish = gohelper.findChild(slot6.go, "type1")
				slot6.goFinish = gohelper.findChild(slot6.go, "type2")
				slot6.animator = slot6.go:GetComponent(typeof(UnityEngine.Animator))
				slot6.status = nil

				table.insert(slot0.elementItemList, slot6)
			end

			gohelper.setActive(slot6.go, true)

			slot12 = slot0._pass and slot10 <= slot4

			gohelper.setActive(slot6.goNotFinish, not slot12)
			gohelper.setActive(slot6.goFinish, slot12)

			if slot6.status == false and slot12 then
				gohelper.setActive(slot6.goNotFinish, true)
				slot6.animator:Play("switch", 0, 0)
				AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_light_up)
			end

			slot6.status = slot12
		end

		slot0._showAllElementTip = slot0._pass and slot4 ~= #slot3

		if slot0._showAllElementTip and not slot0._showAllElementTip then
			TaskDispatcher.cancelTask(slot0._hideAllElementTip, slot0)
			TaskDispatcher.runDelay(slot0._hideAllElementTip, slot0, 0.8)
		else
			gohelper.setActive(slot0._gotipcontent, slot0._showAllElementTip)
		end
	end
end

function slot0._hideAllElementTip(slot0)
	gohelper.setActive(slot0._gotipcontent, false)

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	if slot0:_getFallIconTargetPos(GameUtil.utf8len(slot0._config.name)) then
		slot0._tweenId = ZProj.TweenHelper.DOAnchorPosX(slot0._gofall.transform, slot1, 0.26, slot0._tweenEnd, slot0)
	else
		slot0:_tweenEnd()
	end
end

function slot0._tweenEnd(slot0)
	slot0:setFallIconPos(GameUtil.utf8len(slot0._config.name))
end

function slot0._getElementTipWidth(slot0, slot1)
	if slot0._map then
		slot2 = DungeonConfig.instance:getMapElements(slot0._map.id)

		if slot0._showAllElementTip then
			if slot1 > 3 then
				return 20 * #slot2 + 2 * (#slot2 - 1) - 12
			elseif #slot2 < 3 then
				return 43
			else
				return 20 * #slot2 + 2 * (#slot2 - 1) - 12
			end
		end
	end

	return 0
end

function slot0._refreshUI(slot0, slot1, slot2)
	UISpriteSetMgr.instance:setUiFBSprite(slot0._imagesuo, slot1 and slot2 and "bg_suo_fuben" or "bg_kaisuo_fuben", true)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtlocktips, slot1 and slot2 and "#A64B47" or "#D88147")
	UISpriteSetMgr.instance:setUiFBSprite(slot0._imagedecorate, slot1 and slot2 and "bg_fenge" or "zhangjiefenge_005")
	ZProj.UGUIHelper.SetColorAlpha(slot0._txtsection, slot1 and slot2 and 0.65 or 1)
	ZProj.UGUIHelper.SetColorAlpha(slot0._txtsectionname, slot1 and slot2 and 0.65 or 1)
end

function slot0._updateLock(slot0)
	if not DungeonModel.instance:isFinishElementList(slot0._config) ~= slot0._isLock then
		slot2 = nil
	end

	slot0:_updateInteractiveProgress()

	if slot2 == false then
		return
	end

	slot0._isLock = not DungeonModel.instance:isFinishElementList(slot0._config)

	if slot0._isLock and not slot0._isLock then
		if slot0._golock:GetComponent(typeof(UnityEngine.Animator)) then
			slot4.enabled = true
		end

		gohelper.setActive(gohelper.findChild(slot0._golock, "raycast"), false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
	else
		gohelper.setActive(slot0._golock, slot0._isLock)
	end

	if not slot0._graphics then
		slot0._graphics = slot0:getUserDataTb_()
		slot5 = slot0._gogray:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic)):GetEnumerator()

		while slot5:MoveNext() do
			table.insert(slot0._graphics, slot5.Current.gameObject)
		end
	end

	if slot0._graphics then
		for slot7, slot8 in ipairs(slot0._graphics) do
			ZProj.UGUIHelper.SetGrayscale(slot8, slot0._isLock)
		end
	end
end

function slot0._updateInteractiveProgress(slot0)
end

function slot0._updateProgressUI(slot0, slot1, slot2)
	slot0._progressItemTab = slot0._progressItemTab or slot0:getUserDataTb_()

	for slot6 = 1, #slot1 do
		if not slot0._progressItemTab[slot6] then
			table.insert(slot0._progressItemTab, gohelper.cloneInPlace(slot0._goprogressitem, "progress_" .. slot6))
		end

		slot8 = slot1[slot6]

		gohelper.setActive(slot7, slot8)

		if slot8 then
			slot9 = slot6 <= slot2

			gohelper.setActive(gohelper.findChild(slot7, "finish"), slot9)
			gohelper.setActive(gohelper.findChild(slot7, "unfinish"), not slot9)
		end
	end

	slot3 = #slot0._progressItemTab

	if slot0._progressItemTab and slot3 > #slot1 then
		for slot7 = #slot1 + 1, slot3 do
			gohelper.setActive(slot0._progressItemTab[slot7], false)
		end
	end
end

function slot0.isLock(slot0)
	return slot0._isLock
end

function slot0.getMap(slot0)
	if not slot0 then
		return nil
	end

	if slot0.preEpisode > 0 and DungeonConfig.instance:getEpisodeCO(slot1).chapterId ~= slot0.chapterId then
		slot1 = 0
	end

	return DungeonConfig.instance:getChapterMapCfg(slot0.chapterId, slot1)
end

function slot0._showMap(slot0)
	slot0._map = uv0.getMap(slot0._config)
	slot0._mapIsUnlock = slot0._map and DungeonMapModel.instance:mapIsUnlock(slot0._map.id)

	if slot0._init and not slot0._mapIsUnlock and slot0._mapIsUnlock and not slot0._isLock then
		slot0:_changeMap()
	end

	if not slot0._mapIsUnlock then
		slot0._txttime.text = ""

		gohelper.setActive(slot0._imagemapstate.gameObject, false)

		return
	end

	slot0._txttime.text = slot0._map.desc

	slot0:_updateMapElementState()
end

function slot0._updateMapElementState(slot0)
	slot0.unfinishedMap = false

	for slot5, slot6 in ipairs(DungeonMapModel.instance:getElements(slot0._map.id)) do
		if slot6.hidden == 0 then
			slot0.unfinishedMap = true

			break
		end
	end

	gohelper.setActive(slot0._imagemapstate.gameObject, false)
end

function slot0._initStar(slot0)
	gohelper.setActive(slot0._gostar, true)

	slot0._starImgList = slot0:getUserDataTb_()

	table.insert(slot0._starImgList, gohelper.findChildImage(slot0._gosimplestarbg, "0"))
	table.insert(slot0._starImgList, gohelper.findChildImage(slot0._gonormalstarbg, "1"))
	table.insert(slot0._starImgList, gohelper.findChildImage(slot0._gonormalstarbg, "2"))
	table.insert(slot0._starImgList, gohelper.findChildImage(slot0._gohardstarbg, "3"))
	table.insert(slot0._starImgList, gohelper.findChildImage(slot0._gohardstarbg, "4"))
end

function slot0.showStatus(slot0)
	slot7 = DungeonConfig.instance:getHardEpisode(slot0._config.id) and DungeonModel.instance:getEpisodeInfo(slot6.id)

	slot0:_setStar(slot0._starImgList[2], DungeonEnum.StarType.Normal <= slot0._info.star and (slot0._config.id and DungeonModel.instance:hasPassLevelAndStory(slot1)), 1)
	gohelper.setActive(slot0._starImgList[3], false)
	gohelper.setActive(slot0._starImgList[4], false)
	gohelper.setActive(slot0._starImgList[5], false)
	gohelper.setActive(slot0._gonormalstarbg, true)
	gohelper.setActive(slot0._gohardstarbg, false)

	slot0.starNum2 = nil
	slot0.starNum3 = nil
	slot0.starNum4 = nil

	gohelper.setActive(slot0._goboss, slot0._config.displayMark == 1)

	if not string.nilorempty(DungeonConfig.instance:getEpisodeAdvancedConditionText(slot1)) then
		slot11 = DungeonEnum.StarType.Advanced <= slot5.star and slot3
		slot0.starNum2 = slot11

		slot0:_setStar(slot10, slot11, 2)
		gohelper.setActive(slot10.gameObject, true)

		if slot7 and DungeonEnum.StarType.Advanced <= slot5.star and DungeonModel.instance:isOpenHardDungeon(slot0._config.chapterId) and slot3 then
			slot12 = DungeonEnum.StarType.Normal <= slot7.star
			slot0.starNum3 = slot12

			slot0:_setStar(slot9, slot12, 3)
			gohelper.setActive(slot9.gameObject, true)

			slot0.starNum4 = DungeonEnum.StarType.Advanced <= slot7.star

			slot0:_setStar(slot8, slot0.starNum4, 4)
			gohelper.setActive(slot8.gameObject, true)
			gohelper.setActive(slot0._gohardstarbg, true)
		end
	end

	slot11 = DungeonConfig.instance:getSimpleEpisode(slot0._config)

	gohelper.setActive(slot0._gosimplestarbg, slot11)

	if slot11 then
		if DungeonModel.instance:hasPassLevelAndStory(slot11.id) then
			SLFramework.UGUI.GuiHelper.SetColor(slot0._starImgList[1], "#efb974")
		else
			SLFramework.UGUI.GuiHelper.SetColor(slot0._starImgList[1], "#87898C")
		end
	end
end

function slot0._setHardModeState(slot0, slot1)
	slot3 = slot1.isHardMode

	if slot0._levelIndex == slot1.index then
		gohelper.setActive(slot0._gonormaleye, not slot3)
		gohelper.setActive(slot0._gohardeye, slot3)
	end
end

function slot0._setStar(slot0, slot1, slot2, slot3)
	if slot0._isResourceTypeLock then
		SLFramework.UGUI.GuiHelper.SetColor(slot1, "#e5e5e5")
		ZProj.UGUIHelper.SetColorAlpha(slot1, 0.75)
	else
		if slot2 then
			SLFramework.UGUI.GuiHelper.SetColor(slot1, slot3 < 3 and "#F77040" or "#FF4343")
		else
			SLFramework.UGUI.GuiHelper.SetColor(slot1, "#87898C")
		end

		ZProj.UGUIHelper.SetColorAlpha(slot1, 1)
	end
end

function slot0._onLockClickHandler(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_close)
	DungeonController.instance:openDungeonMapTaskView({
		viewParam = slot0._config.preEpisode
	})
end

function slot0.onClickHandler(slot0)
	slot0:_onClickHandler()
end

function slot0._onClickHandler(slot0)
	if slot0._isLock then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) and slot0._isSelected then
		return
	end

	if not DungeonModel.isBattleEpisode(slot0._config) and DungeonModel.instance:getCantChallengeToast(slot0._config) then
		GameFacade.showToast(ToastEnum.CantChallengeToast, slot1)

		return
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickFocusEpisode, slot0)

	if not ViewMgr.instance:isOpen(ViewName.DungeonChangeMapStatusView) then
		slot0:_showMapLevelView(true)
	else
		DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeFocusEpisodeItem, slot0)
	end
end

function slot0._showMapLevelView(slot0, slot1)
	DungeonController.instance:enterLevelView(slot0.viewParam)

	if slot1 then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeFocusEpisodeItem, slot0)
	end
end

function slot0.setFallIconPos(slot0, slot1)
	if slot0:_getFallIconTargetPos(slot1) then
		recthelper.setAnchorX(slot0._gofall.transform, slot2)
	end

	slot3 = recthelper.getAnchorX(slot0._gofall.transform)
	slot5 = slot0:_getElementTipWidth(slot1)

	if slot0.goV1a7Fall and slot0.goV1a7Fall.activeSelf then
		slot4 = 0 + recthelper.getWidth(slot0.goV1a7Fall.transform)
	end

	if slot0._gofallbg.activeSelf then
		slot4 = slot4 + recthelper.getWidth(slot0._gofallbg.transform)
	end

	slot0._maxWidth = slot3 + slot4 + slot5
end

function slot0._getFallIconTargetPos(slot0, slot1)
	if slot1 >= 4 then
		return recthelper.getAnchorX(slot0._txtsectionname.transform) + slot0._txtsectionname.preferredWidth + 70 + slot0:_getElementTipWidth(slot1)
	end
end

function slot0.getMaxWidth(slot0)
	return slot0._maxWidth
end

function slot0.hasUnlockContent(slot0)
	return (OpenConfig.instance:getOpenShowInEpisode(slot0._config.id) or DungeonConfig.instance:getUnlockEpisodeList(slot0._config.id) or OpenConfig.instance:getOpenGroupShowInEpisode(slot0._config.id)) and not DungeonModel.instance:hasPassLevelAndStory(slot0._config.id) or slot0._config.unlockEpisode > 0 and not DungeonModel.instance:hasPassLevelAndStory(slot0._config.unlockEpisode)
end

function slot0._showUnlockContent(slot0)
	for slot5, slot6 in ipairs(DungeonModel.instance:getUnlockContentList(slot0._config.id)) do
		UISpriteSetMgr.instance:setUiFBSprite(slot0._imagesuo, "unlock", true)

		slot0._txtlocktips.text = slot6
		slot0.hasUnlockContentText = true

		return
	end

	slot0.hasUnlockContentText = false
end

function slot0._showBeUnlockEpisode(slot0)
	if slot0._config.unlockEpisode <= 0 or DungeonModel.instance:hasPassLevelAndStory(slot0._config.unlockEpisode) then
		slot0.hasUnlockEpisodeText = false

		return
	end

	UISpriteSetMgr.instance:setUiFBSprite(slot0._imagesuo, "lock", true)

	if slot0._config.unlockEpisode == 9999 then
		slot1 = DungeonModel.instance:getChallengeUnlockText(slot0._config) or luaLang("level_limit_4RD_unlock")
	end

	if string.nilorempty(slot1) then
		slot0.hasUnlockEpisodeText = false
		slot0._txtlocktips.text = ""

		return
	end

	slot0.hasUnlockEpisodeText = true
	slot0._txtlocktips.text = formatLuaLang("dungeon_unlock_episode_mode", slot1)
end

function slot0.onOpen(slot0)
	slot0._click:AddClickListener(slot0._onClickHandler, slot0)
	slot0._lockClick:AddClickListener(slot0._onLockClickHandler, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, slot0._onChangeFocusEpisodeItem, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, slot0._OnUpdateMapElementState, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, slot0._beginShowRewardView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, slot0._endShowRewardView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.SwitchHardMode, slot0._setHardModeState, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0._OnChangeMap(slot0, slot1)
end

function slot0._beginShowRewardView(slot0)
	slot0._showRewardView = true
end

function slot0._endShowRewardView(slot0)
	slot0._showRewardView = false

	slot0:_showAllElementTipView()

	if slot0._isLock and not not DungeonModel.instance:isFinishElementList(slot0._config) then
		slot0._startBlock = true

		UIBlockMgr.instance:endAll()
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("DungeonMapEpisodeItem showUnlock")
		TaskDispatcher.runDelay(slot0._moveEpisode, slot0, DungeonEnum.MoveEpisodeTimeAfterShowReward)
		TaskDispatcher.runDelay(slot0._updateLock, slot0, DungeonEnum.UpdateLockTimeAfterShowReward)
		TaskDispatcher.runDelay(slot0._changeEpisodeMap, slot0, DungeonEnum.UpdateLockTimeAfterShowReward)

		return
	end

	slot0:_updateInteractiveProgress()
end

function slot0._moveEpisode(slot0)
	DungeonMapModel.instance.focusEpisodeTweenDuration = 0.8

	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickFocusEpisode, slot0)
end

function slot0._changeEpisodeMap(slot0)
	slot0._startBlock = false

	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("DungeonMapEpisodeItem showUnlock")
end

function slot0._OnUpdateMapElementState(slot0, slot1)
	if slot1 == slot0._map.id then
		slot0:_updateMapElementState()
	end

	if not slot0._showRewardView then
		slot0:_updateLock()
	end
end

function slot0._onChangeFocusEpisodeItem(slot0, slot1)
	slot0._isSelected = slot1.viewGO == slot0.viewGO

	if slot0._isSelected then
		if not slot0._isSelected then
			slot0:_changeMap()
		end

		gohelper.setActive(slot0._gobeselected, true)
		slot0._animator:Play(UIAnimationName.Selected)
	else
		gohelper.setActive(slot0._gobeselected, false)

		if ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) then
			slot0:_setUnselectedState(slot1)
		else
			slot0:_resetUnselectedState()
		end
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.DungeonMapLevelView and not slot0._isSelected then
		slot0:_resetUnselectedState()

		return
	end

	if slot1 == ViewName.DungeonChangeMapStatusView and slot0._needShowMapLevelView then
		slot0:_showMapLevelView()
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
end

function slot0._setUnselectedState(slot0, slot1)
	slot2 = false

	if slot1._info.star == DungeonEnum.StarType.Advanced then
		slot2 = DungeonConfig.instance:getHardEpisode(slot1._config.id) ~= nil and DungeonModel.instance:isOpenHardDungeon(slot0._config.chapterId)
	end

	if true then
		slot0._animator:Play("notselected")

		slot0._resetName = "restore"

		return
	end

	slot0._animator:Play("right")

	slot0._resetName = "right_reset"
end

function slot0._resetUnselectedState(slot0)
	slot0._animator:Play(slot0._resetName or "restore")
end

function slot0.getIndex(slot0)
	return slot0._levelIndex
end

function slot0.onClose(slot0)
	slot0._click:RemoveClickListener()
	slot0._lockClick:RemoveClickListener()
	TaskDispatcher.cancelTask(slot0._moveEpisode, slot0)
	TaskDispatcher.cancelTask(slot0._updateLock, slot0)
	TaskDispatcher.cancelTask(slot0._changeEpisodeMap, slot0)
	TaskDispatcher.cancelTask(slot0._hideAllElementTip, slot0)
	TaskDispatcher.cancelTask(slot0.refreshV1a7Fall, slot0)

	if slot0._startBlock then
		slot0._startBlock = false

		UIBlockMgr.instance:endBlock("DungeonMapEpisodeItem showUnlock")
	end
end

function slot0._onRefreshActivityState(slot0, slot1)
	slot0:refreshLockTip()
	slot0:refreshV1a7Fall()
end

function slot0.onDestroyView(slot0)
	if slot0._graphics then
		for slot4, slot5 in ipairs(slot0._graphics) do
			ZProj.UGUIHelper.DisableGrayKey(slot5)
		end
	end

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	if slot0.simageV1a7Icon then
		slot0.simageV1a7Icon:UnLoadImage()
	end
end

return slot0
