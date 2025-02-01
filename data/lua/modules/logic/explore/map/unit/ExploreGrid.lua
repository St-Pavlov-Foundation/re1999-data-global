module("modules.logic.explore.map.unit.ExploreGrid", package.seeall)

slot0 = class("ExploreGrid", ExploreBaseUnit)

function slot0.onInit(slot0)
	slot0._resLoader = PrefabInstantiate.Create(slot0.go)

	slot0._resLoader:startLoad("explore/prefabs/unit/m_s10_dynamic_ground_01.prefab")
end

function slot0.setName(slot0, slot1)
	slot0.go.name = slot1
end

function slot0.setPos(slot0, slot1)
	if gohelper.isNil(slot0.go) == false then
		slot1.y = 10
		slot2, slot3 = UnityEngine.Physics.Raycast(slot1, Vector3.down, nil, Mathf.Infinity, ExploreHelper.getNavigateMask())

		if slot2 then
			slot1.y = slot3.point.y
		else
			slot1.y = slot0.trans.position.y
		end

		slot0.position = slot1

		transformhelper.setPos(slot0.trans, slot0.position.x, slot0.position.y, slot0.position.z)

		if ExploreHelper.posToTile(slot1) ~= slot0.nodePos then
			slot5 = slot0.nodePos
			slot0.nodePos = slot4
			slot0.nodeMO = ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot0.nodePos))
		end
	end
end

return slot0
