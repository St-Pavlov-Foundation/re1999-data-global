module("framework.luamono.LuaMonoContainer", package.seeall)

local var_0_0 = class("LuaMonoContainer")
local var_0_1 = {}

function var_0_0.tryDispose()
	for iter_1_0, iter_1_1 in pairs(var_0_1) do
		if gohelper.isNil(iter_1_0._go) then
			if isDebugBuild then
				logWarn("保底 destory: " .. iter_1_0._path)
			end

			callWithCatch(iter_1_0.__onDispose, iter_1_0)
		end
	end
end

function var_0_0.__onDispose(arg_2_0)
	if not var_0_1[arg_2_0] then
		return
	end

	var_0_1[arg_2_0] = nil

	if not arg_2_0._luaMonoList then
		return
	end

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._luaMonoList) do
		iter_2_1:__onDispose()
	end

	arg_2_0._monoCom = nil
	arg_2_0._go = nil
	arg_2_0._luaMonoList = nil
	arg_2_0._tempList = nil
	arg_2_0._hasStarted = false
	arg_2_0._compDirty = true
end

function var_0_0.ctor(arg_3_0, arg_3_1)
	arg_3_0._monoCom = arg_3_1
	arg_3_0._go = arg_3_1.gameObject
	arg_3_0._luaMonoList = {}
	arg_3_0._compNames = {}
	arg_3_0._hasStarted = false
	arg_3_0._compDirty = true

	if isDebugBuild then
		arg_3_0._path = SLFramework.GameObjectHelper.GetPath(arg_3_0._go)
	end

	var_0_1[arg_3_0] = true
end

function var_0_0.getCompNames(arg_4_0)
	return arg_4_0._compNames
end

function var_0_0.addCompOnce(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:getComp(arg_5_1)

	if var_5_0 ~= nil then
		return var_5_0
	end

	local var_5_1 = arg_5_1.New(arg_5_2)

	var_5_1:__onInit()
	var_5_1:init(arg_5_0._go)

	if arg_5_0._hasStarted then
		if var_5_1.onEnable and arg_5_0._monoCom:IsEnabled() then
			var_5_1:onEnable()
		end

		if var_5_1.onStart then
			var_5_1:onStart()
		end

		var_5_1:addEventListeners()
	end

	arg_5_0._compDirty = true

	table.insert(arg_5_0._luaMonoList, var_5_1)
	table.insert(arg_5_0._compNames, var_5_1.__cname)

	return var_5_1
end

function var_0_0.removeComp(arg_6_0, arg_6_1)
	local var_6_0 = #arg_6_0._luaMonoList
	local var_6_1

	for iter_6_0 = var_6_0, 1, -1 do
		local var_6_2 = arg_6_0._luaMonoList[iter_6_0]

		if arg_6_1 == var_6_2 then
			arg_6_0._compDirty = true

			table.remove(arg_6_0._luaMonoList, iter_6_0)
			table.remove(arg_6_0._compNames, iter_6_0)
			arg_6_0:_onRemove(var_6_2)

			break
		end
	end
end

function var_0_0.removeCompByDefine(arg_7_0, arg_7_1)
	local var_7_0 = #arg_7_0._luaMonoList
	local var_7_1

	for iter_7_0 = var_7_0, 1, -1 do
		local var_7_2 = arg_7_0._luaMonoList[iter_7_0]

		if isTypeOf(var_7_2, arg_7_1) then
			arg_7_0._compDirty = true

			table.remove(arg_7_0._luaMonoList, iter_7_0)
			table.remove(arg_7_0._compNames, iter_7_0)
			arg_7_0:_onRemove(var_7_2)

			break
		end
	end
end

function var_0_0._onRemove(arg_8_0, arg_8_1)
	if arg_8_1.onDisable then
		arg_8_1:onDisable()
	end

	if arg_8_1.removeEventListeners then
		arg_8_1:removeEventListeners()
	end

	if arg_8_1.onDestroy then
		arg_8_1:onDestroy()
	end

	arg_8_1:__onDispose()
end

function var_0_0.getComp(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._luaMonoList) do
		if isTypeOf(iter_9_1, arg_9_1) then
			return iter_9_1
		end
	end

	return nil
end

function var_0_0.onEnable(arg_10_0)
	local var_10_0 = arg_10_0:_getCompListTemp()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if iter_10_1.onEnable then
			iter_10_1:onEnable()
		end
	end

	local var_10_1
end

function var_0_0.onDisable(arg_11_0)
	local var_11_0 = arg_11_0:_getCompListTemp()

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if iter_11_1.onDisable then
			iter_11_1:onDisable()
		end
	end

	local var_11_1
end

function var_0_0.onStart(arg_12_0)
	arg_12_0._hasStarted = true

	local var_12_0 = arg_12_0:_getCompListTemp()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if iter_12_1.onStart then
			iter_12_1:onStart()
		end

		if iter_12_1.addEventListeners then
			iter_12_1:addEventListeners()
		end
	end

	local var_12_1
end

function var_0_0.onUpdate(arg_13_0)
	local var_13_0 = arg_13_0:_getCompListTemp()

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		if iter_13_1.onUpdate then
			iter_13_1:onUpdate()
		end
	end

	local var_13_1
end

function var_0_0.onDestroy(arg_14_0)
	if not var_0_1[arg_14_0] then
		return
	end

	var_0_1[arg_14_0] = nil

	local var_14_0 = arg_14_0:_getCompListTemp()

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		arg_14_0:_onRemove(iter_14_1)
	end

	local var_14_1

	arg_14_0._monoCom = nil
	arg_14_0._go = nil
	arg_14_0._luaMonoList = nil
	arg_14_0._tempList = nil
	arg_14_0._hasStarted = false
	arg_14_0._compDirty = true
end

function var_0_0.onTriggerEnter(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:_getCompListTemp()

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if iter_15_1.onTriggerEnter then
			iter_15_1:onTriggerEnter(arg_15_1)
		end
	end

	local var_15_1
end

function var_0_0.onTriggerExit(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:_getCompListTemp()

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if iter_16_1.onTriggerExit then
			iter_16_1:onTriggerExit(arg_16_1)
		end
	end

	local var_16_1
end

function var_0_0._getCompListTemp(arg_17_0)
	if arg_17_0._compDirty then
		arg_17_0._tempList = arg_17_0._tempList or {}

		for iter_17_0, iter_17_1 in ipairs(arg_17_0._luaMonoList) do
			arg_17_0._tempList[iter_17_0] = iter_17_1
		end

		for iter_17_2 = #arg_17_0._luaMonoList + 1, #arg_17_0._tempList do
			arg_17_0._tempList[iter_17_2] = nil
		end

		arg_17_0._compDirty = false
	end

	return arg_17_0._tempList
end

return var_0_0
