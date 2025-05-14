module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.TeamChessEffectPool", package.seeall)

local var_0_0 = class("TeamChessEffectPool")
local var_0_1 = 1
local var_0_2 = {}
local var_0_3 = 10
local var_0_4

function var_0_0.dispose()
	if var_0_2 ~= nil then
		for iter_1_0, iter_1_1 in pairs(var_0_2) do
			iter_1_1:dispose()
		end

		var_0_2 = {}
	end
end

function var_0_0.getEffect(arg_2_0, arg_2_1, arg_2_2)
	if var_0_2 == nil then
		var_0_2 = {}
	end

	local var_2_0 = var_0_2[arg_2_0]

	if var_2_0 == nil then
		var_2_0 = LuaObjPool.New(var_0_3, function()
			return (var_0_0._createWrap(arg_2_0))
		end, function(arg_4_0)
			if arg_4_0 ~= nil then
				arg_4_0:onDestroy()
			end
		end, function(arg_5_0)
			if arg_5_0 ~= nil then
				arg_5_0:clear()
			end
		end)
		var_0_2[arg_2_0] = var_2_0
	end

	local var_2_1 = var_2_0:getObject()

	if var_2_1 == nil then
		var_2_1 = var_0_0._createWrap(arg_2_0)
	end

	var_2_1:setCallback(arg_2_1, arg_2_2)

	return var_2_1
end

function var_0_0.returnEffect(arg_6_0)
	if arg_6_0 == nil then
		return
	end

	local var_6_0 = var_0_2[arg_6_0.effectType]

	if var_6_0 ~= nil then
		var_6_0:putObject(arg_6_0)
	end
end

function var_0_0.setPoolContainerGO(arg_7_0)
	var_0_4 = arg_7_0
end

function var_0_0.getPoolContainerGO()
	return var_0_4
end

function var_0_0._createWrap(arg_9_0)
	local var_9_0 = gohelper.create3d(var_0_0.getPoolContainerGO(), arg_9_0)
	local var_9_1 = MonoHelper.addLuaComOnceToGo(var_9_0, TeamChessEffectWrap)

	var_9_1:init(var_9_0)
	var_9_1:setUniqueId(var_0_1)
	var_9_1:setEffectType(arg_9_0)

	var_0_1 = var_0_1 + 1

	return var_9_1
end

return var_0_0
