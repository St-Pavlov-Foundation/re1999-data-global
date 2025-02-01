module("modules.logic.versionactivity1_9.heroinvitation.view.HeroInvitationDungeonMapSceneElements", package.seeall)

slot0 = class("HeroInvitationDungeonMapSceneElements", DungeonMapSceneElements)

function slot0.onInitView(slot0)
	uv0.super.onInitView(slot0)

	slot0.goItem = gohelper.findChild(slot0.viewGO, "#go_arrow/#go_item")
	slot0.allFinish = HeroInvitationModel.instance:isAllFinish()
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0:addEventCb(HeroInvitationController.instance, HeroInvitationEvent.StateChange, slot0.updateState, slot0)
	slot0:addEventCb(HeroInvitationController.instance, HeroInvitationEvent.UpdateInfo, slot0.updateHeroInvitation, slot0)
end

function slot0.updateState(slot0)
	if slot0._mapCfg then
		slot0:_showElements(slot0._mapCfg.id)
	end
end

function slot0.updateHeroInvitation(slot0)
	if HeroInvitationModel.instance:isAllFinish() == slot0.allFinish then
		return
	end

	if slot0._mapCfg then
		slot0:_showElements(slot0._mapCfg.id)
	end
end

function slot0._addElement(slot0, slot1)
	slot4 = false

	if not slot0._elementList[slot1.id] then
		slot5 = UnityEngine.GameObject.New(tostring(slot2))

		gohelper.addChild(slot0._elementRoot, slot5)

		slot0._elementList[slot2] = MonoHelper.addLuaComOnceToGo(slot5, HeroInvitationDungeonMapElement, {
			slot1,
			slot0._mapScene,
			slot0
		})
		slot4 = true
	end

	if slot3:showArrow() then
		slot0:createArrowItem(slot2)
		slot0:_updateArrow(slot3)
	end

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnElementAdd, slot2)

	if slot0._inRemoveElementId == slot2 then
		slot3:setWenHaoGoVisible(true)
		slot0:_removeElement(slot2)
	else
		slot3:setWenHaoGoVisible(slot0.allFinish or not DungeonMapModel.instance:elementIsFinished(slot2))

		if not slot4 and slot0.allFinish then
			slot3:setWenHaoAnim(DungeonMapElement.InAnimName)
		end
	end
end

function slot0._getElements(slot0, slot1)
	slot0.allFinish = HeroInvitationModel.instance:isAllFinish()
	slot3 = {}

	if DungeonConfig.instance:getMapElements(slot1) then
		for slot7, slot8 in ipairs(slot2) do
			if HeroInvitationModel.instance:getInvitationStateByElementId(slot8.id) ~= HeroInvitationEnum.InvitationState.TimeLocked and slot9 ~= HeroInvitationEnum.InvitationState.ElementLocked and (slot0.allFinish or DungeonMapModel.instance:getElementById(slot8.id) or DungeonMapModel.instance:elementIsFinished(slot8.id)) then
				table.insert(slot3, slot8)
			end
		end
	end

	return slot3
end

function slot0._removeElement(slot0, slot1)
	if not slot0._elementList[slot1] then
		slot0._inRemoveElementId = slot1

		return
	end

	DungeonMapModel.instance.directFocusElement = true

	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnFocusElement, slot1)

	DungeonMapModel.instance.directFocusElement = false
	slot0._inRemoveElementId = nil
	slot0._inRemoveElement = true

	if slot2 then
		slot2:setFinishAndDotDestroy()
	end

	if slot0._arrowList[slot1] then
		slot0:destoryArrowItem(slot3)

		slot0._arrowList[slot1] = nil
	end
end

function slot0.onRemoveElementFinish(slot0)
	slot0._inRemoveElement = false

	if slot0._mapCfg then
		slot0:_showElements(slot0._mapCfg.id)
	end
end

function slot0._showElements(slot0, slot1)
	if slot0._inRemoveElement then
		return
	end

	if gohelper.isNil(slot0._sceneGo) or slot0._lockShowElementAnim then
		return
	end

	if slot0._inRemoveElementId then
		slot3 = {}
		slot4 = {}

		for slot8, slot9 in ipairs(slot0:_getElements(slot1)) do
			if slot9.id <= slot0._inRemoveElementId then
				if slot9.showCamera == 1 and not slot0._skipShowElementAnim and slot0._forceShowElementAnim then
					table.insert(slot3, slot9.id)
				else
					table.insert(slot4, slot9)
				end
			end
		end

		slot0:_showElementAnim(slot3, slot4)
	else
		slot3 = DungeonMapModel.instance:getNewElements()
		slot4 = {}
		slot5 = {}

		for slot9, slot10 in ipairs(slot0:_getElements(slot1)) do
			if slot10.showCamera == 1 and not slot0._skipShowElementAnim and (slot3 and tabletool.indexOf(slot3, slot10.id) or slot0._forceShowElementAnim) then
				table.insert(slot4, slot10.id)
			else
				table.insert(slot5, slot10)
			end
		end

		slot0:_showElementAnim(slot4, slot5)
		DungeonMapModel.instance:clearNewElements()
	end
end

function slot0.clickElement(slot0, slot1)
	if slot0:_isShowElementAnim() then
		return
	end

	if not slot0._elementList[tonumber(slot1)] then
		return
	end

	slot3 = slot2._config

	slot0:_focusElementById(slot3.id)

	if DungeonMapModel.instance:elementIsFinished(slot3.id) then
		StoryController.instance:playStory(HeroInvitationConfig.instance:getInvitationConfigByElementId(slot3.id).restoryId, {
			blur = true,
			hideStartAndEndDark = true
		})
	else
		StoryController.instance:playStory(slot4.storyId, {
			blur = true,
			hideStartAndEndDark = true
		}, function ()
			DungeonRpc.instance:sendMapElementRequest(uv0.id)
		end)
	end
end

function slot0.hideMapHeroIcon(slot0)
	for slot4, slot5 in pairs(slot0._arrowList) do
		slot0:destoryArrowItem(slot5)
	end

	slot0._arrowList = slot0:getUserDataTb_()
end

function slot0.createArrowItem(slot0, slot1)
	if slot0._arrowList[slot1] then
		return slot0._arrowList[slot1]
	end

	slot2 = slot0:getUserDataTb_()
	slot2.elementId = slot1
	slot2.go = gohelper.cloneInPlace(slot0.goItem, tostring(slot1))

	gohelper.setActive(slot2.go, false)

	slot2.arrowGO = gohelper.findChild(slot2.go, "arrow")
	slot2.rotationTrans = slot2.arrowGO.transform
	slot2.goHeroIcon = gohelper.findChild(slot2.go, "heroicon")
	slot2.heroHeadImage = gohelper.findChildSingleImage(slot2.go, "heroicon/#simage_herohead")
	slot2.click = gohelper.getClickWithDefaultAudio(slot2.heroHeadImage.gameObject)

	slot2.click:AddClickListener(slot0.onClickHeroHeadIcon, slot0, slot2)

	slot3, slot4, slot5 = transformhelper.getLocalRotation(slot2.rotationTrans)
	slot2.initRotation = {
		slot3,
		slot4,
		slot5
	}
	slot0._arrowList[slot1] = slot2

	slot2.heroHeadImage:LoadImage(ResUrl.getHeadIconSmall(HeroInvitationConfig.instance:getInvitationConfigByElementId(slot1).head))

	return slot2
end

function slot0.destoryArrowItem(slot0, slot1)
	if not slot1 then
		return
	end

	slot1.click:RemoveClickListener()
	slot1.heroHeadImage:UnLoadImage()
	gohelper.destroy(slot1.go)
end

function slot0.onClickHeroHeadIcon(slot0, slot1)
	DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnFocusElement, slot1.elementId)
end

function slot0._updateArrow(slot0, slot1)
	if not slot1:showArrow() then
		return
	end

	slot4 = CameraMgr.instance:getMainCamera():WorldToViewportPoint(slot1._transform.position)
	slot6 = slot4.y
	slot7 = DungeonMapModel.instance:elementIsFinished(slot1:getElementId())
	slot8 = slot4.x >= 0 and slot5 <= 1 and slot6 >= 0 and slot6 <= 1

	if not slot0._arrowList[slot1:getElementId()] then
		return
	end

	gohelper.setActive(slot9.go, not slot7 and not slot8)

	if slot8 or slot7 then
		return
	end

	slot10 = math.max(0.05, math.min(slot5, 0.95))

	if math.max(0.1, math.min(slot6, 0.9)) > 0.85 and slot10 < 0.15 then
		slot11 = 0.85
	end

	recthelper.setAnchor(slot9.go.transform, recthelper.getWidth(slot0._goarrow.transform) * (slot10 - 0.5), recthelper.getHeight(slot0._goarrow.transform) * (slot11 - 0.5))

	slot14 = slot9.initRotation

	if slot5 >= 0 and slot5 <= 1 then
		if slot6 < 0 then
			transformhelper.setLocalRotation(slot9.rotationTrans, slot14[1], slot14[2], 180)

			return
		elseif slot6 > 1 then
			transformhelper.setLocalRotation(slot9.rotationTrans, slot14[1], slot14[2], 0)

			return
		end
	end

	if slot6 >= 0 and slot6 <= 1 then
		if slot5 < 0 then
			transformhelper.setLocalRotation(slot9.rotationTrans, slot14[1], slot14[2], 90)

			return
		elseif slot5 > 1 then
			transformhelper.setLocalRotation(slot9.rotationTrans, slot14[1], slot14[2], 270)

			return
		end
	end

	transformhelper.setLocalRotation(slot9.rotationTrans, slot14[1], slot14[2], Mathf.Deg(Mathf.Atan2(slot6, slot5)) - 90)
end

function slot0._disposeOldMap(slot0)
	for slot4, slot5 in pairs(slot0._elementList) do
		slot5:onDestroy()
	end

	slot0._elementList = slot0:getUserDataTb_()

	slot0:hideMapHeroIcon()
	slot0:_stopShowSequence()
end

return slot0
