module("modules.logic.fight.entity.mgr.FightSkillBehaviorMgr", package.seeall)

local var_0_0 = class("FightSkillBehaviorMgr")

function var_0_0.init(arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnSkillEffectPlayFinish, arg_1_0._onSkillEffectPlayFinish, arg_1_0)

	arg_1_0._hasPlayDict = {}
	arg_1_0._specialWorkList = {}
end

function var_0_0.playSkillEffectBehavior(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_1 or not arg_2_2 then
		return
	end

	if FightSkillMgr.instance:isPlayingAnyTimeline() then
		return
	end

	local var_2_0 = arg_2_2.configEffect

	if var_2_0 and var_2_0 > 0 then
		local var_2_1 = arg_2_2.targetId .. ":" .. var_2_0
		local var_2_2 = arg_2_0._hasPlayDict[arg_2_1.stepUid]

		if not var_2_2 then
			var_2_2 = {}
			arg_2_0._hasPlayDict[arg_2_1.stepUid] = var_2_2
		end

		if not var_2_2[var_2_1] then
			var_2_2[var_2_1] = true

			local var_2_3 = lua_skill_behavior.configDict[var_2_0]

			if var_2_3 then
				arg_2_0:_doSkillBehaviorEffect(arg_2_1, arg_2_2, var_2_3, false)
			end
		end
	end
end

function var_0_0.playSkillBehavior(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_1 then
		return
	end

	local var_3_0 = arg_3_1.actId

	if not lua_skill.configDict[var_3_0] then
		return
	end

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.actEffect) do
		local var_3_1 = iter_3_1.configEffect

		if var_3_1 and var_3_1 > 0 then
			local var_3_2 = arg_3_2 and arg_3_2[var_3_1]
			local var_3_3 = iter_3_1.targetId .. ":" .. var_3_1
			local var_3_4 = arg_3_0._hasPlayDict[arg_3_1.stepUid]

			if not var_3_4 then
				var_3_4 = {}
				arg_3_0._hasPlayDict[arg_3_1.stepUid] = var_3_4
			end

			local var_3_5 = not arg_3_2 and not var_3_4[var_3_3]

			if var_3_2 or var_3_5 then
				var_3_4[var_3_3] = true

				local var_3_6 = lua_skill_behavior.configDict[var_3_1]

				if var_3_6 then
					arg_3_0:_doSkillBehaviorEffect(arg_3_1, iter_3_1, var_3_6, arg_3_3)
				end
			end
		end
	end
end

function var_0_0._doSkillBehaviorEffect(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = FightHelper.getEntity(arg_4_2.targetId) or arg_4_2.entity and FightHelper.getEntity(arg_4_2.entity.id)
	local var_4_1 = arg_4_3.effect
	local var_4_2 = arg_4_3.effectHangPoint
	local var_4_3 = arg_4_3.audioId
	local var_4_4 = FightDataHelper.entityMgr:getById(arg_4_1.fromId)

	if var_4_4 then
		local var_4_5 = lua_fight_replace_skill_behavior_effect.configDict[var_4_4.skin]

		var_4_5 = var_4_5 and var_4_5[arg_4_3.id]

		if var_4_5 then
			var_4_1 = string.nilorempty(var_4_5.effect) and var_4_1 or var_4_5.effect
			var_4_2 = string.nilorempty(var_4_5.effectHangPoint) and var_4_2 or var_4_5.effectHangPoint
			var_4_3 = var_4_5.audioId == 0 and var_4_3 or var_4_5.audioId
		end
	end

	if arg_4_3.id == 60052 and var_4_4 then
		local var_4_6 = lua_fight_sp_effect_kkny_bear_damage_hit.configDict[var_4_4.skin]

		if var_4_6 then
			var_4_1 = var_4_6.path
			var_4_2 = var_4_6.hangPoint
			var_4_3 = var_4_6.audio
		end
	end

	if not string.nilorempty(var_4_1) and var_4_0 and var_4_0.effect then
		local var_4_7

		if not string.nilorempty(var_4_2) then
			var_4_7 = var_4_0.effect:addHangEffect(var_4_1, var_4_2)

			var_4_7:setLocalPos(0, 0, 0)
		else
			var_4_7 = var_4_0.effect:addGlobalEffect(var_4_1)

			var_4_7:setWorldPos(FightHelper.getProcessEntitySpinePos(var_4_0))
		end

		FightRenderOrderMgr.instance:onAddEffectWrap(var_4_0.id, var_4_7)

		arg_4_0._effectCache = arg_4_0._effectCache or {}

		table.insert(arg_4_0._effectCache, {
			var_4_0.id,
			var_4_7,
			Time.time
		})
		TaskDispatcher.runRepeat(arg_4_0._removeEffects, arg_4_0, 0.5)
	end

	if var_4_3 > 0 then
		FightAudioMgr.instance:playAudio(var_4_3)
	end

	if arg_4_3.dec_Type > 0 then
		local var_4_8 = arg_4_2.targetId

		if arg_4_2.effectType == FightEnum.EffectType.CARDLEVELCHANGE then
			var_4_8 = arg_4_2.entity and arg_4_2.entity.uid or arg_4_1.fromId
		end

		FightFloatMgr.instance:float(var_4_8, FightEnum.FloatType.buff, arg_4_3.dec, arg_4_3.dec_Type, false)
	end

	if arg_4_4 then
		local var_4_9 = arg_4_3.type

		if (var_4_9 == FightEnum.Behavior_AddExPoint or var_4_9 == FightEnum.Behavior_DelExPoint) and arg_4_2.effectType == FightEnum.EffectType.EXPOINTCHANGE then
			local var_4_10 = FightWork2Work.New(FightWorkExPointChange, arg_4_1, arg_4_2)

			var_4_10:onStart()
			table.insert(arg_4_0._specialWorkList, var_4_10)
		elseif FightEnum.BuffEffectType[arg_4_2.effectType] then
			FightSkillBuffMgr.instance:playSkillBuff(arg_4_1, arg_4_2)
		elseif var_4_9 == FightEnum.Behavior_LostLife and arg_4_2.effectType == FightEnum.EffectType.DAMAGE and not arg_4_2:isDone() then
			local var_4_11 = FightWork2Work.New(FightWorkEffectDamage, arg_4_1, arg_4_2)

			var_4_11:onStart()
			table.insert(arg_4_0._specialWorkList, var_4_11)
		end
	end
end

function var_0_0._onSkillEffectPlayFinish(arg_5_0, arg_5_1)
	arg_5_0:playSkillBehavior(arg_5_1, false)
end

function var_0_0._removeEffects(arg_6_0, arg_6_1)
	if not arg_6_0._effectCache then
		return
	end

	local var_6_0 = Time.time

	for iter_6_0 = #arg_6_0._effectCache, 1, -1 do
		local var_6_1 = arg_6_0._effectCache[iter_6_0][1]
		local var_6_2 = arg_6_0._effectCache[iter_6_0][2]
		local var_6_3 = arg_6_0._effectCache[iter_6_0][3]
		local var_6_4 = FightHelper.getEntity(var_6_1)

		if arg_6_1 or var_6_0 - var_6_3 > 2 then
			if var_6_4 then
				FightRenderOrderMgr.instance:onRemoveEffectWrap(var_6_4.id, var_6_2)
				var_6_4.effect:removeEffect(var_6_2)
			end

			table.remove(arg_6_0._effectCache, iter_6_0)
		end
	end

	if #arg_6_0._effectCache == 0 then
		TaskDispatcher.cancelTask(arg_6_0._removeEffects, arg_6_0)
	end
end

function var_0_0.dispose(arg_7_0)
	if arg_7_0._specialWorkList then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._specialWorkList) do
			if iter_7_1.status == WorkStatus.Running then
				iter_7_1:onStop()
			end
		end
	end

	arg_7_0._specialWorkList = nil

	FightController.instance:unregisterCallback(FightEvent.OnSkillEffectPlayFinish, arg_7_0._onSkillEffectPlayFinish, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._removeEffects, arg_7_0)
	arg_7_0:_removeEffects(true)

	arg_7_0._effectCache = nil
	arg_7_0._hasPlayDict = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
