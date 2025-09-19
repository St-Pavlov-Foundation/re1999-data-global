module("modules.logic.fight.mgr.FightGameMgr", package.seeall)

local var_0_0 = class("FightGameMgr", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.fightMgr = {}
	arg_1_0.gamePlayMgr = {}

	arg_1_0:com_registMsg(FightMsgId.RestartGame, arg_1_0.onRestartGame)
end

function var_0_0.onAwake(arg_2_0)
	arg_2_0:registFightMgr()
	arg_2_0:registGamePlayMgr()
	arg_2_0:defineMgrRef(arg_2_0.fightMgr)
	arg_2_0:defineMgrRef(arg_2_0.gamePlayMgr)
end

function var_0_0.registFightMgr(arg_3_0)
	if GameSceneMgr.instance:useDefaultScene() == false then
		arg_3_0.sceneTriggerSceneAnimatorMgr = arg_3_0:newClass(FightSceneTriggerSceneAnimatorMgr)
	end
end

function var_0_0.registGamePlayMgr(arg_4_0)
	arg_4_0.checkCrashMgr = arg_4_0:newClass(FightCheckCrashMgr)
	arg_4_0.entrustEntityMgr = arg_4_0:newClass(FightEntrustEntityMgr)
	arg_4_0.entrustDeadEntityMgr = arg_4_0:newClass(FightEntrustDeadEntityMgr)
end

function var_0_0.defineMgrRef(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		for iter_5_2, iter_5_3 in pairs(arg_5_0) do
			if iter_5_3 == iter_5_1 then
				FightGameHelper[iter_5_2] = iter_5_1

				break
			end
		end
	end
end

function var_0_0.onRestartGame(arg_6_0)
	for iter_6_0 = #arg_6_0.gamePlayMgr, 1, -1 do
		arg_6_0.gamePlayMgr[iter_6_0]:disposeSelf()
	end

	tabletool.clear(arg_6_0.gamePlayMgr)
	arg_6_0:registGamePlayMgr()
	arg_6_0:defineMgrRef(arg_6_0.gamePlayMgr)
end

function var_0_0.onDestructor(arg_7_0)
	return
end

return var_0_0
