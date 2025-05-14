module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffectBuffLayerEnemySkin", package.seeall)

local var_0_0 = class("FightEntitySpecialEffectBuffLayerEnemySkin", FightEntitySpecialEffectBase)
local var_0_1 = 3000

function var_0_0.initClass(arg_1_0)
	arg_1_0._effectWraps = {}
	arg_1_0._buffId2Config = {}
	arg_1_0._oldLayer = {}
	arg_1_0._buffType = {}
	arg_1_0.playCount = 0
	arg_1_0.hideWhenPlayTimeline = {}

	arg_1_0:addEventCb(FightController.instance, FightEvent.SetBuffEffectVisible, arg_1_0._onSetBuffEffectVisible, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_1_0._onBuffUpdate, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.BeforeDeadEffect, arg_1_0._onBeforeDeadEffect, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.BeforeEnterStepBehaviour, arg_1_0._onBeforeEnterStepBehaviour, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.SkillEditorRefreshBuff, arg_1_0._onSkillEditorRefreshBuff, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_1_0._onSkillPlayStart, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish, arg_1_0, LuaEventSystem.High)
	arg_1_0:addEventCb(FightController.instance, FightEvent.BeforePlayTimeline, arg_1_0.onBeforePlayTimeline, arg_1_0)
end

function var_0_0.onBeforePlayTimeline(arg_2_0, arg_2_1)
	if arg_2_0._entity.id == arg_2_1 then
		arg_2_0.playCount = arg_2_0.playCount + 1

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.hideWhenPlayTimeline) do
			iter_2_1:setActive(false, "FightEntitySpecialEffectBuffLayerEnemySkin_onBeforePlayTimeline")
		end
	end
end

function var_0_0.afterPlayTimeline(arg_3_0)
	arg_3_0.playCount = arg_3_0.playCount - 1

	if arg_3_0.playCount == 0 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0.hideWhenPlayTimeline) do
			iter_3_1:setActive(true, "FightEntitySpecialEffectBuffLayerEnemySkin_afterPlayTimeline")
		end
	end
end

function var_0_0._onBeforeEnterStepBehaviour(arg_4_0)
	local var_4_0 = arg_4_0._entity:getMO()

	if var_4_0 then
		local var_4_1 = var_4_0:getBuffDic()

		for iter_4_0, iter_4_1 in pairs(var_4_1) do
			arg_4_0:_onBuffUpdate(arg_4_0._entity.id, FightEnum.EffectType.BUFFADD, iter_4_1.buffId, iter_4_1.uid, nil, iter_4_1)
		end
	end
end

function var_0_0._onSkillEditorRefreshBuff(arg_5_0)
	arg_5_0:_releaseAllEffect()
	arg_5_0:_onBeforeEnterStepBehaviour()
end

function var_0_0._onSetBuffEffectVisible(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_0._entity.id == arg_6_1 and arg_6_0._effectWraps then
		for iter_6_0, iter_6_1 in pairs(arg_6_0._effectWraps) do
			for iter_6_2, iter_6_3 in pairs(iter_6_1) do
				iter_6_3:setActive(arg_6_2, arg_6_3 or "FightEntitySpecialEffectBuffLayerEnemySkin")
			end
		end
	end
end

function var_0_0._onSkillPlayStart(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_1:getMO()

	if var_7_0 and var_7_0.id == arg_7_0._entity.id and FightCardDataHelper.isBigSkill(arg_7_2) then
		arg_7_0:_onSetBuffEffectVisible(var_7_0.id, false, "FightEntitySpecialEffectBuffLayerEnemySkin_onSkillPlayStart")
	end
end

function var_0_0._onSkillPlayFinish(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_1:getMO()

	if var_8_0 and var_8_0.id == arg_8_0._entity.id then
		if FightCardDataHelper.isBigSkill(arg_8_2) then
			arg_8_0:_onSetBuffEffectVisible(var_8_0.id, true, "FightEntitySpecialEffectBuffLayerEnemySkin_onSkillPlayStart")
		end

		arg_8_0:afterPlayTimeline()
	end
end

function var_0_0.sortList(arg_9_0, arg_9_1)
	return arg_9_0.layer > arg_9_1.layer
end

function var_0_0._onBuffUpdate(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5, arg_10_6)
	if arg_10_1 ~= arg_10_0._entity.id then
		return
	end

	if lua_fight_buff_layer_effect_enemy_skin.configDict[arg_10_3] then
		if arg_10_2 == FightEnum.EffectType.BUFFDEL or arg_10_2 == FightEnum.EffectType.BUFFDELNOEFFECT then
			local var_10_0 = arg_10_0._buffType[arg_10_4]

			if not var_10_0 then
				return
			end

			if var_10_0 == FightEnum.BuffType.LayerSalveHalo then
				return
			end

			arg_10_0:_refreshEffect(arg_10_3, nil, 0, arg_10_2)

			return
		end

		if not arg_10_6 then
			return
		end

		arg_10_0._buffType[arg_10_4] = arg_10_6.type

		if arg_10_6.type == FightEnum.BuffType.LayerSalveHalo then
			return
		end

		local var_10_1 = arg_10_0._entity:getMO()

		if not var_10_1 then
			return
		end

		local var_10_2 = var_10_1.side == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
		local var_10_3 = FightDataHelper.entityMgr:getOriginNormalList(var_10_2)

		if not arg_10_0:checkRefreshEffect(var_10_3, arg_10_6, arg_10_1, arg_10_2) then
			local var_10_4 = FightDataHelper.entityMgr:getOriginSpList(var_10_2)
			local var_10_5 = arg_10_0:checkRefreshEffect(var_10_4, arg_10_6, arg_10_1, arg_10_2)
		end
	end
end

function var_0_0.checkRefreshEffect(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = arg_11_2.buffId

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		local var_11_1 = lua_fight_buff_layer_effect_enemy_skin.configDict[var_11_0][iter_11_1.originSkin] or lua_fight_buff_layer_effect_enemy_skin.configDict[var_11_0][0]

		if var_11_1 then
			local var_11_2 = {}

			for iter_11_2, iter_11_3 in pairs(var_11_1) do
				table.insert(var_11_2, iter_11_3)
			end

			table.sort(var_11_2, var_0_0.sortList)

			local var_11_3 = arg_11_2 and arg_11_2.layer or 0
			local var_11_4 = lua_skill_buff.configDict[var_11_0]

			if FightSkillBuffMgr.instance:buffIsStackerBuff(var_11_4) then
				var_11_3 = FightSkillBuffMgr.instance:getStackedCount(arg_11_3, arg_11_2)
			end

			arg_11_0:_refreshEffect(var_11_0, var_11_2, var_11_3, arg_11_4)

			return true
		end
	end
end

function var_0_0._refreshEffect(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if not arg_12_0._effectWraps then
		return
	end

	if not arg_12_0._effectWraps[arg_12_1] then
		arg_12_0._effectWraps[arg_12_1] = {}
	end

	local var_12_0 = arg_12_0._oldLayer[arg_12_1] or 0

	arg_12_0._oldLayer[arg_12_1] = arg_12_3

	if (arg_12_4 == FightEnum.EffectType.BUFFDEL or arg_12_4 == FightEnum.EffectType.BUFFDELNOEFFECT) and arg_12_3 == 0 then
		local var_12_1 = arg_12_0._buffId2Config[arg_12_1]

		if var_12_1 and not string.nilorempty(var_12_1.destroyEffect) then
			local var_12_2 = var_12_1.releaseDestroyEffectTime > 0 and var_12_1.releaseDestroyEffectTime or var_0_1
			local var_12_3 = arg_12_0._entity.effect:addHangEffect(var_12_1.destroyEffect, var_12_1.destroyEffectRoot, nil, var_12_2 / 1000)

			var_12_3:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(arg_12_0._entity.id, var_12_3)

			if var_12_1.destroyEffectAudio > 0 then
				AudioMgr.instance:trigger(var_12_1.destroyEffectAudio)
			end
		end

		arg_12_0:_releaseBuffIdEffect(arg_12_1)

		return
	end

	local var_12_4

	for iter_12_0, iter_12_1 in ipairs(arg_12_2) do
		if arg_12_3 >= iter_12_1.layer then
			var_12_4 = iter_12_1

			break
		end
	end

	if not var_12_4 then
		arg_12_0:_releaseBuffIdEffect(arg_12_1)

		return
	end

	local var_12_5 = var_12_4.layer
	local var_12_6 = arg_12_0._buffId2Config[arg_12_1]

	arg_12_0._buffId2Config[arg_12_1] = var_12_4

	local var_12_7 = var_12_6 ~= var_12_4

	if not arg_12_0._effectWraps[arg_12_1][var_12_5] and not string.nilorempty(var_12_4.loopEffect) then
		local var_12_8 = arg_12_0._entity.effect:addHangEffect(var_12_4.loopEffect, var_12_4.loopEffectRoot)

		var_12_8:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(arg_12_0._entity.id, var_12_8)

		arg_12_0._effectWraps[arg_12_1][var_12_5] = var_12_8

		var_12_8:setActive(false)

		if var_12_4.hideWhenPlayTimeline == 1 then
			table.insert(arg_12_0.hideWhenPlayTimeline, var_12_8)
		end
	end

	if var_12_7 then
		arg_12_0:_hideEffect(arg_12_1)

		if not string.nilorempty(var_12_4.createEffect) then
			local var_12_9 = var_12_4.releaseCreateEffectTime > 0 and var_12_4.releaseCreateEffectTime or var_0_1
			local var_12_10 = arg_12_0._entity.effect:addHangEffect(var_12_4.createEffect, var_12_4.createEffectRoot, nil, var_12_9 / 1000)

			var_12_10:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(arg_12_0._entity.id, var_12_10)

			if var_12_4.createAudio > 0 then
				AudioMgr.instance:trigger(var_12_4.createAudio)
			end
		end

		if var_12_4.delayTimeBeforeLoop > 0 then
			TaskDispatcher.runDelay(function()
				arg_12_0:_refreshEffectState(arg_12_1)
			end, arg_12_0, var_12_4.delayTimeBeforeLoop / 1000)
		else
			arg_12_0:_refreshEffectState(arg_12_1)
		end
	else
		if var_12_4.loopEffectAudio > 0 then
			AudioMgr.instance:trigger(var_12_4.loopEffectAudio)
		end

		arg_12_0:_refreshEffectState(arg_12_1)

		if arg_12_4 == FightEnum.EffectType.BUFFUPDATE and var_12_0 < arg_12_3 then
			if not string.nilorempty(var_12_4.addLayerEffect) then
				local var_12_11 = var_12_4.releaseAddLayerEffectTime > 0 and var_12_4.releaseAddLayerEffectTime or var_0_1
				local var_12_12 = arg_12_0._entity.effect:addHangEffect(var_12_4.addLayerEffect, var_12_4.addLayerEffectRoot, nil, var_12_11 / 1000)

				var_12_12:setLocalPos(0, 0, 0)
				FightRenderOrderMgr.instance:onAddEffectWrap(arg_12_0._entity.id, var_12_12)
			end

			if var_12_4.addLayerAudio > 0 then
				AudioMgr.instance:trigger(var_12_4.addLayerAudio)
			end
		end
	end
end

function var_0_0._refreshEffectState(arg_14_0, arg_14_1)
	if not arg_14_0 then
		return
	end

	if arg_14_0._effectWraps then
		local var_14_0 = arg_14_0._effectWraps[arg_14_1]

		if var_14_0 then
			local var_14_1 = arg_14_0._buffId2Config[arg_14_1].layer

			for iter_14_0, iter_14_1 in pairs(var_14_0) do
				iter_14_1:setActive(var_14_1 == iter_14_0)
			end
		end
	end
end

function var_0_0._hideEffect(arg_15_0, arg_15_1)
	if arg_15_0._effectWraps then
		local var_15_0 = arg_15_0._effectWraps[arg_15_1]

		if var_15_0 then
			for iter_15_0, iter_15_1 in pairs(var_15_0) do
				iter_15_1:setActive(false)
			end
		end
	end
end

function var_0_0._releaseAllEffect(arg_16_0)
	if arg_16_0._effectWraps then
		for iter_16_0, iter_16_1 in pairs(arg_16_0._effectWraps) do
			arg_16_0:_releaseBuffIdEffect(iter_16_0)
		end

		arg_16_0._effectWraps = nil
	end
end

function var_0_0._releaseBuffIdEffect(arg_17_0, arg_17_1)
	if arg_17_0._effectWraps then
		for iter_17_0, iter_17_1 in pairs(arg_17_0._effectWraps[arg_17_1]) do
			arg_17_0:_releaseEffect(iter_17_1)
		end

		arg_17_0._effectWraps[arg_17_1] = nil
	end
end

function var_0_0._releaseEffect(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.hideWhenPlayTimeline) do
		if iter_18_1 == arg_18_1 then
			table.remove(arg_18_0.hideWhenPlayTimeline, iter_18_0)

			break
		end
	end

	arg_18_0._entity.effect:removeEffect(arg_18_1)
	FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_18_0._entity.id, arg_18_1)
end

function var_0_0._onBeforeDeadEffect(arg_19_0, arg_19_1)
	if arg_19_1 == arg_19_0._entity.id then
		arg_19_0:_releaseAllEffect()
	end
end

function var_0_0.releaseSelf(arg_20_0)
	arg_20_0:_releaseAllEffect()
end

return var_0_0
