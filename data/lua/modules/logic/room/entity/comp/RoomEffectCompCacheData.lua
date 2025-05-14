module("modules.logic.room.entity.comp.RoomEffectCompCacheData", package.seeall)

local var_0_0 = class("RoomEffectCompCacheData")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.effectComp = arg_1_1
	arg_1_0._cacheDataDic = {}
end

function var_0_0.getUserDataTb_(arg_2_0)
	return arg_2_0.effectComp:getUserDataTb_()
end

function var_0_0.addDataByKey(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_0._cacheDataDic
	local var_3_1 = var_3_0[arg_3_2]

	if not var_3_1 then
		var_3_1 = {}
		var_3_0[arg_3_2] = var_3_1
	end

	var_3_1[arg_3_1] = arg_3_3
end

function var_0_0.getDataByKey(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0._cacheDataDic[arg_4_2]

	if var_4_0 then
		return var_4_0[arg_4_1]
	end
end

function var_0_0.removeDataByKey(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._cacheDataDic

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		local var_5_1 = iter_5_1[arg_5_1]

		if var_5_1 then
			arg_5_0:_removeData(var_5_1)
			rawset(iter_5_1, arg_5_1, nil)
		end
	end
end

function var_0_0._removeData(arg_6_0, arg_6_1)
	if arg_6_1 and type(arg_6_1) == "table" then
		for iter_6_0 in pairs(arg_6_1) do
			rawset(arg_6_1, iter_6_0, nil)
		end
	end
end

function var_0_0.dispose(arg_7_0)
	local var_7_0 = arg_7_0._cacheDataDic

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		for iter_7_2, iter_7_3 in pairs(iter_7_1) do
			if iter_7_3 then
				rawset(iter_7_1, iter_7_2, nil)
				arg_7_0:_removeData(iter_7_3)
			end
		end

		var_7_0[iter_7_0] = nil
	end
end

return var_0_0
