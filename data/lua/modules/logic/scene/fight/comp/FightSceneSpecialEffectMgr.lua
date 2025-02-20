module("modules.logic.scene.fight.comp.FightSceneSpecialEffectMgr", package.seeall)

slot0 = class("FightSceneSpecialEffectMgr", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	FightController.instance:registerCallback(FightEvent.OnInvokeSkill, slot0._onInvokeSkill, slot0)
	FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, slot0._beforeDeadEffect, slot0)
	FightController.instance:registerCallback(FightEvent.FightRoundEnd, slot0._onFightRoundEnd, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:registerCallback(FightEvent.BeforeDestroyEntity, slot0._onBeforeDestroyEntity, slot0)
end

function slot0.addBuff(slot0, slot1, slot2)
	slot0:_detectShiSiHangShiGoodEffect(slot1)
	slot0:_detectPlayBuffAnimation(slot1, slot2)
	slot0:_detectPlayCarAnimation(slot1, slot2)
end

function slot0.delBuff(slot0, slot1, slot2)
	slot0:_detectShiSiHangShiGoodEffect(slot1)

	if slot1.id == slot0._xia_li_uid and (slot2.buffId == 30172 or slot2.buffId == 30171) then
		slot0:_releaseXiaLiSpecialEffect()
	end

	slot0:_detectPlayBuffAnimation(slot1, slot2, true)
end

function slot0._detectPlayBuffAnimation(slot0, slot1, slot2, slot3)
	if FightBuffHelper.isDormantBuff(slot2.buffId) then
		if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
			-- Nothing
		elseif not FightWorkStepBuff.canPlayDormantBuffAni then
			return
		end

		if not slot0._buff_animation_dic then
			slot0._buff_animation_dic = {}
		end

		if not slot0._buff_animation_dic[slot1.id] then
			slot0._buff_animation_dic[slot1.id] = {}
		end

		slot0:_releaseEntityAnimation(slot1.id)
		table.insert(slot0._buff_animation_dic[slot1.id], FightBuffPlayAnimation.New(slot1, slot2, slot3 and "mjzz_return" or "mjzz_sleep"))
	end
end

function slot0._onSkillPlayStart(slot0, slot1)
	if slot1 and slot1.id == slot0._xia_li_uid and slot0._xia_li_skill_id == 30170143 and slot0._xiali_special_effect then
		slot0._xiali_special_effect:setActive(false)
	end
end

function slot0._onSkillPlayFinish(slot0, slot1)
	if slot1 and slot1.id == slot0._xia_li_uid and slot0._xiali_special_effect then
		slot0._xiali_special_effect:setActive(true)
	end
end

function slot0._onInvokeSkill(slot0, slot1)
	if slot1.actType == FightEnum.ActType.SKILL and FightHelper.getEntity(slot1.fromId) and slot1.fromId == slot2.id then
		if slot1.actId == 30170141 then
			slot0:_releaseXiaLiSpecialEffect()

			slot0._xiali_special_effect = slot2.effect:addHangEffect("buff/xiali_buff_innate1", ModuleEnum.SpineHangPoint.mounthead, nil, , {
				z = 0,
				x = 0,
				y = 0
			})

			slot0._xiali_special_effect:setLocalPos(0, 0, 0)

			slot0._xia_li_uid = slot2.id
			slot0._xia_li_skill_id = slot1.actId

			FightRenderOrderMgr.instance:onAddEffectWrap(slot2.id, slot0._xiali_special_effect)
		elseif slot1.actId == 30170143 then
			slot0:_releaseXiaLiSpecialEffect()

			slot0._xiali_special_effect = slot2.effect:addHangEffect("buff/xiali_buff_innate2", "special4", nil, , {
				z = 0,
				x = 0,
				y = 0
			})

			slot0._xiali_special_effect:setLocalPos(0, 0, 0)

			slot0._xia_li_uid = slot2.id
			slot0._xia_li_skill_id = slot1.actId

			FightRenderOrderMgr.instance:onAddEffectWrap(slot2.id, slot0._xiali_special_effect)
		end
	end
end

function slot0._onFightRoundEnd(slot0)
end

function slot0.setBuffEffectVisible(slot0, slot1, slot2)
	if slot1 and slot1.id == slot0._xia_li_uid and slot0._xiali_special_effect then
		slot0._xiali_special_effect:setActive(slot2)
	end

	if slot1 and slot1.id == slot0._shi_si_hang_shi_uid and slot0._shi_si_hang_shi_good_effect then
		slot0._shi_si_hang_shi_good_effect:setActive(slot2)
	end
end

function slot0._releaseXiaLiSpecialEffect(slot0)
	if slot0._xiali_special_effect then
		if FightHelper.getEntity(slot0._xia_li_uid) then
			slot1.effect:removeEffect(slot0._xiali_special_effect)
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0._xia_li_uid, slot0._xiali_special_effect)

		slot0._xiali_special_effect = nil
		slot0._xia_li_uid = nil
	end
end

function slot0._releaseShiSiHangShiGoodEffect(slot0)
	if slot0._shi_si_hang_shi_good_effect then
		if FightHelper.getEntity(slot0._shi_si_hang_shi_uid) then
			slot1.effect:removeEffect(slot0._shi_si_hang_shi_good_effect)
		end

		FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0._shi_si_hang_shi_uid, slot0._shi_si_hang_shi_good_effect)

		slot0._shi_si_hang_shi_good_effect = nil
		slot0._shi_si_hang_shi_uid = nil
	end
end

function slot0._detectShiSiHangShiGoodEffect(slot0, slot1, slot2)
	if slot1:getMO() and slot3.modelId == 3023 then
		slot4, slot5 = HeroConfig.instance:getShowLevel(slot3.level)

		if slot5 < 2 then
			return
		end

		slot6 = false

		for slot11, slot12 in pairs(slot3:getBuffDic()) do
			for slot18, slot19 in ipairs(FightEnum.BuffTypeList.GoodBuffList) do
				if lua_skill_bufftype.configDict[lua_skill_buff.configDict[slot12.buffId].typeId].type == slot19 then
					slot6 = true

					break
				end
			end

			if slot6 then
				break
			end
		end

		if slot6 then
			if not slot0._shi_si_hang_shi_good_effect then
				slot0._shi_si_hang_shi_good_effect = slot1.effect:addHangEffect("buff/shisihangshi_innate", ModuleEnum.SpineHangPoint.mountweapon, nil, , {
					z = 0,
					x = 0,
					y = 0
				})

				slot0._shi_si_hang_shi_good_effect:setLocalPos(0, 0, 0)

				slot0._shi_si_hang_shi_uid = slot1.id

				FightRenderOrderMgr.instance:onAddEffectWrap(slot1.id, slot0._shi_si_hang_shi_good_effect)
			end
		else
			slot0:_releaseShiSiHangShiGoodEffect()
		end
	end
end

function slot0._detectPlayCarAnimation(slot0, slot1, slot2)
	for slot6 = 1, 10 do
		if slot2.buffId == 6301310 + slot6 then
			if slot1.spine:tryPlay("idle_change") then
				slot1.spine:addAnimEventCallback(slot0._onAnimEvent, slot0, slot1)
			end

			break
		end
	end
end

function slot0._onAnimEvent(slot0, slot1, slot2, slot3, slot4)
	if slot2 == SpineAnimEvent.ActionComplete and slot1 == "idle_change" then
		slot4.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
		slot4:resetAnimState()
	end
end

function slot0._releaseAllEntityAnimation(slot0)
	if slot0._buff_animation_dic then
		for slot4, slot5 in pairs(slot0._buff_animation_dic) do
			slot0:_releaseEntityAnimation(slot4)
		end
	end

	slot0._buff_animation_dic = nil
end

function slot0._releaseEntityAnimation(slot0, slot1)
	if slot0._buff_animation_dic and slot0._buff_animation_dic[slot1] then
		for slot5, slot6 in ipairs(slot0._buff_animation_dic[slot1]) do
			slot6:releaseSelf()
		end

		slot0._buff_animation_dic[slot1] = {}
	end
end

function slot0._releaseEntitySpineAnimEvent(slot0, slot1)
	if slot1 and slot1.spine then
		slot1.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
	end
end

function slot0._beforeDeadEffect(slot0, slot1, slot2)
	if slot2 or FightHelper.getEntity(slot1) then
		if slot3.id == slot0._xia_li_uid then
			slot0:_releaseXiaLiSpecialEffect()
		end

		if slot3.id == slot0._shi_si_hang_shi_uid then
			slot0:_releaseShiSiHangShiGoodEffect()
		end

		slot0:_releaseEntityAnimation(slot3.id)
	end
end

function slot0._onBeforeDestroyEntity(slot0, slot1)
	slot0:_releaseEntitySpineAnimEvent(slot1)
end

function slot0.clearEffect(slot0, slot1)
	slot0:_beforeDeadEffect(nil, slot1)
end

function slot0.clearAllEffect(slot0)
	slot0:_releaseXiaLiSpecialEffect()
	slot0:_releaseShiSiHangShiGoodEffect()
	slot0:_releaseAllEntityAnimation()
end

function slot0.onSceneClose(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnInvokeSkill, slot0._onInvokeSkill, slot0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, slot0._beforeDeadEffect, slot0)
	FightController.instance:unregisterCallback(FightEvent.FightRoundEnd, slot0._onFightRoundEnd, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDestroyEntity, slot0._onBeforeDestroyEntity, slot0)
	slot0:clearAllEffect()
end

return slot0
