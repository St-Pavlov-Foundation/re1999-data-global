module("modules.logic.fight.entity.comp.FightBuffComp", package.seeall)

local var_0_0 = class("FightBuffComp", LuaCompBase)
local var_0_1 = 2
local var_0_2 = {
	[FightEnum.BuffType_Petrified] = FightBuffFrozen,
	[FightEnum.BuffType_Frozen] = FightBuffFrozen,
	[FightEnum.BuffTypeId_CoverPerson] = FightBuffCoverPerson,
	[FightEnum.BuffType_ExPointOverflowBank] = FightBuffStoredExPoint,
	[FightEnum.BuffType_ContractBuff] = FightBuffContractBuff,
	[FightEnum.BuffType_BeContractedBuff] = FightBuffBeContractedBuff,
	[FightEnum.BuffType_CardAreaRedOrBlue] = FightBuffCardAreaRedOrBlueBuff,
	[FightEnum.BuffType_RedOrBlueCount] = FightBuffRedOrBlueCountBuff,
	[FightEnum.BuffType_RedOrBlueChangeTrigger] = FightBuffRedOrBlueChangeTriggerBuff,
	[FightEnum.BuffType_SaveFightRecord] = FightBuffSaveFightRecord
}
local var_0_3 = {
	[31080132] = FightBuffAddBKLESpBuff,
	[31080134] = FightBuffAddBKLESpBuff
}

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._entity = arg_1_1
	arg_1_0._animPriorityQueue = PriorityQueue.New(var_0_0.buffCompareFuncAni)
	arg_1_0._matPriorityQueue = PriorityQueue.New(var_0_0.buffCompareFuncMat)
	arg_1_0._buffEffectDict = {}
	arg_1_0._loopBuffEffectWrapDict = {}
	arg_1_0._onceEffectDict = {}
	arg_1_0._buffHandlerDict = {}
	arg_1_0._buff_loop_effect_name = {}
	arg_1_0._curBuffIdDic = {}
	arg_1_0._delBuffEffectDic = {}
	arg_1_0._addBuffEffectPathDic = {}
	arg_1_0._curBuffTypeIdDic = {}
	arg_1_0._buffDic = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0:addEventCb(FightController.instance, FightEvent.CoverPerformanceEntityData, arg_2_0._onCoverPerformanceEntityData, arg_2_0)
end

function var_0_0.dealStartBuff(arg_3_0)
	local var_3_0 = arg_3_0._entity:getMO()

	if var_3_0 then
		arg_3_0.filter_start_buff_stacked = {}

		for iter_3_0, iter_3_1 in pairs(var_3_0:getBuffDic()) do
			arg_3_0:addBuff(iter_3_1, true)
		end

		arg_3_0.filter_start_buff_stacked = nil
	end

	arg_3_0._entity:resetAnimState()
end

function var_0_0.buffCompareFuncAni(arg_4_0, arg_4_1)
	local var_4_0 = lua_skill_buff.configDict[arg_4_0.buffId]
	local var_4_1 = lua_skill_buff.configDict[arg_4_1.buffId]

	if not var_4_0 then
		logError("buff表找不到id:" .. arg_4_0.buffId)
	end

	if not var_4_1 then
		logError("buff表找不到id:" .. arg_4_1.buffId)
	end

	local var_4_2 = lua_skill_bufftype.configDict[var_4_0.typeId]
	local var_4_3 = lua_skill_bufftype.configDict[var_4_1.typeId]

	if not var_4_2 then
		logError("buff类表找不到id:" .. var_4_0.typeId)
	end

	if not var_4_3 then
		logError("buff类表找不到id:" .. var_4_1.typeId)
	end

	local var_4_4 = lua_skill_bufftype.configDict[var_4_0.typeId].aniSort
	local var_4_5 = lua_skill_bufftype.configDict[var_4_1.typeId].aniSort

	if var_4_4 ~= var_4_5 then
		return var_4_5 < var_4_4
	end

	if var_4_4 == 0 and var_4_5 == 0 then
		local var_4_6 = not string.nilorempty(var_4_0.animationName) and var_4_0.animationName ~= "0"
		local var_4_7 = not string.nilorempty(var_4_1.animationName) and var_4_1.animationName ~= "0"

		if var_4_6 and not var_4_7 then
			return true
		elseif not var_4_6 and var_4_7 then
			return false
		end
	end

	if arg_4_0.time ~= arg_4_1.time then
		return arg_4_0.time > arg_4_1.time
	end

	return arg_4_0.id > arg_4_1.id
end

function var_0_0.buffCompareFuncMat(arg_5_0, arg_5_1)
	local var_5_0 = lua_skill_buff.configDict[arg_5_0.buffId]
	local var_5_1 = lua_skill_buff.configDict[arg_5_1.buffId]
	local var_5_2 = lua_skill_bufftype.configDict[var_5_0.typeId].matSort
	local var_5_3 = lua_skill_bufftype.configDict[var_5_1.typeId].matSort

	if var_5_2 ~= var_5_3 then
		return var_5_3 < var_5_2
	end

	if var_5_2 == 0 and var_5_3 == 0 then
		local var_5_4 = not var_0_0.isEmptyMat(var_5_0.mat)
		local var_5_5 = not var_0_0.isEmptyMat(var_5_1.mat)

		if var_5_4 and not var_5_5 then
			return true
		elseif not var_5_4 and var_5_5 then
			return false
		end
	end

	if arg_5_0.time ~= arg_5_1.time then
		return arg_5_0.time > arg_5_1.time
	end

	return arg_5_0.id > arg_5_1.id
end

function var_0_0.haveBuffId(arg_6_0, arg_6_1)
	return arg_6_0._curBuffIdDic[arg_6_1] and arg_6_0._curBuffIdDic[arg_6_1] > 0
end

function var_0_0.haveBuffTypeId(arg_7_0, arg_7_1)
	return arg_7_0._curBuffTypeIdDic[arg_7_1] and arg_7_0._curBuffTypeIdDic[arg_7_1] > 0
end

function var_0_0.addBuff(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_1.type == FightEnum.BuffType.LayerSalveHalo then
		return
	end

	arg_8_0._buffDic[arg_8_1.uid] = arg_8_1

	arg_8_0:_showBuffFloat(arg_8_1)

	local var_8_0 = lua_skill_buff.configDict[arg_8_1.buffId]

	if not var_8_0 then
		return
	end

	arg_8_0._curBuffIdDic[var_8_0.id] = (arg_8_0._curBuffIdDic[var_8_0.id] or 0) + 1
	arg_8_0._curBuffTypeIdDic[var_8_0.typeId] = (arg_8_0._curBuffTypeIdDic[var_8_0.typeId] or 0) + 1

	arg_8_0._animPriorityQueue:add(arg_8_1)
	arg_8_0._matPriorityQueue:add(arg_8_1)
	arg_8_0:_addBuffHandler(arg_8_1)

	local var_8_1 = FightSkillBuffMgr.instance:hasPlayBuffEffect(arg_8_0._entity.id, arg_8_1, arg_8_3)
	local var_8_2 = var_8_0.effectloop ~= 0 or not arg_8_2
	local var_8_3
	local var_8_4, var_8_5, var_8_6 = FightHelper.processBuffEffectPath(var_8_0.effect, arg_8_0._entity, arg_8_1.buffId, "effectPath", var_8_0.audio)
	local var_8_7, var_8_8 = FightHelper.filterBuffEffectBySkin(arg_8_1.buffId, arg_8_0._entity, var_8_4, var_8_5)

	if var_8_8 > 0 and not AudioEffectMgr.instance:isPlaying(var_8_8) then
		AudioEffectMgr.instance:playAudio(var_8_8)
	end

	local var_8_9 = var_8_7 ~= "0" and not string.nilorempty(var_8_7)

	if var_8_9 then
		if string.find(var_8_7, "/") then
			var_8_3 = var_8_7
		else
			var_8_3 = "buff/" .. var_8_7
		end
	end

	local var_8_10 = FightHelper.getEffectUrlWithLod(var_8_3)
	local var_8_11 = arg_8_0._entity.effect:getEffectWrap(var_8_3) and arg_8_0._addBuffEffectPathDic[var_8_10]

	if not var_8_1 and var_8_9 and var_8_2 then
		if not var_8_11 then
			arg_8_0._addBuffEffectPathDic[var_8_10] = true

			local var_8_12
			local var_8_13 = var_8_0.effectHangPoint

			if var_8_6 and not string.nilorempty(var_8_6.effectHang) then
				var_8_13 = var_8_6.effectHang
			end

			if not string.nilorempty(var_8_13) then
				var_8_12 = arg_8_0._entity.effect:addHangEffect(var_8_3, var_8_13)

				var_8_12:setLocalPos(0, 0, 0)

				if var_8_13 == ModuleEnum.SpineHangPointRoot then
					var_8_12:setLocalPos(FightHelper.getAssembledEffectPosOfSpineHangPointRoot(arg_8_0._entity, var_8_3))
				end
			else
				var_8_12 = arg_8_0._entity.effect:addGlobalEffect(var_8_3)

				local var_8_14, var_8_15, var_8_16 = transformhelper.getPos(arg_8_0._entity.go.transform)

				var_8_12:setWorldPos(var_8_14, var_8_15, var_8_16)
			end

			FightRenderOrderMgr.instance:onAddEffectWrap(arg_8_0._entity.id, var_8_12)

			arg_8_0._buffEffectDict[arg_8_1.uid] = var_8_12

			if var_8_0.effectloop == 0 then
				arg_8_0._onceEffectDict[arg_8_1.uid] = Time.time + var_0_1

				TaskDispatcher.runRepeat(arg_8_0._onTickCheckRemoveEffect, arg_8_0, 0.2)
			end
		elseif var_8_0.effectloop ~= 0 then
			for iter_8_0, iter_8_1 in pairs(arg_8_0._buffEffectDict) do
				if iter_8_1.path == var_8_10 then
					arg_8_0._buffEffectDict[arg_8_1.uid] = iter_8_1

					break
				end
			end
		end

		if var_8_0.effectloop ~= 0 then
			arg_8_0._buff_loop_effect_name[var_8_10] = (arg_8_0._buff_loop_effect_name[var_8_10] or 0) + 1
		end
	end

	local var_8_17 = string.nilorempty(var_8_0.animationName) or var_8_0.animationName == "0"
	local var_8_18 = var_0_0.isEmptyMat(var_8_0.mat)
	local var_8_19 = string.nilorempty(var_8_0.bloommat) or var_8_0.bloommat == "0"

	if not var_8_17 or not var_8_18 or not var_8_19 then
		if not var_8_17 then
			arg_8_0._entity:resetAnimState()
		end

		arg_8_0._entity:resetSpineMat()
		GameSceneMgr.instance:getCurScene().bloom:setSingleEntityPass(var_8_0.bloommat, true, arg_8_0._entity, "buff_bloom")
		arg_8_0:_udpateBuffVariant()
	end

	GameSceneMgr.instance:getCurScene().specialEffectMgr:addBuff(arg_8_0._entity, arg_8_1)
	FightController.instance:dispatchEvent(FightEvent.AddEntityBuff, arg_8_0._entity.id, arg_8_1)
end

function var_0_0.setBuffEffectDict(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._loopBuffEffectWrapDict then
		arg_9_0._loopBuffEffectWrapDict[arg_9_1] = arg_9_2
	end
end

function var_0_0._addBuffHandler(arg_10_0, arg_10_1)
	local var_10_0 = lua_skill_buff.configDict[arg_10_1.buffId]

	if not var_10_0 then
		return
	end

	local var_10_1
	local var_10_2 = FightConfig.instance:getBuffFeatures(var_10_0.id)

	for iter_10_0, iter_10_1 in pairs(var_10_2) do
		if var_0_2[iter_10_0] then
			var_10_1 = iter_10_0

			break
		end
	end

	if not var_10_1 then
		local var_10_3 = lua_skill_bufftype.configDict[var_10_0.typeId]

		if var_10_3 and var_0_2[var_10_3.id] then
			var_10_1 = var_10_3.id
		end
	end

	if var_10_1 then
		local var_10_4 = var_0_2[var_10_1]
		local var_10_5 = FightBuffHandlerPool.getHandlerInst(var_10_1, var_10_4)

		if var_10_5 then
			arg_10_0._buffHandlerDict[arg_10_1.uid] = var_10_5

			var_10_5:onBuffStart(arg_10_0._entity, arg_10_1)
		end
	end

	if var_0_3[arg_10_1.buffId] then
		local var_10_6 = var_0_3[arg_10_1.buffId]
		local var_10_7 = FightBuffHandlerPool.getHandlerInst(arg_10_1.buffId, var_10_6)

		if var_10_7 then
			arg_10_0._buffHandlerDict[arg_10_1.uid] = var_10_7

			var_10_7:onBuffStart(arg_10_0._entity, arg_10_1)
		end
	end
end

function var_0_0._removeBuffHandler(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._buffHandlerDict[arg_11_1]

	if var_11_0 then
		arg_11_0._buffHandlerDict[arg_11_1] = nil

		var_11_0:onBuffEnd()
		FightBuffHandlerPool.putHandlerInst(var_11_0)
	end
end

function var_0_0.updateBuff(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_1.type == FightEnum.BuffType.LayerSalveHalo then
		return
	end

	if not FightSkillBuffMgr.instance:hasPlayBuff(arg_12_3) and (arg_12_1.duration > arg_12_2.duration or arg_12_1.count > arg_12_2.count or arg_12_1.layer > arg_12_2.layer) then
		arg_12_0:_showBuffFloat(arg_12_1)
	end
end

function var_0_0._udpateBuffVariant(arg_13_0)
	local var_13_0
	local var_13_1 = arg_13_0._entity.spineRenderer:getReplaceMat()

	if not var_13_1 then
		return
	end

	local var_13_2 = arg_13_0._entity:getMO():getBuffDic()

	for iter_13_0, iter_13_1 in pairs(var_13_2) do
		local var_13_3 = lua_skill_buff.configDict[iter_13_1.buffId]

		if var_13_3 and string.sub(var_13_3.bloommat, 1, #var_13_3.bloommat - 1) == FightSceneBloomComp.Bloom_invisible then
			var_13_0 = string.sub(var_13_3.bloommat, #var_13_3.bloommat)
		end
	end

	if var_13_0 then
		local var_13_4
		local var_13_5
		local var_13_6 = arg_13_0._entity:isMySide() and -1 or 1

		if var_13_0 == "1" then
			var_13_4 = Color.New(0.55, 0.69, 0.71, var_13_6)
			var_13_5 = Color.New(2.7, 6, 14.25, 0)
		end

		if var_13_0 == "2" then
			var_13_4 = Color.New(0.71, 0.59, 0.55, var_13_6)
			var_13_5 = Color.New(13.5, 9, 9, 0)
		end

		if var_13_0 == "3" then
			var_13_4 = Color.New(0.7, 0.7, 0.7, var_13_6)
			var_13_5 = Color.New(4.5, 4.5, 4.5, 0)
		end

		if var_13_4 then
			GameSceneMgr.instance:getCurScene().bloom:setSingleEntityPass(FightSceneBloomComp.Bloom_invisible, true, arg_13_0._entity, "buff_bloom")
			var_13_1:SetColor(UnityEngine.Shader.PropertyToID("_InvisibleColor"), var_13_4)
			var_13_1:SetColor(UnityEngine.Shader.PropertyToID("_InvisibleColor1"), var_13_5)
		end
	else
		GameSceneMgr.instance:getCurScene().bloom:setSingleEntityPass(FightSceneBloomComp.Bloom_invisible, false, arg_13_0._entity, "buff_bloom")
	end
end

function var_0_0._onTickCheckRemoveEffect(arg_14_0)
	local var_14_0
	local var_14_1 = Time.time

	for iter_14_0, iter_14_1 in pairs(arg_14_0._onceEffectDict) do
		if iter_14_1 < var_14_1 then
			var_14_0 = var_14_0 or {}

			table.insert(var_14_0, iter_14_0)
		end
	end

	if var_14_0 then
		for iter_14_2, iter_14_3 in ipairs(var_14_0) do
			local var_14_2 = arg_14_0._buffEffectDict[iter_14_3]

			arg_14_0._entity.effect:removeEffect(var_14_2)

			arg_14_0._buffEffectDict[iter_14_3] = nil
			arg_14_0._onceEffectDict[iter_14_3] = nil
			arg_14_0._addBuffEffectPathDic[var_14_2.path] = nil
		end
	end

	if tabletool.len(arg_14_0._onceEffectDict) == 0 then
		TaskDispatcher.cancelTask(arg_14_0._onTickCheckRemoveEffect, arg_14_0)
	end
end

function var_0_0._onTickCheckRemoveDelBuffEffect(arg_15_0)
	local var_15_0 = Time.time

	for iter_15_0, iter_15_1 in pairs(arg_15_0._delBuffEffectDic) do
		if var_15_0 > iter_15_1.time then
			local var_15_1 = iter_15_1.effectWrap

			arg_15_0._entity.effect:removeEffect(var_15_1)

			arg_15_0._delBuffEffectDic[iter_15_0] = nil
		end
	end

	if tabletool.len(arg_15_0._delBuffEffectDic) == 0 then
		TaskDispatcher.cancelTask(arg_15_0._onTickCheckRemoveDelBuffEffect, arg_15_0)
	end
end

function var_0_0.showBuffEffects(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in pairs(arg_16_0._buffEffectDict) do
		iter_16_1:setActive(true, arg_16_1)
	end

	for iter_16_2, iter_16_3 in pairs(arg_16_0._loopBuffEffectWrapDict) do
		iter_16_3:setActive(true, arg_16_1)
	end

	GameSceneMgr.instance:getCurScene().specialEffectMgr:setBuffEffectVisible(arg_16_0._entity, true)
	FightController.instance:dispatchEvent(FightEvent.SetBuffEffectVisible, arg_16_0._entity.id, true)
end

function var_0_0.hideBuffEffects(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in pairs(arg_17_0._buffEffectDict) do
		iter_17_1:setActive(false, arg_17_1)
	end

	for iter_17_2, iter_17_3 in pairs(arg_17_0._loopBuffEffectWrapDict) do
		iter_17_3:setActive(false, arg_17_1)
	end

	GameSceneMgr.instance:getCurScene().specialEffectMgr:setBuffEffectVisible(arg_17_0._entity, false)
	FightController.instance:dispatchEvent(FightEvent.SetBuffEffectVisible, arg_17_0._entity.id, false)
end

function var_0_0.hideLoopEffects(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._entity:getMO()

	if not var_18_0 then
		return
	end

	for iter_18_0, iter_18_1 in pairs(arg_18_0._buffEffectDict) do
		local var_18_1 = var_18_0:getBuffMO(iter_18_0)
		local var_18_2 = var_18_1 and lua_skill_buff.configDict[var_18_1.buffId]

		if var_18_2 then
			local var_18_3 = lua_skill_bufftype.configDict[var_18_2.typeId]

			if var_18_1 and var_18_2.effectloop == 1 and var_18_3.playEffect == 0 then
				iter_18_1:setActive(false, arg_18_1)
			end
		elseif var_18_1 then
			logError("buff表找不到id:" .. var_18_1.buffId)
		end
	end

	for iter_18_2, iter_18_3 in pairs(arg_18_0._loopBuffEffectWrapDict) do
		iter_18_3:setActive(false, arg_18_1)
	end
end

function var_0_0._showBuffFloat(arg_19_0, arg_19_1)
	if arg_19_0.lockFloat then
		return
	end

	if arg_19_1.type == FightEnum.BuffType.LayerSalveHalo then
		return
	end

	local var_19_0 = lua_skill_buff.configDict[arg_19_1.buffId]

	if var_19_0 then
		if arg_19_0.filter_start_buff_stacked and FightSkillBuffMgr.instance:buffIsStackerBuff(var_19_0) then
			if arg_19_0.filter_start_buff_stacked[arg_19_1.buffId] then
				return
			else
				arg_19_0.filter_start_buff_stacked[arg_19_1.buffId] = true
			end
		end

		local var_19_1 = lua_skill_bufftype.configDict[var_19_0.typeId]

		if var_19_1 and var_19_1.dontShowFloat ~= 0 then
			local var_19_2 = var_19_0.name

			if FightSkillBuffMgr.instance:buffIsStackerBuff(var_19_0) and var_19_1.takeStage == -1 then
				local var_19_3 = FightSkillBuffMgr.instance:getStackedCount(arg_19_0._entity.id, arg_19_1)

				var_19_2 = var_19_2 .. luaLang("multiple") .. var_19_3
			end

			FightFloatMgr.instance:float(arg_19_1.entityId, FightEnum.FloatType.buff, var_19_2, var_19_1.dontShowFloat)
		end
	end
end

function var_0_0._onCoverPerformanceEntityData(arg_20_0, arg_20_1)
	if arg_20_0._entity and arg_20_0._entity.id == arg_20_1 and arg_20_0._buffDic then
		local var_20_0 = FightDataHelper.entityMgr:getById(arg_20_1)

		if var_20_0 then
			for iter_20_0, iter_20_1 in pairs(arg_20_0._buffDic) do
				if not var_20_0.buffDic[iter_20_0] then
					arg_20_0:delBuff(iter_20_0)
				end
			end
		end
	end
end

local var_0_4 = {
	[4150003] = true
}

function var_0_0.delBuff(arg_21_0, arg_21_1, arg_21_2)
	if not arg_21_0._buffDic then
		return
	end

	local var_21_0 = arg_21_0._buffDic[arg_21_1]

	if not var_21_0 then
		return
	end

	arg_21_0._buffDic[arg_21_1] = nil

	if var_21_0.type == FightEnum.BuffType.LayerSalveHalo then
		return
	end

	local var_21_1 = var_21_0.uid
	local var_21_2 = lua_skill_buff.configDict[var_21_0.buffId]

	if var_21_2 then
		if arg_21_0._curBuffIdDic[var_21_2.id] then
			arg_21_0._curBuffIdDic[var_21_2.id] = arg_21_0._curBuffIdDic[var_21_2.id] - 1
		end

		if arg_21_0._curBuffTypeIdDic[var_21_2.typeId] then
			arg_21_0._curBuffTypeIdDic[var_21_2.typeId] = arg_21_0._curBuffTypeIdDic[var_21_2.typeId] - 1
		end

		local function var_21_3(arg_22_0)
			return arg_22_0.id == var_21_0.id
		end

		local var_21_4 = arg_21_0._animPriorityQueue:getSize()

		arg_21_0._animPriorityQueue:markRemove(var_21_3)
		arg_21_0._matPriorityQueue:markRemove(var_21_3)

		if var_21_2.effect ~= "0" and not string.nilorempty(var_21_2.effect) then
			local var_21_5 = arg_21_0._buffEffectDict[var_21_1]

			if var_21_5 then
				arg_21_0._buffEffectDict[var_21_1] = nil
				arg_21_0._onceEffectDict[var_21_1] = nil

				if arg_21_0._buff_loop_effect_name[var_21_5.path] then
					arg_21_0._buff_loop_effect_name[var_21_5.path] = arg_21_0._buff_loop_effect_name[var_21_5.path] - 1
				end

				if (arg_21_0._buff_loop_effect_name[var_21_5.path] or 0) == 0 then
					arg_21_0._addBuffEffectPathDic[var_21_5.path] = nil

					arg_21_0._entity.effect:removeEffect(var_21_5)
					FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_21_0._entity.id, var_21_5)
				end
			end
		end

		local var_21_6 = GameSceneMgr.instance:getCurScene().entityMgr:getEntity(arg_21_0._entity.id)
		local var_21_7 = var_21_2.id
		local var_21_8, var_21_9 = FightHelper.processBuffEffectPath(var_21_2.delEffect, arg_21_0._entity, var_21_7, "delEffect", var_21_2.delAudio)
		local var_21_10, var_21_11 = FightHelper.filterBuffEffectBySkin(var_21_7, arg_21_0._entity, var_21_8, var_21_9)

		if var_21_11 > 0 then
			FightAudioMgr.instance:playAudio(var_21_11)
		end

		if var_21_6 and var_21_10 ~= "0" and not string.nilorempty(var_21_10) then
			local var_21_12 = true

			if arg_21_2 and var_0_4[var_21_2.id] then
				var_21_12 = false
			end

			if var_21_12 then
				local var_21_13

				if string.find(var_21_10, "/") then
					-- block empty
				else
					var_21_10 = "buff/" .. var_21_10
				end

				if not string.nilorempty(var_21_2.delEffectHangPoint) then
					var_21_13 = arg_21_0._entity.effect:addHangEffect(var_21_10, var_21_2.delEffectHangPoint)

					var_21_13:setLocalPos(0, 0, 0)

					if var_21_2.delEffectHangPoint == ModuleEnum.SpineHangPointRoot then
						var_21_13:setLocalPos(FightHelper.getAssembledEffectPosOfSpineHangPointRoot(arg_21_0._entity, var_21_10))
					end
				else
					var_21_13 = arg_21_0._entity.effect:addGlobalEffect(var_21_10)

					local var_21_14, var_21_15, var_21_16 = transformhelper.getPos(arg_21_0._entity.go.transform)

					var_21_13:setWorldPos(var_21_14, var_21_15, var_21_16)
				end

				FightRenderOrderMgr.instance:onAddEffectWrap(arg_21_0._entity.id, var_21_13)

				arg_21_0._delBuffEffectDic[var_21_1] = {
					effectWrap = var_21_13,
					time = Time.time + var_0_1
				}

				TaskDispatcher.runRepeat(arg_21_0._onTickCheckRemoveDelBuffEffect, arg_21_0, 0.2)
			end
		end

		arg_21_0:_removeBuffHandler(var_21_1)

		local var_21_17 = string.nilorempty(var_21_2.animationName) or var_21_2.animationName == "0"
		local var_21_18 = var_0_0.isEmptyMat(var_21_2.mat)
		local var_21_19 = string.nilorempty(var_21_2.bloommat) or var_21_2.bloommat == "0"

		if not var_21_17 or not var_21_18 or not var_21_19 then
			arg_21_0._entity:resetAnimState()
			arg_21_0._entity:resetSpineMat()
			GameSceneMgr.instance:getCurScene().bloom:setSingleEntityPass(var_21_2.bloommat, false, arg_21_0._entity, "buff_bloom")
			arg_21_0:_udpateBuffVariant()
		end
	end

	GameSceneMgr.instance:getCurScene().specialEffectMgr:delBuff(arg_21_0._entity, var_21_0)
	FightController.instance:dispatchEvent(FightEvent.RemoveEntityBuff, arg_21_0._entity.id, var_21_0)
end

function var_0_0.getBuffAnim(arg_23_0)
	local var_23_0 = arg_23_0._animPriorityQueue:getFirst()

	if var_23_0 then
		local var_23_1 = lua_skill_buff.configDict[var_23_0.buffId]

		if var_23_1 and not (string.nilorempty(var_23_1.animationName) or var_23_1.animationName == "0") then
			return var_23_1.animationName, var_23_0
		end
	end
end

function var_0_0.getBuffMatName(arg_24_0)
	local var_24_0 = arg_24_0._matPriorityQueue:getFirst()

	if var_24_0 then
		local var_24_1 = lua_skill_buff.configDict[var_24_0.buffId]

		if var_24_1 and not var_0_0.isEmptyMat(var_24_1.mat) then
			return var_24_1.mat, var_24_0
		end
	end
end

function var_0_0.isEmptyMat(arg_25_0)
	return arg_25_0 == nil or arg_25_0 == "" or arg_25_0 == "0" or arg_25_0 == "buff_immune"
end

function var_0_0.clear(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0._buffHandlerDict) do
		FightBuffHandlerPool.putHandlerInst(iter_26_1)
	end
end

function var_0_0.releaseAllBuff(arg_27_0)
	if arg_27_0._buffDic then
		for iter_27_0, iter_27_1 in pairs(arg_27_0._buffDic) do
			arg_27_0:delBuff(iter_27_1.uid)
		end
	end
end

function var_0_0.beforeDestroy(arg_28_0)
	local var_28_0 = arg_28_0._entity:getMO()

	if var_28_0 then
		for iter_28_0, iter_28_1 in pairs(var_28_0:getBuffDic()) do
			arg_28_0:delBuff(iter_28_1.uid)
		end
	end

	GameSceneMgr.instance:getCurScene().specialEffectMgr:clearEffect(arg_28_0._entity)
end

function var_0_0.onDestroy(arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0._onTickCheckRemoveEffect, arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0._onTickCheckRemoveDelBuffEffect, arg_29_0)

	for iter_29_0, iter_29_1 in pairs(arg_29_0._buffHandlerDict) do
		FightBuffHandlerPool.putHandlerInst(iter_29_1)
	end

	arg_29_0._buffEffectDict = nil
	arg_29_0._loopBuffEffectWrapDict = nil
	arg_29_0._onceEffectDict = nil
	arg_29_0._buffHandlerDict = nil
	arg_29_0._buff_loop_effect_name = nil
	arg_29_0.lockFloat = nil
	arg_29_0._buffDic = nil
end

return var_0_0
