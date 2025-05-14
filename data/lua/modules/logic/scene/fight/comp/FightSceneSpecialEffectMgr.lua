module("modules.logic.scene.fight.comp.FightSceneSpecialEffectMgr", package.seeall)

local var_0_0 = class("FightSceneSpecialEffectMgr", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	FightController.instance:registerCallback(FightEvent.OnInvokeSkill, arg_1_0._onInvokeSkill, arg_1_0)
	FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, arg_1_0._beforeDeadEffect, arg_1_0)
	FightController.instance:registerCallback(FightEvent.FightRoundEnd, arg_1_0._onFightRoundEnd, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, arg_1_0._onSkillPlayStart, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish, arg_1_0)
	FightController.instance:registerCallback(FightEvent.BeforeDestroyEntity, arg_1_0._onBeforeDestroyEntity, arg_1_0)
end

function var_0_0.addBuff(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:_detectShiSiHangShiGoodEffect(arg_2_1)
	arg_2_0:_detectPlayBuffAnimation(arg_2_1, arg_2_2)
	arg_2_0:_detectPlayCarAnimation(arg_2_1, arg_2_2)
end

function var_0_0.delBuff(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:_detectShiSiHangShiGoodEffect(arg_3_1)

	if arg_3_1.id == arg_3_0._xia_li_uid and (arg_3_2.buffId == 30172 or arg_3_2.buffId == 30171) then
		arg_3_0:_releaseXiaLiSpecialEffect()
	end

	arg_3_0:_detectPlayBuffAnimation(arg_3_1, arg_3_2, true)
end

function var_0_0._detectPlayBuffAnimation(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if FightBuffHelper.isDormantBuff(arg_4_2.buffId) then
		if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
			-- block empty
		elseif not FightWorkStepBuff.canPlayDormantBuffAni then
			return
		end

		if not arg_4_0._buff_animation_dic then
			arg_4_0._buff_animation_dic = {}
		end

		if not arg_4_0._buff_animation_dic[arg_4_1.id] then
			arg_4_0._buff_animation_dic[arg_4_1.id] = {}
		end

		arg_4_0:_releaseEntityAnimation(arg_4_1.id)

		local var_4_0 = FightBuffPlayAnimation.New(arg_4_1, arg_4_2, arg_4_3 and "mjzz_return" or "mjzz_sleep")

		table.insert(arg_4_0._buff_animation_dic[arg_4_1.id], var_4_0)
	end
end

function var_0_0._onSkillPlayStart(arg_5_0, arg_5_1)
	if arg_5_1 and arg_5_1.id == arg_5_0._xia_li_uid and arg_5_0._xia_li_skill_id == 30170143 and arg_5_0._xiali_special_effect then
		arg_5_0._xiali_special_effect:setActive(false)
	end
end

function var_0_0._onSkillPlayFinish(arg_6_0, arg_6_1)
	if arg_6_1 and arg_6_1.id == arg_6_0._xia_li_uid and arg_6_0._xiali_special_effect then
		arg_6_0._xiali_special_effect:setActive(true)
	end
end

function var_0_0._onInvokeSkill(arg_7_0, arg_7_1)
	if arg_7_1.actType == FightEnum.ActType.SKILL then
		local var_7_0 = FightHelper.getEntity(arg_7_1.fromId)

		if var_7_0 and arg_7_1.fromId == var_7_0.id then
			if arg_7_1.actId == 30170141 then
				arg_7_0:_releaseXiaLiSpecialEffect()

				arg_7_0._xiali_special_effect = var_7_0.effect:addHangEffect("buff/xiali_buff_innate1", ModuleEnum.SpineHangPoint.mounthead, nil, nil, {
					z = 0,
					x = 0,
					y = 0
				})

				arg_7_0._xiali_special_effect:setLocalPos(0, 0, 0)

				arg_7_0._xia_li_uid = var_7_0.id
				arg_7_0._xia_li_skill_id = arg_7_1.actId

				FightRenderOrderMgr.instance:onAddEffectWrap(var_7_0.id, arg_7_0._xiali_special_effect)
			elseif arg_7_1.actId == 30170143 then
				arg_7_0:_releaseXiaLiSpecialEffect()

				arg_7_0._xiali_special_effect = var_7_0.effect:addHangEffect("buff/xiali_buff_innate2", "special4", nil, nil, {
					z = 0,
					x = 0,
					y = 0
				})

				arg_7_0._xiali_special_effect:setLocalPos(0, 0, 0)

				arg_7_0._xia_li_uid = var_7_0.id
				arg_7_0._xia_li_skill_id = arg_7_1.actId

				FightRenderOrderMgr.instance:onAddEffectWrap(var_7_0.id, arg_7_0._xiali_special_effect)
			end
		end
	end
end

function var_0_0._onFightRoundEnd(arg_8_0)
	return
end

function var_0_0.setBuffEffectVisible(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 and arg_9_1.id == arg_9_0._xia_li_uid and arg_9_0._xiali_special_effect then
		arg_9_0._xiali_special_effect:setActive(arg_9_2)
	end

	if arg_9_1 and arg_9_1.id == arg_9_0._shi_si_hang_shi_uid and arg_9_0._shi_si_hang_shi_good_effect then
		arg_9_0._shi_si_hang_shi_good_effect:setActive(arg_9_2)
	end
end

function var_0_0._releaseXiaLiSpecialEffect(arg_10_0)
	if arg_10_0._xiali_special_effect then
		local var_10_0 = FightHelper.getEntity(arg_10_0._xia_li_uid)

		if var_10_0 then
			var_10_0.effect:removeEffect(arg_10_0._xiali_special_effect)
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_10_0._xia_li_uid, arg_10_0._xiali_special_effect)

		arg_10_0._xiali_special_effect = nil
		arg_10_0._xia_li_uid = nil
	end
end

function var_0_0._releaseShiSiHangShiGoodEffect(arg_11_0)
	if arg_11_0._shi_si_hang_shi_good_effect then
		local var_11_0 = FightHelper.getEntity(arg_11_0._shi_si_hang_shi_uid)

		if var_11_0 then
			var_11_0.effect:removeEffect(arg_11_0._shi_si_hang_shi_good_effect)
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_11_0._shi_si_hang_shi_uid, arg_11_0._shi_si_hang_shi_good_effect)

		arg_11_0._shi_si_hang_shi_good_effect = nil
		arg_11_0._shi_si_hang_shi_uid = nil
	end
end

function var_0_0._detectShiSiHangShiGoodEffect(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1:getMO()

	if var_12_0 and var_12_0.modelId == 3023 then
		local var_12_1, var_12_2 = HeroConfig.instance:getShowLevel(var_12_0.level)

		if var_12_2 < 2 then
			return
		end

		local var_12_3 = false
		local var_12_4 = var_12_0:getBuffDic()

		for iter_12_0, iter_12_1 in pairs(var_12_4) do
			local var_12_5 = lua_skill_buff.configDict[iter_12_1.buffId]
			local var_12_6 = lua_skill_bufftype.configDict[var_12_5.typeId]

			for iter_12_2, iter_12_3 in ipairs(FightEnum.BuffTypeList.GoodBuffList) do
				if var_12_6.type == iter_12_3 then
					var_12_3 = true

					break
				end
			end

			if var_12_3 then
				break
			end
		end

		if var_12_3 then
			if not arg_12_0._shi_si_hang_shi_good_effect then
				arg_12_0._shi_si_hang_shi_good_effect = arg_12_1.effect:addHangEffect("buff/shisihangshi_innate", ModuleEnum.SpineHangPoint.mountweapon, nil, nil, {
					z = 0,
					x = 0,
					y = 0
				})

				arg_12_0._shi_si_hang_shi_good_effect:setLocalPos(0, 0, 0)

				arg_12_0._shi_si_hang_shi_uid = arg_12_1.id

				FightRenderOrderMgr.instance:onAddEffectWrap(arg_12_1.id, arg_12_0._shi_si_hang_shi_good_effect)
			end
		else
			arg_12_0:_releaseShiSiHangShiGoodEffect()
		end
	end
end

function var_0_0._detectPlayCarAnimation(arg_13_0, arg_13_1, arg_13_2)
	for iter_13_0 = 1, 10 do
		if arg_13_2.buffId == 6301310 + iter_13_0 then
			if arg_13_1.spine:tryPlay("idle_change") then
				arg_13_1.spine:addAnimEventCallback(arg_13_0._onAnimEvent, arg_13_0, arg_13_1)
			end

			break
		end
	end
end

function var_0_0._onAnimEvent(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if arg_14_2 == SpineAnimEvent.ActionComplete and arg_14_1 == "idle_change" then
		arg_14_4.spine:removeAnimEventCallback(arg_14_0._onAnimEvent, arg_14_0)
		arg_14_4:resetAnimState()
	end
end

function var_0_0._releaseAllEntityAnimation(arg_15_0)
	if arg_15_0._buff_animation_dic then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._buff_animation_dic) do
			arg_15_0:_releaseEntityAnimation(iter_15_0)
		end
	end

	arg_15_0._buff_animation_dic = nil
end

function var_0_0._releaseEntityAnimation(arg_16_0, arg_16_1)
	if arg_16_0._buff_animation_dic and arg_16_0._buff_animation_dic[arg_16_1] then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0._buff_animation_dic[arg_16_1]) do
			iter_16_1:releaseSelf()
		end

		arg_16_0._buff_animation_dic[arg_16_1] = {}
	end
end

function var_0_0._releaseEntitySpineAnimEvent(arg_17_0, arg_17_1)
	if arg_17_1 and arg_17_1.spine then
		arg_17_1.spine:removeAnimEventCallback(arg_17_0._onAnimEvent, arg_17_0)
	end
end

function var_0_0._beforeDeadEffect(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2 or FightHelper.getEntity(arg_18_1)

	if var_18_0 then
		if var_18_0.id == arg_18_0._xia_li_uid then
			arg_18_0:_releaseXiaLiSpecialEffect()
		end

		if var_18_0.id == arg_18_0._shi_si_hang_shi_uid then
			arg_18_0:_releaseShiSiHangShiGoodEffect()
		end

		arg_18_0:_releaseEntityAnimation(var_18_0.id)
	end
end

function var_0_0._onBeforeDestroyEntity(arg_19_0, arg_19_1)
	arg_19_0:_releaseEntitySpineAnimEvent(arg_19_1)
end

function var_0_0.clearEffect(arg_20_0, arg_20_1)
	arg_20_0:_beforeDeadEffect(nil, arg_20_1)
end

function var_0_0.clearAllEffect(arg_21_0)
	arg_21_0:_releaseXiaLiSpecialEffect()
	arg_21_0:_releaseShiSiHangShiGoodEffect()
	arg_21_0:_releaseAllEntityAnimation()
end

function var_0_0.onSceneClose(arg_22_0)
	FightController.instance:unregisterCallback(FightEvent.OnInvokeSkill, arg_22_0._onInvokeSkill, arg_22_0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, arg_22_0._beforeDeadEffect, arg_22_0)
	FightController.instance:unregisterCallback(FightEvent.FightRoundEnd, arg_22_0._onFightRoundEnd, arg_22_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, arg_22_0._onSkillPlayStart, arg_22_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_22_0._onSkillPlayFinish, arg_22_0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDestroyEntity, arg_22_0._onBeforeDestroyEntity, arg_22_0)
	arg_22_0:clearAllEffect()
end

return var_0_0
