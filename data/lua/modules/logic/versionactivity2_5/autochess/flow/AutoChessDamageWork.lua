module("modules.logic.versionactivity2_5.autochess.flow.AutoChessDamageWork", package.seeall)

local var_0_0 = class("AutoChessDamageWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.effect = arg_1_1
	arg_1_0.entityMgr = AutoChessEntityMgr.instance
	arg_1_0.attackEntity = arg_1_0.entityMgr:tryGetEntity(arg_1_0.effect.fromId) or arg_1_0.entityMgr:getLeaderEntity(arg_1_0.effect.fromId)
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	local var_2_0 = tonumber(arg_2_0.effect.effectNum)

	if var_2_0 == AutoChessEnum.DamageType.Ranged then
		local var_2_1 = AutoChessStrEnum.Tag2EffectId.Ranged
		local var_2_2 = lua_auto_chess_effect.configDict[var_2_1]
		local var_2_3 = arg_2_0.entityMgr:getEntity(arg_2_0.effect.targetIds[1])

		if arg_2_0.attackEntity and var_2_3 then
			arg_2_0.attackEntity:ranged(var_2_3.transform.position, var_2_2)
		end

		local var_2_4 = 0.5

		TaskDispatcher.runDelay(arg_2_0.playBeingAttack, arg_2_0, var_2_2.duration)
		TaskDispatcher.runDelay(arg_2_0.finishWork, arg_2_0, var_2_2.duration + var_2_4)
	elseif var_2_0 == AutoChessEnum.DamageType.Skill then
		arg_2_0:playBeingAttack()
		TaskDispatcher.runDelay(arg_2_0.finishWork, arg_2_0, 1)
	else
		if arg_2_0.attackEntity then
			arg_2_0.attackEntity:attack()
		end

		TaskDispatcher.runDelay(arg_2_0.playBeingAttack, arg_2_0, AutoChessEnum.ChessAniTime.Melee - 0.3)
		TaskDispatcher.runDelay(arg_2_0.finishWork, arg_2_0, AutoChessEnum.ChessAniTime.Melee)
	end
end

function var_0_0.playBeingAttack(arg_3_0)
	if tonumber(arg_3_0.effect.effectNum) == AutoChessEnum.DamageType.MeleeAoe then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0.effect.targetIds) do
			local var_3_0 = arg_3_0.entityMgr:getEntity(iter_3_1)

			if var_3_0 then
				local var_3_1 = iter_3_0 == 1 and 20001 or 20003

				var_3_0.effectComp:playEffect(var_3_1)
			end
		end
	else
		for iter_3_2, iter_3_3 in ipairs(arg_3_0.effect.targetIds) do
			local var_3_2 = arg_3_0.entityMgr:getEntity(iter_3_3)

			if var_3_2 then
				var_3_2.effectComp:playEffect(20001)
			end
		end
	end
end

function var_0_0.onStop(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.finishWork, arg_4_0)
end

function var_0_0.onResume(arg_5_0)
	arg_5_0:finishWork()
end

function var_0_0.clearWork(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.playBeingAttack, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.finishWork, arg_6_0)

	arg_6_0.effect = nil
end

function var_0_0.finishWork(arg_7_0)
	arg_7_0:onDone(true)
end

return var_0_0
