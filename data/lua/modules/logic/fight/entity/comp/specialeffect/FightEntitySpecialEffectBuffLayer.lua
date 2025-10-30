module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffectBuffLayer", package.seeall)

local var_0_0 = class("FightEntitySpecialEffectBuffLayer", FightEntitySpecialEffectBase)
local var_0_1 = 3000

function var_0_0.initClass(arg_1_0)
	arg_1_0._effectWraps = {}
	arg_1_0._buffId2Config = {}
	arg_1_0._oldLayer = {}
	arg_1_0._buffType = {}
	arg_1_0.hideEffectWhenPlaying = {}

	arg_1_0:addEventCb(FightController.instance, FightEvent.SetBuffEffectVisible, arg_1_0._onSetBuffEffectVisible, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_1_0._onBuffUpdate, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.BeforeDeadEffect, arg_1_0._onBeforeDeadEffect, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.BeforeEnterStepBehaviour, arg_1_0._onBeforeEnterStepBehaviour, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.SkillEditorRefreshBuff, arg_1_0._onSkillEditorRefreshBuff, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_1_0._onSkillPlayStart, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish, arg_1_0, LuaEventSystem.High)
end

function var_0_0._onBeforeEnterStepBehaviour(arg_2_0)
	local var_2_0 = arg_2_0._entity:getMO()

	if var_2_0 then
		local var_2_1 = var_2_0:getBuffDic()

		for iter_2_0, iter_2_1 in pairs(var_2_1) do
			arg_2_0:_onBuffUpdate(arg_2_0._entity.id, FightEnum.EffectType.BUFFADD, iter_2_1.buffId, iter_2_1.uid)
		end
	end
end

function var_0_0._onSkillEditorRefreshBuff(arg_3_0)
	arg_3_0:_releaseAllEffect()
	arg_3_0:_onBeforeEnterStepBehaviour()
end

function var_0_0._onSetBuffEffectVisible(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0._entity.id == arg_4_1 and arg_4_0._effectWraps then
		for iter_4_0, iter_4_1 in pairs(arg_4_0._effectWraps) do
			for iter_4_2, iter_4_3 in pairs(iter_4_1) do
				iter_4_3:setActive(arg_4_2, arg_4_3 or "FightEntitySpecialEffectBuffLayer")
			end
		end
	end
end

function var_0_0._onSkillPlayStart(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_1:getMO()

	if var_5_0 and var_5_0.id == arg_5_0._entity.id then
		if FightCardDataHelper.isBigSkill(arg_5_2) then
			arg_5_0:_onSetBuffEffectVisible(var_5_0.id, false, "FightEntitySpecialEffectBuffLayer_onSkillPlayStart")
		end

		for iter_5_0, iter_5_1 in pairs(arg_5_0.hideEffectWhenPlaying) do
			iter_5_1:setActive(false, "FightEntitySpecialEffectBuffLayerHideWhenPlaying")
		end
	end
end

function var_0_0._onSkillPlayFinish(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_1:getMO()

	if var_6_0 and var_6_0.id == arg_6_0._entity.id then
		if FightCardDataHelper.isBigSkill(arg_6_2) then
			arg_6_0:_onSetBuffEffectVisible(var_6_0.id, true, "FightEntitySpecialEffectBuffLayer_onSkillPlayStart")
		end

		for iter_6_0, iter_6_1 in pairs(arg_6_0.hideEffectWhenPlaying) do
			iter_6_1:setActive(true, "FightEntitySpecialEffectBuffLayerHideWhenPlaying")
		end
	end
end

function var_0_0.sortList(arg_7_0, arg_7_1)
	return arg_7_0.layer > arg_7_1.layer
end

function var_0_0._onBuffUpdate(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_1 ~= arg_8_0._entity.id then
		return
	end

	if lua_fight_buff_layer_effect.configDict[arg_8_3] then
		if arg_8_2 == FightEnum.EffectType.BUFFDEL or arg_8_2 == FightEnum.EffectType.BUFFDELNOEFFECT then
			local var_8_0 = arg_8_0._buffType[arg_8_4]

			if not var_8_0 then
				return
			end

			if var_8_0 == FightEnum.BuffType.LayerSalveHalo then
				return
			end

			arg_8_0:_refreshEffect(arg_8_3, nil, 0, arg_8_2)

			return
		end

		local var_8_1 = arg_8_0._entity:getMO()
		local var_8_2 = var_8_1:getBuffMO(arg_8_4)

		if not var_8_2 then
			return
		end

		arg_8_0._buffType[arg_8_4] = var_8_2.type

		if var_8_2.type == FightEnum.BuffType.LayerSalveHalo then
			return
		end

		if var_8_1 then
			local var_8_3 = lua_fight_buff_layer_effect.configDict[arg_8_3][var_8_1.originSkin] or lua_fight_buff_layer_effect.configDict[arg_8_3][0]

			if var_8_3 then
				local var_8_4 = {}

				for iter_8_0, iter_8_1 in pairs(var_8_3) do
					table.insert(var_8_4, iter_8_1)
				end

				table.sort(var_8_4, var_0_0.sortList)

				local var_8_5 = var_8_2 and var_8_2.layer or 0
				local var_8_6 = lua_skill_buff.configDict[arg_8_3]

				if FightSkillBuffMgr.instance:buffIsStackerBuff(var_8_6) then
					var_8_5 = FightSkillBuffMgr.instance:getStackedCount(arg_8_1, var_8_2)
				end

				arg_8_0:_refreshEffect(arg_8_3, var_8_4, var_8_5, arg_8_2)
			end
		end
	end
end

function var_0_0._refreshEffect(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if not arg_9_0._effectWraps then
		return
	end

	if not arg_9_0._effectWraps[arg_9_1] then
		arg_9_0._effectWraps[arg_9_1] = {}
	end

	local var_9_0 = arg_9_0._oldLayer[arg_9_1] or 0

	arg_9_0._oldLayer[arg_9_1] = arg_9_3

	if (arg_9_4 == FightEnum.EffectType.BUFFDEL or arg_9_4 == FightEnum.EffectType.BUFFDELNOEFFECT) and arg_9_3 == 0 then
		local var_9_1 = arg_9_0._buffId2Config[arg_9_1]

		if var_9_1 and not string.nilorempty(var_9_1.destroyEffect) then
			local var_9_2 = var_9_1.releaseDestroyEffectTime > 0 and var_9_1.releaseDestroyEffectTime or var_0_1
			local var_9_3 = arg_9_0._entity.effect:addHangEffect(var_9_1.destroyEffect, var_9_1.destroyEffectRoot, nil, var_9_2 / 1000)

			var_9_3:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(arg_9_0._entity.id, var_9_3)

			if var_9_1.destroyEffectAudio > 0 then
				AudioMgr.instance:trigger(var_9_1.destroyEffectAudio)
			end
		end

		arg_9_0:_releaseBuffIdEffect(arg_9_1)

		return
	end

	local var_9_4

	for iter_9_0, iter_9_1 in ipairs(arg_9_2) do
		if arg_9_3 >= iter_9_1.layer then
			var_9_4 = iter_9_1

			break
		end
	end

	if not var_9_4 then
		arg_9_0:_releaseBuffIdEffect(arg_9_1)

		return
	end

	local var_9_5 = var_9_4.layer
	local var_9_6 = arg_9_0._buffId2Config[arg_9_1]

	arg_9_0._buffId2Config[arg_9_1] = var_9_4

	local var_9_7 = var_9_6 ~= var_9_4

	if not arg_9_0._effectWraps[arg_9_1][var_9_5] and not string.nilorempty(var_9_4.loopEffect) then
		local var_9_8 = arg_9_0._entity.effect:addHangEffect(var_9_4.loopEffect, var_9_4.loopEffectRoot)

		var_9_8:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(arg_9_0._entity.id, var_9_8)

		arg_9_0._effectWraps[arg_9_1][var_9_5] = var_9_8

		var_9_8:setActive(false)

		if var_9_4.hideEffectWhenPlaying == 1 then
			arg_9_0.hideEffectWhenPlaying[var_9_8.uniqueId] = var_9_8
		end
	end

	if var_9_7 then
		local var_9_9 = arg_9_0._effectWraps[arg_9_1] and arg_9_0._effectWraps[arg_9_1][var_9_5]

		if var_9_9 then
			var_9_9:setActive(false, "FightEntitySpecialEffectBuffLayer_newEffect")
		end

		arg_9_0:_hideEffect(arg_9_1)

		if not string.nilorempty(var_9_4.createEffect) then
			local var_9_10 = var_9_4.releaseCreateEffectTime > 0 and var_9_4.releaseCreateEffectTime or var_0_1
			local var_9_11 = arg_9_0._entity.effect:addHangEffect(var_9_4.createEffect, var_9_4.createEffectRoot, nil, var_9_10 / 1000)

			var_9_11:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(arg_9_0._entity.id, var_9_11)

			if var_9_4.createAudio > 0 then
				AudioMgr.instance:trigger(var_9_4.createAudio)
			end
		end

		if var_9_4.delayTimeBeforeLoop > 0 then
			TaskDispatcher.runDelay(function()
				if var_9_9 then
					var_9_9:setActive(true, "FightEntitySpecialEffectBuffLayer_newEffect")
				end

				arg_9_0:_refreshEffectState(arg_9_1)
			end, arg_9_0, var_9_4.delayTimeBeforeLoop / 1000)
		else
			if var_9_9 then
				var_9_9:setActive(true, "FightEntitySpecialEffectBuffLayer_newEffect")
			end

			arg_9_0:_refreshEffectState(arg_9_1)
		end
	else
		if var_9_4.loopEffectAudio > 0 then
			AudioMgr.instance:trigger(var_9_4.loopEffectAudio)
		end

		arg_9_0:_refreshEffectState(arg_9_1)

		if arg_9_4 == FightEnum.EffectType.BUFFUPDATE and var_9_0 < arg_9_3 then
			if not string.nilorempty(var_9_4.addLayerEffect) then
				local var_9_12 = var_9_4.releaseAddLayerEffectTime > 0 and var_9_4.releaseAddLayerEffectTime or var_0_1
				local var_9_13 = arg_9_0._entity.effect:addHangEffect(var_9_4.addLayerEffect, var_9_4.addLayerEffectRoot, nil, var_9_12 / 1000)

				var_9_13:setLocalPos(0, 0, 0)
				FightRenderOrderMgr.instance:onAddEffectWrap(arg_9_0._entity.id, var_9_13)
			end

			if var_9_4.addLayerAudio > 0 then
				AudioMgr.instance:trigger(var_9_4.addLayerAudio)
			end
		end
	end
end

function var_0_0._refreshEffectState(arg_11_0, arg_11_1)
	if not arg_11_0 then
		return
	end

	if arg_11_0._effectWraps then
		local var_11_0 = arg_11_0._effectWraps[arg_11_1]

		if var_11_0 then
			local var_11_1 = arg_11_0._buffId2Config[arg_11_1].layer

			for iter_11_0, iter_11_1 in pairs(var_11_0) do
				iter_11_1:setActive(var_11_1 == iter_11_0)
			end
		end
	end
end

function var_0_0._hideEffect(arg_12_0, arg_12_1)
	if arg_12_0._effectWraps then
		local var_12_0 = arg_12_0._effectWraps[arg_12_1]

		if var_12_0 then
			for iter_12_0, iter_12_1 in pairs(var_12_0) do
				iter_12_1:setActive(false)
			end
		end
	end
end

function var_0_0._releaseAllEffect(arg_13_0)
	if arg_13_0._effectWraps then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._effectWraps) do
			arg_13_0:_releaseBuffIdEffect(iter_13_0)
		end

		arg_13_0._effectWraps = nil
	end
end

function var_0_0._releaseBuffIdEffect(arg_14_0, arg_14_1)
	if arg_14_0._effectWraps then
		for iter_14_0, iter_14_1 in pairs(arg_14_0._effectWraps[arg_14_1]) do
			arg_14_0:_releaseEffect(iter_14_1)
		end

		arg_14_0._effectWraps[arg_14_1] = nil
	end
end

function var_0_0._releaseEffect(arg_15_0, arg_15_1)
	arg_15_0._entity.effect:removeEffect(arg_15_1)
	FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_15_0._entity.id, arg_15_1)

	arg_15_0.hideEffectWhenPlaying[arg_15_1.uniqueId] = nil
end

function var_0_0._onBeforeDeadEffect(arg_16_0, arg_16_1)
	if arg_16_1 == arg_16_0._entity.id then
		arg_16_0:_releaseAllEffect()
	end
end

function var_0_0.releaseSelf(arg_17_0)
	arg_17_0:_releaseAllEffect()
end

return var_0_0
