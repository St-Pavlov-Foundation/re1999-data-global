module("modules.logic.versionactivity2_2.tianshinana.entity.TianShiNaNaCubeEntity", package.seeall)

slot0 = class("TianShiNaNaCubeEntity", LuaCompBase)
slot1 = TianShiNaNaEnum.Dir
slot2 = TianShiNaNaEnum.OperDir
slot3 = TianShiNaNaEnum.OperEffect
slot4 = TianShiNaNaEnum.DirToQuaternion
slot5 = {
	[slot1.Forward] = true,
	[slot1.Left] = true,
	[slot1.Down] = true
}

function slot0.Create(slot0, slot1, slot2)
	slot3 = UnityEngine.GameObject.New("Cube")

	if slot2 then
		slot3.transform:SetParent(slot2.transform, false)
	end

	return MonoHelper.addNoUpdateLuaComOnceToGo(slot3, uv0, {
		x = slot0,
		y = slot1
	})
end

function slot0.ctor(slot0, slot1)
	slot0.planDirs = {
		uv0.Up,
		uv0.Back,
		uv0.Right,
		uv0.Left,
		uv0.Forward,
		uv0.Down
	}
	slot0.l = 1
	slot0.w = 1
	slot0.h = 2
	slot0.x = slot1.x + slot0.l / 2 - 0.5
	slot0.y = slot0.h / 2 - 1
	slot0.z = slot1.y + slot0.w / 2 - 0.5
	slot0.finalV3 = Vector3(slot0.x, slot0.y, slot0.z)
	slot0.curOper = nil
	slot0.nowTweenValue = 0
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.loader = PrefabInstantiate.Create(slot0.go)

	slot0.loader:startLoad("scenes/v2a2_m_s12_tsnn_jshd/prefab/v2a2_m_s12_tsnn_box_p.prefab", slot0.onLoadResEnd, slot0)

	slot0.trans = slot0.instGo.transform:GetChild(0)

	transformhelper.setLocalPos(slot0.trans, slot0.x, slot0.y, slot0.z)

	TianShiNaNaModel.instance.curPointList = {}
end

function slot0.onLoadResEnd(slot0)
	slot0.plans = slot0:getUserDataTb_()
	slot0.renderers = slot0:getUserDataTb_()
	slot0.hideRenderers = slot0:getUserDataTb_()
	slot0.instGo = slot0.loader:getInstGO()
	slot0.rootGo = slot0.instGo.transform:GetChild(0):GetChild(0).gameObject
	slot0.anim = slot0.instGo:GetComponent(typeof(UnityEngine.Animator))
	slot4 = "open1"

	slot0.anim:Play(slot4, 0, 1)

	for slot4 = 1, 6 do
		slot0.plans[slot4] = gohelper.findChild(slot0.rootGo, slot4)
		slot0.renderers[slot4] = slot0.plans[slot4]:GetComponent(typeof(UnityEngine.Renderer))
	end

	slot0:updateSortOrder()
end

function slot0.playOpenAnim(slot0, slot1)
	if slot1 == TianShiNaNaEnum.CubeType.Type1 then
		slot0.anim:Play("open1", 0, 0)
	else
		slot0.anim:Play("open2", 0, 0)
	end
end

function slot0.updateSortOrder(slot0)
	if not slot0.renderers then
		return
	end

	for slot4, slot5 in pairs(slot0.renderers) do
		if uv0[slot0.planDirs[slot4]] then
			slot5.sortingOrder = TianShiNaNaHelper.getSortIndex(slot0.x, slot0.z) - 1
		else
			slot5.sortingOrder = TianShiNaNaHelper.getSortIndex(slot0.x, slot0.z) + 1
		end
	end
end

function slot0.doCubeTween(slot0, slot1, slot2)
	slot3 = (slot1 == uv0.Left or slot1 == uv0.Right) and slot0.l or slot0.w
	slot0.finalV3.y = math.sqrt((slot3 / 2)^2 + (slot0.h / 2)^2 - (slot3 * Mathf.Clamp(slot2, 0, 0.5) + slot0.h * Mathf.Clamp(slot2 - 0.5, 0, 0.5) - slot3 / 2)^2)

	if slot1 == uv0.Left then
		slot0.finalV3.x = slot0.x - slot7
	elseif slot1 == uv0.Right then
		slot0.finalV3.x = slot0.x + slot7
	elseif slot1 == uv0.Forward then
		slot0.finalV3.z = slot0.z + slot7
	elseif slot1 == uv0.Back then
		slot0.finalV3.z = slot0.z - slot7
	end

	slot12 = TianShiNaNaHelper.lerpQ(uv1[slot0.planDirs[1]][slot0.planDirs[2]], uv1[slot0:getNextDir(slot1, slot0.planDirs[1])][slot0:getNextDir(slot1, slot0.planDirs[2])], (math.atan2(slot0.finalV3.y, slot2 > 0.5 and -slot6 or slot3 / 2 - slot5) - math.atan2(slot0.h, slot3)) / math.pi * 2)

	transformhelper.setLocalRotation2(slot0.trans, slot12.x, slot12.y, slot12.z, slot12.w)
	transformhelper.setLocalPos(slot0.trans, slot0.finalV3.x, slot0.finalV3.y - 1, slot0.finalV3.z)

	if slot2 > 0.5 then
		slot0:doRotate(slot1, true)
		slot0:updateSortOrder()
		slot0:doRotate(-slot1, true)
	else
		slot0:updateSortOrder()
	end
end

function slot0.getPlaneByIndex(slot0, slot1)
	return slot0.plans[slot1]
end

function slot0.setPlaneParent(slot0, slot1, slot2)
	slot0.renderers[slot1].sortingOrder = 1
	slot0.hideRenderers[slot1] = slot0.renderers[slot1]
	slot0.renderers[slot1] = nil

	slot0:getPlaneByIndex(slot1).transform:SetParent(slot2, true)
	tabletool.addValues(TianShiNaNaModel.instance.curPointList, slot0:getCurGrids())
	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.CubePointUpdate)
end

function slot0.revertPlane(slot0, slot1)
	slot2, slot3 = next(slot0.renderers)

	if not slot3 or not slot0.hideRenderers[slot1] then
		return
	end

	slot0.renderers[slot1] = slot0.hideRenderers[slot1]
	slot0.renderers[slot1].sortingOrder = slot3.sortingOrder
	slot0.hideRenderers[slot1] = nil
	slot9 = true

	slot0:getPlaneByIndex(slot1).transform:SetParent(slot0.rootGo.transform, slot9)

	slot5 = slot0:getCurGrids()

	for slot9 = #TianShiNaNaModel.instance.curPointList, 1, -1 do
		for slot14, slot15 in pairs(slot5) do
			if TianShiNaNaHelper.isPosSame(slot15, TianShiNaNaModel.instance.curPointList[slot9]) then
				table.remove(TianShiNaNaModel.instance.curPointList, slot9)

				break
			end
		end
	end

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.CubePointUpdate)
end

function slot0.hideOtherPlane(slot0)
	for slot4 in pairs(slot0.renderers) do
		gohelper.setActive(slot0:getPlaneByIndex(slot4), false)
	end
end

function slot0.doRotate(slot0, slot1, slot2)
	if slot1 == uv0.Left then
		slot0.x = slot0.x - slot0.l / 2 - slot0.h / 2
		slot0.h = slot0.l
		slot0.l = slot0.h
	elseif slot1 == uv0.Right then
		slot0.x = slot0.x + slot0.l / 2 + slot0.h / 2
		slot0.h = slot0.l
		slot0.l = slot0.h
	elseif slot1 == uv0.Forward then
		slot0.z = slot0.z + slot0.w / 2 + slot0.h / 2
		slot0.h = slot0.w
		slot0.w = slot0.h
	elseif slot1 == uv0.Back then
		slot0.z = slot0.z - slot0.w / 2 - slot0.h / 2
		slot0.h = slot0.w
		slot0.w = slot0.h
	end

	slot0.y = slot0.h / 2 - 1
	slot0.allPoint = nil

	if not slot2 then
		for slot6, slot7 in pairs(slot0.planDirs) do
			slot0.planDirs[slot6] = slot0:getNextDir(slot1, slot7)
		end

		slot0.finalV3:Set(slot0.x, slot0.y, slot0.z)
		transformhelper.setLocalPos(slot0.trans, slot0.finalV3.x, slot0.finalV3.y, slot0.finalV3.z)

		slot3 = uv1[slot0.planDirs[1]][slot0.planDirs[2]]

		transformhelper.setLocalRotation2(slot0.trans, slot3.x, slot3.y, slot3.z, slot3.w)
		slot0:updateSortOrder()
	end
end

function slot0.resetPos(slot0)
	slot0.finalV3:Set(slot0.x, slot0.y, slot0.z)
	transformhelper.setLocalPos(slot0.trans, slot0.finalV3.x, slot0.finalV3.y, slot0.finalV3.z)

	slot1 = uv0[slot0.planDirs[1]][slot0.planDirs[2]]

	transformhelper.setLocalRotation2(slot0.trans, slot1.x, slot1.y, slot1.z, slot1.w)
end

function slot0.getCurDownIndex(slot0)
	for slot4, slot5 in pairs(slot0.planDirs) do
		if slot5 == uv0.Down then
			return slot4
		end
	end

	return 1
end

function slot0.getDirByIndex(slot0, slot1)
	return slot0.planDirs[slot1] or uv0.Up
end

function slot0.getCurGrids(slot0)
	if slot0.allPoint then
		return slot0.allPoint
	end

	slot3 = Mathf.Round(slot0.z - slot0.w / 2)
	slot4 = Mathf.Round(slot0.z + slot0.w / 2)
	slot5 = {}

	for slot9 = Mathf.Round(slot0.x - slot0.l / 2), Mathf.Round(slot0.x + slot0.l / 2) - 1 do
		for slot13 = slot3, slot4 - 1 do
			table.insert(slot5, {
				x = slot9,
				y = slot13
			})
		end
	end

	slot0.allPoint = slot5

	return slot5
end

function slot0.getOperGrids(slot0, slot1)
	slot0:doRotate(slot1, true)
	slot0:doRotate(-slot1, true)

	return slot0:getCurGrids()
end

function slot0.getOperDownIndex(slot0, slot1)
	for slot5, slot6 in pairs(slot0.planDirs) do
		if slot0:getNextDir(slot1, slot6) == uv0.Down then
			return slot5
		end
	end

	return 1
end

function slot0.getNextDir(slot0, slot1, slot2)
	slot3 = uv0[slot1]

	if not slot1 then
		return slot2
	end

	return slot3[slot2] or slot2
end

function slot0.onDestroy(slot0)
	for slot4 = 1, 6 do
		gohelper.destroy(slot0.plans[slot4])
	end

	if slot0.loader then
		slot0.loader:dispose()

		slot0.loader = nil
	end
end

return slot0
