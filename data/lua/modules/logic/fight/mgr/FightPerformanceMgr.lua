module("modules.logic.fight.mgr.FightPerformanceMgr", package.seeall)

local var_0_0 = class("FightPerformanceMgr", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.gamePlayMgr = {}
	arg_1_0.userDataMgrList = {}

	arg_1_0:com_registMsg(FightMsgId.RestartGame, arg_1_0._onRestartGame)
end

function var_0_0.onAwake(arg_2_0)
	arg_2_0:registFightMgr()
	arg_2_0:registGamePlayMgr()
end

function var_0_0.registFightMgr(arg_3_0)
	return
end

function var_0_0.registGamePlayMgr(arg_4_0)
	arg_4_0:registGamePlayClass(FightOperationMgr)
	arg_4_0:registGamePlayClass(FightEntityEvolutionMgr)
	arg_4_0:registGamePlayClass(FightBuffTypeId2EffectMgr)
	arg_4_0:registGamePlayClass(FightEntrustedWorkMgr)
	arg_4_0:registGamePlayClass(FightPlayMgr)

	arg_4_0.asfdMgr = arg_4_0:registerUserDataClass(FightASFDMgr)
end

function var_0_0.registGamePlayClass(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:newClass(arg_5_1)

	table.insert(arg_5_0.gamePlayMgr, var_5_0)

	return var_5_0
end

function var_0_0.registerUserDataClass(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.New()

	var_6_0:init()
	table.insert(arg_6_0.userDataMgrList, var_6_0)

	return var_6_0
end

function var_0_0._onRestartGame(arg_7_0)
	for iter_7_0 = #arg_7_0.gamePlayMgr, 1, -1 do
		arg_7_0.gamePlayMgr[iter_7_0]:disposeSelf()
	end

	tabletool.clear(arg_7_0.gamePlayMgr)
	arg_7_0:clearUserDataMgr()
	arg_7_0:registGamePlayMgr()
end

function var_0_0.clearUserDataMgr(arg_8_0)
	for iter_8_0 = #arg_8_0.userDataMgrList, 1, -1 do
		arg_8_0.userDataMgrList[iter_8_0]:dispose()
	end

	tabletool.clear(arg_8_0.userDataMgrList)

	arg_8_0.asfdMgr = nil
end

function var_0_0.getASFDMgr(arg_9_0)
	return arg_9_0.asfdMgr
end

function var_0_0.onDestructor(arg_10_0)
	arg_10_0:clearUserDataMgr()
end

return var_0_0
