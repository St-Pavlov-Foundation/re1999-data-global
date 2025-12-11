module("modules.logic.fight.mgr.FightGameMgr", package.seeall)

local var_0_0 = class("FightGameMgr", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.mgrList = {}

	arg_1_0:com_registEvent(ConnectAliveMgr.instance, ConnectEvent.OnLostConnect, arg_1_0.onLostConnect)
	arg_1_0:com_registMsg(FightMsgId.RestartGame, arg_1_0.onRestartGame)

	var_0_0.restartMgr = arg_1_0:newClass(FightRestartMgr)
end

function var_0_0.onLogicEnter(arg_2_0)
	arg_2_0:registMgr()
	arg_2_0:defineMgrRef()
end

function var_0_0.registMgr(arg_3_0)
	arg_3_0.playMgr = arg_3_0:addMgr(FightPlayMgr)
	arg_3_0.operateMgr = arg_3_0:addMgr(FightOperateMgr)
	arg_3_0.checkCrashMgr = arg_3_0:addMgr(FightCheckCrashMgr)
	arg_3_0.entrustEntityMgr = arg_3_0:addMgr(FightEntrustEntityMgr)
	arg_3_0.entrustDeadEntityMgr = arg_3_0:addMgr(FightEntrustDeadEntityMgr)
	arg_3_0.wadingEffect = arg_3_0:addMgr(FightWadingEffectMgr)

	if GameSceneMgr.instance:useDefaultScene() == false then
		arg_3_0.sceneTriggerSceneAnimatorMgr = arg_3_0:addMgr(FightSceneTriggerSceneAnimatorMgr)
	end

	arg_3_0.userDataClassMgr = arg_3_0:addMgr(FightUserDataClassMgr)
end

function var_0_0.addMgr(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:newClass(arg_4_1)

	table.insert(arg_4_0.mgrList, var_4_0)

	return var_4_0
end

function var_0_0.defineMgrRef(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.mgrList) do
		for iter_5_2, iter_5_3 in pairs(arg_5_0) do
			if iter_5_3 == iter_5_1 then
				var_0_0[iter_5_2] = iter_5_1

				break
			end
		end
	end
end

function var_0_0.onRestartGame(arg_6_0)
	for iter_6_0 = #arg_6_0.mgrList, 1, -1 do
		arg_6_0.mgrList[iter_6_0]:disposeSelf()
		table.remove(arg_6_0.mgrList, iter_6_0)
	end

	arg_6_0:registMgr()
	arg_6_0:defineMgrRef()
end

function var_0_0.onLostConnect(arg_7_0)
	local var_7_0 = PlayerModel.instance:getPlayinfo()
	local var_7_1 = "战斗超时断线,玩家uid:%d, 战斗id: %d"
	local var_7_2 = string.format(var_7_1, var_7_0.userId, FightDataHelper.fieldMgr.battleId)
	local var_7_3 = FightDataHelper.entityMgr.entityDataDic

	for iter_7_0, iter_7_1 in pairs(var_7_3) do
		local var_7_4 = true

		if not iter_7_1:isMySide() then
			var_7_4 = false
		end

		if iter_7_0 == "0" then
			var_7_4 = false
		end

		if var_7_4 then
			var_7_2 = var_7_2 .. ", heroId:" .. iter_7_1.modelId
		end
	end

	logError(var_7_2)
end

function var_0_0.onDestructor(arg_8_0)
	return
end

return var_0_0
