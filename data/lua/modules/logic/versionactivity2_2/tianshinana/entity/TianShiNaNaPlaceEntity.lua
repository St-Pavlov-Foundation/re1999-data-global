module("modules.logic.versionactivity2_2.tianshinana.entity.TianShiNaNaPlaceEntity", package.seeall)

slot0 = class("TianShiNaNaPlaceEntity", LuaCompBase)

function slot0.Create(slot0, slot1, slot2, slot3, slot4)
	slot5 = UnityEngine.GameObject.New("Place")

	if slot4 then
		slot5.transform:SetParent(slot4.transform, false)
	end

	return MonoHelper.addNoUpdateLuaComOnceToGo(slot5, uv0, {
		x = slot0,
		y = slot1,
		canOperDirs = slot2,
		cubeType = slot3
	})
end

function slot0.ctor(slot0, slot1)
	slot0.x = slot1.x
	slot0.y = slot1.y
	slot0.canOperDirs = slot1.canOperDirs
	slot0.cubeType = slot1.cubeType
	slot0._maxLen = slot0.cubeType == TianShiNaNaEnum.CubeType.Type1 and 1 or 2
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.trans = slot1.transform
	slot2 = TianShiNaNaHelper.nodeToV3(TianShiNaNaHelper.getV2(slot0.x, slot0.y))
	slot7 = slot2.y

	transformhelper.setLocalPos(slot0.trans, slot2.x, slot7, slot2.z)

	slot6 = slot0.y
	slot0._renderOrder = TianShiNaNaHelper.getSortIndex(slot0.x, slot6)

	for slot6, slot7 in pairs(TianShiNaNaEnum.OperDir) do
		if slot0.canOperDirs[slot7] then
			slot8 = TianShiNaNaHelper.getOperOffset(slot7)

			if slot0.cubeType == TianShiNaNaEnum.CubeType.Type2 then
				if slot7 == TianShiNaNaEnum.OperDir.Left or slot7 == TianShiNaNaEnum.OperDir.Right then
					transformhelper.setLocalScale(gohelper.create3d(slot0.go, slot6).transform, -1, 1, 1)
				end

				if slot7 == TianShiNaNaEnum.OperDir.Back or slot7 == TianShiNaNaEnum.OperDir.Right then
					slot8.x = slot8.x * 2
					slot8.y = slot8.y * 2
				end
			end

			slot2 = TianShiNaNaHelper.nodeToV3(slot8)

			transformhelper.setLocalPos(slot9.transform, slot2.x, slot2.y, slot2.z)
			PrefabInstantiate.Create(slot9):startLoad(slot0.cubeType == TianShiNaNaEnum.CubeType.Type1 and "scenes/v2a2_m_s12_tsnn_jshd/prefab/uidikuai1.prefab" or "scenes/v2a2_m_s12_tsnn_jshd/prefab/uidikuai2.prefab", slot0._onLoadEnd, slot0)
		end
	end
end

function slot0._onLoadEnd(slot0)
	for slot5 = 0, slot0.go:GetComponentsInChildren(typeof(UnityEngine.Renderer)).Length - 1 do
		slot1[slot5].sortingOrder = slot0._renderOrder - 10
	end
end

function slot0.getClickDir(slot0, slot1)
	slot2 = nil

	if slot1.x == slot0.x then
		if math.abs(slot1.y - slot0.y) > 0 and slot3 <= slot0._maxLen then
			if slot0.y < slot1.y then
				slot2 = TianShiNaNaEnum.OperDir.Forward
			else
				slot2 = TianShiNaNaEnum.OperDir.Back
			end
		end
	elseif slot1.y == slot0.y and math.abs(slot1.x - slot0.x) > 0 and slot3 <= slot0._maxLen then
		slot2 = (slot0.x >= slot1.x or TianShiNaNaEnum.OperDir.Right) and TianShiNaNaEnum.OperDir.Left
	end

	if slot0.canOperDirs[slot2] then
		return slot2
	end
end

function slot0.dispose(slot0)
	gohelper.destroy(slot0.go)
end

return slot0
