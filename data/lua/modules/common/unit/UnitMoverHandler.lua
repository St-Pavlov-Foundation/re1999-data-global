module("modules.common.unit.UnitMoverHandler", package.seeall)

slot0 = class("UnitMoverHandler", LuaCompBase)
slot1 = {
	UnitMoverEase,
	UnitMoverParabola,
	UnitMoverBezier,
	UnitMoverCurve,
	UnitMoverMmo,
	UnitMoverBezier3
}

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._moverList = {}

	for slot5, slot6 in ipairs(uv0) do
		if MonoHelper.getLuaComFromGo(slot0.go, slot6) then
			table.insert(slot0._moverList, slot7)
		end
	end
end

function slot0.addEventListeners(slot0)
	for slot4, slot5 in ipairs(slot0._moverList) do
		slot5:registerCallback(UnitMoveEvent.PosChanged, slot0._onPosChange, slot0)
	end
end

function slot0.removeEventListeners(slot0)
	for slot4, slot5 in ipairs(slot0._moverList) do
		slot5:unregisterCallback(UnitMoveEvent.PosChanged, slot0._onPosChange, slot0)
	end
end

function slot0._onPosChange(slot0, slot1)
	slot3, slot4, slot5 = transformhelper.getPos(CameraMgr.instance:getSceneTransform())
	slot6, slot7, slot8 = slot1:getPos()

	transformhelper.setPos(slot0.go.transform, slot6 + slot3, slot7 + slot4, slot8 + slot5)
end

return slot0
