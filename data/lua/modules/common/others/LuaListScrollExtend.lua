module("modules.common.others.LuaListScrollExtend", package.seeall)

local var_0_0 = class("LuaListScrollExtend", LuaListScrollView)

function var_0_0.onUpdateFinish(arg_1_0)
	for iter_1_0, iter_1_1 in pairs(arg_1_0._cellCompDict) do
		iter_1_0.parent_view = arg_1_0

		if iter_1_0.initDone then
			iter_1_0:initDone()
		end
	end

	arg_1_0.isInitDone = true
end

return var_0_0
