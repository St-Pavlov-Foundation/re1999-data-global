module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapChapterLayout", package.seeall)

slot0 = class("VersionActivity1_5DungeonMapChapterLayout", BaseChildView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._focusIndex = 0
	slot0.rectTransform = slot0.viewGO.transform
	slot1 = Vector2(0, 1)
	slot0.rectTransform.pivot = slot1
	slot0.rectTransform.anchorMin = slot1
	slot0.rectTransform.anchorMax = slot1
	slot0.defaultY = slot0.activityDungeonMo:getLayoutOffsetY()

	recthelper.setAnchorY(slot0.rectTransform, slot0.defaultY)

	slot0.contentTransform = slot0.viewParam.goChapterContent.transform
	slot0._rawWidth = recthelper.getWidth(slot0.rectTransform)
	slot0._rawHeight = recthelper.getHeight(slot0.rectTransform)

	recthelper.setSize(slot0.contentTransform, slot0._rawWidth, slot0._rawHeight)

	slot0._episodeItemDict = slot0:getUserDataTb_()
	slot0._episodeContainerItemList = slot0:getUserDataTb_()
	slot2 = "default"
	slot0._golevellist = gohelper.findChild(slot0.viewGO, string.format("%s/go_levellist", slot2))
	slot0._gotemplatenormal = gohelper.findChild(slot0.viewGO, string.format("%s/go_levellist/#go_templatenormal", slot2))
	slot0.chapterGo = gohelper.findChild(slot0.viewGO, slot2)

	gohelper.setActive(slot0.chapterGo, true)

	slot3 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	slot4 = 600
	slot0._offsetX = (slot3 - slot4) / 2 + slot4
	slot0._constDungeonNormalPosX = slot3 - slot0._offsetX
	slot0._constDungeonNormalPosY = CommonConfig.instance:getConstNum(ConstEnum.DungeonNormalPosY)
	slot0._constDungeonNormalDeltaX = 100
	slot0._timelineAnimation = gohelper.findChildComponent(slot0.viewGO, "timeline", typeof(UnityEngine.Animation))

	if ViewMgr.instance:isOpening(ViewName.VersionActivity1_5DungeonMapLevelView) then
		slot0._timelineAnimation:Play("timeline_mask")
	end

	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0.episodeItemPath = slot0.viewContainer:getSetting().otherRes[1]
end

function slot0.setSelectEpisodeId(slot0, slot1)
	slot0.selectedEpisodeItem = slot0._episodeItemDict[slot1]

	for slot5, slot6 in pairs(slot0._episodeItemDict) do
		slot6:updateSelectStatus(slot0.selectedEpisodeItem)
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

function slot0._onGamepadKeyUp(slot0, slot1)
	slot2 = ViewMgr.instance:getOpenViewNameList()

	if (slot2[#slot2] == ViewName.VersionActivity1_5DungeonMapView or slot3 == ViewName.VersionActivity1_5DungeonMapLevelView) and slot0._focusIndex and not DungeonMapModel.instance:getMapInteractiveItemVisible() and (slot1 == GamepadEnum.KeyCode.LB or slot1 == GamepadEnum.KeyCode.RB) and math.min(math.max(1, slot0._focusIndex + (slot1 == GamepadEnum.KeyCode.LB and -1 or 1)), #slot0._episodeContainerItemList) > 0 and slot5 <= #slot0._episodeContainerItemList then
		slot0._episodeContainerItemList[slot5].episodeItem:onClick(true)
	end
end

function slot0.refreshEpisodeNodes(slot0)
	slot0._episodeItemDict = slot0:getUserDataTb_()
	slot2 = 0
	slot3, slot4 = nil

	for slot8, slot9 in ipairs(DungeonConfig.instance:getChapterEpisodeCOList(slot0.activityDungeonMo.chapterId)) do
		if slot9 and DungeonModel.instance:getEpisodeInfo(slot9.id) or nil then
			slot4 = slot0:getEpisodeContainerItem(slot2 + 1)
			slot0._episodeItemDict[slot9.id] = slot4.episodeItem
			slot4.containerTr.name = slot9.id

			slot4.episodeItem:refresh(slot9, slot3)
		end
	end

	slot7 = recthelper.rectToRelativeAnchorPos(slot0._episodeContainerItemList[slot2].containerTr.position, slot0.rectTransform).x + slot0._offsetX
	slot11 = slot7

	recthelper.setSize(slot0.contentTransform, slot11, slot0._rawHeight)

	slot0._contentWidth = slot7

	for slot11 = slot2 + 1, #slot0._episodeContainerItemList do
		gohelper.setActive(slot0._episodeContainerItemList[slot11].containerTr.gameObject, false)
	end

	slot0:setFocusEpisodeId(slot0.activityDungeonMo.episodeId, false)
end

function slot0.setFocusItem(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if slot2 then
		ZProj.TweenHelper.DOAnchorPosX(slot0.contentTransform, -recthelper.rectToRelativeAnchorPos(slot1.transform.position, slot0.rectTransform).x + slot0._constDungeonNormalPosX, 0.26)
	else
		recthelper.setAnchorX(slot0.contentTransform, slot4)
	end
end

function slot0.setFocusEpisodeItem(slot0, slot1, slot2)
	if slot2 then
		DungeonMapModel.instance.focusEpisodeTweenDuration = nil

		ZProj.TweenHelper.DOAnchorPosX(slot0.contentTransform, -slot1.scrollContentPosX + slot0._constDungeonNormalPosX, DungeonMapModel.instance.focusEpisodeTweenDuration or 0.26)
	else
		recthelper.setAnchorX(slot0.contentTransform, slot3)
	end
end

function slot0.setFocusEpisodeId(slot0, slot1, slot2)
	if slot0._episodeItemDict[slot1] and slot3.viewGO then
		slot0:setFocusItem(slot3.viewGO, slot2)
	end

	if slot3 then
		slot0:_onChangeFocusEpisodeItem(slot3)
	end
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

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnActivityDungeonMoChange, slot0.onActivityDungeonMoChange, slot0)

	if GamepadController.instance:isOpen() then
		slot0:addEventCb(GamepadController.instance, GamepadEvent.KeyUp, slot0._onGamepadKeyUp, slot0)
		slot0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, slot0._onChangeFocusEpisodeItem, slot0)
	end
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.VersionActivity1_5DungeonMapLevelView then
		slot0._timelineAnimation:Play("timeline_mask")
		slot0:setSelectEpisodeItem(slot0._episodeItemDict[slot0.activityDungeonMo.episodeId])
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.VersionActivity1_5DungeonMapLevelView then
		slot0._timelineAnimation:Play("timeline_reset")
		slot0:setSelectEpisodeItem(nil)
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

function slot0.setSelectEpisodeItem(slot0, slot1)
	slot0.selectedEpisodeItem = slot1

	for slot5, slot6 in pairs(slot0._episodeItemDict) do
		slot6:updateSelectStatus(slot0.selectedEpisodeItem)
	end
end

function slot0.updateFocusStatus(slot0)
	for slot4, slot5 in pairs(slot0._episodeItemDict) do
		slot5:refreshFocusStatus()
	end
end

function slot0.isSelectedEpisodeRightEpisode(slot0, slot1)
	if not slot0.selectedEpisodeItem then
		return false
	end

	if DungeonConfig.instance:getChapterEpisodeIndexWithSP(slot0.selectedEpisodeItem._config.chapterId, slot0.selectedEpisodeItem._config.id) < DungeonConfig.instance:getChapterEpisodeIndexWithSP(slot1._config.chapterId, slot1._config.id) then
		return true
	end

	return false
end

function slot0.onActivityDungeonMoChange(slot0)
	slot0:updateFocusStatus()
	slot0:setFocusEpisodeId(slot0.activityDungeonMo.episodeId, true)
end

function slot0.onClose(slot0)
	for slot4, slot5 in pairs(slot0._episodeContainerItemList) do
		slot5.episodeItem:destroyView()
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
