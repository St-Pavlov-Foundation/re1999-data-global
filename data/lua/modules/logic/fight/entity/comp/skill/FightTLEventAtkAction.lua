module("modules.logic.fight.entity.comp.skill.FightTLEventAtkAction", package.seeall)

local var_0_0 = class("FightTLEventAtkAction", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._attacker = FightHelper.getEntity(arg_1_1.fromId)
	arg_1_0._action = arg_1_3[1]
	arg_1_0._loop = arg_1_3[2] == "1" and true or false
	arg_1_0._monsterEvolution = arg_1_3[3] == "1"
	arg_1_0._detectCanPlay = arg_1_3[4] == "1"
	arg_1_0.lockAct = arg_1_3[6] == "1"

	if arg_1_3[5] == "1" then
		arg_1_0._attacker = FightHelper.getEntity(arg_1_1.toId)
	end

	if arg_1_0.timelineItem.spineDelayTime then
		TaskDispatcher.runDelay(arg_1_0._playAct, arg_1_0, arg_1_0.timelineItem.spineDelayTime)
	else
		arg_1_0:_playAct()
	end
end

function var_0_0._playAct(arg_2_0)
	if arg_2_0._attacker and arg_2_0._attacker.spine then
		if not string.nilorempty(arg_2_0._action) then
			if arg_2_0._detectCanPlay then
				if not arg_2_0._attacker.spine:tryPlay(arg_2_0._action, arg_2_0._loop, true) then
					return
				end
			else
				arg_2_0._attacker.spine:play(arg_2_0._action, arg_2_0._loop, true)
			end

			if arg_2_0.timelineItem.spineStartTime then
				arg_2_0._attacker.spine._skeletonAnim:Jump2Time(arg_2_0.timelineItem.spineStartTime)
			end

			if arg_2_0._monsterEvolution then
				local var_2_0 = arg_2_0._attacker:getMO()
				local var_2_1 = arg_2_0._attacker.beforeMonsterChangeSkin or var_2_0.skin

				if var_2_0 and lua_fight_boss_evolution_client.configDict[var_2_1] then
					arg_2_0._attacker.spine.lockAct = true
				end
			end
		end

		if arg_2_0.lockAct then
			arg_2_0._attacker.spine.lockAct = true
		end
	end
end

function var_0_0.onTrackEnd(arg_3_0)
	if arg_3_0.lockAct and arg_3_0._attacker and arg_3_0._attacker.spine then
		arg_3_0._attacker.spine.lockAct = false
	end

	arg_3_0:_onActionFinish()
end

function var_0_0._onActionFinish(arg_4_0)
	arg_4_0._actionFinish = true

	if arg_4_0._attacker and arg_4_0._attacker.spine and arg_4_0._attacker.spine:getAnimState() == arg_4_0._action then
		local var_4_0 = arg_4_0._attacker:getDefaultAnim()
		local var_4_1 = arg_4_0._attacker.spine:getSkeletonAnim()

		if var_4_1 and var_4_1:HasAnimation(var_4_0) then
			arg_4_0._attacker.spine:play(var_4_0, true, false)
		end
	end

	arg_4_0._attacker = nil
end

function var_0_0.onDestructor(arg_5_0)
	if arg_5_0.lockAct and arg_5_0._attacker and arg_5_0._attacker.spine then
		arg_5_0._attacker.spine.lockAct = false
	end

	if not arg_5_0._actionFinish then
		arg_5_0:_onActionFinish()
	end

	arg_5_0._actionFinish = nil
	arg_5_0._attacker = nil

	TaskDispatcher.cancelTask(arg_5_0._playAct, arg_5_0)
end

return var_0_0
