module("modules.logic.versionactivity1_3.versionactivity1_3dungeonbase.view.VersionActivity1_3DungeonBaseEpisodeItem", package.seeall)

slot0 = class("VersionActivity1_3DungeonBaseEpisodeItem", BaseChildView)

function slot0.onInitView(slot0)
	slot0._goscale = gohelper.findChild(slot0.viewGO, "#go_scale")
	slot0._txtsection = gohelper.findChildText(slot0.viewGO, "#go_scale/section/#txt_section")
	slot0._gostaricon = gohelper.findChild(slot0.viewGO, "#go_scale/star/#go_staricon")
	slot0._txtsectionname = gohelper.findChildText(slot0.viewGO, "#go_scale/#txt_sectionname")
	slot0._gotipcontent = gohelper.findChild(slot0.viewGO, "#go_scale/#txt_sectionname/#go_tipcontent")
	slot0._gotipitem = gohelper.findChild(slot0.viewGO, "#go_scale/#txt_sectionname/#go_tipcontent/#go_tipitem")
	slot0._goflag = gohelper.findChild(slot0.viewGO, "#go_scale/#go_flag")
	slot0._gonormaleye = gohelper.findChild(slot0.viewGO, "#go_scale/#image_normal")
	slot0._gohardeye = gohelper.findChild(slot0.viewGO, "#go_scale/#image_hard")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "#go_scale/#txt_sectionname/#txt_nameen")
	slot0._goraycast = gohelper.findChild(slot0.viewGO, "#go_raycast")
	slot0._goclickarea = gohelper.findChild(slot0.viewGO, "#go_clickarea")
	slot0.goSelected = gohelper.findChild(slot0.viewGO, "#go_beselected")
	slot0.txtlocktips = gohelper.findChildText(slot0.viewGO, "#txt_locktips")
	slot0.imagesuo = gohelper.findChildImage(slot0.viewGO, "#txt_locktips/#image_suo")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClick(slot0)
	if ViewMgr.instance:getContainer(ViewName.VersionActivity1_3DungeonMapLevelView) then
		slot1:stopCloseViewTask()

		if slot0._layout.selectedEpisodeItem == slot0 then
			ViewMgr.instance:closeView(ViewName.VersionActivity1_3DungeonMapLevelView)

			return
		end
	end

	if slot0:isLock() then
		ViewMgr.instance:closeView(ViewName.VersionActivity1_3DungeonMapLevelView)
		DungeonController.instance:openDungeonMapTaskView({
			viewParam = slot0._config.preEpisode
		})

		return
	end

	slot0.activityDungeonMo:changeEpisode(slot0:getEpisodeId())
	slot0._mapSceneView:refreshMap()
	slot0._layout:updateFocusStatus(slot0)
	slot0._layout:setFocusEpisodeItem(slot0, true)

	if GamepadController.instance:isOpen() then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeFocusEpisodeItem, slot0)
	end

	slot0._needShowMapLevelView = true

	if slot0:_promptlyShow() then
		slot0:_showMapLevelView()
	else
		ViewMgr.instance:closeView(ViewName.VersionActivity1_3DungeonMapLevelView)
	end
end

function slot0.isLock(slot0)
	return not DungeonModel.instance:isFinishElementList(slot0._config)
end

function slot0._promptlyShow(slot0)
	return true
end

function slot0._showMapLevelView(slot0)
	slot0._needShowMapLevelView = false

	ViewMgr.instance:openView(ViewName.VersionActivity1_3DungeonMapLevelView, {
		episodeId = slot0._config.id
	})
	slot0._layout:setSelectEpisodeItem(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gostaricon, false)
	gohelper.setActive(slot0._goflag, false)
	gohelper.setActive(slot0._gotipitem, false)
	gohelper.setActive(slot0._gonormaleye, false)
	gohelper.setActive(slot0._gohardeye, false)

	slot0.starItemList = {}
	slot0.elementItemList = {}

	table.insert(slot0.starItemList, slot0:createStarItem(slot0._gostaricon))

	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0.goClick = gohelper.getClick(slot0._goclickarea)

	slot0.goClick:AddClickListener(slot0.onClick, slot0)
end

function slot0._showEye(slot0)
	if not (slot0._config.displayMark == 1) then
		gohelper.setActive(slot0._gonormaleye, false)
		gohelper.setActive(slot0._gohardeye, false)

		return
	end

	slot2 = slot0._config.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard

	gohelper.setActive(slot0._gonormaleye, not slot2)
	gohelper.setActive(slot0._gohardeye, slot2)
end

function slot0.initViewParam(slot0)
	slot0._contentTransform = slot0.viewParam[1]
	slot0._layout = slot0.viewParam[2]
	slot0._mapSceneView = slot0.viewContainer.mapScene
end

function slot0.onUpdateParam(slot0)
	slot0:initViewParam()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, slot0.refreshElements, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, slot0._endShowRewardView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:initViewParam()
end

function slot0._onCloseViewFinish(slot0, slot1)
end

function slot0.getMapAllElementList(slot0)
	if not DungeonConfig.instance:getMapElements(slot0._map.id) then
		return
	end

	slot3 = {}

	for slot7, slot8 in ipairs(slot2) do
		if slot8.type ~= DungeonEnum.ElementType.DailyEpisode then
			table.insert(slot3, slot8)
		end
	end

	return slot3
end

function slot0._showAllElementTipView(slot0)
	if not slot0._map then
		gohelper.setActive(slot0._gotipcontent, false)

		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DungeonHideElementTip) then
		return
	end

	slot0._pass = DungeonModel.instance:hasPassLevelAndStory(slot0._config.id)

	if not slot0:getMapAllElementList() or #slot1 < 1 then
		gohelper.setActive(slot0._gotipcontent, false)

		slot0._showAllElementTip = false
	else
		for slot6, slot7 in ipairs(slot1) do
			if DungeonMapModel.instance:elementIsFinished(slot7.id) then
				slot2 = 0 + 1
			end
		end

		slot3 = nil

		for slot7, slot8 in ipairs(slot1) do
			if not slot0.elementItemList[slot7] then
				slot3 = slot0:getUserDataTb_()
				slot3.go = gohelper.cloneInPlace(slot0._gotipitem)
				slot3.goNotFinish = gohelper.findChild(slot3.go, "type1")
				slot3.goFinish = gohelper.findChild(slot3.go, "type2")
				slot3.animator = slot3.go:GetComponent(typeof(UnityEngine.Animator))
				slot3.status = nil

				table.insert(slot0.elementItemList, slot3)
			end

			gohelper.setActive(slot3.go, true)

			slot9 = slot0._pass and slot7 <= slot2

			gohelper.setActive(slot3.goNotFinish, not slot9)
			gohelper.setActive(slot3.goFinish, slot9)

			if slot3.status == false and slot9 then
				gohelper.setActive(slot3.goNotFinish, true)
				slot3.animator:Play("switch", 0, 0)
				AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_light_up)
			end

			slot3.status = slot9
		end

		slot0._showAllElementTip = slot0._pass and slot2 ~= #slot1

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
end

function slot0.refresh(slot0, slot1, slot2)
	slot0._config = slot1
	slot0._dungeonMo = slot2

	if slot0._config.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard then
		slot0._levelIndex = DungeonConfig.instance:getChapterEpisodeIndexWithSP(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei, slot0._config.id - 10000)
	else
		slot0._levelIndex = DungeonConfig.instance:getChapterEpisodeIndexWithSP(slot0._config.chapterId, slot0._config.id)
	end

	slot0.pass = DungeonModel.instance:hasPassLevelAndStory(slot0._config.id)
	slot0._map = DungeonMapEpisodeItem.getMap(slot0._config)

	slot0:refreshUI()
	slot0:calculatePosInContent()
	slot0:playAnimation("selected")

	slot0.isSelected = false

	slot0:_showEye()
end

function slot0.refreshUI(slot0)
	slot0._txtsection.text = string.format("%02d", slot0._levelIndex)
	slot0._txtsectionname.text = slot0._config.name
	slot0._txtnameen.text = slot0._config.name_En

	slot0:refreshStar()
	slot0:refreshFlag()
	slot0:refreshUnlockContent()
	slot0:refreshFocusStatus()
	slot0:refreshElements()
	slot0:_showAllElementTipView()
end

function slot0.refreshStar(slot0)
	if slot0.activityDungeonMo:isHardMode() then
		slot0:refreshHardModeStar()
	else
		slot0:refreshStoryModeStar()
	end
end

function slot0.refreshFlag(slot0)
	gohelper.setActive(slot0._goflag, not slot0.pass)
end

function slot0.refreshUnlockContent(slot0)
	if slot0.pass or DungeonModel.instance:isReactivityEpisode(slot0._config.id) then
		gohelper.setActive(slot0.txtlocktips.gameObject, false)

		return
	end

	if OpenConfig.instance:getOpenShowInEpisode(slot0._config.id) and #slot1 > 0 then
		gohelper.setActive(slot0.txtlocktips.gameObject, true)

		slot0.txtlocktips.text = DungeonModel.instance:getUnlockContentList(slot0._config.id) and #slot2 > 0 and slot2[1] or ""

		UISpriteSetMgr.instance:setUiFBSprite(slot0.imagesuo, "unlock", true)
	else
		gohelper.setActive(slot0.txtlocktips.gameObject, false)
	end
end

function slot0.refreshHardModeStar(slot0)
	slot4 = slot0.starItemList[1]

	slot0:refreshEpisodeStar(slot4, slot0._config.id)

	for slot4 = 2, #slot0.starItemList do
		gohelper.setActive(slot0.starItemList[slot4].goStar, false)
	end
end

function slot0.refreshStoryModeStar(slot0)
	slot1 = nil
	slot4 = DungeonConfig.instance
	slot6 = slot4

	for slot5, slot6 in ipairs(slot4.getVersionActivityBrotherEpisodeByEpisodeCo(slot6, slot0._config)) do
		if not slot0.starItemList[slot5] then
			table.insert(slot0.starItemList, slot0:createStarItem(gohelper.cloneInPlace(slot0._gostaricon)))
		end

		slot0:refreshEpisodeStar(slot1, slot6.id)
	end
end

function slot0.refreshEpisodeStar(slot0, slot1, slot2)
	gohelper.setActive(slot1.goStar, true)

	slot4 = DungeonModel.instance:getEpisodeInfo(slot2)

	slot0:setImage(slot1.imgStar1, slot0.pass and slot4 and DungeonEnum.StarType.None < slot4.star, slot2)

	if string.nilorempty(DungeonConfig.instance:getEpisodeAdvancedConditionText(slot2)) then
		gohelper.setActive(slot1.imgStar2.gameObject, false)
	else
		gohelper.setActive(slot1.imgStar2.gameObject, true)
		slot0:setImage(slot1.imgStar2, slot0.pass and slot4 and DungeonEnum.StarType.Advanced <= slot4.star, slot2)
	end
end

function slot0.refreshFocusStatus(slot0)
	gohelper.setActive(slot0.goSelected, slot0._config.id == slot0.activityDungeonMo.episodeId)
end

function slot0.refreshElements(slot0)
	slot0:_showAllElementTipView()
end

function slot0._endShowRewardView(slot0)
	slot0:_showAllElementTipView()
end

function slot0.calculatePosInContent(slot0)
	slot4 = recthelper.getAnchorX(slot0._txtnameen.transform) + slot0._txtnameen.preferredWidth
	slot0._maxWidth = math.max(recthelper.getAnchorX(slot0._txtsectionname.transform) + slot0._txtsectionname.preferredWidth, VersionActivity1_3DungeonEnum.EpisodeItemMinWidth) + 30

	recthelper.setWidth(slot0._goclickarea.transform, slot0._maxWidth)
	recthelper.setWidth(slot0._goraycast.transform, slot0._maxWidth + slot0._layout._constDungeonNormalDeltaX)

	slot0.scrollContentPosX = recthelper.rectToRelativeAnchorPos(slot0.viewGO.transform.position, slot0._contentTransform).x
end

function slot0.setImage(slot0, slot1, slot2, slot3)
	if slot2 then
		UISpriteSetMgr.instance:setVersionActivity1_3Sprite(slot1, VersionActivity1_3DungeonEnum.EpisodeStarType[DungeonConfig.instance:getEpisodeCO(slot3).chapterId])
	else
		UISpriteSetMgr.instance:setVersionActivity1_3Sprite(slot1, VersionActivity1_3DungeonEnum.EpisodeStarEmptyType[DungeonConfig.instance:getEpisodeCO(slot3).chapterId])
	end
end

function slot0.getMaxWidth(slot0)
	return slot0._maxWidth
end

function slot0.updateSelectStatus(slot0, slot1)
	if not slot1 then
		if not slot0.isSelected and slot0.playLeftAnimation then
			slot0:playAnimation("restore")
		end

		slot0.isSelected = false

		return
	end

	slot0.isSelected = slot1._config.id == slot0._config.id

	if slot1._config.id == slot0._config.id then
		slot0:playAnimation("selected")
	else
		slot0.playLeftAnimation = true

		slot0:playAnimation("notselected")
	end
end

function slot0.playAnimation(slot0, slot1)
	slot0.animator:Play(slot1, 0, 0)
end

function slot0.getEpisodeId(slot0)
	return slot0._config and slot0._config.id
end

function slot0.createStarItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.goStar = slot1
	slot2.imgStar1 = gohelper.findChildImage(slot1, "starLayout/#image_star1")
	slot2.imgStar2 = gohelper.findChildImage(slot1, "starLayout/#image_star2")

	return slot2
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0.goClick:RemoveClickListener()
end

return slot0
