module("modules.logic.explore.map.ExploreMapPipe", package.seeall)

local var_0_0 = class("ExploreMapPipe")
local var_0_1 = ExploreEnum.PipeColor
local var_0_2 = {
	[var_0_1.Color1] = var_0_1.Color1,
	[var_0_1.Color2] = var_0_1.Color2,
	[var_0_1.Color3] = var_0_1.Color3,
	[bit.bor(var_0_1.Color1, var_0_1.Color2)] = var_0_1.Color3,
	[bit.bor(var_0_1.Color3, var_0_1.Color2)] = var_0_1.Color1,
	[bit.bor(var_0_1.Color1, var_0_1.Color3)] = var_0_1.Color2
}

GameUtil.setDefaultValue(var_0_2, var_0_1.None)

function var_0_0.loadMap(arg_1_0)
	return
end

function var_0_0.init(arg_2_0)
	local var_2_0 = ExploreController.instance:getMap():getUnitsByTypeDict(ExploreEnum.PipeTypes)

	if #var_2_0 <= 0 then
		return
	end

	arg_2_0._allPipeMos = {}
	arg_2_0._allPipeComps = {}

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		local var_2_1 = ExploreHelper.getKey(iter_2_1.mo.nodePos)

		arg_2_0._allPipeMos[var_2_1] = iter_2_1.mo
		arg_2_0._allPipeComps[var_2_1] = iter_2_1.pipeComp
	end

	arg_2_0:initColors(true)

	arg_2_0._tweenId = nil
end

function var_0_0.sortUnitById(arg_3_0, arg_3_1)
	return arg_3_0.id < arg_3_1.id
end

function var_0_0.initColors(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0._tweenId then
		ZProj.TweenHelper.KillById(arg_4_0._tweenId)

		arg_4_0._tweenId = nil
	end

	arg_4_3 = arg_4_3 or {}

	if #arg_4_3 > 50 then
		local var_4_0 = ""

		if isDebugBuild then
			for iter_4_0, iter_4_1 in pairs(arg_4_0._allPipeMos) do
				var_4_0 = string.format("%s\n[%s,%s,%s]", var_4_0, iter_4_1.id, iter_4_1:getColor(0), iter_4_1:isInteractActiveState())
			end
		end

		logError("密室管道死循环了？？？" .. var_4_0)

		return
	end

	arg_4_0._all = nil
	arg_4_0._allOutColor = nil

	local var_4_1 = {}
	local var_4_2 = {}

	arg_4_2 = arg_4_2 or {}
	arg_4_0._cacheActiveSensor = arg_4_2

	local var_4_3 = ExploreController.instance:getMap()
	local var_4_4 = var_4_3:getUnitsByType(ExploreEnum.ItemType.PipeEntrance)

	table.sort(var_4_4, var_0_0.sortUnitById)

	for iter_4_2, iter_4_3 in ipairs(var_4_4) do
		local var_4_5 = iter_4_3.mo:getColor()

		if var_4_5 ~= ExploreEnum.PipeColor.None then
			var_4_2[iter_4_3.id] = var_4_5

			arg_4_0:calcRelation(iter_4_3.mo, iter_4_3.id, var_4_1, nil, iter_4_3.mo:getPipeOutDir())
		end
	end

	local var_4_6 = var_4_3:getUnitsByType(ExploreEnum.ItemType.PipeSensor)

	table.sort(var_4_6, var_0_0.sortUnitById)

	for iter_4_4, iter_4_5 in ipairs(var_4_6) do
		local var_4_7 = iter_4_5.mo:getColor()

		if var_4_7 ~= ExploreEnum.PipeColor.None then
			var_4_2[iter_4_5.id] = var_4_7

			arg_4_0:calcRelation(iter_4_5.mo, iter_4_5.id, var_4_1, nil, iter_4_5.mo:getPipeOutDir())
		end
	end

	local var_4_8 = var_4_3:getUnitsByType(ExploreEnum.ItemType.PipeMemory)

	table.sort(var_4_8, var_0_0.sortUnitById)

	for iter_4_6, iter_4_7 in ipairs(var_4_8) do
		local var_4_9 = iter_4_7.mo:getColor()

		if var_4_9 ~= ExploreEnum.PipeColor.None then
			var_4_2[iter_4_7.id] = var_4_9

			arg_4_0:calcRelation(iter_4_7.mo, iter_4_7.id, var_4_1, nil, iter_4_7.mo:getPipeOutDir())
		end
	end

	arg_4_0:delUnUseDir(var_4_1)

	local var_4_10 = {}
	local var_4_11 = {}

	for iter_4_8, iter_4_9 in ipairs(var_4_1) do
		if iter_4_9.isDivisive then
			if not var_4_10[iter_4_9.toId] then
				var_4_10[iter_4_9.toId] = {
					[iter_4_9.fromId] = true
				}
			else
				var_4_10[iter_4_9.toId][iter_4_9.fromId] = true
			end

			if iter_4_9.noOutDivisive then
				var_4_11[iter_4_9.toId] = true
			end
		end
	end

	local var_4_12 = true

	while var_4_12 do
		var_4_12 = false

		for iter_4_10, iter_4_11 in pairs(var_4_10) do
			local var_4_13 = var_0_1.None

			for iter_4_12 in pairs(iter_4_11) do
				if iter_4_12 ~= iter_4_10 then
					if var_4_2[iter_4_12] then
						var_4_13 = bit.bor(var_4_13, var_4_2[iter_4_12])
					else
						var_4_13 = nil

						break
					end
				end
			end

			if var_4_13 then
				local var_4_14 = var_0_2[var_4_13]

				if var_4_11[iter_4_10] and not arg_4_0:haveValue(var_0_1, var_4_13) then
					var_4_14 = var_0_1.None
				end

				var_4_2[iter_4_10] = var_4_14
				var_4_12 = true
				var_4_10[iter_4_10] = nil
			end
		end

		if not var_4_12 and next(var_4_10) then
			for iter_4_13, iter_4_14 in pairs(var_4_10) do
				local var_4_15 = var_0_1.None

				for iter_4_15 in pairs(iter_4_14) do
					if iter_4_15 ~= iter_4_13 then
						if var_4_2[iter_4_15] then
							var_4_15 = bit.bor(var_4_15, var_4_2[iter_4_15])
						elseif not arg_4_0:isRound({}, iter_4_13, iter_4_15, var_4_10) then
							var_4_15 = nil

							break
						end
					end
				end

				if var_4_15 ~= var_0_1.None and var_4_15 then
					local var_4_16 = var_0_2[var_4_15]

					if var_4_11[iter_4_13] and not arg_4_0:haveValue(var_0_1, var_4_15) then
						var_4_16 = var_0_1.None
					end

					var_4_2[iter_4_13] = var_4_16
					var_4_12 = true
					var_4_10[iter_4_13] = nil

					break
				end
			end
		end
	end

	local var_4_17 = {}

	for iter_4_16, iter_4_17 in ipairs(var_4_6) do
		local var_4_18 = iter_4_17.mo:getColor()

		if not arg_4_2[iter_4_17.id] and var_4_18 == ExploreEnum.PipeColor.None then
			local var_4_19 = ExploreHelper.dirToXY(iter_4_17.mo.unitDir)
			local var_4_20 = ExploreHelper.getKeyXY(iter_4_17.mo.nodePos.x + var_4_19.x, iter_4_17.mo.nodePos.y + var_4_19.y)
			local var_4_21 = arg_4_0._allPipeMos[var_4_20]

			if var_4_21 and arg_4_0:getOutDirColor(var_4_1, var_4_2, ExploreHelper.getDir(iter_4_17.mo.unitDir + 180), var_4_21.id, ExploreEnum.PipeDirMatchMode.Single) == iter_4_17.mo:getNeedColor() then
				arg_4_2[iter_4_17.id] = true
				var_4_17[iter_4_17.id] = 1
			end
		end
	end

	for iter_4_18, iter_4_19 in ipairs(var_4_8) do
		local var_4_22 = iter_4_19.mo:getColor()
		local var_4_23 = ExploreHelper.dirToXY(iter_4_19.mo.unitDir)
		local var_4_24 = ExploreHelper.getKeyXY(iter_4_19.mo.nodePos.x + var_4_23.x, iter_4_19.mo.nodePos.y + var_4_23.y)
		local var_4_25 = arg_4_0._allPipeMos[var_4_24]
		local var_4_26 = var_4_25 and arg_4_0:getOutDirColor(var_4_1, var_4_2, ExploreHelper.getDir(iter_4_19.mo.unitDir + 180), var_4_25.id, ExploreEnum.PipeDirMatchMode.Single) or ExploreEnum.PipeColor.None

		if var_4_26 ~= var_4_22 and var_4_26 ~= ExploreEnum.PipeColor.None then
			iter_4_19.mo:setCacheColor(var_4_26)

			var_4_17[iter_4_19.id] = var_4_26
		end
	end

	if not arg_4_0:haveHistory(arg_4_3, var_4_17) then
		table.insert(arg_4_3, var_4_17)

		return arg_4_0:initColors(arg_4_1, arg_4_2, arg_4_3)
	end

	arg_4_0._all = var_4_1
	arg_4_0._allOutColor = var_4_2

	if arg_4_1 then
		arg_4_0._initDone = true
	end

	for iter_4_20, iter_4_21 in pairs(arg_4_0._allPipeComps) do
		iter_4_21:applyColor(arg_4_1)
	end

	if not arg_4_1 then
		ExploreModel.instance:setStepPause(true)
		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Pipe)

		arg_4_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.4, arg_4_0._frameCall, arg_4_0._finishCall, arg_4_0, nil, EaseType.Linear)
	end
end

function var_0_0.haveHistory(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		if tabletool.len(iter_5_1) == tabletool.len(arg_5_2) then
			local var_5_0 = true

			for iter_5_2, iter_5_3 in pairs(iter_5_1) do
				if arg_5_2[iter_5_2] ~= iter_5_3 then
					var_5_0 = false

					break
				end
			end

			if var_5_0 then
				return true
			end
		end
	end

	return false
end

function var_0_0.isRound(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_2 == arg_6_3 then
		return true
	end

	arg_6_3 = arg_6_3 or arg_6_2

	if arg_6_1[arg_6_3] then
		return
	end

	arg_6_1[arg_6_3] = true

	if arg_6_4[arg_6_3] then
		for iter_6_0 in pairs(arg_6_4) do
			if arg_6_0:isRound(arg_6_1, arg_6_2, iter_6_0, arg_6_4) then
				return true
			end
		end
	end
end

function var_0_0.haveValue(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		if iter_7_1 == arg_7_2 then
			return true
		end
	end

	return false
end

function var_0_0.isCacheActive(arg_8_0, arg_8_1)
	if not arg_8_0._cacheActiveSensor then
		return
	end

	return arg_8_0._cacheActiveSensor[arg_8_1]
end

function var_0_0._frameCall(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._allPipeComps) do
		iter_9_1:tweenColor(arg_9_1)
	end
end

function var_0_0._finishCall(arg_10_0)
	ExploreModel.instance:setStepPause(false)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Pipe)
end

function var_0_0.getDirColor(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0._all
	local var_11_1 = arg_11_0._allOutColor

	if ExploreController.instance:getMap():getUnit(arg_11_1).mo:isDivisive() then
		local var_11_2

		for iter_11_0, iter_11_1 in ipairs(var_11_0) do
			if iter_11_1.toId == arg_11_1 and arg_11_2 == iter_11_1.inDir then
				var_11_2 = iter_11_1

				break
			end
		end

		if var_11_2 then
			return var_11_2 and var_11_1[var_11_2.fromId] or arg_11_0:getOutDirColor(var_11_0, var_11_1, arg_11_2, arg_11_1, ExploreEnum.PipeDirMatchMode.Single)
		end
	end

	return arg_11_0:getOutDirColor(var_11_0, var_11_1, arg_11_2, arg_11_1, ExploreEnum.PipeDirMatchMode.Both)
end

function var_0_0.getCenterColor(arg_12_0, arg_12_1)
	return arg_12_0:getOutDirColor(nil, nil, nil, arg_12_1, ExploreEnum.PipeDirMatchMode.All)
end

function var_0_0.getOutDirColor(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	arg_13_1 = arg_13_1 or arg_13_0._all
	arg_13_2 = arg_13_2 or arg_13_0._allOutColor

	if not arg_13_1 then
		return ExploreEnum.PipeColor.None
	end

	if arg_13_2[arg_13_4] then
		local var_13_0 = ExploreMapModel.instance:getUnitMO(arg_13_4)

		if not var_13_0 then
			return ExploreEnum.PipeColor.None
		end

		if arg_13_3 and not var_13_0:isOutDir(arg_13_3) then
			return ExploreEnum.PipeColor.None
		end

		return arg_13_2[arg_13_4]
	end

	local var_13_1

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		local var_13_2 = false

		if arg_13_5 == ExploreEnum.PipeDirMatchMode.Single then
			var_13_2 = arg_13_3 == iter_13_1.outDir
		elseif arg_13_5 == ExploreEnum.PipeDirMatchMode.Both then
			var_13_2 = arg_13_3 == iter_13_1.outDir or arg_13_3 == iter_13_1.inDir
		elseif arg_13_5 == ExploreEnum.PipeDirMatchMode.All then
			var_13_2 = true
		end

		if iter_13_1.toId == arg_13_4 and var_13_2 then
			var_13_1 = iter_13_1

			break
		end
	end

	return var_13_1 and arg_13_2[var_13_1.fromId] or ExploreEnum.PipeColor.None
end

function var_0_0.delUnUseDir(arg_14_0, arg_14_1)
	local var_14_0 = true

	while var_14_0 do
		var_14_0 = false

		for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
			if iter_14_1.isDivisive then
				local var_14_1 = {}

				for iter_14_2, iter_14_3 in ipairs(arg_14_1) do
					if iter_14_3.fromId == iter_14_1.toId and iter_14_1.inDir == iter_14_3.fromDir or iter_14_3.toId == iter_14_1.toId and iter_14_1.inDir == iter_14_3.outDir then
						table.insert(var_14_1, iter_14_2)
					end
				end

				for iter_14_4 = #var_14_1, 1, -1 do
					table.remove(arg_14_1, var_14_1[iter_14_4])

					var_14_0 = true
				end
			end

			if var_14_0 then
				break
			end
		end
	end

	for iter_14_5 = #arg_14_1, 1, -1 do
		local var_14_2 = arg_14_1[iter_14_5]

		for iter_14_6 = iter_14_5 - 1, 1, -1 do
			local var_14_3 = arg_14_1[iter_14_6]

			if not var_14_2.isDivisive and var_14_2.toId == var_14_3.toId and var_14_2.inDir == var_14_3.outDir then
				table.remove(arg_14_1, iter_14_5)

				break
			end
		end
	end
end

function var_0_0.calcRelation(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	local var_15_0, var_15_1, var_15_2 = arg_15_1:getPipeOutDir(arg_15_4)

	arg_15_0:calcRelationDir(var_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	arg_15_0:calcRelationDir(var_15_1, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	arg_15_0:calcRelationDir(var_15_2, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
end

function var_0_0.calcRelationDir(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6)
	if not arg_16_1 then
		return
	end

	for iter_16_0, iter_16_1 in ipairs(arg_16_4) do
		if iter_16_1.inDir == arg_16_5 and iter_16_1.toId == arg_16_2.id and iter_16_1.outDir == arg_16_1 then
			return
		end
	end

	table.insert(arg_16_4, {
		fromId = arg_16_3,
		inDir = arg_16_5,
		toId = arg_16_2.id,
		outDir = arg_16_1,
		fromDir = arg_16_6,
		isDivisive = arg_16_2:isDivisive(),
		noOutDivisive = arg_16_2:isDivisive() and not arg_16_2:haveOutDir()
	})

	local var_16_0 = ExploreHelper.dirToXY(arg_16_1)
	local var_16_1 = ExploreHelper.getKeyXY(arg_16_2.nodePos.x + var_16_0.x, arg_16_2.nodePos.y + var_16_0.y)
	local var_16_2 = arg_16_0._allPipeMos[var_16_1]

	if not var_16_2 or var_16_2.type ~= ExploreEnum.ItemType.Pipe then
		return
	end

	if arg_16_2:isDivisive() then
		arg_16_3 = arg_16_2.id
		arg_16_6 = arg_16_1
	end

	return arg_16_0:calcRelation(var_16_2, arg_16_3, arg_16_4, ExploreHelper.getDir(arg_16_1 + 180), arg_16_6)
end

function var_0_0.isInitDone(arg_17_0)
	return arg_17_0._initDone
end

function var_0_0.unloadMap(arg_18_0)
	arg_18_0:destroy()
end

function var_0_0.destroy(arg_19_0)
	if arg_19_0._tweenId then
		ZProj.TweenHelper.KillById(arg_19_0._tweenId)

		arg_19_0._tweenId = nil
	end

	arg_19_0._initDone = false
	arg_19_0._allPipeMos = {}
	arg_19_0._allPipeComps = {}
	arg_19_0._all = nil
	arg_19_0._allOutColor = nil
	arg_19_0._cacheActiveSensor = nil
end

return var_0_0
