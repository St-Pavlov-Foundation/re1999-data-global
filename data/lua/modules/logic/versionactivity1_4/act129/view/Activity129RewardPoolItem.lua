module("modules.logic.versionactivity1_4.act129.view.Activity129RewardPoolItem", package.seeall)

local var_0_0 = class("Activity129RewardPoolItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.goItem = arg_1_1.goItem
	arg_1_0.itemList = arg_1_1.itemList
	arg_1_0.rare = arg_1_1.rare
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.goGrid = gohelper.findChild(arg_2_0.go, "Grid")
end

function var_0_0.setDict(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_1 then
		gohelper.setActive(arg_3_0.go, false)

		return
	end

	arg_3_0.actId = arg_3_2
	arg_3_0.poolId = arg_3_3
	arg_3_0.isNull = true
	arg_3_0.count = 0

	local var_3_0 = 1

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		for iter_3_2, iter_3_3 in ipairs(iter_3_1) do
			arg_3_0:tryAddReward(iter_3_3, iter_3_0, var_3_0)

			var_3_0 = var_3_0 + 1
		end
	end

	gohelper.setActive(arg_3_0.go, not arg_3_0.isNull)
	arg_3_0:caleHeight()
end

function var_0_0.caleHeight(arg_4_0)
	local var_4_0 = math.ceil(arg_4_0.count / 4) * 200 + 75

	recthelper.setHeight(arg_4_0.go.transform, var_4_0)
end

function var_0_0.tryAddReward(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_0.rare ~= arg_5_2 then
		return
	end

	local var_5_0 = arg_5_0.itemList[arg_5_3] or arg_5_0:createReward(arg_5_3)

	gohelper.addChild(arg_5_0.goGrid, var_5_0.go)
	var_5_0:setData(arg_5_1, arg_5_0.actId, arg_5_0.poolId, arg_5_2)

	arg_5_0.isNull = false
	arg_5_0.count = arg_5_0.count + 1
end

function var_0_0.createReward(arg_6_0, arg_6_1)
	local var_6_0 = gohelper.clone(arg_6_0.goItem, arg_6_0.goGrid)
	local var_6_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_0, Activity129RewardItem)

	arg_6_0.itemList[arg_6_1] = var_6_1

	return var_6_1
end

function var_0_0.onDestroy(arg_7_0)
	return
end

return var_0_0
