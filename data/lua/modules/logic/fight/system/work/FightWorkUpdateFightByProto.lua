module("modules.logic.fight.system.work.FightWorkUpdateFightByProto", package.seeall)

local var_0_0 = class("FightWorkUpdateFightByProto", FightWorkItem)

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0._fightProto = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = FightModel.instance:getFightParam()
	local var_2_1 = FightModel.instance:getCurWaveId()
	local var_2_2 = var_2_1 + 1
	local var_2_3 = var_2_0:getSceneLevel(var_2_1)
	local var_2_4 = var_2_0:getSceneLevel(var_2_2)

	if var_2_4 and var_2_4 ~= var_2_3 then
		arg_2_0._nextLevelId = var_2_4

		local var_2_5 = FightModel.instance:getSpeed()

		arg_2_0:com_registTimer(arg_2_0._delayDone, 10)
		arg_2_0:com_registTimer(arg_2_0._startLoadLevel, 0.25 / var_2_5)
	else
		arg_2_0:_startChange()
	end
end

function var_0_0._changeEntity(arg_3_0)
	local var_3_0 = arg_3_0:_cacheExpoint()
	local var_3_1 = FightModel.instance.power

	arg_3_0._existBuffUidDict = {}

	local var_3_2 = FightDataHelper.entityMgr:getMyNormalList()

	for iter_3_0, iter_3_1 in ipairs(var_3_2) do
		arg_3_0._existBuffUidDict[iter_3_1.id] = {}

		for iter_3_2, iter_3_3 in pairs(iter_3_1:getBuffDic()) do
			arg_3_0._existBuffUidDict[iter_3_1.id][iter_3_3.id] = iter_3_3
		end
	end

	arg_3_0._myStancePos2EntityId = {}
	arg_3_0._enemyStancePos2EntityId = {}

	for iter_3_4, iter_3_5 in pairs(arg_3_0:getTagUnitDict(SceneTag.UnitPlayer)) do
		arg_3_0._myStancePos2EntityId[iter_3_5:getMO().position] = iter_3_5.id
	end

	for iter_3_6, iter_3_7 in pairs(arg_3_0:getTagUnitDict(SceneTag.UnitMonster)) do
		arg_3_0._enemyStancePos2EntityId[iter_3_7:getMO().position] = iter_3_7.id
	end

	FightDataMgr.instance:updateFightData(arg_3_0._fightProto)

	FightModel.instance.power = var_3_1

	arg_3_0:_applyExpoint(var_3_0)
	GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr:changeWave(arg_3_0._nextWaveMsg.fight)
end

function var_0_0._startChange(arg_4_0)
	arg_4_0:_changeEntity()
	arg_4_0:onDone(true)
end

function var_0_0._onLevelLoaded(arg_5_0)
	arg_5_0:_startChange()
end

function var_0_0._startLoadLevel(arg_6_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, arg_6_0._onLevelLoaded, arg_6_0)
	GameSceneMgr.instance:getScene(SceneType.Fight).level:loadLevelWithSwitchEffect(arg_6_0._nextLevelId)
end

function var_0_0._delayDone(arg_7_0)
	arg_7_0:_startChange()
end

function var_0_0._cacheExpoint(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = FightHelper.getAllEntitys()

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		var_8_0[iter_8_1.id] = iter_8_1:getMO().exPoint
	end

	return var_8_0
end

function var_0_0._applyExpoint(arg_9_0, arg_9_1)
	local var_9_0 = FightHelper.getAllEntitys()

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_1 = arg_9_1[iter_9_1.id]

		if var_9_1 then
			iter_9_1:getMO():setExPoint(var_9_1)
		end
	end
end

return var_0_0
