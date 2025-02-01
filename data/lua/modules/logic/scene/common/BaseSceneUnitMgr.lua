module("modules.logic.scene.common.BaseSceneUnitMgr", package.seeall)

slot0 = class("BaseSceneUnitMgr", BaseSceneComp)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)

	slot0._tagUnitDict = {}
	slot0._containerGO = slot0:getCurScene():getSceneContainerGO()
end

function slot0.onSceneClose(slot0)
	slot0:removeAllUnits()
end

function slot0.addUnit(slot0, slot1)
	gohelper.addChild(slot0._containerGO, slot1.go)

	if not slot0._tagUnitDict[slot1.go.tag] then
		slot0._tagUnitDict[slot2] = {}
	end

	slot3[slot1.id] = slot1
end

function slot0.removeUnit(slot0, slot1, slot2)
	if slot0._tagUnitDict[slot1] and slot3[slot2] then
		slot3[slot2] = nil

		slot0:destroyUnit(slot4)
	end
end

function slot0.removeUnitData(slot0, slot1, slot2)
	if slot0._tagUnitDict[slot1] and slot0._tagUnitDict[slot1][slot2] then
		slot0._tagUnitDict[slot1][slot2] = nil

		return slot0._tagUnitDict[slot1][slot2]
	end
end

function slot0.removeUnits(slot0, slot1)
	if slot0._tagUnitDict[slot1] then
		for slot6, slot7 in pairs(slot2) do
			slot2[slot6] = nil

			slot0:destroyUnit(slot7)
		end
	end
end

function slot0.removeAllUnits(slot0)
	for slot4, slot5 in pairs(slot0._tagUnitDict) do
		for slot9, slot10 in pairs(slot5) do
			slot5[slot9] = nil

			slot0:destroyUnit(slot10)
		end
	end
end

function slot0.getUnit(slot0, slot1, slot2)
	if slot0._tagUnitDict[slot1] then
		return slot3[slot2]
	end
end

function slot0.getTagUnitDict(slot0, slot1)
	return slot0._tagUnitDict[slot1]
end

function slot0.destroyUnit(slot0, slot1)
	if slot1.beforeDestroy then
		slot1:beforeDestroy()
	end

	gohelper.destroy(slot1.go)
end

return slot0
