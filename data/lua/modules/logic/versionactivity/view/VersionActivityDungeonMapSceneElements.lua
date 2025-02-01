module("modules.logic.versionactivity.view.VersionActivityDungeonMapSceneElements", package.seeall)

slot0 = class("VersionActivityDungeonMapSceneElements", DungeonMapSceneElements)

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0.finishElementList = {}
end

function slot0.onOpen(slot0)
	slot0.activityDungeonMo = slot0.viewContainer.versionActivityDungeonBaseMo

	uv0.super.onOpen(slot0)
	slot0:addEventCb(VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, slot0.onModeChange, slot0, LuaEventSystem.Low)
	slot0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnInitElements, slot0._initElements, slot0)
end

function slot0.onModeChange(slot0)
	for slot5, slot6 in pairs(slot0._elementList) do
		if slot0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story then
			slot6:show()
		else
			slot6:hide()
		end
	end

	for slot5, slot6 in pairs(slot0.finishElementList) do
		if slot1 then
			slot6:show()
		else
			slot6:hide()
		end
	end
end

function slot0._removeElement(slot0, slot1)
	if not slot0:canShow(DungeonConfig.instance:getChapterMapElement(slot1)) then
		uv0.super._removeElement(slot0, slot1)

		return
	end

	slot3 = slot0._elementList[slot1]
	slot4 = slot3._go

	slot3:setFinishAndDotDestroy()

	slot0._elementList[slot1] = nil

	if slot0._arrowList[slot1] then
		slot5.arrowClick:RemoveClickListener()

		slot0._arrowList[slot1] = nil

		gohelper.destroy(slot5.go)
	end

	slot0:addFinishElement(DungeonConfig.instance:getChapterMapElement(slot1), slot4)
end

function slot0._showElements(slot0, slot1)
	if slot0.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(slot0.activityDungeonMo.episodeId) then
		return
	end

	uv0.super._showElements(slot0, slot1)

	slot2 = DungeonMapModel.instance:getElements(slot1)

	if DungeonConfig.instance:getMapElements(slot1) then
		for slot7, slot8 in ipairs(slot3) do
			if slot0:canShow(slot8) and not slot0:inNotFinishElementList(slot8.id, slot2) then
				slot0:addFinishElement(slot8)
			end
		end
	end
end

function slot0.inNotFinishElementList(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot2) do
		if slot7.id == slot1 then
			return true
		end
	end

	return false
end

function slot0.addFinishElement(slot0, slot1, slot2)
	if slot0.finishElementList[slot1.id] then
		return
	end

	if not slot2 then
		gohelper.addChild(slot0._elementRoot, UnityEngine.GameObject.New(tostring(slot1.id)))
	end

	slot0.finishElementList[slot1.id] = MonoHelper.addLuaComOnceToGo(slot3, DungeonMapFinishElement, {
		slot1,
		slot0._mapScene,
		slot0,
		slot2
	})
end

function slot0.canShow(slot0, slot1)
	return slot1.type == DungeonEnum.ElementType.PuzzleGame or slot1.type == DungeonEnum.ElementType.None
end

function slot0._disposeScene(slot0)
	uv0.super._disposeScene(slot0)
	slot0:disposeFinishElements()
end

function slot0._disposeOldMap(slot0)
	uv0.super._disposeOldMap(slot0)
	slot0:disposeFinishElements()
end

function slot0.disposeFinishElements(slot0)
	for slot4, slot5 in pairs(slot0.finishElementList) do
		slot5:onDestroy()
	end

	slot0.finishElementList = {}
end

return slot0
