module("modules.logic.summon.pool.SummonEffectPool", package.seeall)

local var_0_0 = _M
local var_0_1 = 1
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = {}
local var_0_6
local var_0_7

function var_0_0.onEffectPreload(arg_1_0)
	arg_1_0:Retain()
	table.insert(var_0_2, arg_1_0)

	var_0_3[arg_1_0.ResPath] = arg_1_0

	var_0_0.returnEffect(var_0_0.getEffect(arg_1_0.ResPath))
end

function var_0_0.dispose()
	for iter_2_0, iter_2_1 in pairs(var_0_2) do
		iter_2_1:Release()
	end

	for iter_2_2, iter_2_3 in pairs(var_0_4) do
		for iter_2_4, iter_2_5 in ipairs(iter_2_3) do
			iter_2_5:markCanDestroy()
			gohelper.destroy(iter_2_5.containerGO)
		end
	end

	for iter_2_6, iter_2_7 in pairs(var_0_5) do
		iter_2_7:markCanDestroy()
		gohelper.destroy(iter_2_7.containerGO)
	end

	var_0_2 = {}
	var_0_3 = {}
	var_0_4 = {}
	var_0_5 = {}

	gohelper.destroy(var_0_6)

	var_0_6 = nil
	var_0_7 = nil
	var_0_1 = 1
end

function var_0_0.getEffect(arg_3_0, arg_3_1)
	local var_3_0 = var_0_3[arg_3_0]
	local var_3_1 = var_0_0.getPoolContainerGO()
	local var_3_2

	if var_3_0 then
		local var_3_3 = var_0_4[arg_3_0]

		if var_3_3 and #var_3_3 > 0 then
			local var_3_4 = #var_3_3

			for iter_3_0, iter_3_1 in ipairs(var_3_3) do
				if arg_3_1 == nil and iter_3_1.hangPointGO == var_3_1 or arg_3_1 ~= nil and iter_3_1.hangPointGO == arg_3_1 then
					var_3_4 = iter_3_0

					break
				end
			end

			var_3_2 = table.remove(var_3_3, var_3_4)
		else
			var_3_2 = var_0_0._createWrap(arg_3_0)

			var_0_0._instantiateEffectGO(var_3_0, var_3_2)
		end

		var_3_2:setHangPointGO(arg_3_1 or var_3_1)
	else
		logError("Summon Effect need preload: " .. arg_3_0)

		return nil
	end

	var_0_5[var_3_2.uniqueId] = var_3_2

	var_3_2:setActive(true)

	return var_3_2
end

function var_0_0.returnEffect(arg_4_0)
	if gohelper.isNil(arg_4_0.containerGO) then
		return
	end

	arg_4_0:stop()
	arg_4_0:unloadIcon()
	arg_4_0:setActive(false)

	var_0_5[arg_4_0.uniqueId] = nil

	local var_4_0 = var_0_4[arg_4_0.path]

	if not var_4_0 then
		var_4_0 = {}
		var_0_4[arg_4_0.path] = var_4_0
	end

	table.insert(var_4_0, arg_4_0)
end

function var_0_0.returnEffectToPoolContainer(arg_5_0)
	arg_5_0:setHangPointGO(var_0_0.getPoolContainerGO())
end

function var_0_0.getPoolContainerGO()
	if not var_0_6 then
		local var_6_0 = VirtualSummonScene.instance:getRootGO()

		var_0_6 = gohelper.create3d(var_6_0, "EffectPool")
		var_0_7 = var_0_6.transform
	end

	return var_0_6
end

function var_0_0._instantiateEffectGO(arg_7_0, arg_7_1)
	local var_7_0 = gohelper.clone(arg_7_0:GetResource(), arg_7_1.containerGO)

	arg_7_1:setEffectGO(var_7_0)
end

function var_0_0._createWrap(arg_8_0)
	local var_8_0 = string.split(arg_8_0, "/")
	local var_8_1 = var_8_0[#var_8_0]
	local var_8_2 = gohelper.create3d(var_0_0.getPoolContainerGO(), var_8_1)
	local var_8_3 = MonoHelper.addLuaComOnceToGo(var_8_2, SummonEffectWrap)

	var_8_3:setUniqueId(var_0_1)
	var_8_3:setPath(arg_8_0)

	var_0_1 = var_0_1 + 1

	return var_8_3
end

return var_0_0
