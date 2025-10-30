module("modules.logic.fight.entity.comp.buff.FightBuffWELXStarComp", package.seeall)

local var_0_0 = class("FightBuffWELXStarComp", FightBuffHandleClsBase)

var_0_0.MoveTweenTime = 0.5

function var_0_0.onBuffStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.entityId = arg_1_1.id
	arg_1_0.entity = arg_1_1
	arg_1_0.entityMo = arg_1_1:getMO()

	arg_1_0:initValidBuffDict()
	arg_1_0:initOffsetXY()

	arg_1_0.movingTweenId = nil
	arg_1_0.effectPool = {}
	arg_1_0.effectItemPool = {}
	arg_1_0.effectItemList = {}
	arg_1_0.bornningBuffUidDict = {}
	arg_1_0.removingBuffUidDict = {}
	arg_1_0.updateHandle = UpdateBeat:CreateListener(arg_1_0.onFrameUpdate, arg_1_0)

	UpdateBeat:AddListener(arg_1_0.updateHandle)
	arg_1_0:initStar()
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, arg_1_0.onUpdateBuff, arg_1_0)
end

function var_0_0.getEffectItem(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = table.remove(arg_2_0.effectItemPool) or {}

	var_2_0.effectWrap = arg_2_1
	var_2_0.buffUid = arg_2_2
	var_2_0.buffId = arg_2_3

	local var_2_1, var_2_2, var_2_3 = arg_2_0:getEffectWrapLocalPos(arg_2_1)

	var_2_0.startY = var_2_2
	var_2_0.targetY = var_2_2

	return var_2_0
end

function var_0_0.recycleEffectItem(arg_3_0, arg_3_1)
	arg_3_1.effectWrap = nil
	arg_3_1.buffUid = nil
	arg_3_1.buffId = nil
	arg_3_1.startY = nil
	arg_3_1.targetY = nil

	table.insert(arg_3_0.effectItemPool, arg_3_1)
end

function var_0_0.initValidBuffDict(arg_4_0)
	arg_4_0.validBuffDict = {}

	for iter_4_0, iter_4_1 in pairs(lua_fight_sp_wuerlixi_monster_star_effect.configDict) do
		arg_4_0.validBuffDict[iter_4_0] = true
	end
end

function var_0_0.initOffsetXY(arg_5_0)
	local var_5_0 = arg_5_0.entityMo.modelId
	local var_5_1 = lua_fight_sp_wuerlixi_monster_star_position_offset.configDict[var_5_0] or lua_fight_sp_wuerlixi_monster_star_position_offset.configDict[0]

	arg_5_0.offsetX = var_5_1.offsetX
	arg_5_0.offsetY = var_5_1.offsetY
end

function var_0_0.initStar(arg_6_0)
	local var_6_0 = arg_6_0.entityMo:getOrderedBuffList_ByTime()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = iter_6_1.buffId

		if arg_6_0.validBuffDict[var_6_1] then
			local var_6_2 = lua_fight_sp_wuerlixi_monster_star_effect.configDict[var_6_1]

			if var_6_2 then
				local var_6_3 = arg_6_0:getEffectWrap(var_6_2.effect)
				local var_6_4 = arg_6_0:getEffectItem(var_6_3, iter_6_1.uid, var_6_1)

				var_6_3:setActive(true, var_0_0.EffectRecycleKey)
				table.insert(arg_6_0.effectItemList, var_6_4)
			end
		end
	end

	arg_6_0:refreshEffectPos()
end

function var_0_0.refreshEffectPos(arg_7_0)
	if arg_7_0.movingTweenId then
		return
	end

	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.effectItemList) do
		local var_7_1 = iter_7_1.buffId
		local var_7_2 = lua_fight_sp_wuerlixi_monster_star_effect.configDict[var_7_1]

		if var_7_2 then
			iter_7_1.effectWrap:setLocalPos(arg_7_0.offsetX, arg_7_0.offsetY + var_7_0, 0)

			var_7_0 = var_7_0 + var_7_2.height
		end
	end
end

function var_0_0.onUpdateBuff(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_1 ~= arg_8_0.entityId then
		return
	end

	if not arg_8_0.validBuffDict[arg_8_3] then
		return
	end

	if arg_8_2 == FightEnum.EffectType.BUFFADD then
		arg_8_0:onAddBuff(arg_8_3, arg_8_4)
	elseif arg_8_2 == FightEnum.EffectType.BUFFDEL or arg_8_2 == FightEnum.EffectType.BUFFDELNOEFFECT then
		arg_8_0:onRemoveBuff(arg_8_3, arg_8_4)
	end
end

function var_0_0.onAddBuff(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = lua_fight_sp_wuerlixi_monster_star_effect.configDict[arg_9_1]

	if not var_9_0 then
		return
	end

	if arg_9_0.movingTweenId then
		ZProj.TweenHelper.KillById(arg_9_0.movingTweenId)
	end

	local var_9_1 = var_9_0.bornEffect
	local var_9_2

	if not string.nilorempty(var_9_1) then
		local var_9_3 = var_9_0.bornEffectDuration
		local var_9_4 = arg_9_0.entity.effect:addHangEffect(var_9_1, ModuleEnum.SpineHangPointRoot, nil, var_9_3 + 0.1)

		arg_9_0.bornningBuffUidDict[arg_9_2] = Time.realtimeSinceStartup + var_9_3
		var_9_2 = var_9_4
	else
		var_9_2 = arg_9_0:getEffectWrap(var_9_0.effect)
	end

	FightRenderOrderMgr.instance:onAddEffectWrap(arg_9_0.entityId, var_9_2)
	var_9_2:setLocalPos(arg_9_0.offsetX, arg_9_0.offsetY, 0)

	local var_9_5 = var_9_0.height

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.effectItemList) do
		local var_9_6, var_9_7, var_9_8 = arg_9_0:getEffectWrapLocalPos(iter_9_1.effectWrap)

		iter_9_1.startY = var_9_7

		if arg_9_0.movingTweenId then
			iter_9_1.targetY = iter_9_1.targetY + var_9_5
		else
			iter_9_1.targetY = var_9_7 + var_9_5
		end
	end

	local var_9_9 = arg_9_0:getEffectItem(var_9_2, arg_9_2, arg_9_1)

	table.insert(arg_9_0.effectItemList, 1, var_9_9)

	arg_9_0.movingTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, var_0_0.MoveTweenTime, arg_9_0.onMovingTweenFrameCallback, arg_9_0.onMovingTweenDone, arg_9_0)
end

function var_0_0.onMovingTweenFrameCallback(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.effectItemList) do
		local var_10_0, var_10_1, var_10_2 = arg_10_0:getEffectWrapLocalPos(iter_10_1.effectWrap)
		local var_10_3 = iter_10_1.startY
		local var_10_4 = var_10_3 + (iter_10_1.targetY - var_10_3) * arg_10_1

		iter_10_1.effectWrap:setLocalPos(var_10_0, var_10_4, var_10_2)
	end
end

function var_0_0.onMovingTweenDone(arg_11_0)
	arg_11_0.movingTweenId = nil

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.effectItemList) do
		local var_11_0, var_11_1, var_11_2 = arg_11_0:getEffectWrapLocalPos(iter_11_1.effectWrap)

		iter_11_1.startY = var_11_1
		iter_11_1.targetY = var_11_1
	end

	arg_11_0:refreshEffectPos()
end

function var_0_0.onRemoveBuff(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.effectItemList) do
		if iter_12_1.buffUid == arg_12_2 then
			local var_12_0 = iter_12_1.effectWrap
			local var_12_1 = lua_fight_sp_wuerlixi_monster_star_effect.configDict[arg_12_1]
			local var_12_2 = 0

			if var_12_1 then
				local var_12_3 = var_12_1.disAppearEffect

				if not string.nilorempty(var_12_3) then
					var_12_2 = var_12_1.disAppearEffectDuration

					local var_12_4 = arg_12_0.entity.effect:addHangEffect(var_12_3, ModuleEnum.SpineHangPointRoot, nil, var_12_2)

					FightRenderOrderMgr.instance:onAddEffectWrap(arg_12_0.entityId, var_12_4)
					var_12_4:setLocalPos(arg_12_0:getEffectWrapLocalPos(var_12_0))

					iter_12_1.effectWrap = var_12_4
				end
			end

			arg_12_0:recycleEffect(var_12_0)

			if var_12_2 > 0 then
				arg_12_0.removingBuffUidDict[arg_12_2] = Time.realtimeSinceStartup + var_12_2

				break
			end

			arg_12_0:_frameRemoveEffectItem(arg_12_2)

			break
		end
	end
end

function var_0_0.getEffectWrap(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.effectPool[arg_13_1]

	if var_13_0 and #var_13_0 > 0 then
		return table.remove(var_13_0)
	end

	local var_13_1 = arg_13_0.entity.effect:addHangEffect(arg_13_1, ModuleEnum.SpineHangPointRoot)

	FightRenderOrderMgr.instance:onAddEffectWrap(arg_13_0.entityId, var_13_1)
	arg_13_0.entity.buff:addLoopBuff(var_13_1)

	return var_13_1
end

var_0_0.EffectRecycleKey = "FightBuffWELXStarComp_EffectRecycleKey"

function var_0_0.recycleEffect(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.path
	local var_14_1 = arg_14_0.effectPool[var_14_0]

	if not var_14_1 then
		var_14_1 = {}
		arg_14_0.effectPool[var_14_0] = var_14_1
	end

	arg_14_1:setActive(false, var_0_0.EffectRecycleKey)
	table.insert(var_14_1, arg_14_1)
end

function var_0_0.clear(arg_15_0)
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, arg_15_0.onUpdateBuff, arg_15_0)

	local var_15_0 = arg_15_0.entity.effect

	if arg_15_0.effectItemList then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0.effectItemList) do
			local var_15_1 = iter_15_1.effectWrap

			var_15_0:removeEffect(var_15_1)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_15_0.entityId, var_15_1)
			arg_15_0.entity.buff:removeLoopBuff(var_15_1)
		end

		arg_15_0.effectItemList = nil
	end

	if arg_15_0.effectPool then
		for iter_15_2, iter_15_3 in pairs(arg_15_0.effectPool) do
			for iter_15_4, iter_15_5 in ipairs(iter_15_3) do
				var_15_0:removeEffect(iter_15_5)
				FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_15_0.entityId, iter_15_5)
				arg_15_0.entity.buff:removeLoopBuff(iter_15_5)
			end
		end

		arg_15_0.effectPool = nil
	end

	if arg_15_0.updateHandle then
		UpdateBeat:RemoveListener(arg_15_0.updateHandle)

		arg_15_0.updateHandle = nil
	end

	if arg_15_0.movingTweenId then
		ZProj.TweenHelper.KillById(arg_15_0.movingTweenId)

		arg_15_0.movingTweenId = nil
	end
end

function var_0_0.onFrameUpdate(arg_16_0)
	local var_16_0 = Time.realtimeSinceStartup

	for iter_16_0, iter_16_1 in pairs(arg_16_0.bornningBuffUidDict) do
		if iter_16_1 <= var_16_0 then
			arg_16_0.bornningBuffUidDict[iter_16_0] = nil

			arg_16_0:_frameAddBuffEffect(iter_16_0)
		end
	end

	for iter_16_2, iter_16_3 in pairs(arg_16_0.removingBuffUidDict) do
		if iter_16_3 <= var_16_0 then
			arg_16_0.removingBuffUidDict[iter_16_2] = nil

			arg_16_0:_frameRemoveEffectItem(iter_16_2)
		end
	end
end

function var_0_0._frameAddBuffEffect(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.entityMo:getBuffMO(arg_17_1)

	if var_17_0 then
		local var_17_1 = var_17_0.buffId
		local var_17_2 = lua_fight_sp_wuerlixi_monster_star_effect.configDict[var_17_1]

		if var_17_2 then
			local var_17_3 = arg_17_0:getEffectWrap(var_17_2.effect)

			var_17_3:setActive(true, var_0_0.EffectRecycleKey)

			for iter_17_0, iter_17_1 in ipairs(arg_17_0.effectItemList) do
				if iter_17_1.buffUid == arg_17_1 then
					local var_17_4, var_17_5, var_17_6 = arg_17_0:getEffectWrapLocalPos(iter_17_1.effectWrap)

					var_17_3:setLocalPos(var_17_4, var_17_5, var_17_6)

					iter_17_1.effectWrap = var_17_3

					break
				end
			end
		end
	end
end

function var_0_0._frameRemoveEffectItem(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.effectItemList) do
		if iter_18_1.buffUid == arg_18_1 then
			arg_18_0:recycleEffectItem(iter_18_1)
			table.remove(arg_18_0.effectItemList, iter_18_0)

			break
		end
	end

	arg_18_0:refreshEffectPos()
end

function var_0_0.getEffectWrapLocalPos(arg_19_0, arg_19_1)
	if not arg_19_1 then
		return 0, 0, 0
	end

	local var_19_0 = arg_19_1.containerTr

	if not var_19_0 then
		return 0, 0, 0
	end

	return transformhelper.getLocalPos(var_19_0)
end

return var_0_0
