module("modules.logic.versionactivity1_2.versionactivity1_2dungeonbase.view.VersionActivity1_2DungeonMapChapterBaseLayout", package.seeall)

slot0 = class("VersionActivity1_2DungeonMapChapterBaseLayout", BaseChildView)

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
	slot0.rectTransform = slot0.viewGO.transform
	slot1 = Vector2(0, 1)
	slot0.rectTransform.pivot = slot1
	slot0.rectTransform.anchorMin = slot1
	slot0.rectTransform.anchorMax = slot1
	slot0.defaultY = 100

	recthelper.setAnchorY(slot0.rectTransform, slot0.defaultY)

	slot0._ContentTransform = slot0.viewParam[1].transform
	slot0._rawWidth = recthelper.getWidth(slot0.rectTransform)
	slot0._rawHeight = recthelper.getHeight(slot0.rectTransform)

	recthelper.setSize(slot0._ContentTransform, slot0._rawWidth, slot0._rawHeight)

	slot0._episodeItemDict = slot0:getUserDataTb_()
	slot0._episodeContainerItemList = slot0:getUserDataTb_()
	slot2 = "default"
	slot0._golevellist = gohelper.findChild(slot0.viewGO, string.format("%s/go_levellist", slot2))
	slot0._gotemplatenormal = gohelper.findChild(slot0.viewGO, string.format("%s/go_levellist/#go_templatenormal", slot2))
	slot0._gotemplatesp = gohelper.findChild(slot0.viewGO, string.format("%s/go_levellist/#go_templatesp", slot2))
	slot0.chapterGo = gohelper.findChild(slot0.viewGO, slot2)

	gohelper.setActive(slot0.chapterGo, true)

	slot3 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	slot4 = 600
	slot0._offsetX = (slot3 - slot4) / 2 + slot4
	slot0._constDungeonNormalPosX = slot3 - slot0._offsetX
	slot0._constDungeonNormalPosY = CommonConfig.instance:getConstNum(ConstEnum.DungeonNormalPosY)
	slot0._constDungeonNormalDeltaX = 100
	slot0._timelineAnimation = gohelper.findChildComponent(slot0.viewGO, "timeline", typeof(UnityEngine.Animation))

	if ViewMgr.instance:isOpening(ViewName.DungeonMapLevelView) then
		slot0._timelineAnimation:Play("timeline_mask")
	end

	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0.episodeItemPath = slot0.viewContainer:getSetting().otherRes[1]
end

function slot0.onRefresh(slot0, slot1, slot2)
	slot0._chapterId = slot1
	slot0._episodeItemDict = slot0:getUserDataTb_()
	slot3 = tabletool.copy(DungeonConfig.instance:getChapterEpisodeCOList(slot0._chapterId))

	table.insert(slot3, 1, slot3[1])

	slot5, slot6 = nil

	for slot10, slot11 in ipairs(slot3) do
		if slot11 and DungeonModel.instance:getEpisodeInfo(slot11.id) or nil then
			slot4 = 0 + 1
			slot6 = slot0:getEpisodeContainerItem(slot4)
			slot0._episodeItemDict[slot11.id] = slot6.episodeItem
			slot6.containerTr.name = slot11.id

			slot6.episodeItem:refresh(slot11, slot5, slot4)
		end
	end

	slot9 = recthelper.rectToRelativeAnchorPos(slot0._episodeContainerItemList[slot4].containerTr.position, slot0.rectTransform).x + slot0._offsetX
	slot13 = slot9

	recthelper.setSize(slot0._ContentTransform, slot13, slot0._rawHeight)

	slot0._contentWidth = slot9

	for slot13 = slot4 + 1, #slot0._episodeContainerItemList do
		gohelper.setActive(slot0._episodeContainerItemList[slot13].containerTr.gameObject, false)
	end

	slot0:setFocusEpisodeId(slot2 or slot7.episodeItem:getEpisodeId(), false)
end

function slot0.setFocusItem(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if slot2 then
		ZProj.TweenHelper.DOAnchorPosX(slot0._ContentTransform, -recthelper.rectToRelativeAnchorPos(slot1.transform.position, slot0.rectTransform).x + slot0._constDungeonNormalPosX, 0.26)
	else
		recthelper.setAnchorX(slot0._ContentTransform, slot4)
	end
end

function slot0.setFocusEpisodeItem(slot0, slot1, slot2)
	if slot2 then
		DungeonMapModel.instance.focusEpisodeTweenDuration = nil

		ZProj.TweenHelper.DOAnchorPosX(slot0._ContentTransform, -slot1.scrollContentPosX + slot0._constDungeonNormalPosX, DungeonMapModel.instance.focusEpisodeTweenDuration or 0.26)
	else
		recthelper.setAnchorX(slot0._ContentTransform, slot3)
	end

	slot0._cueSelectIndex = slot1._index

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.selectEpisodeItem, slot0._episodeContainerItemList[slot0._cueSelectIndex].episodeItem._config)
end

function slot0.setFocusEpisodeId(slot0, slot1, slot2)
	if slot0._episodeItemDict[slot1] and slot3.viewGO then
		slot0._cueSelectIndex = slot3._index

		slot0:setFocusItem(slot3.viewGO, slot2)
		VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.focusEpisodeItem, slot1)
		VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.selectEpisodeItem, slot0._episodeContainerItemList[slot0._cueSelectIndex].episodeItem._config)
	end
end

function slot0.getEpisodeContainerItem(slot0, slot1)
	if slot0._episodeContainerItemList[slot1] then
		gohelper.setActive(slot2.containerTr.gameObject, true)

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

	slot5 = slot0:getEpisodeItemClass()
	slot5.viewContainer = slot0.viewContainer

	slot5:initView(slot0.viewContainer:getResInst(slot0.episodeItemPath, slot3), {
		slot0._ContentTransform,
		slot0
	})

	slot2.episodeItem = slot5

	table.insert(slot0._episodeContainerItemList, slot2)

	return slot2
end

function slot0.getEpisodeItemClass(slot0)
	return VersionActivity1_2MapEpisodeBaseItem.New()
end

function slot0.updateEpisodeItemsSelectedStatus(slot0)
	slot1 = slot0._episodeItemDict[VersionActivity1_2DungeonController.instance:getDungeonSelectedEpisodeId()]

	if slot0._episodeItemDict then
		for slot5, slot6 in pairs(slot0._episodeItemDict) do
			slot6:updateSelectStatus(slot1)
		end
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._ContentTransform = slot0.viewParam[1].transform

	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)

	if GamepadController.instance:isOpen() then
		slot0:addEventCb(GamepadController.instance, GamepadEvent.KeyUp, slot0._onGamepadKeyUp, slot0)
	end
end

function slot0._onGamepadKeyUp(slot0, slot1)
	slot2 = ViewMgr.instance:getOpenViewNameList()

	if (slot2[#slot2] == ViewName.VersionActivity1_2DungeonView or slot3 == ViewName.VersionActivity1_2DungeonMapLevelView) and not DungeonMapModel.instance:getMapInteractiveItemVisible() and (slot1 == GamepadEnum.KeyCode.LB or slot1 == GamepadEnum.KeyCode.RB) and slot0._cueSelectIndex + (slot1 == GamepadEnum.KeyCode.LB and -1 or 1) > 1 and slot5 <= #slot0._episodeContainerItemList then
		slot0._episodeContainerItemList[slot5].episodeItem:onClick()
	end
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == slot0:getDungeonMapLevelView() then
		slot0._timelineAnimation:Play("timeline_mask")
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == slot0:getDungeonMapLevelView() then
		slot0._timelineAnimation:Play("timeline_reset")
		slot0:setSelectEpisodeItem(nil)
	end
end

function slot0.getDungeonMapLevelView(slot0)
	return ViewName.VersionActivityDungeonMapLevelView
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

	for slot5, slot6 in ipairs(slot0._episodeContainerItemList) do
		slot6.episodeItem:updateSelectStatus(slot0.selectedEpisodeItem)
	end
end

function slot0.isSelectedEpisodeRightEpisode(slot0, slot1)
	if slot0.selectedEpisodeItem and slot0.selectedEpisodeItem._index < slot1._index then
		return true
	end

	return false
end

function slot0.onClose(slot0)
	for slot4, slot5 in ipairs(slot0._episodeContainerItemList) do
		slot5.episodeItem:destroyView()
	end
end

function slot0.onDestroyView(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)
	end
end

return slot0
