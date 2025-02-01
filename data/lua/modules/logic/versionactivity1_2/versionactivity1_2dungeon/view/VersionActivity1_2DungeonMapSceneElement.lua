module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonMapSceneElement", package.seeall)

slot0 = class("VersionActivity1_2DungeonMapSceneElement", DungeonMapSceneElements)
slot1 = {
	12101,
	12102,
	12104,
	12105
}
slot2 = {
	12101011
}

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveAct116InfoUpdatePush, slot0._onReceiveAct116InfoUpdatePush, slot0)
end

function slot0._OnRemoveElement(slot0, slot1)
	if not slot0._elementList then
		return
	end

	if not slot0._elementList[slot1] then
		return
	end

	uv0.super._OnRemoveElement(slot0, slot1)
end

function slot0._addElement(slot0, slot1)
	if slot1.id == 12101091 then
		return
	end

	if slot0._elementList[slot1.id] then
		return
	end

	slot2 = UnityEngine.GameObject.New(tostring(slot1.id))

	gohelper.setActive(slot2, slot0:_checkShowDailyElement(slot1.id))
	gohelper.addChild(slot0._elementRoot, slot2)

	slot3 = MonoHelper.addLuaComOnceToGo(slot2, VersionActivity1_2DungeonMapElement, {
		slot1,
		slot0._mapScene,
		slot0
	})
	slot0._elementList[slot1.id] = slot3

	if slot3:showArrow() then
		slot5 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[5], slot0._goarrow)
		slot6 = gohelper.findChild(slot5, "mesh")
		slot7, slot8, slot9 = transformhelper.getLocalRotation(slot6.transform)
		slot10 = gohelper.getClick(gohelper.findChild(slot5, "click"))

		slot10:AddClickListener(slot0._arrowClick, slot0, slot1.id)

		slot0._arrowList[slot1.id] = {
			go = slot5,
			rotationTrans = slot6.transform,
			initRotation = {
				slot7,
				slot8,
				slot9
			},
			arrowClick = slot10
		}

		slot0:_updateArrow(slot3)
	end
end

function slot0._onReceiveAct116InfoUpdatePush(slot0)
	if slot0._elementList then
		for slot4, slot5 in ipairs(slot0._elementList) do
			gohelper.setActive(slot5._go, slot0:_checkShowDailyElement(slot5._config.id))
		end
	end

	slot0.viewContainer.mapScene:_showDailyBtn()
end

function slot0._showElements(slot0, slot1)
	if not slot0._sceneGo or slot0._lockShowElementAnim then
		return
	end

	for slot6, slot7 in ipairs(DungeonMapModel.instance:getElements(slot1)) do
		if slot7.type == DungeonEnum.ElementType.Activity1_2Building_Upgrade and not VersionActivity1_2DungeonModel.instance:getElementData(slot7.id) then
			Activity116Rpc.instance:sendGet116InfosRequest()

			break
		end
	end

	slot3 = DungeonMapModel.instance:getNewElements()
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in ipairs(slot2) do
		if slot10.showCamera == 1 and not slot0._skipShowElementAnim and (slot3 and tabletool.indexOf(slot3, slot10.id) or slot0._forceShowElementAnim) then
			table.insert(slot4, slot10.id)
		else
			table.insert(slot5, slot10)
		end
	end

	slot0:_showElementAnim(slot4, slot5)
	DungeonMapModel.instance:clearNewElements()
end

function slot0._checkShowDailyElement(slot0, slot1)
	if lua_chapter_map_element.configDict[slot1].type == DungeonEnum.ElementType.DailyEpisode then
		return VersionActivity1_2DungeonModel.instance:getDailyEpisodeConfigByElementId(slot1)
	end

	return true
end

function slot0.setElementDown(slot0, slot1)
	if not gohelper.isNil(slot0._mapScene._uiGo) then
		return
	end

	slot0.curSelectId = slot1._config.id
	slot0._elementMouseDown = slot1
end

function slot0._onFinishGuide(slot0, slot1)
	if (slot0._lockShowElementAnim or slot0._forceShowElementId ~= nil and tabletool.indexOf(uv0, slot0._forceShowElementId)) and tabletool.indexOf(uv1, slot1) then
		slot0._lockShowElementAnim = nil
		slot0._forceShowElementId = nil

		GuideModel.instance:clearFlagByGuideId(slot1)
		slot0:_initElements()
	end
end

return slot0
