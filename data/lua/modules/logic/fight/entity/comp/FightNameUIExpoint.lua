module("modules.logic.fight.entity.comp.FightNameUIExpoint", package.seeall)

slot0 = class("FightNameUIExpoint")
slot1 = {
	[141102.0] = true
}
slot2 = Color.white
slot3 = Color.New(1, 1, 1, 0.86)

function slot0.init(slot0, slot1, slot2, slot3)
	slot5 = FightModel.instance:getCurMonsterGroupId() and lua_monster_group.configDict[slot4]
	slot6 = slot5 and slot5.bossId

	if uv0[slot1:getMO().modelId] or slot6 and FightHelper.isBossId(slot6, slot1:getMO().modelId) and BossRushController.instance:isInBossRushFight() then
		for slot12, slot13 in ipairs(slot2) do
			gohelper.setActive(slot13, false)
		end

		return
	end

	slot0._point_ani_sequence = {}
	slot0.entity = slot1
	slot0._exPointGOList = slot2
	slot0._exPointFullList = slot3
	slot0._uniqueSkillPoint = slot0.entity:getMO():getUniqueSkillPoint()

	slot0:_updateExPoint(slot1.id)
	slot0:_onExpointMaxAdd(slot1.id)
	FightController.instance:registerCallback(FightEvent.UpdateExPoint, slot0._updateExPoint, slot0)
	FightController.instance:registerCallback(FightEvent.OnExpointMaxAdd, slot0._onExpointMaxAdd, slot0)
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	FightController.instance:registerCallback(FightEvent.OnExPointChange, slot0._onExPointChange, slot0)
	FightController.instance:registerCallback(FightEvent.MultiHpChange, slot0._onMultiHpChange, slot0)
	FightController.instance:registerCallback(FightEvent.OnExSkillPointChange, slot0._onExSkillPointChange, slot0)
end

function slot0.beforeDestroy(slot0)
	FightController.instance:unregisterCallback(FightEvent.UpdateExPoint, slot0._updateExPoint, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnExpointMaxAdd, slot0._onExpointMaxAdd, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnExPointChange, slot0._onExPointChange, slot0)
	FightController.instance:unregisterCallback(FightEvent.MultiHpChange, slot0._onMultiHpChange, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnExSkillPointChange, slot0._onExSkillPointChange, slot0)
	TaskDispatcher.cancelTask(slot0._playPointChangeAni, slot0)
	TaskDispatcher.cancelTask(slot0._playExpointFullLoop, slot0)
	TaskDispatcher.cancelTask(slot0._dealExPoint, slot0)
	slot0:_cancelExpointFullLoop()

	slot0._exPointGOList = nil
	slot0._exPointFullList = nil
	slot0._point_ani_sequence = nil
end

function slot0.getMaxExPoint(slot0)
	if slot0.entity and slot0.entity:getMO() then
		return slot1:getMaxExPoint()
	end

	return 0
end

function slot0.updateUI(slot0)
	if slot0.entity then
		-- Nothing
	end
end

function slot0._getExpoint(slot0)
	slot1 = FightHelper.getPredeductionExpoint(slot0.entity.id)

	if slot0.entity:getMO() then
		return slot2.exPoint - slot1, slot2.exPoint + slot2.moveCardExPoint + slot2.playCardExPoint - slot1
	end

	return 0, 0
end

function slot0._updateExPoint(slot0, slot1)
	if not slot0.entity then
		return
	end

	if slot1 and slot1 ~= slot0.entity.id then
		return
	end

	slot2, slot3 = slot0:_getExpoint()

	if slot0._uniqueSkillPoint > 0 and (slot2 == slot0._uniqueSkillPoint or slot3 == slot0._uniqueSkillPoint) then
		if not slot0._play_done_burst then
			slot0._play_done_burst = true

			slot0:_showAllBurstEffect()
			TaskDispatcher.runDelay(slot0._dealExPoint, slot0, 0.66)
		else
			slot0:_dealExPoint()
		end
	else
		slot0._play_done_burst = nil

		slot0:_dealExPoint()
	end
end

function slot0._dealExPoint(slot0)
	slot0:_refreshExpointListState()

	slot1, slot2 = slot0:_getExpoint()

	if slot0:getMaxExPoint() <= slot1 and slot0:getMaxExPoint() > 0 then
		slot0:_playExpointFullLoop()
	end

	if FightHelper.getPredeductionExpoint(slot0.entity.id) > 0 then
		if not slot0.withholding_open then
			slot0.withholding_open = true

			slot0:_showAllWithHoldingOpen()
			TaskDispatcher.runDelay(slot0._dealExPoint, slot0, 1)
		else
			slot0:_playWithHolding()
		end
	else
		slot0.withholding_open = nil
	end
end

function slot0._refreshExpointListState(slot0)
	if not slot0.entity or not slot0.entity:getMO() then
		return
	end

	slot0:_cancelExpointFullLoop()
	TaskDispatcher.cancelTask(slot0._playExpointFullLoop, slot0)
	slot0:_resetAllAnimator()

	slot1 = nil

	if slot0.entity:getMO():hasBuffFeature(FightEnum.ExPointCantAdd) then
		slot1 = true
	end

	slot2, slot3 = slot0:_getExpoint()

	for slot7, slot8 in ipairs(slot0._exPointFullList) do
		gohelper.setActive(slot8, slot7 <= slot3)

		slot8:GetComponent(gohelper.Type_Image).color = uv0
		slot0._exPointGOList[slot7]:GetComponent(gohelper.Type_Image).color = uv1

		if slot0:_getAnimator(slot7) then
			if slot7 <= slot2 then
				-- Nothing
			elseif slot7 <= slot3 then
				slot0:_playExpointFlash(slot7)
			else
				if FightHelper.getPredeductionExpoint(slot0.entity.id) > 0 and slot7 <= slot0._uniqueSkillPoint then
					slot9.enabled = true

					slot9:Play("withholding_loop", 0, 0)
					slot9:Update(0)
				end

				if slot1 and gohelper.findChild(slot0._exPointGOList[slot7], "effectexpoint/lock") then
					gohelper.setActive(slot10, true)

					gohelper.findChild(slot10, "fulllock"):GetComponent(gohelper.Type_Image).color = uv0
				end
			end
		end
	end
end

function slot0._showAllBurstEffect(slot0)
	for slot4 = 1, slot0._uniqueSkillPoint do
		if slot0:_getAnimator(slot4) and slot5.gameObject.activeInHierarchy then
			slot5.enabled = true

			slot5:Play("fightname_expoint_all", 0, 0)
			slot5:Update(0)
		end

		gohelper.setActive(slot0._exPointFullList[slot4], true)
	end
end

function slot0._showAllWithHoldingOpen(slot0)
	for slot4 = 1, slot0._uniqueSkillPoint do
		if slot0:_getAnimator(slot4) and slot5.gameObject.activeInHierarchy then
			slot5.enabled = true

			slot5:Play("withholding_open", 0, 0)
			slot5:Update(0)
		end

		gohelper.setActive(slot0._exPointFullList[slot4], true)
	end
end

function slot0._onExPointChange(slot0, slot1, slot2, slot3)
	if slot0.entity.id ~= slot1 then
		return
	end

	table.insert(slot0._point_ani_sequence, {
		slot2,
		slot3
	})

	if slot0._pointPlayType == 1 and slot2 < slot3 then
		slot0._change_ani_playing = nil
	elseif slot0._pointPlayType == 2 and slot3 < slot2 then
		slot0._change_ani_playing = nil
	end

	if not slot0._change_ani_playing then
		slot0:_playPointChangeAni()
	end
end

function slot0._playPointChangeAni(slot0)
	if table.remove(slot0._point_ani_sequence, 1) then
		slot2 = slot1[1]
		slot3 = slot1[2]

		if slot0.entity and slot0.entity.id then
			if slot2 < slot3 then
				slot0._pointPlayType = 1

				slot0:_playAddExpointEffect(slot4, slot2, slot3)
			elseif slot3 < slot2 then
				slot0._pointPlayType = 2

				slot0:_playRemoveExPointEffect(slot4, slot2, slot3)
			end
		end
	else
		slot0._change_ani_playing = false
		slot0._pointPlayType = nil

		if slot0.entity and slot0.entity:getMO() then
			slot0:_dealExPoint()
		end
	end
end

function slot0._playAddExpointEffect(slot0, slot1, slot2, slot3)
	if not slot1 or slot1 ~= slot0.entity.id then
		return
	end

	slot4 = nil

	for slot8 = slot2 + 1, slot3 do
		if slot0._exPointFullList[slot8] then
			gohelper.setActive(slot9, true)
			slot0:_playExpointIn(slot8)

			slot4 = slot8
		end
	end

	if slot0:getMaxExPoint() <= slot3 then
		TaskDispatcher.runDelay(slot0._playExpointFullLoop, slot0, 0.93)
	end

	if slot4 then
		slot0._change_ani_playing = true

		TaskDispatcher.runDelay(slot0._playPointChangeAni, slot0, slot0:_getAnimator(slot4):GetCurrentAnimatorStateInfo(0).length / FightModel.instance:getSpeed())
	end
end

function slot0._playRemoveExPointEffect(slot0, slot1, slot2, slot3)
	if slot1 and slot1 ~= slot0.entity.id then
		return
	end

	if slot0:getMaxExPoint() <= slot2 and slot3 < slot0:getMaxExPoint() then
		slot0:_resetAllAnimator()
		slot0:_cancelExpointFullLoop()
	end

	slot4 = nil

	for slot8 = slot3 + 1, slot2 do
		if slot0._exPointFullList[slot8] then
			gohelper.setActive(slot9, false)
			slot0:_playExpointOut(slot8)

			slot4 = slot8
		end
	end

	if slot4 then
		slot0._change_ani_playing = true

		TaskDispatcher.runDelay(slot0._playPointChangeAni, slot0, slot0:_getAnimator(slot4):GetCurrentAnimatorStateInfo(0).length / FightModel.instance:getSpeed())
	end
end

function slot0._playExpointIn(slot0, slot1)
	if slot0:_getAnimator(slot1) and slot2.gameObject.activeInHierarchy then
		slot2.enabled = true

		slot2:Play("fightname_expoint_in", 0, 0)
		slot2:Update(0)
	end
end

function slot0._playExpointOut(slot0, slot1)
	if slot0:_getAnimator(slot1) and slot2.gameObject.activeInHierarchy then
		slot2.enabled = true

		slot2:Play("fightname_expoint_out", 0, 0)
		slot2:Update(0)
	end
end

function slot0._playWithHolding(slot0)
	slot0:_refreshExpointListState()
end

function slot0._playExpointFullLoop(slot0)
	slot1, slot2 = slot0:_getExpoint()

	for slot6 = 1, slot1 do
		if slot0:_getAnimator(slot6) then
			slot7.enabled = false

			slot0:_hideAllEffect(slot0._exPointGOList[slot6])
		end
	end

	slot0.loopIndex = nil

	TaskDispatcher.cancelTask(slot0._playFullLoop, slot0)
	TaskDispatcher.runRepeat(slot0._playFullLoop, slot0, 0.13, slot1)
end

function slot0._playFullLoop(slot0)
	slot0.loopIndex = slot0.loopIndex and slot0.loopIndex + 1 or 1

	if slot0:_getAnimator(slot0.loopIndex) and slot1.gameObject.activeInHierarchy then
		slot1.enabled = true

		slot1:Play("fightname_expoint_loop", 0, 0)
		slot1:Update(0)
	end
end

function slot0._cancelExpointFullLoop(slot0)
	TaskDispatcher.cancelTask(slot0._playFullLoop, slot0)
end

function slot0._playExpointFlash(slot0, slot1)
	if slot0:_getAnimator(slot1) and slot2.gameObject.activeInHierarchy then
		slot2.enabled = true

		slot2:Play("fightname_expoint_flash", 0, 0)
		slot2:Update(0)
	end
end

function slot0._getAnimator(slot0, slot1)
	return slot0._exPointGOList[slot1] and slot2:GetComponent(typeof(UnityEngine.Animator))
end

function slot0._resetAllAnimator(slot0)
	for slot4, slot5 in ipairs(slot0._exPointGOList) do
		slot6 = slot0._exPointFullList[slot4]

		if slot0:_getAnimator(slot4) then
			slot7.enabled = false
		end

		slot6:GetComponent(typeof(UnityEngine.UI.Image)).color = uv0

		slot0:_hideAllEffect(slot5)
		transformhelper.setLocalScale(slot6.transform, 1, 1, 1)
	end
end

function slot0._hideAllEffect(slot0, slot1)
	gohelper.setActive(gohelper.findChild(slot1, "effectexpoint/in"), false)
	gohelper.setActive(gohelper.findChild(slot1, "effectexpoint/loop"), false)
	gohelper.setActive(gohelper.findChild(slot1, "effectexpoint/out"), false)
	gohelper.setActive(gohelper.findChild(slot1, "effectexpoint/all"), false)
	gohelper.setActive(gohelper.findChild(slot1, "effectexpoint/withholding"), false)
	gohelper.setActive(gohelper.findChild(slot1, "effectexpoint/lock"), false)
end

function slot0._onExpointMaxAdd(slot0, slot1, slot2)
	if slot0.entity and slot1 == slot0.entity.id then
		if #slot0._exPointGOList < slot0:getMaxExPoint() then
			for slot8 = slot3 + 1, slot4 do
				slot9 = slot0._exPointGOList[1].transform.parent
				slot11 = gohelper.clone(slot9:Find("extra").gameObject, slot9.gameObject)

				gohelper.setActive(slot11, true)
				table.insert(slot0._exPointGOList, slot11)
				table.insert(slot0._exPointFullList, gohelper.findChild(slot11, "full"))
			end
		else
			for slot8 = 1, slot4 do
				gohelper.setActive(slot0._exPointGOList[slot8], true)
			end

			for slot8 = slot4 + 1, slot3 do
				gohelper.setActive(slot0._exPointGOList[slot8], false)
			end
		end

		slot0:_updateExPoint(slot0.entity.id)
	end
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3)
	if not slot0.entity then
		return
	end

	if slot1 ~= slot0.entity.id then
		return
	end

	slot4 = nil

	if slot2 == FightEnum.EffectType.BUFFADD then
		if FightConfig.instance:hasBuffFeature(slot3, FightEnum.ExPointCantAdd) then
			slot4 = "lock_open"
		end
	elseif slot2 == FightEnum.EffectType.BUFFDEL and FightConfig.instance:hasBuffFeature(slot3, FightEnum.ExPointCantAdd) then
		slot4 = "lock_close"
	end

	if slot4 then
		slot5, slot6 = slot0:_getExpoint()

		for slot10, slot11 in ipairs(slot0._exPointFullList) do
			if slot0:_getAnimator(slot10) and slot6 < slot10 then
				gohelper.setActive(slot11, false)

				slot12.enabled = true

				slot12:Play(slot4, 0, 0)
				slot12:Update(0)
			end
		end
	end
end

function slot0._onMultiHpChange(slot0, slot1)
	slot0:_updateExPoint(slot1)
end

function slot0._onExSkillPointChange(slot0, slot1, slot2, slot3)
	if slot0.entity and slot1 == slot0.entity.id then
		slot0._uniqueSkillPoint = slot3

		slot0:_updateExPoint(slot1)
	end
end

return slot0
