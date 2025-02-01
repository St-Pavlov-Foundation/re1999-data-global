module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandElements", package.seeall)

slot0 = class("FairyLandElements", BaseView)

function slot0.onInitView(slot0)
	slot0.goElements = gohelper.findChild(slot0.viewGO, "main/#go_Root/#go_Elements")
	slot0.goPool = gohelper.findChild(slot0.goElements, "pool")
	slot0.wordRes1 = gohelper.findChild(slot0.goPool, "word1")
	slot0.wordRes2 = gohelper.findChild(slot0.goPool, "word2")
	slot0.elementDict = {}
	slot0.textDict = {}
	slot0.elementTypeDict = {}
	slot0.templateObjDict = {}
	slot0.element2ObjName = {
		[FairyLandEnum.ElementType.Circle] = "circle",
		[FairyLandEnum.ElementType.Square] = "square",
		[FairyLandEnum.ElementType.Triangle] = "triangle",
		[FairyLandEnum.ElementType.Rectangle] = "rectangle",
		[FairyLandEnum.ElementType.NPC] = "npc",
		[FairyLandEnum.ElementType.Character] = "character",
		[FairyLandEnum.ElementType.Door] = "door",
		[FairyLandEnum.ElementType.Text] = "text"
	}
	slot0.element2Cls = {
		[FairyLandEnum.ElementType.Circle] = FairyLandElementShape,
		[FairyLandEnum.ElementType.Square] = FairyLandElementShape,
		[FairyLandEnum.ElementType.Triangle] = FairyLandElementShape,
		[FairyLandEnum.ElementType.Rectangle] = FairyLandElementShape,
		[FairyLandEnum.ElementType.NPC] = FairyLandChessNpc,
		[FairyLandEnum.ElementType.Character] = FairyLandChessSelf,
		[FairyLandEnum.ElementType.Door] = FairyLandElementDoor
	}

	for slot4, slot5 in pairs(slot0.element2ObjName) do
		slot0.templateObjDict[slot4] = gohelper.findChild(slot0.goPool, slot5)
	end

	slot0.characterId = 0
	slot0.characterType = 0

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FairyLandController.instance, FairyLandEvent.DialogFinish, slot0.updateElements, slot0)
	slot0:addEventCb(FairyLandController.instance, FairyLandEvent.UpdateInfo, slot0.updateElements, slot0)
	slot0:addEventCb(FairyLandController.instance, FairyLandEvent.ElementFinish, slot0.onElementFinish, slot0)
	slot0:addEventCb(FairyLandController.instance, FairyLandEvent.SceneLoadFinish, slot0.initElements, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.initElements(slot0)
	slot0:updateElements()
	FairyLandController.instance:dispatchEvent(FairyLandEvent.ElementLoadFinish)
end

function slot0.onElementFinish(slot0)
	slot0:updateElements()
end

function slot0.updateElements(slot0)
	for slot6, slot7 in ipairs(FairyLandConfig.instance:getElements()) do
		if FairyLandModel.instance:isFinishElement(slot7.id) then
			if 0 < slot8 then
				slot2 = slot8
			end

			slot0:removeElement(slot8)
		elseif slot0.elementDict[slot8] then
			slot0:updateElement(slot8)
		else
			slot0:createElement(slot8)
		end
	end

	if slot0.elementDict[slot0.characterId] then
		slot0:updateElement(slot0.characterId)
	else
		slot0:createCharacter()
	end

	slot0:refreshText()
	FairyLandController.instance:dispatchEvent(FairyLandEvent.GuideLatestElementFinish, slot2)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.GuideLatestPuzzleFinish, FairyLandModel.instance:getLatestFinishedPuzzle())
end

function slot0.createCharacter(slot0)
	slot1 = FairyLandEnum.ConfigType2ElementType[slot0.characterType]
	slot4 = slot0.element2Cls[slot1].New(slot0, {
		pos = FairyLandModel.instance:getStairPos()
	})
	slot5 = gohelper.clone(slot0.templateObjDict[slot1], slot0.goElements, tostring(slot0.characterId))

	gohelper.setActive(slot5, true)
	slot4:init(slot5)

	slot0.elementDict[slot0.characterId] = slot4

	slot0:addTypeDict(slot0.characterType, slot0.characterId)
end

function slot0.createElement(slot0, slot1)
	if not FairyLandConfig.instance:getElementConfig(slot1) then
		return
	end

	slot3 = FairyLandEnum.ConfigType2ElementType[slot2.type]
	slot5 = slot0.element2Cls[slot3].New(slot0, slot2)
	slot6 = gohelper.clone(slot0.templateObjDict[slot3], slot0.goElements, tostring(slot1))

	gohelper.setActive(slot6, true)
	slot5:init(slot6)

	slot0.elementDict[slot1] = slot5

	slot0:addTypeDict(slot2.type, slot1)
end

function slot0.addTypeDict(slot0, slot1, slot2)
	if not slot0.elementTypeDict[slot1] then
		slot0.elementTypeDict[slot1] = {}
	end

	table.insert(slot0.elementTypeDict[slot1], slot2)
end

function slot0.updateElement(slot0, slot1)
	if not slot0.elementDict[slot1] then
		return
	end

	slot0.elementDict[slot1]:refresh()
end

function slot0.removeElement(slot0, slot1)
	if not slot0.elementDict[slot1] then
		return
	end

	slot0.elementDict[slot1]:finish()

	slot0.elementDict[slot1] = nil
end

function slot0.getElementByType(slot0, slot1)
	slot3 = slot0.elementTypeDict[slot1 or slot0.characterType] and slot2[#slot2]

	return slot3 and slot0.elementDict[slot3]
end

function slot0.refreshText(slot0)
	if FairyLandModel.instance:isFinishDialog(FairyLandConfig.instance:getFairlyLandPuzzleConfig(10).storyTalkId) then
		for slot11, slot12 in ipairs(lua_fairyland_text.configList) do
			if slot12.node <= FairyLandModel.instance:getStairPos() then
				if not slot0.textDict[slot12.id] then
					slot14 = FairyLandText.New(slot0, {
						pos = 35 + (slot12.id - 1) * 1.8,
						config = slot12
					})
					slot15 = gohelper.clone(slot0.templateObjDict[FairyLandEnum.ElementType.Text], slot0.goElements, string.format("text%s", tostring(slot12.id)))

					gohelper.setActive(slot15, true)
					slot14:init(slot15)

					slot0.textDict[slot12.id] = slot14
				end

				slot0.textDict[slot12.id]:show()
			elseif slot0.textDict[slot12.id] then
				slot0.textDict[slot12.id]:hide()
			end
		end
	else
		for slot8, slot9 in pairs(slot0.textDict) do
			slot9:hide()
		end
	end
end

function slot0.characterMove(slot0)
	if slot0.elementDict[slot0.characterId] then
		slot0.elementDict[slot0.characterId]:move()
	end
end

function slot0.isMoveing(slot0)
	if slot0.elementDict[slot0.characterId] then
		return slot0.elementDict[slot0.characterId]:isMoveing()
	end
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0.elementDict) do
		slot5:onDestroy()
	end

	for slot4, slot5 in pairs(slot0.textDict) do
		slot5:onDestroy()
	end

	slot0.elementDict = nil
end

return slot0
