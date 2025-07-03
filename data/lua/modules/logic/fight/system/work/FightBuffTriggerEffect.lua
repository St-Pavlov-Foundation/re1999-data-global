module("modules.logic.fight.system.work.FightBuffTriggerEffect", package.seeall)

local var_0_0 = class("FightBuffTriggerEffect", FightEffectBase)
local var_0_1 = 2
local var_0_2 = 2

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightHelper.getEntity(arg_1_0.actEffectData.targetId)

	if not var_1_0 then
		arg_1_0:onDone(true)

		return
	end

	local var_1_1 = lua_skill_buff.configDict[arg_1_0.actEffectData.effectNum]

	if var_1_1 and FightHelper.shouUIPoisoningEffect(var_1_1.id) and var_1_0.nameUI and var_1_0.nameUI.showPoisoningEffect then
		var_1_0.nameUI:showPoisoningEffect(var_1_1)
	end

	local var_1_2, var_1_3, var_1_4 = arg_1_0:_getBuffTriggerParam(var_1_1, var_1_0)

	if var_1_2 ~= "0" and not string.nilorempty(var_1_2) then
		local var_1_5 = var_1_0:getSide()
		local var_1_6 = "buff/" .. var_1_2

		arg_1_0._effectWrap = nil

		if not string.nilorempty(var_1_3) then
			arg_1_0._effectWrap = var_1_0.effect:addHangEffect(var_1_6, var_1_3, var_1_5)

			arg_1_0._effectWrap:setLocalPos(0, 0, 0)
		else
			arg_1_0._effectWrap = var_1_0.effect:addGlobalEffect(var_1_6, var_1_5)

			local var_1_7, var_1_8, var_1_9 = transformhelper.getPos(var_1_0.go.transform)

			arg_1_0._effectWrap:setWorldPos(var_1_7, var_1_8, var_1_9)
		end

		FightRenderOrderMgr.instance:onAddEffectWrap(var_1_0.id, arg_1_0._effectWrap)
		TaskDispatcher.runDelay(arg_1_0._onTickCheckRemoveEffect, arg_1_0, var_0_1 / FightModel.instance:getSpeed())
	end

	if var_1_4 and var_1_4 > 0 then
		FightAudioMgr.instance:playAudio(var_1_4)
	end

	arg_1_0._animationName = var_1_1 and var_1_1.triggerAnimationName
	arg_1_0._animationName = FightHelper.processEntityActionName(var_1_0, arg_1_0._animationName)

	if not string.nilorempty(arg_1_0._animationName) and var_1_0.spine:hasAnimation(arg_1_0._animationName) then
		arg_1_0._hasPlayAnim = true

		var_1_0.spine:addAnimEventCallback(arg_1_0._onAnimEvent, arg_1_0)
		var_1_0.spine:play(arg_1_0._animationName, false, true, true)
		TaskDispatcher.runDelay(arg_1_0._onTickCheckRemoveAnim, arg_1_0, var_0_2 / FightModel.instance:getSpeed())
	end

	arg_1_0:onDone(true)
end

function var_0_0._getBuffTriggerParam(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1 and arg_2_1.triggerEffect
	local var_2_1 = arg_2_1 and arg_2_1.triggerEffectHangPoint
	local var_2_2 = arg_2_1 and arg_2_1.triggerAudio

	if string.nilorempty(var_2_0) or var_2_0 == "0" then
		local var_2_3 = lua_buff_act.configDict[arg_2_0.actEffectData.buffActId]

		if var_2_3 and not string.nilorempty(var_2_3.effect) then
			local var_2_4 = var_2_3.effect
			local var_2_5 = var_2_3.effectHangPoint
			local var_2_6 = var_2_3.audioId
			local var_2_7 = arg_2_2 and FightDataHelper.entityMgr:getById(arg_2_2.id)
			local var_2_8 = var_2_7 and lua_fight_replace_buff_act_effect.configDict[var_2_7.skin]

			var_2_8 = var_2_8 and var_2_8[var_2_3.id]

			if var_2_8 then
				var_2_4 = string.nilorempty(var_2_8.effect) and var_2_4 or var_2_8.effect
				var_2_5 = string.nilorempty(var_2_8.effectHangPoint) and var_2_5 or var_2_8.effectHangPoint
				var_2_6 = var_2_8.audioId == 0 and var_2_6 or var_2_8.audioId
			end

			if var_2_4 ~= "0" and not string.nilorempty(var_2_4) then
				return var_2_4, var_2_5, var_2_6
			end
		end
	end

	if arg_2_1 then
		var_2_0 = FightHelper.processBuffEffectPath(var_2_0, arg_2_2, arg_2_1.id, "triggerEffect")
	end

	return var_2_0, var_2_1, var_2_2
end

function var_0_0._onAnimEvent(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 == arg_3_0._animationName and arg_3_2 == SpineAnimEvent.ActionComplete then
		local var_3_0 = FightHelper.getEntity(arg_3_0.actEffectData.targetId)

		if var_3_0 then
			var_3_0.spine:removeAnimEventCallback(arg_3_0._onAnimEvent, arg_3_0)

			if not FightSkillMgr.instance:isEntityPlayingTimeline(var_3_0.id) then
				var_3_0:resetAnimState()
			end
		end
	end
end

function var_0_0._onTickCheckRemoveEffect(arg_4_0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return
	end

	local var_4_0 = FightHelper.getEntity(arg_4_0.actEffectData.targetId)

	if arg_4_0._effectWrap and var_4_0 then
		var_4_0.effect:removeEffect(arg_4_0._effectWrap)

		arg_4_0._effectWrap = nil
	end
end

function var_0_0._onTickCheckRemoveAnim(arg_5_0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return
	end

	local var_5_0 = FightHelper.getEntity(arg_5_0.actEffectData.targetId)

	if var_5_0 then
		var_5_0.spine:removeAnimEventCallback(arg_5_0._onAnimEvent, arg_5_0)
	end
end

function var_0_0.onDestroy(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._onTickCheckRemoveEffect, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._onTickCheckRemoveAnim, arg_6_0)

	if arg_6_0._hasPlayAnim then
		local var_6_0 = FightHelper.getEntity(arg_6_0.actEffectData.targetId)

		if var_6_0 then
			var_6_0.spine:removeAnimEventCallback(arg_6_0._onAnimEvent, arg_6_0)
		end
	end

	var_0_0.super.onDestroy(arg_6_0)
end

return var_0_0
