module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapHeroIconView", package.seeall)

slot0 = class("VersionActivity1_5DungeonMapHeroIconView", BaseView)

function slot0.onInitView(slot0)
	slot0._gomapdirection = gohelper.findChild(slot0.viewGO, "#go_mapdirection")
	slot0._goherorightitem = gohelper.findChild(slot0.viewGO, "#go_mapdirection/#go_rightitem")
	slot0._goheroleftitem = gohelper.findChild(slot0.viewGO, "#go_mapdirection/#go_leftitem")
	slot0._goherotopitem = gohelper.findChild(slot0.viewGO, "#go_mapdirection/#go_topitem")
	slot0._goherobottomitem = gohelper.findChild(slot0.viewGO, "#go_mapdirection/#go_bottomitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.heroItemDict = {}
	slot0.dirToFocusElementDict = {
		[VersionActivity1_5DungeonEnum.MapDir.Right] = {},
		[VersionActivity1_5DungeonEnum.MapDir.Left] = {},
		[VersionActivity1_5DungeonEnum.MapDir.Top] = {},
		[VersionActivity1_5DungeonEnum.MapDir.Bottom] = {}
	}
	slot0.focusElementDataPool = {}

	slot0:createHeroItem(slot0._goherorightitem, VersionActivity1_5DungeonEnum.MapDir.Right)
	slot0:createHeroItem(slot0._goheroleftitem, VersionActivity1_5DungeonEnum.MapDir.Left)
	slot0:createHeroItem(slot0._goherotopitem, VersionActivity1_5DungeonEnum.MapDir.Top)
	slot0:createHeroItem(slot0._goherobottomitem, VersionActivity1_5DungeonEnum.MapDir.Bottom)

	slot0.taskMoList = {}

	for slot4, slot5 in ipairs(VersionActivity1_5RevivalTaskModel.instance:getTaskMoList() or {}) do
		if not slot5:isExploreTask() then
			table.insert(slot0.taskMoList, slot5)
		end
	end

	slot0.mapSceneElementsView = slot0.viewContainer.mapSceneElements
	slot0.mainCamera = CameraMgr.instance:getMainCamera()
	slot0._tempVector = Vector3()
	slot0.loadedElements = false
	slot0.canShowHeroIcon = true

	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnHideInteractUI, slot0.onHideInteractUI, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnClickElement, slot0.onClickElement, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnMapPosChanged, slot0.onMapPosChanged, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnRemoveElement, slot0.onRemoveElement, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnInitElements, slot0.onInitElements, slot0, LuaEventSystem.Low)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, slot0.onDisposeOldMap, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, slot0.onDisposeScene, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseView, slot0)
end

function slot0.onClickElement(slot0)
	slot0:hideMapDir()
end

function slot0.onHideInteractUI(slot0)
	slot0:showMapDir()
end

function slot0.onOpenView(slot0, slot1)
	if slot1 == ViewName.VersionActivity1_5DungeonMapLevelView then
		slot0:hideMapDir()
	end
end

function slot0.onCloseView(slot0, slot1)
	if slot1 == ViewName.VersionActivity1_5DungeonMapLevelView then
		slot0:showMapDir()
	end
end

function slot0.onDisposeOldMap(slot0)
	slot0.loadedElements = false

	slot0:hideMapHeroIcon()
end

function slot0.onDisposeScene(slot0)
	slot0.loadedElements = false

	slot0:hideMapHeroIcon()
end

function slot0.hideMapDir(slot0)
	slot0.canShowHeroIcon = false

	gohelper.setActive(slot0._gomapdirection, slot0.canShowHeroIcon)
end

function slot0.showMapDir(slot0)
	slot0.canShowHeroIcon = true

	gohelper.setActive(slot0._gomapdirection, slot0.canShowHeroIcon)
	slot0:refreshHeroIcon()
end

function slot0.hideMapHeroIcon(slot0)
	for slot4, slot5 in pairs(slot0.heroItemDict) do
		gohelper.setActive(slot5.go, false)
	end
end

function slot0.onInitElements(slot0)
	if slot0.activityDungeonMo:isHardMode() then
		slot0:hideMapHeroIcon()

		return
	end

	slot0.loadedElements = true

	slot0:refreshHeroIcon()
end

function slot0.createHeroItem(slot0, slot1, slot2)
	slot3 = slot0:getUserDataTb_()
	slot3.go = slot1

	gohelper.setActive(slot3.go, false)

	slot3.goHeroIcon1 = gohelper.findChild(slot3.go, "heroicon_container/heroicon1")
	slot3.goHeroIcon2 = gohelper.findChild(slot3.go, "heroicon_container/heroicon2")
	slot3.heroHeadImage1 = gohelper.findChildSingleImage(slot3.go, "heroicon_container/heroicon1/#simage_herohead")
	slot3.heroHeadImage2 = gohelper.findChildSingleImage(slot3.go, "heroicon_container/heroicon2/#simage_herohead")
	slot3.click1 = gohelper.getClickWithDefaultAudio(slot3.heroHeadImage1.gameObject)
	slot3.click2 = gohelper.getClickWithDefaultAudio(slot3.heroHeadImage2.gameObject)

	slot3.click1:AddClickListener(slot0.onClickHeroHeadIcon, slot0, {
		index = 1,
		dir = slot2
	})
	slot3.click2:AddClickListener(slot0.onClickHeroHeadIcon, slot0, {
		index = 2,
		dir = slot2
	})

	slot0.heroItemDict[slot2] = slot3

	return slot3
end

function slot0.onClickHeroHeadIcon(slot0, slot1)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.FocusElement, slot0.dirToFocusElementDict[slot1.dir][slot1.index].focusElementId)
end

function slot0.getElementData(slot0)
	if #slot0.focusElementDataPool > 0 then
		return table.remove(slot0.focusElementDataPool)
	end

	return {}
end

function slot0.onMapPosChanged(slot0)
	slot0:refreshHeroIcon()
end

function slot0.onRemoveElement(slot0)
	slot0:refreshHeroIcon()
end

function slot0.refreshHeroIcon(slot0)
	if not slot0.loadedElements then
		return
	end

	if not slot0.canShowHeroIcon then
		return
	end

	if slot0.activityDungeonMo:isHardMode() then
		return
	end

	for slot4, slot5 in pairs(slot0.dirToFocusElementDict) do
		for slot9 = 1, #slot5 do
			table.insert(slot0.focusElementDataPool, table.remove(slot5))
		end
	end

	for slot4, slot5 in ipairs(slot0.taskMoList) do
		slot6, slot7 = slot0:getTaskMoFirstNotFinishElement(slot5)

		if slot6 then
			slot8 = slot0:getElementData()
			slot8.focusElementId = slot6
			slot8.heroId = slot5.config.heroId

			table.insert(slot0.dirToFocusElementDict[slot0:getDir(slot7.x, slot7.y)], slot8)
		end
	end

	for slot4, slot5 in pairs(slot0.dirToFocusElementDict) do
		slot6 = #slot5 > 0

		gohelper.setActive(slot0.heroItemDict[slot4].go, slot6)

		if slot6 then
			gohelper.setActive(slot0.heroItemDict[slot4].goHeroIcon1, false)
			gohelper.setActive(slot0.heroItemDict[slot4].goHeroIcon2, false)

			for slot10, slot11 in ipairs(slot5) do
				slot0:refreshHeroItemPos(slot4, slot10, slot11)
			end
		end
	end
end

function slot0.getTaskMoFirstNotFinishElement(slot0, slot1)
	if not slot1:isUnlock() then
		return
	end

	if slot1.gainedReward then
		return
	end

	for slot6, slot7 in ipairs(slot1:getSubTaskCoList()) do
		if VersionActivity1_5RevivalTaskModel.instance:getSubHeroTaskStatus(slot7) == VersionActivity1_5DungeonEnum.SubHeroTaskStatus.Normal then
			for slot12, slot13 in ipairs(slot7.elementList) do
				if not DungeonMapModel.instance:elementIsFinished(slot13) and slot0.mapSceneElementsView:getElementComp(slot13) then
					slot15, slot16, slot17 = transformhelper.getPos(slot14:getTransform())

					slot0._tempVector:Set(slot15, slot16, slot17)

					slot18 = slot0.mainCamera:WorldToViewportPoint(slot0._tempVector)
					slot16 = slot18.y

					if slot18.x < 0 or slot15 > 1 or slot16 < 0 or slot16 > 1 then
						return slot13, slot18
					end
				end
			end
		end
	end
end

function slot0.refreshHeroItemPos(slot0, slot1, slot2, slot3)
	if slot2 > 2 then
		return
	end

	gohelper.setActive(slot0.heroItemDict[slot1].go, true)
	gohelper.setActive(slot2 == 1 and slot4.goHeroIcon1 or slot4.goHeroIcon2, true)
	(slot2 == 1 and slot4.heroHeadImage1 or slot4.heroHeadImage2):LoadImage(ResUrl.getHeadIconSmall(slot3.heroId .. "01"))
end

function slot0.getDir(slot0, slot1, slot2)
	if slot1 < 0 then
		return VersionActivity1_5DungeonEnum.MapDir.Left
	elseif slot1 >= 0 and slot1 <= 1 then
		if slot2 < 0 then
			return VersionActivity1_5DungeonEnum.MapDir.Bottom
		else
			return VersionActivity1_5DungeonEnum.MapDir.Top
		end
	else
		return VersionActivity1_5DungeonEnum.MapDir.Right
	end
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0.heroItemDict) do
		slot5.click1:RemoveClickListener()
		slot5.click2:RemoveClickListener()
		slot5.heroHeadImage1:UnLoadImage()
		slot5.heroHeadImage2:UnLoadImage()
	end
end

return slot0
