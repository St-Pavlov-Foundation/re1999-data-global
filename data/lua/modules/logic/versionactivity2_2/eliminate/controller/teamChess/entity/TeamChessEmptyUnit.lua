module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.entity.TeamChessEmptyUnit", package.seeall)

slot0 = class("TeamChessEmptyUnit", TeamChessSoldierUnit)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.trans = slot1.transform
end

function slot0.setPath(slot0, slot1)
	slot0._path = slot1

	slot0:loadAsset(slot1)
end

function slot0.setScreenPoint(slot0, slot1)
	slot0._screenPoint = slot1
end

function slot0.setUnitParentPosition(slot0, slot1)
	slot0._unitParentPosition = slot1
end

function slot0._onResLoaded(slot0)
	uv0.super._onResLoaded(slot0)

	if gohelper.isNil(slot0._backGo) then
		return
	end

	slot0:setAllMeshRenderOrderInLayer(20)
	slot0:updateByScreenPos()
	slot0:setActive(true)
end

function slot0.updateByScreenPos(slot0)
	if slot0._screenPoint == nil or slot0._unitParentPosition == nil then
		return
	end

	slot1, slot2, slot3 = recthelper.screenPosToWorldPos3(slot0._screenPoint, nil, slot0._unitParentPosition)

	slot0:updatePos(slot1, slot2, slot3)
end

function slot0.setOutlineActive(slot0, slot1)
	if gohelper.isNil(slot0._backOutLineGo) then
		return
	end

	if slot0._normalActive then
		slot0:setNormalActive(not slot1, false)
	end

	gohelper.setActive(slot0._backOutLineGo.gameObject, slot1)
	uv0.super.setOutlineActive(slot0, slot1)
end

function slot0.setGrayActive(slot0, slot1)
	if gohelper.isNil(slot0._backGrayGo) then
		return
	end

	if slot0._normalActive then
		slot0:setNormalActive(not slot1, false)
	end

	gohelper.setActive(slot0._backGrayGo.gameObject, slot1)
end

function slot0.setNormalActive(slot0, slot1, slot2)
	if gohelper.isNil(slot0._backGo) then
		return
	end

	if slot2 == nil then
		slot2 = true
	end

	if slot2 then
		slot0._active = slot1
	end

	gohelper.setActive(slot0._backGo.gameObject, slot1)
end

function slot0.onDestroy(slot0)
	slot0._screenPoint = nil

	uv0.super.onDestroy(slot0)
end

return slot0
