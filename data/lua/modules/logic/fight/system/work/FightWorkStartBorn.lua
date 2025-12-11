module("modules.logic.fight.system.work.FightWorkStartBorn", package.seeall)

local var_0_0 = class("FightWorkStartBorn", BaseWork)
local var_0_1 = 10

function var_0_0.onStart(arg_1_0)
	arg_1_0.playedVoice = false
	FightAudioMgr.instance.enterFightVoiceHeroID = nil
	arg_1_0._flowParallel = FlowParallel.New()

	local var_1_0 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_1 = iter_1_1:getMO()
		local var_1_2 = false

		if var_1_1:isAssistBoss() then
			var_1_2 = true
		end

		if var_1_1:isAct191Boss() then
			var_1_2 = true
		end

		if iter_1_1.spine and not iter_1_1.spine:hasAnimation(SpineAnimState.born) then
			var_1_2 = true
		end

		if not var_1_2 then
			if not arg_1_0.playedVoice then
				arg_1_0.playedVoice = true

				arg_1_0:_playEnterVoice()
			end

			local var_1_3 = FightWorkStartBornNormal.New(iter_1_1, true)

			var_1_3.dontDealBuff = true

			if FightDataHelper.entityMgr:isSub(iter_1_1.id) then
				var_1_3:onStart()
			else
				arg_1_0._flowParallel:addWork(var_1_3)
			end
		else
			if iter_1_1.nameUI then
				iter_1_1.nameUI:setActive(true)
			end

			iter_1_1:setAlpha(1, 0)
		end
	end

	TaskDispatcher.runDelay(arg_1_0._onBornTimeout, arg_1_0, var_0_1)
	FightController.instance:dispatchEvent(FightEvent.OnStartFightPlayBorn)
	arg_1_0._flowParallel:registerDoneListener(arg_1_0._onBornEnd, arg_1_0)
	arg_1_0._flowParallel:start()
end

function var_0_0._playEnterVoice(arg_2_0)
	FightAudioMgr.instance.enterFightVoiceHeroID = nil

	local var_2_0 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, false)

	if var_2_0 and #var_2_0 > 0 then
		local var_2_1 = var_2_0[math.random(#var_2_0)]:getMO().modelId

		FightAudioMgr.instance:playHeroVoiceRandom(var_2_1, CharacterEnum.VoiceType.EnterFight)

		FightAudioMgr.instance.enterFightVoiceHeroID = var_2_1
	end
end

function var_0_0._onBornEnd(arg_3_0)
	FightAudioMgr.instance.enterFightVoiceHeroID = nil

	arg_3_0:onDone(true)
end

function var_0_0._onBornTimeout(arg_4_0)
	FightAudioMgr.instance.enterFightVoiceHeroID = nil

	logError("播放出生效果时间超过" .. var_0_1 .. "秒")
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	if arg_5_0._flowParallel then
		arg_5_0._flowParallel:stop()
		arg_5_0._flowParallel:unregisterDoneListener(arg_5_0._onBornEnd, arg_5_0)
	end

	TaskDispatcher.cancelTask(arg_5_0._onBornTimeout, arg_5_0)
end

return var_0_0
