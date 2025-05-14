module("modules.logic.explore.map.unit.comp.ExploreUnitClickComp", package.seeall)

local var_0_0 = class("ExploreUnitClickComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.unit = arg_1_1
	arg_1_0.enable = true
end

function var_0_0.setup(arg_2_0, arg_2_1)
	arg_2_0.colliderList = arg_2_1:GetComponentsInChildren(typeof(UnityEngine.Collider))

	if arg_2_0.colliderList == nil or arg_2_0.colliderList.Length == 0 then
		return
	end

	for iter_2_0 = 0, arg_2_0.colliderList.Length - 1 do
		local var_2_0 = arg_2_0.colliderList[iter_2_0]

		tolua.setpeer(var_2_0, arg_2_0)

		var_2_0.enabled = arg_2_0.enable
	end
end

function var_0_0.click(arg_3_0)
	if not arg_3_0.enable then
		return false
	end

	if arg_3_0.unit.mo.triggerByClick then
		ExploreController.instance:dispatchEvent(ExploreEvent.OnClickUnit, arg_3_0.unit.mo)
	end

	return arg_3_0.unit.mo.triggerByClick
end

function var_0_0.setEnable(arg_4_0, arg_4_1)
	arg_4_0.enable = arg_4_1

	if arg_4_0.colliderList then
		for iter_4_0 = 0, arg_4_0.colliderList.Length - 1 do
			arg_4_0.colliderList[iter_4_0].enabled = arg_4_1
		end
	end
end

function var_0_0.beforeDestroy(arg_5_0)
	return
end

function var_0_0.clear(arg_6_0)
	if arg_6_0.colliderList then
		for iter_6_0 = 0, arg_6_0.colliderList.Length - 1 do
			tolua.setpeer(arg_6_0.colliderList[iter_6_0], nil)
		end
	end

	arg_6_0.colliderList = nil
end

function var_0_0.onDestroy(arg_7_0)
	arg_7_0:clear()
end

return var_0_0
