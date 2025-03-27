module("modules.logic.versionactivity1_8.dungeon.view.map.VersionActivity1_8DungeonMapEpisodeItem", package.seeall)

slot0 = class("VersionActivity1_8DungeonMapEpisodeItem", BaseChildView)
slot1 = 30
slot2 = 0.8

function slot0.onInitView(slot0)
	slot0._goscale = gohelper.findChild(slot0.viewGO, "#go_scale")
	slot0._txtsection = gohelper.findChildText(slot0.viewGO, "#go_scale/section/#txt_section")
	slot0._gonormaleye = gohelper.findChild(slot0.viewGO, "#go_scale/#image_normal")
	slot0._gohardeye = gohelper.findChild(slot0.viewGO, "#go_scale/#image_hard")
	slot0._gostaricon = gohelper.findChild(slot0.viewGO, "#go_scale/star/#go_staricon")
	slot0._txtsectionname = gohelper.findChildText(slot0.viewGO, "#go_scale/#txt_sectionname")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "#go_scale/#txt_sectionname/#txt_nameen")
	slot0._gotipcontent = gohelper.findChild(slot0.viewGO, "#go_scale/#txt_sectionname/#go_tipcontent")
	slot0._gotipitem = gohelper.findChild(slot0.viewGO, "#go_scale/#txt_sectionname/#go_tipcontent/#go_tipitem")
	slot0._goflag = gohelper.findChild(slot0.viewGO, "#go_scale/#go_flag")
	slot0._golock = gohelper.findChild(slot0.viewGO, "#go_scale/#go_lock")
	slot0._goprogressitem = gohelper.findChild(slot0.viewGO, "#go_scale/#go_lock/interactiveprogress/#go_progressitem")
	slot0._gomaxpos = gohelper.findChild(slot0.viewGO, "#go_maxpos")
	slot0._goraycast = gohelper.findChild(slot0.viewGO, "#go_raycast")
	slot0._goclickarea = gohelper.findChild(slot0.viewGO, "#go_clickarea")
	slot0._gobeselected = gohelper.findChild(slot0.viewGO, "#go_beselected")
	slot0._txtlocktips = gohelper.findChildText(slot0.viewGO, "#txt_locktips")
	slot0._imagesuo = gohelper.findChildImage(slot0.viewGO, "#txt_locktips/#image_suo")
	slot0.goClick = gohelper.getClick(slot0._goclickarea)
	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0.goLockAnimator = slot0._golock:GetComponent(gohelper.Type_Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, slot0.beginShowRewardView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, slot0.endShowRewardView, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, slot0.onRemoveElement, slot0, LuaEventSystem.Low)
	slot0:addEventCb(Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, slot0.onChangeInProgressMissionGroup, slot0)
	slot0:addEventCb(Activity157Controller.instance, Activity157Event.Act157RepairComponent, slot0._onRepairComponent, slot0)
	slot0.goClick:AddClickListener(slot0.onClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, slot0.beginShowRewardView, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, slot0.endShowRewardView, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, slot0.onRemoveElement, slot0, LuaEventSystem.Low)
	slot0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, slot0.onChangeInProgressMissionGroup, slot0)
	slot0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157RepairComponent, slot0._onRepairComponent, slot0)
	slot0.goClick:RemoveClickListener()
end

function slot0._onCloseView(slot0)
	if slot0._waitCloseFactoryView then
		if not ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryMapView) and not ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryBlueprintView) then
			slot0:_showAllElementTipView()

			slot0._waitCloseFactoryView = false
		end
	end
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

	slot0:_showAllElementTipView()
end

function slot0.playUnLockAnimation(slot0)
	if not slot0.goLockAnimator then
		return
	end

	slot0.goLockAnimator.enabled = true
end

function slot0.onRemoveElement(slot0, slot1)
	if not slot0.beginReward then
		slot0:_showAllElementTipView()
	end

	slot0:initElementIdList()

	if not slot0.elementIdList then
		return
	end

	for slot5, slot6 in ipairs(slot0.elementIdList) do
		if slot6 == slot1 then
			if slot0:checkLock() == slot0.isLock then
				break
			end

			if slot7 then
				slot0:refreshLock()

				break
			else
				slot0.isLock = slot7

				if slot0.beginReward then
					slot0.needPlayUnLockAnimation = true
				else
					slot0:playUnLockAnimation()
				end
			end
		end
	end
end

function slot0.initElementIdList(slot0)
	if not slot0.elementIdList and not string.nilorempty(slot0._config.elementList) then
		slot0.elementIdList = string.splitToNumber(slot1, "#")
	end
end

function slot0.onChangeInProgressMissionGroup(slot0)
	if not Activity157Model.instance:getIsSideMissionUnlocked() then
		return
	end

	slot0:_showAllElementTipView()
end

function slot0._onRepairComponent(slot0)
	if ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryMapView) or ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryBlueprintView) then
		slot0._waitCloseFactoryView = true
	else
		slot0:_showAllElementTipView()
	end
end

function slot0.onClick(slot0)
	if slot0.isLock then
		return
	end

	if ViewMgr.instance:getContainer(ViewName.VersionActivity1_8DungeonMapLevelView) then
		slot1:stopCloseViewTask()

		if slot1:getOpenedEpisodeId() == slot0._config.id then
			ViewMgr.instance:closeView(ViewName.VersionActivity1_8DungeonMapLevelView)

			return
		end
	end

	slot0.activityDungeonMo:changeEpisode(slot0:getEpisodeId())
	slot0._layout:setSelectEpisodeItem(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_8DungeonMapLevelView, {
		episodeId = slot0._config.id
	})
end

function slot0.getEpisodeId(slot0)
	return slot0._config and slot0._config.id
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
end

function slot0.onUpdateParam(slot0)
	slot0:initViewParam()
	slot0:_showAllElementTipView()
end

function slot0.onOpen(slot0)
	slot0:initViewParam()
end

function slot0.initViewParam(slot0)
	slot0._contentTransform = slot0.viewParam[1]
	slot0._layout = slot0.viewParam[2]
	slot0._mapSceneView = slot0.viewContainer.mapScene
end

function slot0.refresh(slot0, slot1, slot2)
	slot0._config = slot1
	slot0._dungeonMo = slot2
	slot0._levelIndex = DungeonConfig.instance:getEpisodeLevelIndex(slot0._config)
	slot0.pass = DungeonModel.instance:hasPassLevelAndStory(slot0._config.id)
	slot0._map = VersionActivity1_8DungeonConfig.instance:getEpisodeMapConfig(slot0._config.id)

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
	slot0:_showAllElementTipView()
	slot0:_showEye()
	slot0:refreshLock()
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

function slot0.refreshEpisodeStar(slot0, slot1, slot2)
	gohelper.setActive(slot1.goStar, true)

	slot3 = DungeonModel.instance:getEpisodeInfo(slot2)

	slot0:setStarImage(slot1.imgStar1, slot0.pass and slot3 and DungeonEnum.StarType.None < slot3.star, slot2)

	if string.nilorempty(DungeonConfig.instance:getEpisodeAdvancedConditionText(slot2)) then
		gohelper.setActive(slot1.imgStar2.gameObject, false)
	else
		gohelper.setActive(slot1.imgStar2.gameObject, true)
		slot0:setStarImage(slot1.imgStar2, slot0.pass and slot3 and DungeonEnum.StarType.Advanced <= slot3.star, slot2)
	end
end

function slot0.setStarImage(slot0, slot1, slot2, slot3)
	if not DungeonConfig.instance:getEpisodeCO(slot3) then
		return
	end

	if slot2 then
		UISpriteSetMgr.instance:setV1a8DungeonSprite(slot1, VersionActivity1_8DungeonEnum.EpisodeStarType[slot4.chapterId].light)
	else
		UISpriteSetMgr.instance:setV1a8DungeonSprite(slot1, slot5.empty)
	end
end

function slot0.refreshStoryModeStar(slot0)
	for slot5, slot6 in ipairs(DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(slot0._config)) do
		if not slot0.starItemList[slot5] then
			table.insert(slot0.starItemList, slot0:createStarItem(gohelper.cloneInPlace(slot0._gostaricon)))
		end

		slot0:refreshEpisodeStar(slot7, slot6.id)
	end
end

function slot0.createStarItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.goStar = slot1
	slot2.imgStar1 = gohelper.findChildImage(slot1, "starLayout/#image_star1")
	slot2.imgStar2 = gohelper.findChildImage(slot1, "starLayout/#image_star2")

	return slot2
end

function slot0.refreshFlag(slot0)
	gohelper.setActive(slot0._goflag, false)
end

function slot0.refreshUnlockContent(slot0)
	if slot0.pass or DungeonModel.instance:isReactivityEpisode(slot0._config.id) then
		gohelper.setActive(slot0._txtlocktips.gameObject, false)

		return
	end

	if OpenConfig.instance:getOpenShowInEpisode(slot0._config.id) and #slot2 > 0 then
		gohelper.setActive(slot0._txtlocktips.gameObject, true)

		slot0._txtlocktips.text = DungeonModel.instance:getUnlockContentList(slot0._config.id) and #slot3 > 0 and slot3[1] or ""

		UISpriteSetMgr.instance:setUiFBSprite(slot0._imagesuo, "unlock", true)
	else
		gohelper.setActive(slot0._txtlocktips.gameObject, false)
	end
end

function slot0.refreshFocusStatus(slot0)
	gohelper.setActive(slot0._gobeselected, slot0._config.id == slot0.activityDungeonMo.episodeId)
end

function slot0._showAllElementTipView(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DungeonHideElementTip) or not slot0._map then
		gohelper.setActive(slot0._gotipcontent, false)

		return
	end

	slot3 = VersionActivity1_8DungeonModel.instance:getElementCoListWithFinish(slot0._map.id, true)

	if slot0.activityDungeonMo:isHardMode() or not slot3 or #slot3 < 1 then
		slot0._showAllElementTip = false

		gohelper.setActive(slot0._gotipcontent, false)

		return
	end

	slot5 = {}

	for slot9, slot10 in ipairs(slot3) do
		if Activity157Config.instance:getMissionIdByElementId(Activity157Model.instance:getActId(), slot10.id) and Activity157Config.instance:isSideMission(slot11, slot13) then
			if not Activity157Model.instance:isFinishAllMission(Activity157Config.instance:getMissionGroup(slot11, slot13)) then
				slot5[#slot5 + 1] = slot12

				if DungeonMapModel.instance:elementIsFinished(slot12) then
					slot4 = 0 + 1
				end
			end
		else
			slot5[#slot5 + 1] = slot12

			if slot15 then
				slot4 = slot4 + 1
			end
		end
	end

	if Activity157Model.instance:getIsSideMissionUnlocked() then
		if slot0._lastProgressGroupId and slot0._lastProgressGroupId ~= 0 and slot0._lastProgressGroupId ~= Activity157Model.instance:getInProgressMissionGroup() then
			for slot11, slot12 in ipairs(slot0.elementItemList) do
				slot12.status = nil

				slot12.animator:Play("idle", 0, 1)
				gohelper.setActive(slot12.go, false)
			end
		end

		slot0._lastProgressGroupId = slot7
	end

	for slot10, slot11 in ipairs(slot5) do
		if not slot0.elementItemList[slot10] then
			slot12 = slot0:getUserDataTb_()
			slot12.go = gohelper.cloneInPlace(slot0._gotipitem)
			slot12.goNotFinish = gohelper.findChild(slot12.go, "type1")
			slot12.goFinish = gohelper.findChild(slot12.go, "type2")
			slot12.animator = slot12.go:GetComponent(typeof(UnityEngine.Animator))
			slot12.status = nil

			table.insert(slot0.elementItemList, slot12)
		end

		gohelper.setActive(slot12.go, true)

		slot13 = slot0.pass and slot10 <= slot4

		gohelper.setActive(slot12.goNotFinish, not slot13)
		gohelper.setActive(slot12.goFinish, slot13)

		if slot12.status == false and slot13 then
			gohelper.setActive(slot12.goNotFinish, true)
			slot12.animator:Play("switch", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_light_up)
		end

		slot12.status = slot13
	end

	if #slot5 < #slot0.elementItemList then
		for slot12 = slot7 + 1, slot8 do
			if slot0.elementItemList[slot12] then
				slot13.status = nil

				slot13.animator:Play("idle", 0, 1)
				gohelper.setActive(slot13.go, false)
			end
		end
	end

	slot0._showAllElementTip = slot0.pass and slot4 ~= #slot5

	if slot0._showAllElementTip and not slot0._showAllElementTip then
		TaskDispatcher.cancelTask(slot0._hideAllElementTip, slot0)
		TaskDispatcher.runDelay(slot0._hideAllElementTip, slot0, uv0)
	else
		gohelper.setActive(slot0._gotipcontent, slot0._showAllElementTip)
	end
end

function slot0._hideAllElementTip(slot0)
	gohelper.setActive(slot0._gotipcontent, false)
end

function slot0._showEye(slot0)
	if not (slot0._config.displayMark == 1) then
		gohelper.setActive(slot0._gonormaleye, false)
		gohelper.setActive(slot0._gohardeye, false)

		return
	end

	slot2 = slot0._config.chapterId == VersionActivity1_8DungeonEnum.DungeonChapterId.Hard

	gohelper.setActive(slot0._gonormaleye, not slot2)
	gohelper.setActive(slot0._gohardeye, slot2)
end

function slot0.refreshLock(slot0)
	slot0.isLock = slot0:checkLock()

	gohelper.setActive(slot0._golock, slot0.isLock)
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

function slot0.calculatePosInContent(slot0)
	slot0._maxWidth = math.max(math.max(recthelper.getAnchorX(slot0._txtsectionname.transform) + slot0._txtsectionname.preferredWidth, recthelper.getAnchorX(slot0._txtnameen.transform) + slot0._txtsectionname.preferredWidth) * 2, VersionActivity1_3DungeonEnum.EpisodeItemMinWidth) + uv0

	recthelper.setWidth(slot0._goclickarea.transform, slot0._maxWidth)
	recthelper.setWidth(slot0._goraycast.transform, slot0._maxWidth + slot0._layout._constDungeonNormalDeltaX)

	slot0.scrollContentPosX = recthelper.rectToRelativeAnchorPos(slot0.viewGO.transform.position, slot0._contentTransform).x
end

function slot0.playAnimation(slot0, slot1)
	if slot0.prePlayAnimName == slot1 then
		return
	end

	slot0.prePlayAnimName = slot1

	slot0.animator:Play(slot1, 0, 0)
end

function slot0.getMaxWidth(slot0)
	return slot0._maxWidth
end

function slot0.clearElementIdList(slot0)
	slot0.elementIdList = nil
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._hideAllElementTip, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
