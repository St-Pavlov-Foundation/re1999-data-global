module("modules.logic.room.entity.pool.RoomUIPool", package.seeall)

local var_0_0 = _M
local var_0_1 = false
local var_0_2
local var_0_3
local var_0_4 = {}
local var_0_5 = {}
local var_0_6 = {}
local var_0_7 = {}
local var_0_8

function var_0_0.init(arg_1_0)
	var_0_0._reset()

	var_0_8 = arg_1_0
	var_0_1 = true

	TaskDispatcher.runRepeat(var_0_0._onTickSortSibling, nil, 2)
end

function var_0_0.getInstance(arg_2_0, arg_2_1)
	if not var_0_1 then
		return
	end

	local var_2_0 = var_0_8[arg_2_0] or GameSceneMgr.instance:getCurScene().preloader:getResource(arg_2_0)

	if not var_2_0 then
		logError(string.format("找不到资源:%s", arg_2_0))

		return
	end

	local var_2_1 = var_0_4[arg_2_0]

	if not var_2_1 then
		var_2_1 = {}
		var_0_4[arg_2_0] = var_2_1
	end

	local var_2_2 = var_0_5[arg_2_0]

	if not var_2_2 then
		var_2_2 = {}
		var_0_5[arg_2_0] = var_2_2
	end

	local var_2_3

	if #var_2_1 > 0 then
		var_2_3 = var_2_1[#var_2_1]

		gohelper.addChild(var_0_0.getInstanceContainerGO(), var_2_3)

		var_2_3.name = arg_2_1 or "ui"

		table.remove(var_2_1, #var_2_1)
	else
		var_2_3 = gohelper.clone(var_2_0, var_0_0.getInstanceContainerGO(), arg_2_1 or "ui")
	end

	table.insert(var_2_2, var_2_3)
	table.insert(var_0_6, var_2_3)
	transformhelper.setLocalScale(var_2_3.transform, 0.01, 0.01, 0.01)

	return var_2_3
end

function var_0_0.returnInstance(arg_3_0, arg_3_1)
	if not var_0_1 then
		return
	end

	local var_3_0 = var_0_4[arg_3_0]

	if not var_3_0 then
		var_3_0 = {}
		var_0_4[arg_3_0] = var_3_0
	end

	local var_3_1 = var_0_5[arg_3_0]

	if not var_3_1 then
		var_3_1 = {}
		var_0_5[arg_3_0] = var_3_1
	end

	gohelper.addChild(var_0_0.getPoolContainerGO(), arg_3_1)

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		if iter_3_1 == arg_3_1 then
			table.remove(var_3_1, iter_3_0)

			break
		end
	end

	tabletool.removeValue(var_0_6, arg_3_1)
	table.insert(var_3_0, arg_3_1)
end

function var_0_0.dispose()
	var_0_1 = false

	for iter_4_0, iter_4_1 in pairs(var_0_5) do
		for iter_4_2, iter_4_3 in ipairs(iter_4_1) do
			gohelper.destroy(iter_4_3)
		end
	end

	for iter_4_4, iter_4_5 in pairs(var_0_4) do
		for iter_4_6, iter_4_7 in ipairs(iter_4_5) do
			gohelper.destroy(iter_4_7)
		end
	end

	var_0_0._reset()
	TaskDispatcher.cancelTask(var_0_0._onTickSortSibling, nil)
end

function var_0_0._reset()
	var_0_1 = false
	var_0_2 = nil
	var_0_3 = nil
	var_0_4 = {}
	var_0_5 = {}

	for iter_5_0, iter_5_1 in pairs(var_0_6) do
		var_0_6[iter_5_0] = nil
	end

	for iter_5_2, iter_5_3 in pairs(var_0_7) do
		var_0_7[iter_5_2] = nil
	end

	var_0_6 = {}
	var_0_7 = {}
end

function var_0_0.getPoolContainerGO()
	if not var_0_2 then
		local var_6_0 = GameSceneMgr.instance:getCurScene()

		var_0_2 = gohelper.findChild(var_6_0.go.canvasGO, "uipoolcontainer")

		gohelper.setActive(var_0_2, false)
	end

	return var_0_2
end

function var_0_0.getInstanceContainerGO()
	if not var_0_3 then
		local var_7_0 = GameSceneMgr.instance:getCurScene()

		var_0_3 = gohelper.findChild(var_7_0.go.canvasGO, "uiinstancecontainer")
	end

	return var_0_3
end

function var_0_0._onTickSortSibling()
	if #var_0_6 <= 1 then
		return
	end

	local var_8_0, var_8_1, var_8_2 = transformhelper.getPos(CameraMgr.instance:getMainCameraTrs())

	for iter_8_0, iter_8_1 in ipairs(var_0_6) do
		local var_8_3, var_8_4, var_8_5 = transformhelper.getPos(iter_8_1.transform)
		local var_8_6 = var_8_0 - var_8_3
		local var_8_7 = var_8_1 - var_8_4
		local var_8_8 = var_8_2 - var_8_5
		local var_8_9 = var_8_6 * var_8_6 + var_8_7 * var_8_7 + var_8_8 * var_8_8

		var_0_7[iter_8_1] = var_8_9
	end

	table.sort(var_0_6, var_0_0._sortByDistance)

	for iter_8_2, iter_8_3 in ipairs(var_0_6) do
		gohelper.setSibling(iter_8_3, iter_8_2 - 1)
	end
end

function var_0_0._sortByDistance(arg_9_0, arg_9_1)
	return var_0_7[arg_9_0] > var_0_7[arg_9_1]
end

return var_0_0
