module("modules.logic.fight.model.SkillEffectStatModel", package.seeall)

local var_0_0 = class("SkillEffectStatModel", ListScrollModel)

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

function var_0_0.switchTab(arg_2_0, arg_2_1)
	arg_2_0.toggleId = arg_2_1
end

function var_0_0.clearStat(arg_3_0)
	arg_3_0._maxParticleSystem = 0
	arg_3_0._maxParticleCount = 0
	arg_3_0._maxMaterialCount = 0
	arg_3_0._maxTextureCount = 0
end

function var_0_0.statistic(arg_4_0)
	arg_4_0.type1MOCount = 0
	arg_4_0.type2MOCount = 0
	arg_4_0.idCounter = 1

	local var_4_0 = 1
	local var_4_1 = {}
	local var_4_2 = {}
	local var_4_3 = FightEffectPool.getId2UsingWrapDict()

	for iter_4_0, iter_4_1 in pairs(var_4_3) do
		if not gohelper.isNil(iter_4_1.effectGO) then
			table.insert(var_4_1, iter_4_1.effectGO)
		end
	end

	local var_4_4 = 0
	local var_4_5 = 0
	local var_4_6 = 0
	local var_4_7 = 0

	for iter_4_2, iter_4_3 in ipairs(var_4_1) do
		local var_4_8, var_4_9, var_4_10, var_4_11 = arg_4_0:_statSingle(iter_4_3)

		if var_4_8 > 0 or var_4_9 > 0 or var_4_10 > 0 or var_4_11 > 0 then
			arg_4_0.type2MOCount = arg_4_0.type2MOCount + 1

			local var_4_12 = arg_4_0.type2MOList[arg_4_0.type2MOCount]

			if not var_4_12 then
				var_4_12 = {}
				arg_4_0.type2MOList[arg_4_0.type2MOCount] = var_4_12
			end

			arg_4_0:_setMO(var_4_12, iter_4_3.name, iter_4_3, var_4_8, var_4_9, var_4_10, var_4_11)
		end

		var_4_4 = var_4_4 + var_4_8
		var_4_5 = var_4_5 + var_4_9
		var_4_6 = var_4_6 + var_4_10
		var_4_7 = var_4_7 + var_4_11
	end

	arg_4_0:_setMO(arg_4_0.titleMO, "", nil, "粒子系统", "粒子数", "材质数", "贴图数")
	arg_4_0:_setMO(arg_4_0.totalMO, "总计", nil, var_4_4, var_4_5, var_4_6, var_4_7)

	arg_4_0._maxParticleSystem = var_4_4 < arg_4_0._maxParticleSystem and arg_4_0._maxParticleSystem or var_4_4
	arg_4_0._maxParticleCount = var_4_5 < arg_4_0._maxParticleCount and arg_4_0._maxParticleCount or var_4_5
	arg_4_0._maxMaterialCount = var_4_6 < arg_4_0._maxMaterialCount and arg_4_0._maxMaterialCount or var_4_6
	arg_4_0._maxTextureCount = var_4_7 < arg_4_0._maxTextureCount and arg_4_0._maxTextureCount or var_4_7

	arg_4_0:_setMO(arg_4_0.maxMO, "最大数", nil, arg_4_0._maxParticleSystem, arg_4_0._maxParticleCount, arg_4_0._maxMaterialCount, arg_4_0._maxTextureCount)

	local var_4_13 = {}

	if arg_4_0.toggleId == 1 then
		for iter_4_4 = 1, arg_4_0.type1MOCount do
			table.insert(var_4_13, arg_4_0.type1MOList[iter_4_4])
		end
	else
		for iter_4_5 = 1, arg_4_0.type2MOCount do
			table.insert(var_4_13, arg_4_0.type2MOList[iter_4_5])
		end
	end

	table.sort(var_4_13, function(arg_5_0, arg_5_1)
		if arg_5_0.particleCount ~= arg_5_1.particleCount then
			return arg_5_0.particleCount > arg_5_1.particleCount
		elseif arg_5_0.particleSystem ~= arg_5_1.particleSystem then
			return arg_5_0.particleSystem > arg_5_1.particleSystem
		else
			return arg_5_0.id < arg_5_1.id
		end
	end)
	table.insert(var_4_13, 1, arg_4_0.totalMO)
	table.insert(var_4_13, 1, arg_4_0.maxMO)
	table.insert(var_4_13, 1, arg_4_0.titleMO)
	arg_4_0:setList(var_4_13)
end

function var_0_0._statSingle(arg_6_0, arg_6_1)
	if not arg_6_1.activeInHierarchy then
		return 0, 0, 0, 0
	end

	local var_6_0 = 0
	local var_6_1 = 0
	local var_6_2 = 0
	local var_6_3 = 0
	local var_6_4 = arg_6_1:GetComponent(typeof("UnityEngine.ParticleSystem"))

	if var_6_4 then
		var_6_0 = var_6_0 + 1
		var_6_1 = var_6_1 + var_6_4.particleCount
	end

	local var_6_5 = arg_6_1:GetComponent(typeof("UnityEngine.Renderer"))

	if var_6_5 then
		local var_6_6 = var_6_5.sharedMaterials
		local var_6_7 = var_6_6.Length

		for iter_6_0 = 0, var_6_7 - 1 do
			local var_6_8 = var_6_6[iter_6_0]

			if not gohelper.isNil(var_6_8) then
				var_6_2 = var_6_2 + 1

				local var_6_9 = var_6_8:GetTexturePropertyNames()

				for iter_6_1 = 0, var_6_9.Length - 1 do
					local var_6_10 = var_6_9[iter_6_1]

					if var_6_8:GetTexture(var_6_10) then
						var_6_3 = var_6_3 + 1
					end
				end
			end
		end
	end

	if var_6_0 > 0 or var_6_1 > 0 or var_6_2 > 0 or var_6_3 > 0 then
		arg_6_0.type1MOCount = arg_6_0.type1MOCount + 1

		local var_6_11 = arg_6_0.type1MOList[arg_6_0.type1MOCount]

		if not var_6_11 then
			var_6_11 = {}
			arg_6_0.type1MOList[arg_6_0.type1MOCount] = var_6_11
		end

		arg_6_0:_setMO(var_6_11, arg_6_1.name, arg_6_1, var_6_0, var_6_1, var_6_2, var_6_3)
	end

	local var_6_12 = arg_6_1.transform
	local var_6_13 = var_6_12.childCount

	for iter_6_2 = 0, var_6_13 - 1 do
		local var_6_14, var_6_15, var_6_16, var_6_17 = arg_6_0:_statSingle(var_6_12:GetChild(iter_6_2).gameObject)

		var_6_0 = var_6_0 + var_6_14
		var_6_1 = var_6_1 + var_6_15
		var_6_2 = var_6_2 + var_6_16
		var_6_3 = var_6_3 + var_6_17
	end

	return var_6_0, var_6_1, var_6_2, var_6_3
end

function var_0_0._setMO(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6, arg_7_7)
	arg_7_1.name = arg_7_2
	arg_7_1.go = arg_7_3
	arg_7_1.particleSystem = arg_7_4
	arg_7_1.particleCount = arg_7_5
	arg_7_1.materialCount = arg_7_6
	arg_7_1.textureCount = arg_7_7
	arg_7_1.id = arg_7_0.idCounter
	arg_7_0.idCounter = arg_7_0.idCounter + 1
end

var_0_0.instance = var_0_0.New()

return var_0_0
