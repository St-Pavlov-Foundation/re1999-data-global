module("modules.logic.fight.entity.comp.FightBuffComp", package.seeall)

slot0 = class("FightBuffComp", LuaCompBase)
slot1 = 2
slot2 = {
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
slot3 = {
	[31080132] = FightBuffAddBKLESpBuff,
	[31080134] = FightBuffAddBKLESpBuff
}

function slot0.ctor(slot0, slot1)
	slot0._entity = slot1
	slot0._animPriorityQueue = PriorityQueue.New(uv0.buffCompareFuncAni)
	slot0._matPriorityQueue = PriorityQueue.New(uv0.buffCompareFuncMat)
	slot0._buffEffectDict = {}
	slot0._loopBuffEffectWrapDict = {}
	slot0._onceEffectDict = {}
	slot0._buffHandlerDict = {}
	slot0._buff_loop_effect_name = {}
	slot0._curBuffIdDic = {}
	slot0._delBuffEffectDic = {}
	slot0._addBuffEffectPathDic = {}
	slot0._curBuffTypeIdDic = {}
	slot0._buffDic = {}
end

function slot0.init(slot0, slot1)
	slot0:addEventCb(FightController.instance, FightEvent.CoverPerformanceEntityData, slot0._onCoverPerformanceEntityData, slot0)
end

function slot0.dealStartBuff(slot0)
	if slot0._entity:getMO() then
		slot0.filter_start_buff_stacked = {}

		for slot5, slot6 in pairs(slot1:getBuffDic()) do
			slot0:addBuff(slot6, true)
		end

		slot0.filter_start_buff_stacked = nil
	end

	slot0._entity:resetAnimState()
end

function slot0.buffCompareFuncAni(slot0, slot1)
	slot3 = lua_skill_buff.configDict[slot1.buffId]

	if not lua_skill_buff.configDict[slot0.buffId] then
		logError("buff表找不到id:" .. slot0.buffId)
	end

	if not slot3 then
		logError("buff表找不到id:" .. slot1.buffId)
	end

	slot5 = lua_skill_bufftype.configDict[slot3.typeId]

	if not lua_skill_bufftype.configDict[slot2.typeId] then
		logError("buff类表找不到id:" .. slot2.typeId)
	end

	if not slot5 then
		logError("buff类表找不到id:" .. slot3.typeId)
	end

	if lua_skill_bufftype.configDict[slot2.typeId].aniSort ~= lua_skill_bufftype.configDict[slot3.typeId].aniSort then
		return slot7 < slot6
	end

	if slot6 == 0 and slot7 == 0 then
		if not string.nilorempty(slot2.animationName) and slot2.animationName ~= "0" and not (not string.nilorempty(slot3.animationName) and slot3.animationName ~= "0") then
			return true
		elseif not slot8 and slot9 then
			return false
		end
	end

	if slot0.time ~= slot1.time then
		return slot1.time < slot0.time
	end

	return slot1.id < slot0.id
end

function slot0.buffCompareFuncMat(slot0, slot1)
	if lua_skill_bufftype.configDict[lua_skill_buff.configDict[slot0.buffId].typeId].matSort ~= lua_skill_bufftype.configDict[lua_skill_buff.configDict[slot1.buffId].typeId].matSort then
		return slot5 < slot4
	end

	if slot4 == 0 and slot5 == 0 then
		if not uv0.isEmptyMat(slot2.mat) and not not uv0.isEmptyMat(slot3.mat) then
			return true
		elseif not slot6 and slot7 then
			return false
		end
	end

	if slot0.time ~= slot1.time then
		return slot1.time < slot0.time
	end

	return slot1.id < slot0.id
end

function slot0.haveBuffId(slot0, slot1)
	return slot0._curBuffIdDic[slot1] and slot0._curBuffIdDic[slot1] > 0
end

function slot0.haveBuffTypeId(slot0, slot1)
	return slot0._curBuffTypeIdDic[slot1] and slot0._curBuffTypeIdDic[slot1] > 0
end

function slot0.addBuff(slot0, slot1, slot2, slot3)
	if slot1.type == FightEnum.BuffType.LayerSalveHalo then
		return
	end

	slot0._buffDic[slot1.uid] = slot1

	slot0:_showBuffFloat(slot1)

	if not lua_skill_buff.configDict[slot1.buffId] then
		return
	end

	slot0._curBuffIdDic[slot5.id] = (slot0._curBuffIdDic[slot5.id] or 0) + 1
	slot0._curBuffTypeIdDic[slot5.typeId] = (slot0._curBuffTypeIdDic[slot5.typeId] or 0) + 1

	slot0._animPriorityQueue:add(slot1)
	slot0._matPriorityQueue:add(slot1)
	slot0:_addBuffHandler(slot1)

	slot6 = FightSkillBuffMgr.instance:hasPlayBuffEffect(slot0._entity.id, slot1, slot3)
	slot7 = slot5.effectloop ~= 0 or not slot2
	slot8 = nil
	slot9, slot10, slot11 = FightHelper.processBuffEffectPath(slot5.effect, slot0._entity, slot1.buffId, "effectPath", slot5.audio)
	slot9, slot13 = FightHelper.filterBuffEffectBySkin(slot1.buffId, slot0._entity, slot9, slot10)

	if slot13 > 0 and not AudioEffectMgr.instance:isPlaying(slot10) then
		AudioEffectMgr.instance:playAudio(slot10)
	end

	if slot9 ~= "0" and not string.nilorempty(slot9) then
		slot8 = string.find(slot9, "/") and slot9 or "buff/" .. slot9
	end

	if not slot6 and slot12 and slot7 then
		if not (slot0._entity.effect:getEffectWrap(slot8) and slot0._addBuffEffectPathDic[FightHelper.getEffectUrlWithLod(slot8)]) then
			slot0._addBuffEffectPathDic[slot13] = true
			slot15 = nil
			slot16 = slot5.effectHangPoint

			if slot11 and not string.nilorempty(slot11.effectHang) then
				slot16 = slot11.effectHang
			end

			if not string.nilorempty(slot16) then
				slot0._entity.effect:addHangEffect(slot8, slot16):setLocalPos(0, 0, 0)

				if slot16 == ModuleEnum.SpineHangPointRoot then
					slot15:setLocalPos(FightHelper.getAssembledEffectPosOfSpineHangPointRoot(slot0._entity, slot8))
				end
			else
				slot17, slot18, slot19 = transformhelper.getPos(slot0._entity.go.transform)

				slot0._entity.effect:addGlobalEffect(slot8):setWorldPos(slot17, slot18, slot19)
			end

			FightRenderOrderMgr.instance:onAddEffectWrap(slot0._entity.id, slot15)

			slot0._buffEffectDict[slot1.uid] = slot15

			if slot5.effectloop == 0 then
				slot0._onceEffectDict[slot1.uid] = Time.time + uv0

				TaskDispatcher.runRepeat(slot0._onTickCheckRemoveEffect, slot0, 0.2)
			end
		elseif slot5.effectloop ~= 0 then
			for slot18, slot19 in pairs(slot0._buffEffectDict) do
				if slot19.path == slot13 then
					slot0._buffEffectDict[slot1.uid] = slot19

					break
				end
			end
		end

		if slot5.effectloop ~= 0 then
			slot0._buff_loop_effect_name[slot13] = (slot0._buff_loop_effect_name[slot13] or 0) + 1
		end
	end

	if not string.nilorempty(slot5.animationName) and slot5.animationName ~= "0" or not uv1.isEmptyMat(slot5.mat) or not (string.nilorempty(slot5.bloommat) or slot5.bloommat == "0") then
		if not slot15 then
			slot0._entity:resetAnimState()
		end

		slot0._entity:resetSpineMat()
		GameSceneMgr.instance:getCurScene().bloom:setSingleEntityPass(slot5.bloommat, true, slot0._entity, "buff_bloom")
		slot0:_udpateBuffVariant()
	end

	GameSceneMgr.instance:getCurScene().specialEffectMgr:addBuff(slot0._entity, slot1)
	FightController.instance:dispatchEvent(FightEvent.AddEntityBuff, slot0._entity.id, slot1)
end

function slot0.setBuffEffectDict(slot0, slot1, slot2)
	if slot0._loopBuffEffectWrapDict then
		slot0._loopBuffEffectWrapDict[slot1] = slot2
	end
end

function slot0._addBuffHandler(slot0, slot1)
	if not lua_skill_buff.configDict[slot1.buffId] then
		return
	end

	slot3 = nil

	for slot8, slot9 in pairs(FightConfig.instance:getBuffFeatures(slot2.id)) do
		if uv0[slot8] then
			slot3 = slot8

			break
		end
	end

	if not slot3 and lua_skill_bufftype.configDict[slot2.typeId] and uv0[slot5.id] then
		slot3 = slot5.id
	end

	if slot3 and FightBuffHandlerPool.getHandlerInst(slot3, uv0[slot3]) then
		slot0._buffHandlerDict[slot1.uid] = slot6

		slot6:onBuffStart(slot0._entity, slot1)
	end

	if uv1[slot1.buffId] and FightBuffHandlerPool.getHandlerInst(slot1.buffId, uv1[slot1.buffId]) then
		slot0._buffHandlerDict[slot1.uid] = slot6

		slot6:onBuffStart(slot0._entity, slot1)
	end
end

function slot0._removeBuffHandler(slot0, slot1)
	if slot0._buffHandlerDict[slot1] then
		slot0._buffHandlerDict[slot1] = nil

		slot2:onBuffEnd()
		FightBuffHandlerPool.putHandlerInst(slot2)
	end
end

function slot0.updateBuff(slot0, slot1, slot2, slot3)
	if slot1.type == FightEnum.BuffType.LayerSalveHalo then
		return
	end

	if not FightSkillBuffMgr.instance:hasPlayBuff(slot3) and (slot2.duration < slot1.duration or slot2.count < slot1.count or slot2.layer < slot1.layer) then
		slot0:_showBuffFloat(slot1)
	end
end

function slot0._udpateBuffVariant(slot0)
	slot1 = nil

	if not slot0._entity.spineRenderer:getReplaceMat() then
		return
	end

	for slot7, slot8 in pairs(slot0._entity:getMO():getBuffDic()) do
		if lua_skill_buff.configDict[slot8.buffId] and string.sub(slot9.bloommat, 1, #slot9.bloommat - 1) == FightSceneBloomComp.Bloom_invisible then
			slot1 = string.sub(slot9.bloommat, #slot9.bloommat)
		end
	end

	if slot1 then
		slot4, slot5 = nil

		if slot1 == "1" then
			slot4 = Color.New(0.55, 0.69, 0.71, slot0._entity:isMySide() and -1 or 1)
			slot5 = Color.New(2.7, 6, 14.25, 0)
		end

		if slot1 == "2" then
			slot4 = Color.New(0.71, 0.59, 0.55, slot6)
			slot5 = Color.New(13.5, 9, 9, 0)
		end

		if slot1 == "3" then
			slot4 = Color.New(0.7, 0.7, 0.7, slot6)
			slot5 = Color.New(4.5, 4.5, 4.5, 0)
		end

		if slot4 then
			GameSceneMgr.instance:getCurScene().bloom:setSingleEntityPass(FightSceneBloomComp.Bloom_invisible, true, slot0._entity, "buff_bloom")
			slot2:SetColor(UnityEngine.Shader.PropertyToID("_InvisibleColor"), slot4)
			slot2:SetColor(UnityEngine.Shader.PropertyToID("_InvisibleColor1"), slot5)
		end
	else
		GameSceneMgr.instance:getCurScene().bloom:setSingleEntityPass(FightSceneBloomComp.Bloom_invisible, false, slot0._entity, "buff_bloom")
	end
end

function slot0._onTickCheckRemoveEffect(slot0)
	slot1 = nil

	for slot6, slot7 in pairs(slot0._onceEffectDict) do
		if slot7 < Time.time then
			table.insert(slot1 or {}, slot6)
		end
	end

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			slot8 = slot0._buffEffectDict[slot7]

			slot0._entity.effect:removeEffect(slot8)

			slot0._buffEffectDict[slot7] = nil
			slot0._onceEffectDict[slot7] = nil
			slot0._addBuffEffectPathDic[slot8.path] = nil
		end
	end

	if tabletool.len(slot0._onceEffectDict) == 0 then
		TaskDispatcher.cancelTask(slot0._onTickCheckRemoveEffect, slot0)
	end
end

function slot0._onTickCheckRemoveDelBuffEffect(slot0)
	for slot5, slot6 in pairs(slot0._delBuffEffectDic) do
		if slot6.time < Time.time then
			slot0._entity.effect:removeEffect(slot6.effectWrap)

			slot0._delBuffEffectDic[slot5] = nil
		end
	end

	if tabletool.len(slot0._delBuffEffectDic) == 0 then
		TaskDispatcher.cancelTask(slot0._onTickCheckRemoveDelBuffEffect, slot0)
	end
end

function slot0.showBuffEffects(slot0, slot1)
	for slot5, slot6 in pairs(slot0._buffEffectDict) do
		slot6:setActive(true, slot1)
	end

	for slot5, slot6 in pairs(slot0._loopBuffEffectWrapDict) do
		slot6:setActive(true, slot1)
	end

	GameSceneMgr.instance:getCurScene().specialEffectMgr:setBuffEffectVisible(slot0._entity, true)
	FightController.instance:dispatchEvent(FightEvent.SetBuffEffectVisible, slot0._entity.id, true)
end

function slot0.hideBuffEffects(slot0, slot1)
	for slot5, slot6 in pairs(slot0._buffEffectDict) do
		slot6:setActive(false, slot1)
	end

	for slot5, slot6 in pairs(slot0._loopBuffEffectWrapDict) do
		slot6:setActive(false, slot1)
	end

	GameSceneMgr.instance:getCurScene().specialEffectMgr:setBuffEffectVisible(slot0._entity, false)
	FightController.instance:dispatchEvent(FightEvent.SetBuffEffectVisible, slot0._entity.id, false)
end

function slot0.hideLoopEffects(slot0, slot1)
	if not slot0._entity:getMO() then
		return
	end

	for slot6, slot7 in pairs(slot0._buffEffectDict) do
		if slot2:getBuffMO(slot6) and lua_skill_buff.configDict[slot8.buffId] then
			if slot8 and slot9.effectloop == 1 and lua_skill_bufftype.configDict[slot9.typeId].playEffect == 0 then
				slot7:setActive(false, slot1)
			end
		elseif slot8 then
			logError("buff表找不到id:" .. slot8.buffId)
		end
	end

	for slot6, slot7 in pairs(slot0._loopBuffEffectWrapDict) do
		slot7:setActive(false, slot1)
	end
end

function slot0._showBuffFloat(slot0, slot1)
	if slot0.lockFloat then
		return
	end

	if slot1.type == FightEnum.BuffType.LayerSalveHalo then
		return
	end

	if lua_skill_buff.configDict[slot1.buffId] then
		if slot0.filter_start_buff_stacked and FightSkillBuffMgr.instance:buffIsStackerBuff(slot2) then
			if slot0.filter_start_buff_stacked[slot1.buffId] then
				return
			else
				slot0.filter_start_buff_stacked[slot1.buffId] = true
			end
		end

		if lua_skill_bufftype.configDict[slot2.typeId] and slot3.dontShowFloat ~= 0 then
			if FightSkillBuffMgr.instance:buffIsStackerBuff(slot2) and slot3.takeStage == -1 then
				slot4 = slot2.name .. luaLang("multiple") .. FightSkillBuffMgr.instance:getStackedCount(slot0._entity.id, slot1)
			end

			FightFloatMgr.instance:float(slot1.entityId, FightEnum.FloatType.buff, slot4, slot3.dontShowFloat)
		end
	end
end

function slot0._onCoverPerformanceEntityData(slot0, slot1)
	if slot0._entity and slot0._entity.id == slot1 and slot0._buffDic and FightDataHelper.entityMgr:getById(slot1) then
		for slot6, slot7 in pairs(slot0._buffDic) do
			if not slot2.buffDic[slot6] then
				slot0:delBuff(slot6)
			end
		end
	end
end

slot4 = {
	[4150003.0] = true
}

function slot0.delBuff(slot0, slot1, slot2)
	if not slot0._buffDic then
		return
	end

	if not slot0._buffDic[slot1] then
		return
	end

	slot0._buffDic[slot1] = nil

	if slot3.type == FightEnum.BuffType.LayerSalveHalo then
		return
	end

	slot5 = slot3.uid

	if lua_skill_buff.configDict[slot3.buffId] then
		if slot0._curBuffIdDic[slot6.id] then
			slot0._curBuffIdDic[slot6.id] = slot0._curBuffIdDic[slot6.id] - 1
		end

		if slot0._curBuffTypeIdDic[slot6.typeId] then
			slot0._curBuffTypeIdDic[slot6.typeId] = slot0._curBuffTypeIdDic[slot6.typeId] - 1
		end

		function slot7(slot0)
			return slot0.id == uv0.id
		end

		slot8 = slot0._animPriorityQueue:getSize()

		slot0._animPriorityQueue:markRemove(slot7)
		slot0._matPriorityQueue:markRemove(slot7)

		if slot6.effect ~= "0" and not string.nilorempty(slot6.effect) and slot0._buffEffectDict[slot5] then
			slot0._buffEffectDict[slot5] = nil
			slot0._onceEffectDict[slot5] = nil

			if slot0._buff_loop_effect_name[slot9.path] then
				slot0._buff_loop_effect_name[slot9.path] = slot0._buff_loop_effect_name[slot9.path] - 1
			end

			if (slot0._buff_loop_effect_name[slot9.path] or 0) == 0 then
				slot0._addBuffEffectPathDic[slot9.path] = nil

				slot0._entity.effect:removeEffect(slot9)
				FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0._entity.id, slot9)
			end
		end

		slot10 = GameSceneMgr.instance:getCurScene().entityMgr:getEntity(slot0._entity.id)
		slot11 = slot6.id
		slot12, slot13 = FightHelper.processBuffEffectPath(slot6.delEffect, slot0._entity, slot11, "delEffect", slot6.delAudio)
		slot12, slot15 = FightHelper.filterBuffEffectBySkin(slot11, slot0._entity, slot12, slot13)

		if slot15 > 0 then
			FightAudioMgr.instance:playAudio(slot13)
		end

		if slot10 and slot12 ~= "0" and not string.nilorempty(slot12) then
			slot14 = true

			if slot2 and uv0[slot6.id] then
				slot14 = false
			end

			if slot14 then
				slot15 = nil

				if not string.find(slot12, "/") then
					slot12 = "buff/" .. slot12
				end

				if not string.nilorempty(slot6.delEffectHangPoint) then
					slot0._entity.effect:addHangEffect(slot12, slot6.delEffectHangPoint):setLocalPos(0, 0, 0)

					if slot6.delEffectHangPoint == ModuleEnum.SpineHangPointRoot then
						slot15:setLocalPos(FightHelper.getAssembledEffectPosOfSpineHangPointRoot(slot0._entity, slot12))
					end
				else
					slot17, slot18, slot19 = transformhelper.getPos(slot0._entity.go.transform)

					slot0._entity.effect:addGlobalEffect(slot12):setWorldPos(slot17, slot18, slot19)
				end

				FightRenderOrderMgr.instance:onAddEffectWrap(slot0._entity.id, slot15)

				slot0._delBuffEffectDic[slot5] = {
					effectWrap = slot15,
					time = Time.time + uv1
				}

				TaskDispatcher.runRepeat(slot0._onTickCheckRemoveDelBuffEffect, slot0, 0.2)
			end
		end

		slot0:_removeBuffHandler(slot5)

		if not string.nilorempty(slot6.animationName) and slot6.animationName ~= "0" or not uv2.isEmptyMat(slot6.mat) or not (string.nilorempty(slot6.bloommat) or slot6.bloommat == "0") then
			slot0._entity:resetAnimState()
			slot0._entity:resetSpineMat()
			GameSceneMgr.instance:getCurScene().bloom:setSingleEntityPass(slot6.bloommat, false, slot0._entity, "buff_bloom")
			slot0:_udpateBuffVariant()
		end
	end

	GameSceneMgr.instance:getCurScene().specialEffectMgr:delBuff(slot0._entity, slot3)
	FightController.instance:dispatchEvent(FightEvent.RemoveEntityBuff, slot0._entity.id, slot3)
end

function slot0.getBuffAnim(slot0)
	if slot0._animPriorityQueue:getFirst() and lua_skill_buff.configDict[slot1.buffId] and not (string.nilorempty(slot2.animationName) or slot2.animationName == "0") then
		return slot2.animationName, slot1
	end
end

function slot0.getBuffMatName(slot0)
	if slot0._matPriorityQueue:getFirst() and lua_skill_buff.configDict[slot1.buffId] and not uv0.isEmptyMat(slot2.mat) then
		return slot2.mat, slot1
	end
end

function slot0.isEmptyMat(slot0)
	return slot0 == nil or slot0 == "" or slot0 == "0" or slot0 == "buff_immune"
end

function slot0.clear(slot0)
	for slot4, slot5 in pairs(slot0._buffHandlerDict) do
		FightBuffHandlerPool.putHandlerInst(slot5)
	end
end

function slot0.releaseAllBuff(slot0)
	if slot0._buffDic then
		for slot4, slot5 in pairs(slot0._buffDic) do
			slot0:delBuff(slot5.uid)
		end
	end
end

function slot0.beforeDestroy(slot0)
	if slot0._entity:getMO() then
		for slot5, slot6 in pairs(slot1:getBuffDic()) do
			slot0:delBuff(slot6.uid)
		end
	end

	GameSceneMgr.instance:getCurScene().specialEffectMgr:clearEffect(slot0._entity)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._onTickCheckRemoveEffect, slot0)
	TaskDispatcher.cancelTask(slot0._onTickCheckRemoveDelBuffEffect, slot0)

	for slot4, slot5 in pairs(slot0._buffHandlerDict) do
		FightBuffHandlerPool.putHandlerInst(slot5)
	end

	slot0._buffEffectDict = nil
	slot0._loopBuffEffectWrapDict = nil
	slot0._onceEffectDict = nil
	slot0._buffHandlerDict = nil
	slot0._buff_loop_effect_name = nil
	slot0.lockFloat = nil
	slot0._buffDic = nil
end

return slot0
