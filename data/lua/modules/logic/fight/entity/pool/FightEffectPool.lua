module("modules.logic.fight.entity.pool.FightEffectPool", package.seeall)

local var_0_0 = _M
local var_0_1 = 1
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = {}
local var_0_6
local var_0_7

var_0_0.isForbidEffect = nil

function var_0_0.getId2UsingWrapDict()
	return var_0_4
end

function var_0_0.releaseUnuseEffect()
	for iter_2_0, iter_2_1 in pairs(var_0_3) do
		for iter_2_2, iter_2_3 in pairs(iter_2_1) do
			for iter_2_4, iter_2_5 in ipairs(iter_2_3) do
				iter_2_5:markCanDestroy()
				gohelper.destroy(iter_2_5.containerGO)
			end
		end
	end

	var_0_3 = {}

	local var_2_0 = {}

	for iter_2_6, iter_2_7 in pairs(var_0_4) do
		var_2_0[iter_2_7.path] = true
	end

	local var_2_1 = {}

	for iter_2_8, iter_2_9 in pairs(var_0_2) do
		if not var_2_0[iter_2_8] then
			var_2_1[iter_2_8] = true

			iter_2_9:Release()

			var_0_2[iter_2_8] = nil
		end
	end

	return var_2_1
end

function var_0_0.dispose()
	for iter_3_0, iter_3_1 in pairs(var_0_2) do
		iter_3_1:Release()

		var_0_2[iter_3_0] = nil
	end

	for iter_3_2, iter_3_3 in pairs(var_0_3) do
		for iter_3_4, iter_3_5 in pairs(iter_3_3) do
			for iter_3_6, iter_3_7 in ipairs(iter_3_5) do
				iter_3_7:markCanDestroy()
				gohelper.destroy(iter_3_7.containerGO)
			end
		end
	end

	for iter_3_8, iter_3_9 in pairs(var_0_4) do
		iter_3_9:markCanDestroy()
		gohelper.destroy(iter_3_9.containerGO)
	end

	for iter_3_10, iter_3_11 in pairs(var_0_5) do
		for iter_3_12, iter_3_13 in ipairs(iter_3_11) do
			iter_3_13:markCanDestroy()
			gohelper.destroy(iter_3_13.containerGO)
		end
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

function var_0_0.hasLoaded(arg_4_0)
	return (var_0_2 and var_0_2[arg_4_0]) ~= nil
end

function var_0_0.isLoading(arg_5_0)
	return var_0_5[arg_5_0]
end

function var_0_0.getEffect(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	local var_6_0 = var_0_2[arg_6_0]
	local var_6_1 = var_0_0.getPoolContainerGO()
	local var_6_2

	if var_6_0 then
		var_6_2 = var_0_0._getLoadedEffect(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, var_6_0)
	else
		var_6_2 = var_0_0._getNotLoadEffect(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
		var_0_4[var_6_2.uniqueId] = var_6_2

		if not var_0_0.isForbidEffect then
			local var_6_3 = MultiAbLoader.New()

			var_6_3:addPath(var_6_2.abPath)
			var_6_3:startLoad(var_0_0._onEffectLoaded)
		end
	end

	var_0_4[var_6_2.uniqueId] = var_6_2

	return var_6_2
end

function var_0_0._getLoadedEffect(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)
	local var_7_0
	local var_7_1 = var_0_0.getPoolContainerGO()
	local var_7_2 = var_0_3[arg_7_0]
	local var_7_3 = var_7_2 and var_7_2[arg_7_1]

	if var_7_3 and #var_7_3 > 0 then
		local var_7_4 = #var_7_3

		for iter_7_0, iter_7_1 in ipairs(var_7_3) do
			if arg_7_4 == nil and iter_7_1.hangPointGO == var_7_1 or arg_7_4 ~= nil and iter_7_1.hangPointGO == arg_7_4 then
				var_7_4 = iter_7_0

				break
			end
		end

		var_7_0 = table.remove(var_7_3, var_7_4)

		var_7_0:setHangPointGO(arg_7_4 or var_7_1)
	else
		var_7_0 = var_0_0._createWrap(arg_7_0)

		var_7_0:setHangPointGO(arg_7_4 or var_7_1)

		var_7_0.side = arg_7_1

		var_0_0._instantiateEffectGO(arg_7_6, var_7_0)
	end

	var_7_0:setCallback(arg_7_2, arg_7_3)
	var_7_0:doCallback(true)
	var_7_0:setTimeScale(FightModel.instance:getSpeed())

	var_7_0.dontPlay = arg_7_5

	var_7_0:play()

	return var_7_0
end

function var_0_0._getNotLoadEffect(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	local var_8_0 = var_0_0.getPoolContainerGO()
	local var_8_1 = var_0_0._createWrap(arg_8_0)

	var_8_1.side = arg_8_1

	var_8_1:setHangPointGO(arg_8_4 or var_8_0)
	var_8_1:setCallback(arg_8_2, arg_8_3)

	var_8_1.dontPlay = arg_8_5

	local var_8_2 = var_0_5[arg_8_0]

	if not var_8_2 then
		var_8_2 = {}
		var_0_5[arg_8_0] = var_8_2
	end

	table.insert(var_8_2, var_8_1)

	return var_8_1
end

function var_0_0.returnEffect(arg_9_0)
	if gohelper.isNil(arg_9_0.containerGO) then
		return
	end

	arg_9_0:setActive(false)
	arg_9_0:onReturnPool()

	var_0_4[arg_9_0.uniqueId] = nil

	local var_9_0 = var_0_3[arg_9_0.path]

	if not var_9_0 then
		var_9_0 = {}
		var_0_3[arg_9_0.path] = var_9_0
	end

	local var_9_1 = var_9_0[arg_9_0.side]

	if not var_9_1 then
		var_9_1 = {}
		var_9_0[arg_9_0.side] = var_9_1
	end

	if not tabletool.indexOf(var_9_1, arg_9_0) then
		table.insert(var_9_1, arg_9_0)
	end
end

function var_0_0.returnEffectToPoolContainer(arg_10_0)
	arg_10_0:setHangPointGO(var_0_0.getPoolContainerGO())
end

function var_0_0.getPoolContainerGO()
	if not var_0_6 then
		local var_11_0 = GameSceneMgr.instance:getScene(SceneType.Fight):getSceneContainerGO()

		var_0_6 = gohelper.create3d(var_11_0, "EffectPool")
		var_0_7 = var_0_6.transform
	end

	return var_0_6
end

function var_0_0._onEffectLoaded(arg_12_0)
	local var_12_0 = arg_12_0:getFirstAssetItem()

	if var_12_0 and var_12_0.IsLoadSuccess then
		if GameResMgr.IsFromEditorDir then
			var_0_0._createLoadedEffectWrap(var_12_0, var_12_0.ResPath)
		else
			local var_12_1 = var_12_0.AllAssetNames

			if var_12_1 then
				for iter_12_0 = 0, var_12_1.Length - 1 do
					local var_12_2 = var_12_1[iter_12_0]
					local var_12_3 = ResUrl.getPathWithoutAssetLib(var_12_2)

					var_0_0._createLoadedEffectWrap(var_12_0, var_12_3)
				end
			end
		end
	else
		for iter_12_1, iter_12_2 in pairs(var_0_5) do
			local var_12_4

			for iter_12_3, iter_12_4 in ipairs(iter_12_2) do
				if var_12_0 then
					if iter_12_4.abPath == var_12_0.ResPath then
						iter_12_4:doCallback(false)

						var_12_4 = true
					end
				elseif arg_12_0._pathList and iter_12_4.abPath == arg_12_0._pathList[1] then
					iter_12_4:doCallback(false)

					var_12_4 = true
				end
			end

			if var_12_4 then
				var_0_5[iter_12_1] = nil
			end
		end

		if var_12_0 then
			logError("load effect fail: " .. var_12_0.ResPath)
		end
	end

	arg_12_0:dispose()
end

function var_0_0._createLoadedEffectWrap(arg_13_0, arg_13_1)
	if not var_0_2[arg_13_1] then
		var_0_2[arg_13_1] = arg_13_0

		arg_13_0:Retain()
	end

	local var_13_0 = var_0_5[arg_13_1]

	var_0_5[arg_13_1] = nil

	local var_13_1 = var_13_0 and #var_13_0 or 0

	for iter_13_0 = 1, var_13_1 do
		local var_13_2 = var_13_0[iter_13_0]

		var_0_0._instantiateEffectGO(arg_13_0, var_13_2)

		if var_0_4[var_13_2.uniqueId] then
			var_13_2:doCallback(true)
			var_13_2:setTimeScale(FightModel.instance:getSpeed())
			var_13_2:setActive(false)
			var_13_2:play()
		end
	end
end

function var_0_0._instantiateEffectGO(arg_14_0, arg_14_1)
	local var_14_0 = gohelper.clone(arg_14_0:GetResource(arg_14_1.path), arg_14_1.containerGO)
	local var_14_1 = var_14_0
	local var_14_2

	if arg_14_1.side == FightEnum.EntitySide.MySide then
		var_14_2 = "_r"
	elseif arg_14_1.side == FightEnum.EntitySide.EnemySide then
		var_14_2 = "_l"
	end

	if not string.nilorempty(var_14_2) then
		local var_14_3 = var_14_0.transform
		local var_14_4 = var_14_3.childCount

		for iter_14_0 = 0, var_14_4 - 1 do
			local var_14_5 = var_14_3:GetChild(iter_14_0)
			local var_14_6 = var_14_5.name
			local var_14_7 = string.len(var_14_6)

			if string.sub(var_14_6, var_14_7 - 1, var_14_7) == var_14_2 then
				var_14_1 = var_14_5.gameObject

				gohelper.addChild(arg_14_1.containerGO, var_14_1)
				gohelper.destroy(var_14_0)

				break
			end
		end
	end

	gohelper.removeEffectNode(var_14_1)
	arg_14_1:setEffectGO(var_14_1)
end

function var_0_0._createWrap(arg_15_0)
	local var_15_0 = FightStrUtil.instance:getSplitCache(arg_15_0, "/")
	local var_15_1 = var_15_0[#var_15_0]
	local var_15_2 = gohelper.create3d(var_0_0.getPoolContainerGO(), var_15_1)
	local var_15_3 = MonoHelper.addLuaComOnceToGo(var_15_2, FightEffectWrap)

	var_15_3:setUniqueId(var_0_1)
	var_15_3:setPath(arg_15_0)

	var_0_1 = var_0_1 + 1

	return var_15_3
end

return var_0_0
