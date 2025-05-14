module("modules.logic.effect.model.EffectStatModel", package.seeall)

local var_0_0 = class("EffectStatModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.idCounter = 1
	arg_1_0.toggleId = 1
	arg_1_0.titleMO = {}
	arg_1_0.maxMO = {}
	arg_1_0.totalMO = {}
	arg_1_0.type1MOList = {}
	arg_1_0.type2MOList = {}
	arg_1_0.type1MOCount = 0
	arg_1_0.type2MOCount = 0

	arg_1_0:clearStat()
end

function var_0_0.setCameraRootActive(arg_2_0)
	local var_2_0 = gohelper.find("cameraroot")

	gohelper.setActive(var_2_0, false)
	gohelper.setActive(var_2_0, true)
end

function var_0_0.switchTab(arg_3_0, arg_3_1)
	arg_3_0.toggleId = arg_3_1
end

function var_0_0.clearStat(arg_4_0)
	arg_4_0._maxParticleSystem = 0
	arg_4_0._maxParticleCount = 0
	arg_4_0._maxMaterialCount = 0
	arg_4_0._maxTextureCount = 0
end

function var_0_0.statistic(arg_5_0)
	arg_5_0.type1MOCount = 0
	arg_5_0.type2MOCount = 0
	arg_5_0.idCounter = 1

	local var_5_0 = 1
	local var_5_1 = {}
	local var_5_2 = {}
	local var_5_3 = FightEffectPool.getId2UsingWrapDict()
	local var_5_4 = gohelper.find("cameraroot")

	table.insert(var_5_1, var_5_4)

	local var_5_5 = 0
	local var_5_6 = 0
	local var_5_7 = 0
	local var_5_8 = 0

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		local var_5_9, var_5_10, var_5_11, var_5_12 = arg_5_0:_statSingle(iter_5_1)

		if var_5_9 > 0 or var_5_10 > 0 or var_5_11 > 0 or var_5_12 > 0 then
			arg_5_0.type2MOCount = arg_5_0.type2MOCount + 1

			local var_5_13 = arg_5_0.type2MOList[arg_5_0.type2MOCount]

			if not var_5_13 then
				var_5_13 = {}
				arg_5_0.type2MOList[arg_5_0.type2MOCount] = var_5_13
			end

			arg_5_0:_setMO(var_5_13, iter_5_1.name, iter_5_1, var_5_9, var_5_10, var_5_11, var_5_12)
		end

		var_5_5 = var_5_5 + var_5_9
		var_5_6 = var_5_6 + var_5_10
		var_5_7 = var_5_7 + var_5_11
		var_5_8 = var_5_8 + var_5_12
	end

	arg_5_0:_setMO(arg_5_0.titleMO, "", nil, "粒子系统", "粒子数", "材质数", "贴图数")
	arg_5_0:_setMO(arg_5_0.totalMO, "总计", nil, var_5_5, var_5_6, var_5_7, var_5_8)

	arg_5_0._maxParticleSystem = var_5_5 < arg_5_0._maxParticleSystem and arg_5_0._maxParticleSystem or var_5_5
	arg_5_0._maxParticleCount = var_5_6 < arg_5_0._maxParticleCount and arg_5_0._maxParticleCount or var_5_6
	arg_5_0._maxMaterialCount = var_5_7 < arg_5_0._maxMaterialCount and arg_5_0._maxMaterialCount or var_5_7
	arg_5_0._maxTextureCount = var_5_8 < arg_5_0._maxTextureCount and arg_5_0._maxTextureCount or var_5_8

	arg_5_0:_setMO(arg_5_0.maxMO, "最大数", nil, arg_5_0._maxParticleSystem, arg_5_0._maxParticleCount, arg_5_0._maxMaterialCount, arg_5_0._maxTextureCount)

	local var_5_14 = {}

	if arg_5_0.toggleId == 1 then
		for iter_5_2 = 1, arg_5_0.type1MOCount do
			table.insert(var_5_14, arg_5_0.type1MOList[iter_5_2])
		end
	else
		for iter_5_3 = 1, arg_5_0.type2MOCount do
			table.insert(var_5_14, arg_5_0.type2MOList[iter_5_3])
		end
	end

	table.sort(var_5_14, function(arg_6_0, arg_6_1)
		if arg_6_0.particleCount ~= arg_6_1.particleCount then
			return arg_6_0.particleCount > arg_6_1.particleCount
		elseif arg_6_0.particleSystem ~= arg_6_1.particleSystem then
			return arg_6_0.particleSystem > arg_6_1.particleSystem
		else
			return arg_6_0.id < arg_6_1.id
		end
	end)
	table.insert(var_5_14, 1, arg_5_0.totalMO)
	table.insert(var_5_14, 1, arg_5_0.maxMO)
	table.insert(var_5_14, 1, arg_5_0.titleMO)
	arg_5_0:setList(var_5_14)
end

function var_0_0._statSingle(arg_7_0, arg_7_1)
	if not arg_7_1.activeInHierarchy then
		return 0, 0, 0, 0
	end

	local var_7_0 = 0
	local var_7_1 = 0
	local var_7_2 = 0
	local var_7_3 = 0
	local var_7_4 = arg_7_1:GetComponent(typeof("UnityEngine.ParticleSystem"))

	if var_7_4 then
		var_7_0 = var_7_0 + 1
		var_7_1 = var_7_1 + var_7_4.particleCount
	end

	local var_7_5 = arg_7_1:GetComponent(typeof("UnityEngine.Renderer"))

	if var_7_5 then
		local var_7_6 = var_7_5.sharedMaterials
		local var_7_7 = var_7_6.Length

		for iter_7_0 = 0, var_7_7 - 1 do
			local var_7_8 = var_7_6[iter_7_0]

			if not gohelper.isNil(var_7_8) then
				var_7_2 = var_7_2 + 1

				local var_7_9 = var_7_8:GetTexturePropertyNames()

				for iter_7_1 = 0, var_7_9.Length - 1 do
					local var_7_10 = var_7_9[iter_7_1]

					if var_7_8:GetTexture(var_7_10) then
						var_7_3 = var_7_3 + 1
					end
				end
			end
		end
	end

	if var_7_0 > 0 or var_7_1 > 0 or var_7_2 > 0 or var_7_3 > 0 then
		arg_7_0.type1MOCount = arg_7_0.type1MOCount + 1

		local var_7_11 = arg_7_0.type1MOList[arg_7_0.type1MOCount]

		if not var_7_11 then
			var_7_11 = {}
			arg_7_0.type1MOList[arg_7_0.type1MOCount] = var_7_11
		end

		arg_7_0:_setMO(var_7_11, arg_7_1.name, arg_7_1, var_7_0, var_7_1, var_7_2, var_7_3)
	end

	local var_7_12 = arg_7_1.transform
	local var_7_13 = var_7_12.childCount

	for iter_7_2 = 0, var_7_13 - 1 do
		local var_7_14, var_7_15, var_7_16, var_7_17 = arg_7_0:_statSingle(var_7_12:GetChild(iter_7_2).gameObject)

		var_7_0 = var_7_0 + var_7_14
		var_7_1 = var_7_1 + var_7_15
		var_7_2 = var_7_2 + var_7_16
		var_7_3 = var_7_3 + var_7_17
	end

	return var_7_0, var_7_1, var_7_2, var_7_3
end

function var_0_0._setMO(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7)
	arg_8_1.name = arg_8_2
	arg_8_1.go = arg_8_3
	arg_8_1.particleSystem = arg_8_4
	arg_8_1.particleCount = arg_8_5
	arg_8_1.materialCount = arg_8_6
	arg_8_1.textureCount = arg_8_7
	arg_8_1.id = arg_8_0.idCounter
	arg_8_0.idCounter = arg_8_0.idCounter + 1
end

var_0_0.instance = var_0_0.New()

return var_0_0
