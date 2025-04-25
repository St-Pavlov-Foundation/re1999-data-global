module("modules.logic.versionactivity2_5.dungeon.view.map.VersionActivity2_5DungeonMapChapterLayout", package.seeall)

slot0 = class("VersionActivity2_5DungeonMapChapterLayout", BaseChildView)
slot1 = "default"
slot2 = 600
slot3 = 100
slot4 = 0.26

function slot0.onInitView(slot0)
	slot0.rectTransform = slot0.viewGO.transform
	slot0.contentTransform = slot0.viewParam.goChapterContent.transform
	slot0._golevellist = gohelper.findChild(slot0.viewGO, string.format("%s/go_levellist", uv0))
	slot0._gotemplatenormal = gohelper.findChild(slot0.viewGO, string.format("%s/go_levellist/#go_templatenormal", uv0))
	slot0.chapterGo = gohelper.findChild(slot0.viewGO, uv0)

	gohelper.setActive(slot0.chapterGo, true)

	slot0._timelineAnimation = gohelper.findChildComponent(slot0.viewGO, "timeline", typeof(UnityEngine.Animation))
	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, slot0.onActivityDungeonMoChange, slot0)
	slot0:addEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.GuideShowElement, slot0._GuideShowElement, slot0)

	if GamepadController.instance:isOpen() then
		slot0:addEventCb(GamepadController.instance, GamepadEvent.KeyUp, slot0._onGamepadKeyUp, slot0)
		slot0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, slot0._onChangeFocusEpisodeItem, slot0)
	end
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:removeEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, slot0.onActivityDungeonMoChange, slot0)
	slot0:removeEventCb(GamepadController.instance, GamepadEvent.KeyUp, slot0._onGamepadKeyUp, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, slot0._onChangeFocusEpisodeItem, slot0)
	slot0:removeEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.GuideShowElement, slot0._GuideShowElement, slot0)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.VersionActivity2_5DungeonMapLevelView then
		slot0._timelineAnimation:Play("timeline_mask")
		slot0:setSelectEpisodeItem(slot0._episodeItemDict[slot0.activityDungeonMo.episodeId])
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.VersionActivity2_5DungeonMapLevelView then
		slot0._timelineAnimation:Play("timeline_reset")
		slot0:setSelectEpisodeItem(nil)
	end
end

function slot0.onActivityDungeonMoChange(slot0)
	slot0:updateFocusStatus()
	slot0:setFocusEpisodeId(slot0.activityDungeonMo.episodeId, true)
end

function slot0.updateFocusStatus(slot0)
	for slot4, slot5 in pairs(slot0._episodeItemDict) do
		slot5:refreshFocusStatus()
	end
end

function slot0._onGamepadKeyUp(slot0, slot1)
	slot2 = ViewMgr.instance:getOpenViewNameList()

	if slot2[#slot2] ~= ViewName.VersionActivity2_5DungeonMapView and slot3 ~= ViewName.VersionActivity2_5DungeonMapLevelView then
		return
	end

	if slot0._focusIndex and not DungeonMapModel.instance:getMapInteractiveItemVisible() and (slot1 == GamepadEnum.KeyCode.LB or slot1 == GamepadEnum.KeyCode.RB) and math.min(math.max(1, slot0._focusIndex + (slot4 and -1 or 1)), #slot0._episodeContainerItemList) > 0 and slot8 <= #slot0._episodeContainerItemList then
		slot0._episodeContainerItemList[slot8].episodeItem:onClick(true)
	end
end

function slot0._onChangeFocusEpisodeItem(slot0, slot1)
	if GamepadController.instance:isOpen() then
		for slot5, slot6 in ipairs(slot0._episodeContainerItemList) do
			if slot6.episodeItem == slot1 then
				slot0._focusIndex = slot5
			end
		end
	end
end

function slot0._editableInitView(slot0)
	slot0._focusIndex = 0
	slot0._episodeItemDict = slot0:getUserDataTb_()
	slot0._episodeContainerItemList = slot0:getUserDataTb_()
	slot0.episodeItemPath = slot0.viewContainer:getSetting().otherRes[1]
	slot1 = Vector2(0, 1)
	slot0.rectTransform.pivot = slot1
	slot0.rectTransform.anchorMin = slot1
	slot0.rectTransform.anchorMax = slot1
	slot0.defaultY = slot0.activityDungeonMo:getLayoutOffsetY()

	recthelper.setAnchorY(slot0.rectTransform, slot0.defaultY)

	slot0._rawWidth = recthelper.getWidth(slot0.rectTransform)
	slot0._rawHeight = recthelper.getHeight(slot0.rectTransform)

	recthelper.setSize(slot0.contentTransform, slot0._rawWidth, slot0._rawHeight)

	slot3 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	slot0._offsetX = (slot3 - uv0) / 2 + uv0
	slot0._constDungeonNormalPosX = slot3 - slot0._offsetX
	slot0._constDungeonNormalPosY = CommonConfig.instance:getConstNum(ConstEnum.DungeonNormalPosY)
	slot0._constDungeonNormalDeltaX = uv1

	if ViewMgr.instance:isOpening(ViewName.VersionActivity2_5DungeonMapLevelView) then
		slot0._timelineAnimation:Play("timeline_mask")
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.refreshEpisodeNodes(slot0)
	slot0._episodeItemDict = slot0:getUserDataTb_()
	slot1 = 0
	slot2, slot3 = nil

	for slot8, slot9 in ipairs(DungeonConfig.instance:getChapterEpisodeCOList(slot0.activityDungeonMo.chapterId)) do
		if slot9 and DungeonModel.instance:getEpisodeInfo(slot9.id) or nil then
			slot3 = slot0:getEpisodeContainerItem(slot1 + 1)
			slot0._episodeItemDict[slot9.id] = slot3.episodeItem
			slot3.containerTr.name = slot9.id

			slot3.episodeItem:refresh(slot9, slot2)
		end
	end

	slot7 = recthelper.rectToRelativeAnchorPos(slot0._episodeContainerItemList[slot1].containerTr.position, slot0.rectTransform).x + slot0._offsetX
	slot11 = slot0._rawHeight

	recthelper.setSize(slot0.contentTransform, slot7, slot11)

	slot0._contentWidth = slot7

	for slot11 = slot1 + 1, #slot0._episodeContainerItemList do
		gohelper.setActive(slot0._episodeContainerItemList[slot11].containerTr.gameObject, false)
	end

	slot0:setFocusEpisodeId(slot0.activityDungeonMo.episodeId, false)
end

function slot0.getEpisodeContainerItem(slot0, slot1)
	if slot0._episodeContainerItemList[slot1] then
		gohelper.setActive(slot2.containerTr.gameObject, true)
		slot2.episodeItem:clearElementIdList()

		return slot2
	end

	slot3 = gohelper.cloneInPlace(slot0._gotemplatenormal, tostring(slot1))

	gohelper.setActive(slot3, true)

	slot0:getUserDataTb_().containerTr = slot3.transform

	if slot1 > 1 then
		recthelper.setAnchorX(slot2.containerTr, (recthelper.getAnchorX(slot0._episodeContainerItemList[slot1 - 1].containerTr) or 0) + slot4.episodeItem:getMaxWidth() + slot0._constDungeonNormalDeltaX)
	else
		recthelper.setAnchorX(slot2.containerTr, slot0._constDungeonNormalPosX)
	end

	recthelper.setAnchorY(slot2.containerTr, slot0._constDungeonNormalPosY)

	slot5 = slot0.activityDungeonMo:getEpisodeItemClass().New()
	slot5.viewContainer = slot0.viewContainer
	slot5.activityDungeonMo = slot0.activityDungeonMo

	slot5:initView(slot0.viewContainer:getResInst(slot0.episodeItemPath, slot3), {
		slot0.contentTransform,
		slot0
	})

	slot2.episodeItem = slot5

	table.insert(slot0._episodeContainerItemList, slot2)

	return slot2
end

function slot0.setFocusEpisodeId(slot0, slot1, slot2)
	if slot0._episodeItemDict[slot1] and slot3.viewGO then
		slot0:setFocusItem(slot3.viewGO, slot2)
	end

	if slot3 then
		slot0:_onChangeFocusEpisodeItem(slot3)
	end
end

function slot0.setFocusItem(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if slot2 then
		ZProj.TweenHelper.DOAnchorPosX(slot0.contentTransform, -recthelper.rectToRelativeAnchorPos(slot1.transform.position, slot0.rectTransform).x + slot0._constDungeonNormalPosX, uv0)
	else
		recthelper.setAnchorX(slot0.contentTransform, slot4)
	end
end

function slot0.setFocusEpisodeItem(slot0, slot1, slot2)
	if slot2 then
		DungeonMapModel.instance.focusEpisodeTweenDuration = nil

		ZProj.TweenHelper.DOAnchorPosX(slot0.contentTransform, -slot1.scrollContentPosX + slot0._constDungeonNormalPosX, DungeonMapModel.instance.focusEpisodeTweenDuration or uv0)
	else
		recthelper.setAnchorX(slot0.contentTransform, slot3)
	end
end

function slot0.setSelectEpisodeItem(slot0, slot1)
	slot0.selectedEpisodeItem = slot1

	for slot5, slot6 in pairs(slot0._episodeItemDict) do
		slot6:updateSelectStatus(slot0.selectedEpisodeItem)
	end
end

function slot0.playAnimation(slot0, slot1)
	slot0.animator:Play(slot1, 0, 0)
end

function slot0.playEpisodeItemAnimation(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._episodeContainerItemList) do
		slot6.episodeItem:playAnimation(slot1)
	end
end

function slot0.setSelectEpisodeId(slot0, slot1, slot2)
	slot0.selectedEpisodeItem = slot0._episodeItemDict[slot1]

	for slot6, slot7 in pairs(slot0._episodeItemDict) do
		slot7:updateSelectStatus(slot0.selectedEpisodeItem, slot2)
	end
end

function slot0.isSelectedEpisodeRightEpisode(slot0, slot1)
	if not slot0.selectedEpisodeItem then
		return false
	end

	slot4 = slot0.selectedEpisodeItem._config

	if not slot1._config then
		return slot2
	end

	if DungeonConfig.instance:getChapterEpisodeIndexWithSP(slot4.chapterId, slot4.id) < DungeonConfig.instance:getChapterEpisodeIndexWithSP(slot3.chapterId, slot3.id) then
		slot2 = true
	end

	return slot2
end

function slot0._GuideShowElement(slot0, slot1)
	if DungeonConfig.instance:getChapterMapElement(tonumber(slot1)) then
		if slot0.selectedEpisodeItem ~= slot0._episodeItemDict[slot3.mapId] then
			slot0.activityDungeonMo:changeEpisode(slot4)
			slot0:setSelectEpisodeItem(slot5)
		end

		VersionActivity2_5DungeonController.instance:dispatchEvent(VersionActivity2_5DungeonEvent.FocusElement, slot2)
	end
end

function slot0.onClose(slot0)
	for slot4, slot5 in pairs(slot0._episodeContainerItemList) do
		slot5.episodeItem:destroyView()
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
