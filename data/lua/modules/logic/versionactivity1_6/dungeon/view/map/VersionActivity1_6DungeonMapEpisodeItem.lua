module("modules.logic.versionactivity1_6.dungeon.view.map.VersionActivity1_6DungeonMapEpisodeItem", package.seeall)

slot0 = class("VersionActivity1_6DungeonMapEpisodeItem", BaseChildView)

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
	slot0.goLock = gohelper.findChild(slot0.viewGO, "#go_scale/#go_lock")
	slot0.goLockAnimator = slot0.goLock:GetComponent(gohelper.Type_Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClick(slot0)
	if slot0.isLock then
		ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonMapTaskView, {
			episodeId = slot0:getEpisodeId()
		})

		return
	end

	if ViewMgr.instance:getContainer(ViewName.VersionActivity1_6DungeonMapLevelView) then
		slot1:stopCloseViewTask()

		if slot1:getOpenedEpisodeId() == slot0._config.id then
			ViewMgr.instance:closeView(ViewName.VersionActivity1_6DungeonMapLevelView)

			return
		end
	end

	slot0.activityDungeonMo:changeEpisode(slot0:getEpisodeId())
	slot0._layout:setSelectEpisodeItem(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonMapLevelView, {
		episodeId = slot0._config.id
	})
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

function slot0.initViewParam(slot0)
	slot0._contentTransform = slot0.viewParam[1]
	slot0._layout = slot0.viewParam[2]
	slot0._mapSceneView = slot0.viewContainer.mapScene
end

function slot0.onUpdateParam(slot0)
	slot0:initViewParam()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, slot0.beginShowRewardView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, slot0.endShowRewardView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, slot0.onRemoveElement, slot0, LuaEventSystem.Low)
	slot0:initViewParam()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0.goClick:RemoveClickListener()
end

function slot0.refresh(slot0, slot1, slot2)
	slot0._config = slot1
	slot0._dungeonMo = slot2
	slot0._levelIndex = DungeonConfig.instance:getEpisodeLevelIndex(slot0._config)
	slot0.pass = DungeonModel.instance:hasPassLevelAndStory(slot0._config.id)
	slot0._map = VersionActivity1_6DungeonController.instance:getEpisodeMapConfig(slot0._config.id)

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
	slot0:_showEye()
	slot0:refreshLock()
end

function slot0.refreshLock(slot0)
	slot0.isLock = slot0:checkLock()

	gohelper.setActive(slot0.goLock, slot0.isLock)
end

function slot0.checkLock(slot0)
	slot0:initElementIdList()

	if not slot0.elementIdList then
		return false
	end

	for slot4, slot5 in ipairs(slot0.elementIdList) do
		if not DungeonMapModel.instance:elementIsFinished(slot5) then
			return true
		end
	end

	return false
end

function slot0.refreshUnlockContent(slot0)
	if slot0.pass then
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

function slot0.playUnLockAnimation(slot0)
	slot0.goLock:GetComponent(typeof(UnityEngine.Animator)).enabled = true
end

function slot0.refreshStar(slot0)
	if slot0.activityDungeonMo:isHardMode() then
		slot0:refreshHardModeStar()
	else
		slot0:refreshStoryModeStar()
	end
end

function slot0.refreshHardModeStar(slot0)
	slot4 = slot0._config.id

	slot0:refreshEpisodeStar(slot0.starItemList[1], slot4)

	for slot4 = 2, #slot0.starItemList do
		gohelper.setActive(slot0.starItemList[slot4].goStar, false)
	end
end

function slot0.refreshStoryModeStar(slot0)
	slot1 = nil

	for slot6, slot7 in ipairs(DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(slot0._config)) do
		if not slot0.starItemList[slot6] then
			table.insert(slot0.starItemList, slot0:createStarItem(gohelper.cloneInPlace(slot0._gostaricon)))
		end

		slot0:refreshEpisodeStar(slot1, slot7.id)
	end
end

function slot0.refreshEpisodeStar(slot0, slot1, slot2)
	gohelper.setActive(slot1.goStar, true)

	slot4 = DungeonModel.instance:getEpisodeInfo(slot2)

	slot0:setStarImage(slot1.imgStar1, slot0.pass and slot4 and DungeonEnum.StarType.None < slot4.star, slot2)

	if string.nilorempty(DungeonConfig.instance:getEpisodeAdvancedConditionText(slot2)) then
		gohelper.setActive(slot1.imgStar2.gameObject, false)
	else
		gohelper.setActive(slot1.imgStar2.gameObject, true)
		slot0:setStarImage(slot1.imgStar2, slot0.pass and slot4 and DungeonEnum.StarType.Advanced <= slot4.star, slot2)
	end
end

function slot0.createStarItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.goStar = slot1
	slot2.imgStar1 = gohelper.findChildImage(slot1, "starLayout/#image_star1")
	slot2.imgStar2 = gohelper.findChildImage(slot1, "starLayout/#image_star2")

	return slot2
end

function slot0.setStarImage(slot0, slot1, slot2, slot3)
	if slot2 then
		UISpriteSetMgr.instance:setV1a6DungeonSprite(slot1, VersionActivity1_6DungeonEnum.EpisodeStarType[DungeonConfig.instance:getEpisodeCO(slot3).chapterId])
	else
		UISpriteSetMgr.instance:setV1a6DungeonSprite(slot1, VersionActivity1_6DungeonEnum.EpisodeStarEmptyType[DungeonConfig.instance:getEpisodeCO(slot3).chapterId])
	end
end

function slot0.refreshFlag(slot0)
	gohelper.setActive(slot0._goflag, false)
end

function slot0.initElementIdList(slot0)
	if not slot0.elementIdList and not string.nilorempty(slot0._config.elementList) then
		slot0.elementIdList = string.splitToNumber(slot1, "#")
	end
end

function slot0.clearElementIdList(slot0)
	slot0.elementIdList = nil
end

function slot0.getMapAllElementList(slot0)
	slot1, slot2 = VersionActivity1_6DungeonModel.instance:getElementCoList(slot0._map.id)

	return slot1
end

function slot0._showAllElementTipView(slot0)
	if not slot0._map then
		gohelper.setActive(slot0._gotipcontent, false)

		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DungeonHideElementTip) then
		return
	end

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

			slot9 = slot0.pass and slot7 <= slot2

			gohelper.setActive(slot3.goNotFinish, not slot9)
			gohelper.setActive(slot3.goFinish, slot9)

			if slot3.status == false and slot9 then
				gohelper.setActive(slot3.goNotFinish, true)
				slot3.animator:Play("switch", 0, 0)
				AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_light_up)
			end

			slot3.status = slot9
		end

		slot0._showAllElementTip = slot0.pass and slot2 ~= #slot1

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

function slot0.onRemoveElement(slot0, slot1)
	if not slot0.isLock then
		return
	end

	slot0:initElementIdList()

	if not slot0.elementIdList then
		return
	end

	for slot5, slot6 in ipairs(slot0.elementIdList) do
		if slot6 == slot1 then
			slot0.isLock = slot0:checkLock()

			if not slot0.isLock and slot0.beginReward then
				slot0.needPlayUnLockAnimation = true

				break
			end

			slot0:playUnLockAnimation()

			break
		end
	end
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

function slot0.refreshFocusStatus(slot0)
	gohelper.setActive(slot0.goSelected, slot0._config.id == slot0.activityDungeonMo.episodeId)
end

function slot0.beginShowRewardView(slot0)
	slot0.beginReward = true
end

function slot0.endShowRewardView(slot0)
	slot0.beginReward = false

	if slot0.needPlayUnLockAnimation then
		slot0:playUnLockAnimation()

		slot0.needPlayUnLockAnimation = nil
	end
end

function slot0.calculatePosInContent(slot0)
	slot0._maxWidth = recthelper.getAnchorX(slot0._txtsectionname.transform) + slot0._txtsectionname.preferredWidth

	if slot0._txtnameen.gameObject.activeSelf then
		slot0._maxWidth = math.max(math.max(slot3, recthelper.getAnchorX(slot0._txtnameen.transform) + slot0._txtsectionname.preferredWidth) * 2, VersionActivity1_3DungeonEnum.EpisodeItemMinWidth) + 30
	else
		slot0._maxWidth = math.max(slot3, 220) + 250
	end

	recthelper.setWidth(slot0._goclickarea.transform, slot0._maxWidth)
	recthelper.setWidth(slot0._goraycast.transform, slot0._maxWidth + slot0._layout._constDungeonNormalDeltaX)

	slot0.scrollContentPosX = recthelper.rectToRelativeAnchorPos(slot0.viewGO.transform.position, slot0._contentTransform).x
end

function slot0.getMaxWidth(slot0)
	return slot0._maxWidth
end

function slot0.updateSelectStatus(slot0, slot1, slot2)
	if not slot1 then
		if not slot0.isSelected and slot0.playLeftAnimation then
			slot0:playAnimation("restore")
		end

		slot0.isSelected = false

		return
	end

	slot0.isSelected = slot1._config.id == slot0._config.id

	if slot2 then
		return
	end

	if slot1._config.id == slot0._config.id then
		slot0:playAnimation("selected")
	else
		slot0.playLeftAnimation = true

		slot0:playAnimation("notselected")
	end
end

function slot0.playAnimation(slot0, slot1)
	if slot0.prePlayAnimName == slot1 then
		return
	end

	slot0.prePlayAnimName = slot1

	slot0.animator:Play(slot1, 0, 0)
end

function slot0.getEpisodeId(slot0)
	return slot0._config and slot0._config.id
end

return slot0
