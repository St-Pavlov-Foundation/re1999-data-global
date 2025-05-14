module("modules.logic.explore.map.unit.ExploreGrid", package.seeall)

local var_0_0 = class("ExploreGrid", ExploreBaseUnit)

function var_0_0.onInit(arg_1_0)
	arg_1_0._resLoader = PrefabInstantiate.Create(arg_1_0.go)

	arg_1_0._resLoader:startLoad("explore/prefabs/unit/m_s10_dynamic_ground_01.prefab")
end

function var_0_0.setName(arg_2_0, arg_2_1)
	arg_2_0.go.name = arg_2_1
end

function var_0_0.setPos(arg_3_0, arg_3_1)
	if gohelper.isNil(arg_3_0.go) == false then
		arg_3_1.y = 10

		local var_3_0, var_3_1 = UnityEngine.Physics.Raycast(arg_3_1, Vector3.down, nil, Mathf.Infinity, ExploreHelper.getNavigateMask())

		if var_3_0 then
			arg_3_1.y = var_3_1.point.y
		else
			arg_3_1.y = arg_3_0.trans.position.y
		end

		arg_3_0.position = arg_3_1

		transformhelper.setPos(arg_3_0.trans, arg_3_0.position.x, arg_3_0.position.y, arg_3_0.position.z)

		local var_3_2 = ExploreHelper.posToTile(arg_3_1)

		if var_3_2 ~= arg_3_0.nodePos then
			local var_3_3 = arg_3_0.nodePos

			arg_3_0.nodePos = var_3_2
			arg_3_0.nodeMO = ExploreMapModel.instance:getNode(ExploreHelper.getKey(arg_3_0.nodePos))
		end
	end
end

return var_0_0
