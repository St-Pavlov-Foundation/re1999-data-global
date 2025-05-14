module("modules.common.res.ResDispose", package.seeall)

local var_0_0 = _M
local var_0_1 = 4
local var_0_2 = {}

function var_0_0.dispose()
	var_0_2 = {}
end

function var_0_0.open()
	TaskDispatcher.runRepeat(var_0_0._loop, nil, var_0_1)
end

function var_0_0.close()
	TaskDispatcher.cancelTask(var_0_0._loop, nil)
end

function var_0_0.unloadTrue()
	local var_4_0 = ResMgr.getAssetPool()

	var_0_2 = {}

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		if iter_4_1:canRelease() then
			table.insert(var_0_2, iter_4_1)
		end
	end

	for iter_4_2, iter_4_3 in ipairs(var_0_2) do
		iter_4_3:tryDispose()
	end
end

function var_0_0._loop()
	local var_5_0 = ResMgr.getAssetPool()

	var_0_2 = {}

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		if iter_5_1:canRelease() then
			table.insert(var_0_2, iter_5_1)
		end
	end

	for iter_5_2, iter_5_3 in ipairs(var_0_2) do
		iter_5_3:tryDispose()
	end
end

return var_0_0
