module("modules.versionactivitybase.dungeon.view.VersionActivityDungeonBaseEpisodeItem", package.seeall)

slot0 = class("VersionActivityDungeonBaseEpisodeItem", BaseChildView)

function slot0.onInitView(slot0)
	slot0._goscale = gohelper.findChild(slot0.viewGO, "#go_scale")
	slot0._txtsection = gohelper.findChildText(slot0.viewGO, "#go_scale/section/#txt_section")
	slot0._gostaricon = gohelper.findChild(slot0.viewGO, "#go_scale/star/#go_staricon")
	slot0._txtsectionname = gohelper.findChildText(slot0.viewGO, "#go_scale/#txt_sectionname")
	slot0._goflag = gohelper.findChild(slot0.viewGO, "#go_scale/#go_flag")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "#go_scale/#txt_sectionname/#txt_nameen")
	slot0._gointeractcontent = gohelper.findChild(slot0.viewGO, "#go_scale/#txt_sectionname/#go_interactContent")
	slot0._gointeractitem = gohelper.findChild(slot0.viewGO, "#go_scale/#txt_sectionname/#go_interactContent/#go_interact")
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
	if ViewMgr.instance:getContainer(ViewName.VersionActivityDungeonMapLevelView) then
		slot1:stopCloseViewTask()

		if slot1:getOpenedEpisodeId() == slot0._config.id then
			ViewMgr.instance:closeView(ViewName.VersionActivityDungeonMapLevelView)

			return
		end
	end

	ViewMgr.instance:openView(ViewName.VersionActivityDungeonMapLevelView, {
		episodeId = slot0._config.id
	})
	slot0._layout:setFocusEpisodeItem(slot0, true)
	slot0._layout:setSelectEpisodeItem(slot0)
	slot0.activityDungeonMo:changeEpisode(slot0:getEpisodeId())
	slot0._mapSceneView:refreshMap()
	slot0._layout:updateFocusStatus(slot0)

	if GamepadController.instance:isOpen() then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeFocusEpisodeItem, slot0)
	end
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gostaricon, false)
	gohelper.setActive(slot0._goflag, false)
	gohelper.setActive(slot0._gointeractitem, false)

	slot0.starItemList = {}
	slot0.elementItemList = {}

	table.insert(slot0.starItemList, slot0:createStarItem(slot0._gostaricon))

	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0.goClick = gohelper.getClick(slot0._goclickarea)

	slot0.goClick:AddClickListener(slot0.onClick, slot0)
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
	slot0:initViewParam()
end

function slot0.refresh(slot0, slot1, slot2)
	slot0._config = slot1
	slot0._dungeonMo = slot2
	slot0._levelIndex = DungeonConfig.instance:getEpisodeLevelIndex(slot0._config)
	slot0.pass = DungeonModel.instance:hasPassLevelAndStory(slot0._config.id)

	slot0:refreshUI()
	slot0:calculatePosInContent()
	slot0:playAnimation("selected")

	slot0.isSelected = false
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
	if slot0.pass then
		gohelper.setActive(slot0.txtlocktips.gameObject, false)

		return
	end

	if DungeonModel.instance:isReactivityEpisode(slot0._config.id) then
		gohelper.setActive(slot0.txtlocktips, false)

		return
	end

	if OpenConfig.instance:getOpenShowInEpisode(slot0._config.id) and #slot2 > 0 then
		gohelper.setActive(slot0.txtlocktips.gameObject, true)

		slot0.txtlocktips.text = DungeonModel.instance:getUnlockContentList(slot0._config.id) and #slot3 > 0 and slot3[1] or ""

		UISpriteSetMgr.instance:setUiFBSprite(slot0.imagesuo, "unlock", true)
	else
		gohelper.setActive(slot0.txtlocktips.gameObject, false)
	end
end

function slot0.refreshHardModeStar(slot0)
	slot4 = slot0._config.id

	slot0:refreshEpisodeStar(slot0.starItemList[1], slot4, true)

	for slot4 = 2, #slot0.starItemList do
		gohelper.setActive(slot0.starItemList[slot4].goStar, false)
	end
end

function slot0.refreshStoryModeStar(slot0)
	slot1 = nil
	slot5 = slot0._config

	for slot5, slot6 in ipairs(DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(slot5)) do
		if not slot0.starItemList[slot5] then
			table.insert(slot0.starItemList, slot0:createStarItem(gohelper.cloneInPlace(slot0._gostaricon)))
		end

		slot0:refreshEpisodeStar(slot1, slot6.id)
	end
end

function slot0.refreshEpisodeStar(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1.goStar, true)

	slot5 = DungeonModel.instance:getEpisodeInfo(slot2)

	slot0:setImage(slot1.imgStar1, slot0.pass and slot5 and DungeonEnum.StarType.None < slot5.star, slot3)

	if string.nilorempty(DungeonConfig.instance:getEpisodeAdvancedConditionText(slot2)) then
		gohelper.setActive(slot1.imgStar2.gameObject, false)
	else
		gohelper.setActive(slot1.imgStar2.gameObject, true)
		slot0:setImage(slot1.imgStar2, slot0.pass and slot5 and DungeonEnum.StarType.Advanced <= slot5.star, slot3)
	end
end

function slot0.refreshFocusStatus(slot0)
	gohelper.setActive(slot0.goSelected, slot0._config.id == slot0.activityDungeonMo.episodeId)
end

function slot0.refreshElements(slot0)
	if slot0.activityDungeonMo:isHardMode() then
		gohelper.setActive(slot0._gointeractcontent, false)

		return
	end

	if not DungeonConfig.instance:getChapterMapCfg(slot0._config.chapterId, slot0._config.preEpisode) then
		gohelper.setActive(slot0._gointeractcontent, false)

		return
	end

	if not DungeonConfig.instance:getMapElements(slot1.id) or #slot2 < 1 then
		gohelper.setActive(slot0._gointeractcontent, false)
	else
		gohelper.setActive(slot0._gointeractcontent, true)

		slot4 = #slot2 - (DungeonMapModel.instance:getElements(slot1.id) and #slot3 or 0)
		slot5 = nil

		for slot9, slot10 in ipairs(slot2) do
			if not slot0.elementItemList[slot9] then
				slot5 = slot0:getUserDataTb_()
				slot5.go = gohelper.cloneInPlace(slot0._gointeractitem)
				slot5.goNotFinish = gohelper.findChild(slot5.go, "go_notfinish")
				slot5.goFinish = gohelper.findChild(slot5.go, "go_finish")

				table.insert(slot0.elementItemList, slot5)
			end

			gohelper.setActive(slot5.go, true)
			gohelper.setActive(slot5.goNotFinish, not slot0.pass or slot4 < slot9)
			gohelper.setActive(slot5.goFinish, slot0.pass and slot9 <= slot4)
		end

		for slot9 = #slot2 + 1, #slot0.elementItemList do
			gohelper.setActive(slot0.elementItemList[slot9].go, false)
		end
	end
end

function slot0.calculatePosInContent(slot0)
	slot4 = recthelper.getAnchorX(slot0._txtnameen.transform) + slot0._txtnameen.preferredWidth
	slot0._maxWidth = math.max(recthelper.getAnchorX(slot0._txtsectionname.transform) + slot0._txtsectionname.preferredWidth, VersionActivityEnum.EpisodeItemMinWidth) + 30

	recthelper.setWidth(slot0._goclickarea.transform, slot0._maxWidth)
	recthelper.setWidth(slot0._goraycast.transform, slot0._maxWidth + slot0._layout._constDungeonNormalDeltaX)

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
	slot0.animator:Play(slot1)
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
