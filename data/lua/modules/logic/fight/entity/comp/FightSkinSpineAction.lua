module("modules.logic.fight.entity.comp.FightSkinSpineAction", package.seeall)

local var_0_0 = class("FightSkinSpineAction", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._effectWraps = {}
	arg_1_0.lock = false
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._spine = arg_2_0.entity.spine
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._spine:addAnimEventCallback(arg_3_0._onAnimEvent, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._spine:removeAnimEventCallback(arg_4_0._onAnimEvent, arg_4_0)
end

function var_0_0._onAnimEvent(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_0.lock then
		return
	end

	local var_5_0 = arg_5_0.entity:getMO()

	if not var_5_0 then
		return
	end

	local var_5_1 = FightConfig.instance:getSkinSpineActionDict(var_5_0.skin, arg_5_1)

	if not var_5_1 then
		return
	end

	local var_5_2 = var_5_1[arg_5_1]

	if arg_5_2 == SpineAnimEvent.ActionStart then
		arg_5_0:_removeEffect()

		local var_5_3 = true

		if arg_5_1 == SpineAnimState.die or arg_5_1 == SpineAnimState.born then
			if FightDataHelper.entityMgr:isSub(var_5_0.id) then
				var_5_3 = false
			end

			if arg_5_1 == SpineAnimState.born and FightAudioMgr.instance.enterFightVoiceHeroID and FightAudioMgr.instance.enterFightVoiceHeroID ~= var_5_0.modelId then
				var_5_3 = false
			end
		end

		if var_5_2 then
			arg_5_0:_playActionEffect(var_5_2)

			if var_5_3 then
				arg_5_0:_playActionAudio(var_5_2)
			end

			if var_5_2.effectRemoveTime > 0 then
				TaskDispatcher.cancelTask(arg_5_0._removeEffect, arg_5_0)
				TaskDispatcher.runDelay(arg_5_0._removeEffect, arg_5_0, var_5_2.effectRemoveTime)
			end
		end
	elseif arg_5_2 == SpineAnimEvent.ActionComplete and var_5_2 and var_5_2.effectRemoveTime == 0 then
		arg_5_0:_removeEffect()
	end
end

function var_0_0._removeEffect(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._removeEffect, arg_6_0)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._effectWraps) do
		arg_6_0.entity.effect:removeEffect(iter_6_1)
	end

	arg_6_0._effectWraps = {}
end

function var_0_0._playActionEffect(arg_7_0, arg_7_1)
	if not string.nilorempty(arg_7_1.effect) then
		local var_7_0 = string.split(arg_7_1.effect, "#")
		local var_7_1 = string.split(arg_7_1.effectHangPoint, "#")

		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			local var_7_2 = arg_7_0.entity.effect:addHangEffect(iter_7_1, var_7_1[iter_7_0])

			var_7_2:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(arg_7_0.entity.id, var_7_2)
			table.insert(arg_7_0._effectWraps, var_7_2)
		end
	end
end

function var_0_0._playActionAudio(arg_8_0, arg_8_1)
	if arg_8_1.audioId and arg_8_1.audioId > 0 then
		if not arg_8_0.entity:getMO() then
			return
		end

		local var_8_0
		local var_8_1 = arg_8_0.entity:getMO().modelId

		if not var_8_1 then
			return
		end

		local var_8_2, var_8_3, var_8_4 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(var_8_1)
		local var_8_5 = LangSettings.shortcutTab[var_8_2]

		if not string.nilorempty(var_8_5) and not var_8_4 then
			var_8_0 = var_8_5
		end

		FightAudioMgr.instance:playAudioWithLang(arg_8_1.audioId, var_8_0)
	end
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0:_removeEffect()
end

return var_0_0
