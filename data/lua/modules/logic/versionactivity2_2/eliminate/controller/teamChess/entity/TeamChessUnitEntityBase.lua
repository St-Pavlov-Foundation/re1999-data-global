module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.entity.TeamChessUnitEntityBase", package.seeall)

slot0 = class("TeamChessUnitEntityBase", LuaCompBase)
slot1 = ZProj.TweenHelper

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.trans = slot1.transform
	slot0._posX = 0
	slot0._posY = 0
	slot0._posZ = 0
	slot0._lastActive = nil
	slot0._canClick = false
	slot0._canDrag = false
	slot0._scale = 1
end

function slot0.updateMo(slot0, slot1)
	slot0._unitMo = slot1

	slot0:setScale(slot1:getScale())
	slot0:loadAsset(slot0._unitMo:getUnitPath())
end

function slot0.loadAsset(slot0, slot1)
	if not string.nilorempty(slot1) and not slot0._loader then
		slot0._loader = PrefabInstantiate.Create(slot0.go)

		slot0._loader:startLoad(slot1, slot0._onResLoaded, slot0)
	end
end

function slot0.updatePos(slot0, slot1, slot2, slot3)
	slot0._posZ = slot3
	slot0._posY = slot2
	slot0._posX = slot1

	transformhelper.setPos(slot0.trans, slot1, slot2, slot3)
end

function slot0.moveToPos(slot0, slot1, slot2, slot3)
	uv0.DOMove(slot0.trans, slot1, slot2, slot3, EliminateTeamChessEnum.entityMoveTime, slot0._onMoveEnd, nil, , EaseType.OutQuart)
end

function slot0.getPosXYZ(slot0)
	slot1, slot2, slot3 = transformhelper.getPos(slot0.trans)

	return slot1, slot2 + 0.4, slot3
end

function slot0.getTopPosXYZ(slot0)
	slot1, slot2, slot3 = slot0:getPosXYZ()

	return slot1 - 0.1, slot2 + 0.5, slot3
end

function slot0.setActive(slot0, slot1)
	if slot0._lastActive == nil then
		slot0._lastActive = slot1
	end

	if slot0._lastActive ~= slot1 then
		gohelper.setActive(slot0.go, slot1)

		slot0._lastActive = slot1
	end
end

function slot0.setCanClick(slot0, slot1)
	slot0._canClick = slot1
end

function slot0.setCanDrag(slot0, slot1)
	slot0._canDrag = slot1
end

function slot0.setScale(slot0, slot1)
	slot0._scale = slot1 or 1
end

function slot0._onResLoaded(slot0)
	slot0._resGo = slot0._loader:getInstGO()

	transformhelper.setLocalScale(slot0._resGo.transform, slot0._scale, slot0._scale, slot0._scale)
end

function slot0.dispose(slot0)
	slot0:onDestroy()
end

function slot0.onDestroy(slot0)
	gohelper.destroy(slot0.go)

	slot0._lastActive = nil

	if slot0._loader then
		slot0._loader:onDestroy()

		slot0._loader = nil
	end
end

return slot0
