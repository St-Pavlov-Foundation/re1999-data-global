module("modules.logic.fight.fightcomponent.FightLoaderList", package.seeall)

local var_0_0 = class("FightLoaderList", FightBaseClass)

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.urlList = arg_1_1
	arg_1_0.oneCallback = arg_1_2
	arg_1_0.finishCallback = arg_1_3
	arg_1_0.handle = arg_1_4
	arg_1_0.paramList = arg_1_5 or {}
	arg_1_0.count = 0
	arg_1_0.urlDic = {}
end

function var_0_0.startLoad(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.urlList) do
		local var_2_0 = arg_2_0:newClass(FightLoaderItem, iter_2_1, arg_2_0.onOneLoadCallback, arg_2_0, arg_2_0.paramList[iter_2_0])

		arg_2_0.urlDic[iter_2_1] = var_2_0

		var_2_0:startLoad()
	end
end

function var_0_0.onOneLoadCallback(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_0.oneCallback then
		arg_3_0.oneCallback(arg_3_0.handle, arg_3_1, arg_3_2, arg_3_3)
	end

	arg_3_0.count = arg_3_0.count + 1

	if arg_3_0.count == #arg_3_0.urlList and arg_3_0.finishCallback then
		arg_3_0.finishCallback(arg_3_0.handle, arg_3_0)
	end
end

function var_0_0.getAssetItem(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.urlDic[arg_4_1]

	if var_4_0 then
		return var_4_0.assetItem
	end
end

function var_0_0.onDestructor(arg_5_0)
	return
end

return var_0_0
