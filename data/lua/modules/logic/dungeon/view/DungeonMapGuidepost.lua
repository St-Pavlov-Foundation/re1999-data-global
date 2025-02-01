module("modules.logic.dungeon.view.DungeonMapGuidepost", package.seeall)

slot0 = class("DungeonMapGuidepost", LuaCompBase)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.ctor(slot0, slot1)
	slot0._scene = slot1
end

function slot0.setConfig(slot0, slot1, slot2)
	slot0._config = slot1
	slot0._episodeId = slot2

	if not string.nilorempty(slot0._config.pos) then
		slot3 = string.splitToNumber(slot0._config.pos, "#")

		transformhelper.setLocalPos(slot0.viewGO.transform, slot3[1], slot3[2], -5)
	end

	for slot8 = 1, 3 do
		slot9 = string.splitToNumber(DungeonConfig.instance:getElementList(slot2), "#")[slot8]

		gohelper.setActive(slot0._goList[slot8], slot9)

		if slot9 then
			slot12 = gohelper.findChild(slot10, "click")

			if DungeonMapModel.instance:elementIsFinished(slot9) then
				slot10:GetComponent(typeof(UnityEngine.Renderer)).material:SetColor("_MainCol", GameUtil.parseColor("#c66030ff"))
			else
				slot13:SetColor("_MainCol", GameUtil.parseColor("#ffffff99"))
			end

			gohelper.setActive(slot12, slot14)

			slot16 = slot13:GetVector("_Frame")
			slot16.w = DungeonEnum.ElementTypeIconIndex[string.format("%s", lua_chapter_map_element.configDict[slot9].type .. (slot14 and 1 or 0))]

			slot13:SetVector("_Frame", slot16)
		end
	end
end

function slot0.allElementsFinished(slot0)
	for slot6, slot7 in ipairs(string.splitToNumber(DungeonConfig.instance:getElementList(slot0), "#")) do
		if not DungeonMapModel.instance:elementIsFinished(slot7) then
			return false
		end
	end

	return true
end

function slot0._editableInitView(slot0)
	slot0._goList = slot0:getUserDataTb_()

	slot0:_initElementGo(gohelper.findChild(slot0.viewGO, "ani/plane_a"))
	slot0:_initElementGo(gohelper.findChild(slot0.viewGO, "ani/plane_b"))
	slot0:_initElementGo(gohelper.findChild(slot0.viewGO, "ani/plane_c"))
end

function slot0._initElementGo(slot0, slot1)
	table.insert(slot0._goList, slot1)
	DungeonMapElement.addBoxColliderListener(slot1, slot0._onDown, slot0)
end

function slot0._onDown(slot0)
	if slot0._scene:showInteractiveItem() then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.Guidepost) then
		return
	end

	DungeonController.instance:openDungeonMapTaskView({
		viewParam = slot0._episodeId
	})
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()
	slot0:addEvents()
	slot0:_editableAddEvents()
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onDestroy(slot0)
	slot0:removeEvents()
	slot0:_editableRemoveEvents()
end

return slot0
