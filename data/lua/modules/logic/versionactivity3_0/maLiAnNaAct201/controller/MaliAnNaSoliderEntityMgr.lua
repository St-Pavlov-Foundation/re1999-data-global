module("modules.logic.versionactivity3_0.maLiAnNaAct201.controller.MaliAnNaSoliderEntityMgr", package.seeall)

local var_0_0 = class("MaliAnNaSoliderEntityMgr")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._soliderItem = arg_1_1
	arg_1_0._heroItem = arg_1_2
	arg_1_0._soliderEntityDict = {}
end

function var_0_0.getSoliderEntity(arg_2_0)
	return arg_2_0._soliderEntityDict
end

function var_0_0._initPool(arg_3_0)
	local var_3_0 = 20

	arg_3_0._playerSoliderEntityPool = LuaObjPool.New(var_3_0, function()
		return (arg_3_0:cloneSolider())
	end, function(arg_5_0)
		if arg_5_0 ~= nil then
			arg_5_0:onDestroy()
		end
	end, function(arg_6_0)
		if arg_6_0 ~= nil then
			arg_6_0:clear()
		end
	end)
	arg_3_0._enemySoliderEntityPool = LuaObjPool.New(var_3_0, function()
		return (arg_3_0:cloneSolider())
	end, function(arg_8_0)
		if arg_8_0 ~= nil then
			arg_8_0:onDestroy()
		end
	end, function(arg_9_0)
		if arg_9_0 ~= nil then
			arg_9_0:clear()
		end
	end)
end

function var_0_0.cloneSolider(arg_10_0)
	local var_10_0 = gohelper.cloneInPlace(arg_10_0._soliderItem, "solider")

	return (MonoHelper.addLuaComOnceToGo(var_10_0, MaLiAnNaSoliderEntity))
end

function var_0_0.cloneHeroSolider(arg_11_0)
	local var_11_0 = gohelper.cloneInPlace(arg_11_0._heroItem, "hero")

	return (MonoHelper.addLuaComOnceToGo(var_11_0, MaLiAnNaSoliderHeroEntity))
end

function var_0_0.getEntity(arg_12_0, arg_12_1)
	local var_12_0

	if arg_12_1:isHero() then
		var_12_0 = arg_12_0:cloneHeroSolider()
	else
		if arg_12_0._playerSoliderEntityPool == nil or arg_12_0._enemySoliderEntityPool == nil then
			arg_12_0:_initPool()
		end

		if arg_12_1:getCamp() == Activity201MaLiAnNaEnum.CampType.Player then
			var_12_0 = arg_12_0._playerSoliderEntityPool:getObject(arg_12_1)
		else
			var_12_0 = arg_12_0._enemySoliderEntityPool:getObject(arg_12_1)
		end

		if var_12_0 == nil or var_12_0:getGo() == nil then
			var_12_0 = arg_12_0:cloneSolider()
		end
	end

	if var_12_0 then
		var_12_0:initSoliderInfo(arg_12_1)

		arg_12_0._soliderEntityDict[arg_12_1:getId()] = var_12_0

		gohelper.setAsFirstSibling(var_12_0._go)
	end

	return var_12_0
end

function var_0_0.recycleEntity(arg_13_0, arg_13_1)
	if arg_13_0._soliderEntityDict == nil or arg_13_1 == nil then
		return
	end

	local var_13_0 = arg_13_1:getId()
	local var_13_1 = arg_13_0._soliderEntityDict[var_13_0]

	if var_13_1 == nil then
		return
	end

	if not arg_13_1:isHero() then
		if arg_13_1:getCamp() == Activity201MaLiAnNaEnum.CampType.Player then
			if arg_13_0._playerSoliderEntityPool then
				arg_13_0._playerSoliderEntityPool:putObject(var_13_1)
			end
		elseif arg_13_0._enemySoliderEntityPool then
			arg_13_0._enemySoliderEntityPool:putObject(var_13_1)
		end
	else
		var_13_1:onDestroy()
	end

	arg_13_0._soliderEntityDict[var_13_0] = nil
end

function var_0_0.setHideEntity(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == nil or arg_14_0._soliderEntityDict == nil then
		return
	end

	local var_14_0 = arg_14_1:getId()
	local var_14_1 = arg_14_0._soliderEntityDict[var_14_0]

	if var_14_1 then
		var_14_1:setHide(arg_14_2)
	end
end

function var_0_0.clear(arg_15_0)
	if arg_15_0._soliderEntityDict ~= nil then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._soliderEntityDict) do
			if iter_15_1 then
				iter_15_1:onDestroy()
			end
		end

		tabletool.clear(arg_15_0._soliderEntityDict)
	end
end

function var_0_0.onDestroy(arg_16_0)
	arg_16_0:clear()

	arg_16_0._soliderEntityDict = nil

	if arg_16_0._playerSoliderEntityPool ~= nil then
		arg_16_0._playerSoliderEntityPool:dispose()

		arg_16_0._playerSoliderEntityPool = nil
	end

	if arg_16_0._enemySoliderEntityPool ~= nil then
		arg_16_0._enemySoliderEntityPool:dispose()

		arg_16_0._enemySoliderEntityPool = nil
	end

	if arg_16_0._soliderItem ~= nil then
		gohelper.destroy(arg_16_0._soliderItem)

		arg_16_0._soliderItem = nil
	end

	if arg_16_0._heroItem ~= nil then
		gohelper.destroy(arg_16_0._heroItem)

		arg_16_0._heroItem = nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
