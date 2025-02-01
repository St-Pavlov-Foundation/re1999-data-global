module("modules.logic.dungeon.view.map.DungeonMapChapterLayout", package.seeall)

slot0 = class("DungeonMapChapterLayout", BaseChildView)

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
	slot1 = slot0.viewGO.transform
	slot2 = Vector2(0, 1)
	slot1.pivot = slot2
	slot1.anchorMin = slot2
	slot1.anchorMax = slot2
	slot0.defaultY = 100

	recthelper.setAnchorY(slot1, slot0.defaultY)

	slot0._ContentTransform = slot0.viewParam[1].transform
	slot0._rawWidth = recthelper.getWidth(slot1)
	slot0._rawHeight = recthelper.getHeight(slot1)

	recthelper.setSize(slot0._ContentTransform, slot0._rawWidth, slot0._rawHeight)

	slot0._episodeItemList = slot0:getUserDataTb_()
	slot3 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	slot4 = 600
	slot0._offsetX = (slot3 - slot4) / 2 + slot4
	slot0._constDungeonNormalPosX = slot3 - slot0._offsetX
	slot0._constDungeonNormalPosY = CommonConfig.instance:getConstNum(ConstEnum.DungeonNormalPosY)
	slot0._constDungeonNormalDeltaX = CommonConfig.instance:getConstNum(ConstEnum.DungeonNormalDeltaX) - 220
	slot0._constDungeonSPDeltaX = CommonConfig.instance:getConstNum(ConstEnum.DungeonSPDeltaX)
	slot0._timelineAnimation = gohelper.findChildComponent(slot0.viewGO, "timeline", typeof(UnityEngine.Animation))

	if ViewMgr.instance:isOpening(ViewName.DungeonMapLevelView) then
		slot0._timelineAnimation:Play("timeline_mask")
	end

	if slot0.viewGO:GetComponent(typeof(UnityEngine.Animator)) then
		slot5:Play(UIAnimationName.Open)
	end
end

function slot0.CheckVision(slot0)
	slot1, slot2, slot3, slot4 = nil

	for slot9, slot10 in ipairs(slot0._episodeItemList) do
		if slot10.scrollVisiblePosX < recthelper.getAnchorX(slot0._ContentTransform) then
			break
		end

		if slot10.unfinishedMap then
			slot4 = slot10
		end

		if slot10.starNum2 == false then
			slot1 = slot1 or slot10
		end

		if slot10.starNum3 == false then
			slot2 = slot2 or slot10
		end

		if slot10.starNum4 == false then
			slot3 = slot3 or slot10
		end
	end

	if not slot0._tempParam then
		slot0._tempParam = {}
	end

	slot0._tempParam[1] = slot1 or slot2 or slot3
	slot0._tempParam[2] = slot4

	DungeonController.instance:dispatchEvent(DungeonEvent.OnCheckVision, slot0._tempParam)
end

function slot0.isSpecial(slot0, slot1)
	return slot1.id == 10217
end

function slot0.getFocusMap(slot0, slot1)
	slot2, slot3, slot4, slot5 = nil
	slot6 = false

	for slot11, slot12 in ipairs(DungeonConfig.instance:getChapterEpisodeCOList(slot0)) do
		if DungeonModel.instance:getEpisodeInfo(slot12.id) then
			slot14 = DungeonModel.instance:isFinishElementList(slot12)

			if slot12.id == DungeonModel.instance.lastSendEpisodeId then
				slot2 = slot12
			end

			if slot14 then
				slot5 = slot12
			end

			if slot13.isNew and not slot3 then
				if slot2 and slot14 and not slot6 then
					slot2 = slot12
				end
			end

			if slot1 and slot12.id == slot1 then
				slot6 = true
				slot2 = slot12
			end

			if not slot4 and not DungeonModel.instance:hasPassLevelAndStory(slot12.id) and slot14 then
				slot4 = slot12
			end
		end
	end

	return DungeonMapEpisodeItem.getMap(slot2 or slot4 or slot5)
end

function slot0.onRefresh(slot0, slot1)
	slot2 = slot0.viewGO.transform
	slot0._ContentTransform = slot0.viewParam[1].transform
	slot0._ScrollView = slot0.viewParam[2]
	slot0._scrollTrans = slot0.viewParam[3].transform
	slot0._dungeonChapterView = slot0.viewParam[4]
	slot0._chapter = slot0.viewParam[5]
	slot3 = "default"

	gohelper.setActive(gohelper.findChild(slot0.viewGO, string.format("%s", slot3)).gameObject, true)

	slot0._golevellist = gohelper.findChild(slot0.viewGO, string.format("%s/go_levellist", slot3))
	slot0._gotemplatenormal = gohelper.findChild(slot0.viewGO, string.format("%s/go_levellist/#go_templatenormal", slot3))
	slot0._gotemplatesp = gohelper.findChild(slot0.viewGO, string.format("%s/go_levellist/#go_templatesp", slot3))
	slot5 = DungeonConfig.instance:getChapterEpisodeCOList(DungeonModel.instance.curLookChapterId)
	slot0._levelItemList = slot0._levelItemList or slot0:getUserDataTb_()
	slot6, slot7, slot8, slot9, slot10, slot11, slot12, slot13 = nil
	slot14 = false
	slot15, slot16 = DungeonConfig.instance:getChapterIndex(DungeonModel.instance.curChapterType, DungeonModel.instance.curLookChapterId)

	slot0:_initLevelList()

	slot17 = 0
	slot18 = 0
	slot19 = nil
	slot0._episodeOpenCount = 0
	slot0._episodeCount = slot5 and #slot5 or 0

	gohelper.setActive(slot0._scrollTrans, slot0._episodeCount ~= 0)

	if slot0._episodeCount == 0 then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeMap, {
			DungeonConfig.instance:getChapterMapCfg(DungeonModel.instance.curLookChapterId, 0)
		})
	end

	if slot5 then
		for slot23, slot24 in ipairs(slot5) do
			slot25 = slot24.type == DungeonEnum.EpisodeType.Sp
			slot26 = slot24 and DungeonModel.instance:getEpisodeInfo(slot24.id) or nil
			slot27 = slot0:_isSpShow(slot24, slot5[slot23 + 1])
			slot28 = slot26 and not slot25 and slot0:_getLevelContainer(slot24)

			if slot26 and slot28 then
				if not slot25 then
					slot0._episodeOpenCount = slot25 and slot17 + 1 or slot18 + 1
				end

				slot29 = nil
				slot28.name = slot24.id
				slot30 = DungeonModel.instance:isFinishElementList(slot24)

				if not slot0._levelItemList[slot24.id] then
					slot31 = DungeonMapEpisodeItem.New()

					slot31:initView((slot28.childCount ~= 0 or slot0._dungeonChapterView:getResInst(slot0._dungeonChapterView.viewContainer:getSetting().otherRes[1], slot28.gameObject)) and slot28:GetChild(0).gameObject, {
						slot24,
						slot26,
						slot0._ContentTransform,
						slot19
					})
					table.insert(slot0._episodeItemList, slot31)

					slot0._levelItemList[slot24.id] = slot31
				else
					slot31:updateParam(slot32)
				end

				if slot24.id == DungeonModel.instance.lastSendEpisodeId then
					DungeonModel.instance.lastSendEpisodeId = nil
					slot10 = slot29
				end

				if not slot12 or recthelper.getAnchorX(slot12) <= recthelper.getAnchorX(slot28) then
					slot12 = slot28
					slot11 = slot29
				end

				if not slot25 and not slot31:isLock() and slot30 then
					slot13 = slot29
				end

				if slot26.isNew then
					slot26.isNew = false

					if not slot7 then
						if not slot25 and slot10 and slot30 and not slot14 then
							slot10 = slot29

							slot31:showUnlockAnim()
						end
					end
				end

				if slot1 and slot24.id == slot1 then
					slot14 = true
					slot10 = slot29
				end

				if not slot25 and not slot6 and not slot31:isLock() and not DungeonModel.instance:hasPassLevelAndStory(slot24.chainEpisode ~= 0 and slot24.chainEpisode or slot24.id) and slot30 then
					slot6 = slot29
				end

				slot34 = DungeonConfig.instance:getHardEpisode(slot24.id)

				if DungeonModel.instance:isOpenHardDungeon(slot24.chapterId) and not slot25 and not slot9 and slot34 and not DungeonModel.instance:hasPassLevelAndStory(slot34.id) then
					-- Nothing
				end

				if not slot25 and not slot8 and slot34 and slot26.star == DungeonEnum.StarType.Normal then
					-- Nothing
				end
			elseif slot26 and not slot28 then
				-- Nothing
			end
		end
	end

	slot10 = slot10 or slot6 or slot13 or slot0._episodeItemList[1] and slot0._episodeItemList[1].viewGO

	if slot11 then
		slot21 = recthelper.rectToRelativeAnchorPos(slot11.transform.position, slot2).x + slot0._offsetX

		recthelper.setSize(slot0._ContentTransform, slot21, slot0._rawHeight)

		slot0._contentWidth = slot21
	end

	slot0:setFocusItem(slot10, false)
end

function slot0.setFocusItem(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot5 = recthelper.getWidth(slot0._scrollTrans)
	slot6 = recthelper.getHeight(slot0._scrollTrans)

	if slot2 then
		ZProj.TweenHelper.DOAnchorPosX(slot0._ContentTransform, -recthelper.rectToRelativeAnchorPos(slot1.transform.position, slot0.viewGO.transform).x + slot0._constDungeonNormalPosX, 0.26)
	else
		recthelper.setAnchorX(slot0._ContentTransform, slot7)
	end

	slot0:CheckVision()

	for slot11, slot12 in ipairs(slot0._episodeItemList) do
		if slot12.viewGO == slot1 then
			DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeFocusEpisodeItem, slot12)

			break
		end
	end
end

function slot0.setFocusEpisodeItem(slot0, slot1, slot2)
	if slot2 then
		DungeonMapModel.instance.focusEpisodeTweenDuration = nil

		ZProj.TweenHelper.DOAnchorPosX(slot0._ContentTransform, -slot1.scrollContentPosX + slot0._constDungeonNormalPosX, DungeonMapModel.instance.focusEpisodeTweenDuration or 0.26)
	else
		recthelper.setAnchorX(slot0._ContentTransform, slot3)
	end

	slot0:CheckVision()
end

function slot0.setFocusEpisodeId(slot0, slot1, slot2)
	if slot0._levelItemList[slot1] and slot3.viewGO then
		slot0:setFocusItem(slot3.viewGO, slot2)
	end
end

function slot0.changeFocusEpisodeItem(slot0, slot1)
	if not slot0._levelItemList[slot1] then
		return
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeFocusEpisodeItem, slot2)
end

function slot0._initLevelList(slot0)
	slot2 = slot0._golevellist.transform.childCount

	if not slot0._itemTransformList then
		slot0._itemTransformList = slot0:getUserDataTb_()
		slot0._rawGoList = slot0:getUserDataTb_()
	end
end

function slot0._isSpShow(slot0, slot1, slot2)
	if slot1.type == DungeonEnum.EpisodeType.Sp and slot2 and slot2.preEpisode == slot1.id and slot2.type ~= DungeonEnum.EpisodeType.Sp then
		slot3 = false
	end

	return slot3
end

function slot0.getEpisodeCount(slot0)
	return slot0._episodeCount
end

function slot0._getLevelContainer(slot0, slot1)
	if slot0._itemTransformList[slot1.id] then
		return slot3
	end

	if not slot3 and #slot0._rawGoList > 0 then
		slot3 = table.remove(slot0._rawGoList, 1)
	end

	if not slot3 then
		slot7 = gohelper.cloneInPlace(slot0._gotemplatenormal, slot2)

		gohelper.setActive(slot7, true)

		if slot0._itemTransformList[slot1.preEpisode] and recthelper.getAnchorX(slot5) then
			recthelper.setAnchorX(slot7.transform, slot6 + slot0._levelItemList[slot4]:getMaxWidth() + slot0._constDungeonNormalDeltaX)
		else
			recthelper.setAnchorX(slot3, slot0._constDungeonNormalPosX)
		end

		recthelper.setAnchorY(slot3, slot0._constDungeonNormalPosY)
	end

	slot0._itemTransformList[slot2] = slot3

	return slot3
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)

	if GamepadController.instance:isOpen() then
		slot0:addEventCb(GamepadController.instance, GamepadEvent.KeyUp, slot0._onGamepadKeyUp, slot0)
	end

	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, slot0._onChangeFocusEpisodeItem, slot0)
end

function slot0._onChangeFocusEpisodeItem(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._episodeItemList) do
		if slot6 == slot1 then
			slot0._focusIndex = slot5
		end
	end
end

function slot0._onGamepadKeyUp(slot0, slot1)
	slot2 = ViewMgr.instance:getOpenViewNameList()

	if (slot2[#slot2] == ViewName.DungeonMapView or slot3 == ViewName.DungeonMapLevelView) and slot0._focusIndex and not DungeonMapModel.instance:getMapInteractiveItemVisible() and (slot1 == GamepadEnum.KeyCode.LB or slot1 == GamepadEnum.KeyCode.RB) and slot0._focusIndex + (slot1 == GamepadEnum.KeyCode.LB and -1 or 1) > 0 and slot5 <= #slot0._episodeItemList then
		slot0._episodeItemList[slot5]:onClickHandler()
	end
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.DungeonMapLevelView then
		slot0._timelineAnimation:Play("timeline_mask")
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.DungeonMapLevelView then
		slot0._timelineAnimation:Play("timeline_reset")
	end
end

function slot0.onClose(slot0)
	for slot4, slot5 in pairs(slot0._levelItemList) do
		slot5:destroyView()
	end
end

function slot0.onDestroyView(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)
	end
end

return slot0
