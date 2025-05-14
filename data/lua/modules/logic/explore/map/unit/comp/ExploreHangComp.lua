module("modules.logic.explore.map.unit.comp.ExploreHangComp", package.seeall)

local var_0_0 = class("ExploreHangComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.unit = arg_1_1
	arg_1_0.hangList = {}
end

function var_0_0.setup(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1

	for iter_2_0, iter_2_1 in pairs(arg_2_0.hangList) do
		arg_2_0:addHang(iter_2_0, iter_2_1)
	end
end

function var_0_0.addHang(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.hangList[arg_3_1] = arg_3_2

	if arg_3_0.go then
		local var_3_0 = gohelper.findChild(arg_3_0.go, arg_3_1)

		if var_3_0 then
			local var_3_1 = PrefabInstantiate.Create(var_3_0)

			if var_3_1:getPath() ~= arg_3_2 then
				var_3_1:startLoad(arg_3_2)
			end
		end
	end
end

function var_0_0.clear(arg_4_0)
	arg_4_0.go = nil
end

return var_0_0
