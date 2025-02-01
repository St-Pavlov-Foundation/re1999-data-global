module("modules.logic.versionactivity2_2.tianshinana.entity.TianShiNaNaUnitEntityBase", package.seeall)

slot0 = class("TianShiNaNaUnitEntityBase", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.trans = slot1.transform
end

function slot0.updateMo(slot0, slot1)
	slot0._unitMo = slot1

	if not string.nilorempty(slot1.co.unitPath) and not slot0._loader then
		slot0._loader = PrefabInstantiate.Create(slot0.go)

		slot0._loader:startLoad(slot1.co.unitPath, slot0._onResLoaded, slot0)
	end

	slot2 = TianShiNaNaHelper.nodeToV3(slot1)

	transformhelper.setLocalPos(slot0.trans, slot2.x, slot2.y, slot2.z)
end

function slot0.updatePosAndDir(slot0)
	slot0:_killTween()

	slot1 = TianShiNaNaHelper.nodeToV3(slot0._unitMo)

	transformhelper.setLocalPos(slot0.trans, slot1.x, slot1.y, slot1.z)
	slot0:setDir()
	slot0:updateSortOrder()
end

function slot0.getWorldPos(slot0)
	slot1, slot2, slot3 = transformhelper.getPos(slot0.trans)

	return TianShiNaNaHelper.getV3(slot1, slot2, slot3)
end

function slot0.getLocalPos(slot0)
	slot1, slot2, slot3 = transformhelper.getLocalPos(slot0.trans)

	return TianShiNaNaHelper.getV3(slot1, slot2, slot3)
end

function slot0.moveTo(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot1 == slot0._unitMo.x and slot2 == slot0._unitMo.y then
		if slot3 ~= slot0._unitMo.dir then
			slot0._unitMo.dir = slot3

			slot0:setDir()
		end

		slot4(slot5)

		return
	end

	slot6 = slot0._unitMo.x
	slot7 = slot0._unitMo.y
	slot0._unitMo.x = slot1
	slot0._unitMo.y = slot2
	slot0._unitMo.dir = slot3
	slot0._moveEndCall = slot4
	slot0._moveEndCallObj = slot5

	slot0:setDir()

	if slot0._isMoveHalf then
		slot0._isMoveHalf = false

		slot0:_killTween()
		slot0:_onEndMoveHalf()
	else
		slot0:_beginMoveHalf(TianShiNaNaHelper.nodeToV3(TianShiNaNaHelper.getV2((slot1 + slot6) / 2, (slot2 + slot7) / 2)))
	end
end

function slot0.moveToHalf(slot0, slot1, slot2, slot3, slot4)
	if slot0._unitMo:isPosEqual(slot1, slot2) then
		slot3(slot4)

		return
	end

	slot0._isMoveHalf = true
	slot5 = TianShiNaNaHelper.getV2(slot1, slot2)

	slot0:changeDir(slot1, slot2)

	slot0._moveEndCall = slot3
	slot0._moveEndCallObj = slot4

	slot0:_killTween()
	slot5:Add(slot0._unitMo):Div(2)

	slot0._targetPos = TianShiNaNaHelper.nodeToV3(slot5):Clone()
	slot0._beginPos = slot0:getLocalPos():Clone()
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.15, slot0._onMoving, slot0._onEndMove, slot0, nil, EaseType.Linear)
end

function slot0.changeDir(slot0, slot1, slot2)
	slot0._unitMo.dir = TianShiNaNaHelper.getDir(slot0._unitMo, TianShiNaNaHelper.getV2(slot1, slot2), slot0._unitMo.dir)

	slot0:setDir()
end

function slot0._beginMoveHalf(slot0, slot1)
	slot0:_killTween()

	slot0._targetPos = slot1:Clone()
	slot0._beginPos = slot0:getLocalPos():Clone()
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.15, slot0._onMoving, slot0._onEndMoveHalf, slot0, nil, EaseType.Linear)
end

function slot0._onEndMoveHalf(slot0)
	slot0:updateSortOrder()

	slot0._targetPos = TianShiNaNaHelper.nodeToV3(slot0._unitMo):Clone()
	slot0._beginPos = slot0:getLocalPos():Clone()
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.15, slot0._onMoving, slot0._onEndMove, slot0, nil, EaseType.Linear)
end

function slot0._onEndMove(slot0)
	slot0._tweenId = nil
	slot0._moveEndCall = nil
	slot0._moveEndCallObj = nil

	if slot0._moveEndCall then
		slot1(slot0._moveEndCallObj)
	end
end

function slot0._onMoving(slot0, slot1)
	if not slot0._beginPos or not slot0._targetPos then
		return
	end

	slot2 = TianShiNaNaHelper.lerpV3(slot0._beginPos, slot0._targetPos, slot1)

	transformhelper.setLocalPos(slot0.trans, slot2.x, slot2.y, slot2.z)
	slot0:onMoving()
end

function slot0.onMoving(slot0)
end

function slot0._onResLoaded(slot0)
	slot0._resGo = slot0._loader:getInstGO()
	slot0._dirs = slot0:getUserDataTb_()

	for slot4, slot5 in pairs(TianShiNaNaEnum.OperDir) do
		slot0._dirs[slot5] = gohelper.findChild(slot0._resGo, TianShiNaNaEnum.ResDirPath[slot5])
	end

	if slot0._resGo:GetComponentsInChildren(typeof(UnityEngine.Renderer), true).Length > 0 then
		slot0._renderers = {}

		for slot5 = 0, slot1.Length - 1 do
			slot0._renderers[slot5 + 1] = slot1[slot5]
		end
	end

	slot0:setDir()
	slot0:updateSortOrder()
	slot0:onResLoaded()
end

function slot0.onResLoaded(slot0)
end

function slot0.reAdd(slot0)
end

function slot0._killTween(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0.setDir(slot0)
	if not slot0._resGo then
		return
	end

	for slot4, slot5 in pairs(slot0._dirs) do
		gohelper.setActive(slot5, slot4 == slot0._unitMo.dir)
	end
end

function slot0.updateSortOrder(slot0)
	if not slot0._renderers then
		return
	end

	for slot4, slot5 in pairs(slot0._renderers) do
		slot5.sortingOrder = TianShiNaNaHelper.getSortIndex(slot0._unitMo.x, slot0._unitMo.y)
	end
end

function slot0.onDestroy(slot0)
	slot0:_killTween()
end

function slot0.dispose(slot0)
	gohelper.destroy(slot0.go)
end

return slot0
