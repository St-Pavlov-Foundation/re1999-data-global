module("modules.logic.versionactivity2_2.tianshinana.entity.TianShiNaNaNodeEntity", package.seeall)

slot0 = class("TianShiNaNaNodeEntity", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
end

function slot0.updateCo(slot0, slot1)
	PrefabInstantiate.Create(slot0.go):startLoad(slot1.nodePath)

	slot3 = TianShiNaNaHelper.nodeToV3(TianShiNaNaHelper.getV2(slot1.x, slot1.y))

	transformhelper.setLocalPos(slot0.go.transform, slot3.x, slot3.y, slot3.z)
end

function slot0.dispose(slot0)
	gohelper.destroy(slot0.go)
end

return slot0
