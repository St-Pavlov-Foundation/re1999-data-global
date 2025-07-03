module("modules.logic.scene.fight.comp.FightSceneBloomComp", package.seeall)

local var_0_0 = class("FightSceneBloomComp", BaseSceneComp)

var_0_0.Bloom_invisible = "invisible"
var_0_0.Bloom_mirror = "mirror"
var_0_0.Bloom_useShadow = "useShadow"
var_0_0.Bloom_mirrorNoise = "mirrorNoise"

local var_0_1 = {
	[var_0_0.Bloom_invisible] = "useInvisible",
	[var_0_0.Bloom_mirror] = "useMirror",
	[var_0_0.Bloom_useShadow] = "useShadow"
}
local var_0_2 = {
	[var_0_0.Bloom_invisible] = "characterInvisibleActive"
}

function var_0_0.onInit(arg_1_0)
	arg_1_0:addConstEvents()
end

function var_0_0.addConstEvents(arg_2_0)
	arg_2_0:getCurScene().level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, arg_2_0._onLevelLoaded, arg_2_0)
end

function var_0_0.onSceneStart(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._entityDict = {}
	arg_3_0._scenePassDict = {}
	arg_3_0._entityPassDict = {}

	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, arg_3_0._onSkillPlayStart, arg_3_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_3_0._onSkillPlayFinish, arg_3_0)
end

function var_0_0.onSceneClose(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, arg_4_0._onSkillPlayStart, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_4_0._onSkillPlayFinish, arg_4_0)

	if arg_4_0._localBloomColor then
		PostProcessingMgr.instance:setLocalBloomColor(arg_4_0._localBloomColor)

		arg_4_0._localBloomColor = nil
	end

	arg_4_0._entityDict = {}
	arg_4_0._scenePassDict = {}
	arg_4_0._entityPassDict = {}

	arg_4_0:_checkCameraPPVolume()
	TaskDispatcher.cancelTask(arg_4_0._delayAddEntityBloom, arg_4_0)
end

function var_0_0._onLevelLoaded(arg_5_0, arg_5_1)
	local var_5_0 = lua_scene_level.configDict[arg_5_1]

	if var_5_0 and var_5_0.useBloom == 1 then
		if arg_5_0._localBloomColor == nil then
			arg_5_0._localBloomColor = PostProcessingMgr.instance:getLocalBloomColor()
		end

		PostProcessingMgr.instance:setLocalBloomColor(Color.New(var_5_0.bloomR, var_5_0.bloomG, var_5_0.bloomB, var_5_0.bloomA))
		PostProcessingMgr.instance:setFlickerSceneFactor(var_5_0.flickerSceneFactor)
		PostProcessingMgr.instance:setLocalBloomActive(true)

		arg_5_0._scenePassDict = {}

		if not string.nilorempty(var_5_0.bloomEffect) then
			local var_5_1 = string.split(var_5_0.bloomEffect, "#")

			for iter_5_0, iter_5_1 in ipairs(var_5_1) do
				arg_5_0._scenePassDict[iter_5_1] = true
			end
		end
	end

	for iter_5_2, iter_5_3 in pairs(arg_5_0._entityDict) do
		arg_5_0:_checkEntityPPEffectMask(iter_5_2)
	end

	arg_5_0:_checkCameraPPVolume()
end

function var_0_0.addEntity(arg_6_0, arg_6_1)
	arg_6_0._delayAddEntitys = arg_6_0._delayAddEntitys or {}

	table.insert(arg_6_0._delayAddEntitys, arg_6_1)
	TaskDispatcher.cancelTask(arg_6_0._delayAddEntityBloom, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._delayAddEntityBloom, arg_6_0, 2)
end

function var_0_0._delayAddEntityBloom(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._delayAddEntitys) do
		arg_7_0._entityDict[iter_7_1] = true

		arg_7_0:_checkEntityPPEffectMask(iter_7_1)
		arg_7_0:_checkCameraPPVolume()
	end

	arg_7_0._delayAddEntitys = nil
end

function var_0_0.removeEntity(arg_8_0, arg_8_1)
	arg_8_0._entityDict[arg_8_1] = nil

	arg_8_0:_checkEntityPPEffectMask(arg_8_1)
	arg_8_0:_checkCameraPPVolume()
end

function var_0_0.setSingleEntityPass(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = arg_9_0._entityPassDict[arg_9_1]

	if not var_9_0 then
		var_9_0 = {}
		arg_9_0._entityPassDict[arg_9_1] = var_9_0
	end

	local var_9_1 = var_9_0[arg_9_3]

	if not var_9_1 then
		var_9_1 = {}
		var_9_0[arg_9_3] = var_9_1
	end

	var_9_1[arg_9_4] = arg_9_2 and true or nil

	arg_9_0:_checkEntityPPEffectMask(arg_9_3)
	arg_9_0:_checkCameraPPVolume(arg_9_1)
end

function var_0_0._checkEntityPPEffectMask(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1.spine and arg_10_1.spine:getPPEffectMask()

	if not var_10_0 then
		return
	end

	if not arg_10_1.spineRenderer then
		return
	end

	local var_10_1 = arg_10_1.spineRenderer:getReplaceMat()

	if gohelper.isNil(var_10_1) then
		logError("FightSceneBloomComp.SetPassEnable mat=nil")

		return
	end

	for iter_10_0, iter_10_1 in pairs(var_0_1) do
		local var_10_2 = arg_10_0._entityDict[arg_10_1] and arg_10_0._scenePassDict[iter_10_0] or false

		if not var_10_2 then
			local var_10_3 = arg_10_0._entityPassDict[iter_10_0]

			if var_10_3 then
				local var_10_4 = var_10_3[arg_10_1]

				if var_10_4 then
					for iter_10_2, iter_10_3 in pairs(var_10_4) do
						var_10_2 = true

						break
					end
				end
			end
		end

		var_10_0:SetPassEnable(var_10_1, iter_10_1, var_10_2)
	end
end

function var_0_0._checkCameraPPVolume(arg_11_0, arg_11_1)
	if arg_11_1 then
		if var_0_2[arg_11_1] then
			arg_11_0:_checkOneCameraPPVolume(arg_11_1)
		end
	else
		for iter_11_0, iter_11_1 in pairs(var_0_2) do
			arg_11_0:_checkOneCameraPPVolume(iter_11_0)
		end
	end
end

function var_0_0._checkOneCameraPPVolume(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._scenePassDict[arg_12_1]

	if not var_12_0 then
		local var_12_1 = arg_12_0._entityPassDict[arg_12_1]

		if var_12_1 then
			for iter_12_0, iter_12_1 in pairs(var_12_1) do
				for iter_12_2, iter_12_3 in pairs(iter_12_1) do
					var_12_0 = true

					break
				end

				if var_12_0 then
					break
				end
			end
		end
	end

	local var_12_2 = var_0_2[arg_12_1]

	PostProcessingMgr.instance:setUnitPPValue(var_12_2, var_12_0)
end

function var_0_0._onSkillPlayStart(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1:getMO()

	if var_13_0 and FightCardDataHelper.isBigSkill(arg_13_2) then
		local var_13_1 = FightHelper.getSideEntitys(var_13_0.side)

		for iter_13_0, iter_13_1 in ipairs(var_13_1) do
			GameSceneMgr.instance:getCurScene().bloom:setSingleEntityPass(var_0_0.Bloom_invisible, false, iter_13_1, "buff_bloom")
		end
	end
end

function var_0_0._onSkillPlayFinish(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1:getMO()

	if var_14_0 and FightCardDataHelper.isBigSkill(arg_14_2) then
		local var_14_1 = FightHelper.getSideEntitys(var_14_0.side)

		for iter_14_0, iter_14_1 in ipairs(var_14_1) do
			if iter_14_1.buff then
				iter_14_1.buff:_udpateBuffVariant()
			end
		end
	end
end

return var_0_0
