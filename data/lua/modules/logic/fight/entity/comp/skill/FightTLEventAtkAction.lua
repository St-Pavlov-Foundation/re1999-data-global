module("modules.logic.fight.entity.comp.skill.FightTLEventAtkAction", package.seeall)

slot0 = class("FightTLEventAtkAction")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0._attacker = FightHelper.getEntity(slot1.fromId)
	slot0._action = slot3[1]
	slot0._loop = slot3[2] == "1" and true or false
	slot0._monsterEvolution = slot3[3] == "1"
	slot0._detectCanPlay = slot3[4] == "1"

	if slot0._timeline_item._spine_delay_time then
		TaskDispatcher.runDelay(slot0._playAct, slot0, slot0._timeline_item._spine_delay_time)
	else
		slot0:_playAct()
	end
end

function slot0._playAct(slot0)
	if not string.nilorempty(slot0._action) and slot0._attacker and slot0._attacker.spine then
		if slot0._detectCanPlay then
			if not slot0._attacker.spine:tryPlay(slot0._action, slot0._loop, true) then
				return
			end
		else
			slot0._attacker.spine:play(slot0._action, slot0._loop, true)
		end

		if slot0._timeline_item._spine_start_time then
			slot0._attacker.spine._skeletonAnim:Jump2Time(slot0._timeline_item._spine_start_time)
		end

		if slot0._monsterEvolution then
			slot1 = slot0._attacker:getMO()

			if slot1 and lua_fight_boss_evolution_client.configDict[slot0._attacker.beforeMonsterChangeSkin or slot1.skin] then
				slot0._attacker.spine.lockAct = true
			end
		end
	end
end

function slot0.handleSkillEventEnd(slot0)
	slot0:_onActionFinish()
end

function slot0._onActionFinish(slot0)
	slot0._actionFinish = true

	if slot0._attacker.spine:getAnimState() == slot0._action then
		slot1 = slot0._attacker:getDefaultAnim()

		if slot0._attacker.spine:getSkeletonAnim() and slot2:HasAnimation(slot1) then
			slot0._attacker.spine:play(slot1, true, false)
		end
	end

	slot0._attacker = nil
end

function slot0.reset(slot0)
	if not slot0._actionFinish then
		slot0:_onActionFinish()
	end

	slot0._actionFinish = nil
	slot0._attacker = nil

	TaskDispatcher.cancelTask(slot0._playAct, slot0)
end

function slot0.dispose(slot0)
	slot0._attacker = nil
end

return slot0
