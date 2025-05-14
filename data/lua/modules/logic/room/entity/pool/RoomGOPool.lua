module("modules.logic.room.entity.pool.RoomGOPool", package.seeall)

local var_0_0 = _M
local var_0_1 = false
local var_0_2
local var_0_3
local var_0_4 = {}
local var_0_5 = {}
local var_0_6 = {}
local var_0_7

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0._reset()

	var_0_2 = arg_1_0
	var_0_7 = arg_1_1
	var_0_1 = true
end

function var_0_0.addPrefab(arg_2_0, arg_2_1, arg_2_2)
	if var_0_2 then
		var_0_2[arg_2_0] = arg_2_1
		var_0_7[arg_2_0] = arg_2_2
	end
end

function var_0_0.getInstance(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not var_0_1 then
		return
	end

	local var_3_0 = var_0_2[arg_3_0] or GameSceneMgr.instance:getCurScene().preloader:getResource(arg_3_0, arg_3_3)

	if not var_3_0 then
		logError(string.format("找不到资源: %s", arg_3_0))

		return
	end

	if not var_0_6[arg_3_0] then
		var_0_6[arg_3_0] = arg_3_3 or arg_3_0
	end

	local var_3_1 = var_0_4[arg_3_0]

	if not var_3_1 then
		var_3_1 = {}
		var_0_4[arg_3_0] = var_3_1
	end

	local var_3_2 = var_0_5[arg_3_0]

	if not var_3_2 then
		var_3_2 = {}
		var_0_5[arg_3_0] = var_3_2
	end

	local var_3_3

	if #var_3_1 > 0 then
		var_3_3 = var_3_1[#var_3_1]

		gohelper.addChild(arg_3_1, var_3_3)

		var_3_3.name = arg_3_2 or "instance"

		table.remove(var_3_1, #var_3_1)
	else
		var_3_3 = gohelper.clone(var_3_0, arg_3_1, arg_3_2 or "instance")
	end

	table.insert(var_3_2, var_3_3)

	return var_3_3
end

function var_0_0.returnInstance(arg_4_0, arg_4_1)
	if not var_0_1 then
		return
	end

	local var_4_0 = var_0_4[arg_4_0]

	if not var_4_0 then
		var_4_0 = {}
		var_0_4[arg_4_0] = var_4_0
	end

	local var_4_1 = var_0_5[arg_4_0]

	if not var_4_1 then
		var_4_1 = {}
		var_0_5[arg_4_0] = var_4_1
	end

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		if iter_4_1 == arg_4_1 then
			table.remove(var_4_1, iter_4_0)

			break
		end
	end

	if var_0_7[arg_4_0] and var_0_7[arg_4_0] >= 0 and var_0_7[arg_4_0] <= #var_4_0 then
		gohelper.addChild(var_0_0.getPoolContainerGO(), arg_4_1)
		gohelper.destroy(arg_4_1)
	else
		gohelper.addChild(var_0_0.getPoolContainerGO(), arg_4_1)
		table.insert(var_4_0, arg_4_1)
	end
end

function var_0_0.clearPool()
	local var_5_0 = var_0_4

	var_0_4 = {}

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
			gohelper.destroy(iter_5_3)
		end
	end
end

function var_0_0.existABPath(arg_6_0)
	local var_6_0

	for iter_6_0, iter_6_1 in pairs(var_0_6) do
		if iter_6_1 == arg_6_0 then
			var_6_0 = false

			if var_0_0.existResPath(iter_6_0) == true then
				return true
			end
		end
	end

	return var_6_0
end

function var_0_0.existResPath(arg_7_0)
	local var_7_0 = var_0_4[arg_7_0]

	if var_7_0 and #var_7_0 > 0 then
		return true
	end

	local var_7_1 = var_0_5[arg_7_0]

	if var_7_1 and #var_7_1 > 0 then
		return true
	end

	return false
end

function var_0_0.dispose()
	var_0_1 = false

	for iter_8_0, iter_8_1 in pairs(var_0_5) do
		for iter_8_2, iter_8_3 in ipairs(iter_8_1) do
			gohelper.destroy(iter_8_3)
		end
	end

	for iter_8_4, iter_8_5 in pairs(var_0_4) do
		for iter_8_6, iter_8_7 in ipairs(iter_8_5) do
			gohelper.destroy(iter_8_7)
		end
	end

	var_0_0._reset()
end

function var_0_0._reset()
	var_0_1 = false
	var_0_2 = nil
	var_0_3 = nil
	var_0_4 = {}
	var_0_5 = {}
	var_0_6 = {}
end

function var_0_0.getPoolContainerGO()
	if not var_0_3 then
		var_0_3 = GameSceneMgr.instance:getCurScene().go.poolContainerGO

		gohelper.setActive(var_0_3, false)
	end

	return var_0_3
end

return var_0_0
