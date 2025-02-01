module("modules.logic.versionactivity1_2.versionactivity1_2dungeonbase.view.VersionActivity1_2MapEpisodeBaseItem", package.seeall)

slot0 = class("VersionActivity1_2MapEpisodeBaseItem", BaseChildView)

function slot0.onInitView(slot0)
	slot0._goscale = gohelper.findChild(slot0.viewGO, "#go_scale")
	slot0._txtsection = gohelper.findChildText(slot0.viewGO, "#go_scale/section/#txt_section")
	slot0._gostaricon = gohelper.findChild(slot0.viewGO, "#go_scale/star/#go_staricon")
	slot0._txtsectionname = gohelper.findChildText(slot0.viewGO, "#go_scale/#txt_sectionname")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "#go_scale/#txt_nameen")
	slot0._goraycast = gohelper.findChild(slot0.viewGO, "#go_raycast")
	slot0._goclickarea = gohelper.findChild(slot0.viewGO, "#go_clickarea")
	slot0._golock = gohelper.findChild(slot0.viewGO, "#go_scale/#go_lock")
	slot0.txtlocktips = gohelper.findChildText(slot0.viewGO, "#go_scale/#txt_locktips")
	slot0.imagesuo = gohelper.findChildImage(slot0.viewGO, "#go_scale/#txt_locktips/#image_suo")
	slot0._goprogressitem = gohelper.findChild(slot0.viewGO, "#go_scale/#go_lock/interactiveprogress/#go_progressitem")
	slot0._gobeselected = gohelper.findChild(slot0.viewGO, "#go_beselected")
	slot0._gointro = gohelper.findChild(slot0.viewGO, "#go_Intro_section")
	slot0._goclickintro = gohelper.findChild(slot0.viewGO, "#go_Intro_section/#btn_intro_section")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, slot0._OnUpdateMapElementState, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.focusEpisodeItem, slot0._focusEpisodeItem, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.afterCollectLastShow, slot0._afterCollectLastShow, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.unlockEpisodeItemByGuide, slot0._updateLock, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, slot0._beginShowRewardView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, slot0._endShowRewardView, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._focusEpisodeItem(slot0, slot1)
	gohelper.setActive(slot0._gobeselected, slot1 == slot0._config.id and slot0._index ~= 1)
end

function slot0.onClick(slot0, slot1)
	if ViewMgr.instance:getContainer(slot0:getDungeonMapLevelView()) then
		slot2:stopCloseViewTask()

		if slot0._layout.selectedEpisodeItem == slot0 then
			ViewMgr.instance:closeView(slot0:getDungeonMapLevelView())

			return
		end
	end

	if slot0:isLock() then
		ViewMgr.instance:closeView(slot0:getDungeonMapLevelView())
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_close)
		DungeonController.instance:openDungeonMapTaskView({
			viewParam = slot0._config.preEpisode
		})

		return
	end

	ViewMgr.instance:openView(slot0:getDungeonMapLevelView(), {
		episodeId = slot1 or slot0._config.id,
		isJump = slot1 and true
	})
	slot0._layout:setFocusEpisodeItem(slot0, true)
	slot0._layout:setSelectEpisodeItem(slot0)
	slot0._mapSceneView:changeMap(slot0:getMapCfg())
	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.focusEpisodeItem, slot0._config.id)
end

function slot0.getDungeonMapLevelView(slot0)
	return ViewName.VersionActivityDungeonMapLevelView
end

function slot0._onIntroClick(slot0)
	StoryController.instance:playStory(200201)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gostaricon, false)

	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0.goClick = gohelper.getClick(slot0._goclickarea)

	slot0.goClick:AddClickListener(slot0.onClick, slot0)

	slot0.goIntroClick = gohelper.getClick(slot0._goclickintro)

	slot0.goIntroClick:AddClickListener(slot0._onIntroClick, slot0)
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
	slot0:initViewParam()
end

function slot0.refresh(slot0, slot1, slot2, slot3)
	slot0._index = slot3
	slot0._config = slot1
	slot0._dungeonMo = slot2
	slot0._levelIndex = VersionActivity1_2DungeonConfig.instance:getEpisodeIndex(slot0._config.id)
	slot0.pass = DungeonModel.instance:hasPassLevelAndStory(slot0._config.id)

	slot0:refreshUI()
	slot0:calculatePosInContent()
	slot0:playAnimation("selected")

	slot0.isSelected = false

	slot0:_updateLock()

	if slot0._index == 1 then
		for slot9 = 0, slot0.viewGO.transform.childCount - 1 do
			gohelper.setActive(slot4:GetChild(slot9).gameObject, false)
		end

		gohelper.setActive(slot0._gointro, true)
	end
end

function slot0._OnUpdateMapElementState(slot0)
	slot0:_updateLock()
end

function slot0.refreshUI(slot0)
	slot0._txtsection.text = string.format("%02d", slot0._levelIndex)
	slot0._txtsectionname.text = slot0._config.name
	slot0._txtnameen.text = slot0._config.name_En

	slot0:refreshStar()
	slot0:refreshUnlockContent()
end

function slot0.refreshStar(slot0)
	slot0:refreshStoryModeStar()
end

function slot0.isDungeonHardModel(slot0)
	return VersionActivity1_2DungeonEnum.DungeonChapterId2UIModel[slot0._config.chapterId] == VersionActivity1_2DungeonEnum.DungeonMode.Hard
end

function slot0.refreshStoryModeStar(slot0)
	gohelper.CreateObjList(slot0, slot0._onStarItemShow, DungeonConfig.instance:get1_2VersionActivityEpisodeCoList(slot0._config.id), gohelper.findChild(slot0.viewGO, "#go_scale/star"), slot0._gostaricon)
end

function slot0._onStarItemShow(slot0, slot1, slot2, slot3)
	slot4 = slot2
	slot6 = DungeonModel.instance:getEpisodeInfo(slot4)

	slot0:setImage(gohelper.findChildImage(slot1, "#image_star1"), DungeonModel.instance:hasPassLevelAndStory(slot4), slot0:isDungeonHardModel())

	if string.nilorempty(DungeonConfig.instance:getEpisodeAdvancedConditionText(slot4)) then
		gohelper.setActive(gohelper.findChildImage(slot1, "#image_star2").gameObject, false)
	else
		gohelper.setActive(slot8.gameObject, true)
		slot0:setImage(slot8, slot9 and slot6 and DungeonEnum.StarType.Advanced <= slot6.star, slot0:isDungeonHardModel())
	end
end

function slot0.refreshEpisodeStar(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1.goStar, true)

	slot5 = DungeonModel.instance:getEpisodeInfo(slot2)

	slot0:setImage(slot1.imgStar1, DungeonModel.instance:hasPassLevelAndStory(slot2), slot3)

	if string.nilorempty(DungeonConfig.instance:getEpisodeAdvancedConditionText(slot2)) then
		gohelper.setActive(slot1.imgStar2.gameObject, false)
	else
		gohelper.setActive(slot1.imgStar2.gameObject, true)
		slot0:setImage(slot1.imgStar2, slot6 and slot5 and DungeonEnum.StarType.Advanced <= slot5.star, slot3)
	end
end

function slot0.calculatePosInContent(slot0)
	slot0._maxWidth = math.max(math.max(recthelper.getAnchorX(slot0._txtsectionname.transform) + slot0._txtsectionname.preferredWidth, recthelper.getAnchorX(slot0._txtnameen.transform) + slot0._txtsectionname.preferredWidth) * 2, VersionActivityEnum.EpisodeItemMinWidth) + 100

	recthelper.setWidth(slot0._goclickarea.transform, slot0._maxWidth)
	gohelper.setActive(slot0._goraycast, false)

	slot0.scrollContentPosX = recthelper.rectToRelativeAnchorPos(slot0.viewGO.transform.position, slot0._contentTransform).x
end

function slot0.setImage(slot0, slot1, slot2, slot3)
	if slot2 then
		if slot3 then
			UISpriteSetMgr.instance:setVersionActivitySprite(slot1, "star_0_4")
		else
			UISpriteSetMgr.instance:setVersionActivitySprite(slot1, "star_0_3")
		end
	else
		UISpriteSetMgr.instance:setVersionActivitySprite(slot1, "star_0_1")
	end
end

function slot0.refreshUnlockContent(slot0)
	if slot0.pass or DungeonModel.instance:isReactivityEpisode(slot0._config.id) or DungeonModel.instance:isPermanentEpisode(slot0._config.id) then
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

function slot0._beginShowRewardView(slot0)
	slot0._showRewardView = true
end

function slot0._endShowRewardView(slot0)
	slot0._showRewardView = false

	slot0:_updateLock()
end

function slot0._afterCollectLastShow(slot0)
	if slot0._config.id == 1210113 then
		slot0:_updateLock()
	end
end

function slot0._updateLock(slot0)
	if slot0._showRewardView then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.KeepEpisodeItemLock) then
		return
	end

	if not DungeonModel.instance:isFinishElementList(slot0._config) ~= slot0._lastLockState then
		slot2 = nil
	end

	slot0:_updateInteractiveProgress()

	if slot2 == false then
		return
	end

	slot3 = slot0._lastLockState
	slot0._lastLockState = not DungeonModel.instance:isFinishElementList(slot0._config)

	if slot0._config.id == 1210113 and not DungeonMapModel.instance:elementIsFinished(12101091) then
		slot0._lastLockState = true
	end

	if slot3 and not slot0._lastLockState then
		if slot0._golock:GetComponent(typeof(UnityEngine.Animator)) then
			slot4.enabled = true
		end

		gohelper.setActive(gohelper.findChild(slot0._golock, "raycast"), false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
	else
		gohelper.setActive(slot0._golock, slot0._lastLockState)
	end
end

function slot0._updateInteractiveProgress(slot0)
	if slot0._lastLockState == false then
		return
	end

	for slot7, slot8 in ipairs(string.splitToNumber(slot0._config.elementList, "#")) do
		if DungeonMapModel.instance:elementIsFinished(slot8) then
			slot3 = 0 + 1
		end
	end

	slot0:_updateProgressUI(slot2, slot3)
end

function slot0._updateProgressUI(slot0, slot1, slot2)
	gohelper.setActive(slot0._goprogressitem, false)

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
	if slot0._config.id == 1210113 and not DungeonMapModel.instance:elementIsFinished(12101091) then
		return true
	end

	return not DungeonModel.instance:isFinishElementList(slot0._config)
end

function slot0.getMaxWidth(slot0)
	return slot0._maxWidth
end

function slot0.showUnlockAnim(slot0)
	logWarn("episode item play unlock animation")
end

function slot0.getMapCfg(slot0)
	return VersionActivity1_2DungeonConfig.instance:get1_2EpisodeMapConfig(slot0._config.id)
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

function slot0.onClose(slot0)
	slot0.goClick:RemoveClickListener()
	slot0.goIntroClick:RemoveClickListener()
end

function slot0.onDestroyView(slot0)
end

return slot0
