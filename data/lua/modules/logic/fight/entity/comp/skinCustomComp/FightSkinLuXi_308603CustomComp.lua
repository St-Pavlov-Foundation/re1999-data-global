module("modules.logic.fight.entity.comp.skinCustomComp.FightSkinLuXi_308603CustomComp", package.seeall)

local var_0_0 = class("FightSkinLuXi_308603CustomComp", FightSkinCustomCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0.skinId = arg_1_1:getMO().skin
	arg_1_0.entityId = arg_1_1.id
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.effectList = {}

	arg_2_0.entity.spine:addAnimEventCallback(arg_2_0.onAnimEvent, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnStartFightPlayBornNormal, arg_2_0.onStartFightPlayBornNormal, arg_2_0)
	FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, arg_2_0.onBeforeDeadEffect, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0.entity.spine:removeAnimEventCallback(arg_3_0.onAnimEvent, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnStartFightPlayBornNormal, arg_3_0.onStartFightPlayBornNormal, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, arg_3_0.onBeforeDeadEffect, arg_3_0)
end

function var_0_0.onStartFightPlayBornNormal(arg_4_0, arg_4_1)
	if arg_4_1 ~= arg_4_0.entityId then
		return
	end

	local var_4_0 = lua_fight_luxi_skin_effect.configDict[arg_4_0.skinId]

	if not var_4_0 then
		return
	end

	arg_4_0:removeAllEffect()
	arg_4_0:addEffect(var_4_0[SpineAnimState.born])
end

function var_0_0.onBeforeDeadEffect(arg_5_0, arg_5_1)
	if arg_5_1 ~= arg_5_0.entityId then
		return
	end

	local var_5_0 = lua_fight_luxi_skin_effect.configDict[arg_5_0.skinId]

	if not var_5_0 then
		return
	end

	arg_5_0:removeAllEffect()
	arg_5_0:addEffect(var_5_0[SpineAnimState.die])
end

function var_0_0.onAnimEvent(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2 == SpineAnimEvent.ActionComplete and arg_6_1 == SpineAnimState.born then
		arg_6_0:removeAllEffect()
	end
end

function var_0_0.addEffect(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0 = arg_7_1.effect
	local var_7_1 = arg_7_1.effectHangPoint

	if not string.nilorempty(var_7_0) then
		local var_7_2 = string.split(var_7_0, "#")
		local var_7_3 = string.split(var_7_1, "#")

		for iter_7_0, iter_7_1 in ipairs(var_7_2) do
			local var_7_4 = arg_7_0.entity.effect:addHangEffect(iter_7_1, var_7_3[iter_7_0])

			var_7_4:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(arg_7_0.entity.id, var_7_4)
			table.insert(arg_7_0.effectList, var_7_4)
		end
	end

	local var_7_5 = arg_7_1.audio

	if var_7_5 > 0 then
		if not arg_7_0.entity:getMO() then
			return
		end

		local var_7_6
		local var_7_7 = arg_7_0.entity:getMO().modelId

		if not var_7_7 then
			return
		end

		local var_7_8, var_7_9, var_7_10 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(var_7_7)
		local var_7_11 = LangSettings.shortcutTab[var_7_8]

		if not string.nilorempty(var_7_11) and not var_7_10 then
			var_7_6 = var_7_11
		end

		FightAudioMgr.instance:playAudioWithLang(var_7_5, var_7_6)
	end
end

function var_0_0.removeAllEffect(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.effectList) do
		arg_8_0.entity.effect:removeEffect(iter_8_1)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_8_0.entity.id, iter_8_1)
	end

	tabletool.clear(arg_8_0.effectList)
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0:removeAllEffect()
end

return var_0_0
