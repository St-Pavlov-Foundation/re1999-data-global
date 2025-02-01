module("modules.logic.versionactivity2_2.tianshinana.controller.TianShiNaNaEntityMgr", package.seeall)

slot0 = class("TianShiNaNaEntityMgr")

function slot0.ctor(slot0)
	slot0._entitys = {}
	slot0._nodes = {}
end

function slot0.addEntity(slot0, slot1, slot2)
	if slot0._entitys[slot1.co.id] then
		slot3:reAdd()

		return slot3
	end

	if not TianShiNaNaModel.instance.mapCo:getNodeCo(slot1.x, slot1.y) or slot4:isCollapse() then
		return nil
	end

	slot6 = TianShiNaNaEnum.UnitTypeToName[slot1.co.unitType] or ""
	slot3 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.create3d(slot2, slot6 .. slot1.co.id), _G[string.format("TianShiNaNa%sEntity", slot6)] or TianShiNaNaUnitEntityBase)

	slot3:updateMo(slot1)

	slot0._entitys[slot1.co.id] = slot3

	return slot3
end

function slot0.getEntity(slot0, slot1)
	return slot0._entitys[slot1]
end

function slot0.removeEntity(slot0, slot1)
	if slot0._entitys[slot1] then
		slot0._entitys[slot1]:dispose()

		slot0._entitys[slot1] = nil
	end
end

function slot0.addNode(slot0, slot1, slot2)
	if string.nilorempty(slot1.nodePath) then
		return
	end

	if slot0._nodes[slot1] then
		return slot0._nodes[slot1]
	end

	slot4 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.create3d(slot2, string.format("%d_%d", slot1.x, slot1.y)), TianShiNaNaNodeEntity)

	slot4:updateCo(slot1)

	slot0._nodes[slot1] = slot4

	return slot4
end

function slot0.removeNode(slot0, slot1)
	if slot0._nodes[slot1] then
		slot0._nodes[slot1]:dispose()

		slot0._nodes[slot1] = nil
	end
end

function slot0.clear(slot0)
	for slot4, slot5 in pairs(slot0._entitys) do
		slot5:dispose()
	end

	for slot4, slot5 in pairs(slot0._nodes) do
		slot5:dispose()
	end

	slot0._entitys = {}
	slot0._nodes = {}
end

slot0.instance = slot0.New()

return slot0
