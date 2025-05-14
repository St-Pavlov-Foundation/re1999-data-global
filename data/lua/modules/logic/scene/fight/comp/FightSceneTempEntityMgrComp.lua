module("modules.logic.scene.fight.comp.FightSceneTempEntityMgrComp", package.seeall)

local var_0_0 = class("FightSceneTempEntityMgrComp", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._entityDic = {}
	arg_1_0._entityVisible = {}
	arg_1_0._entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
end

function var_0_0.onScenePrepared(arg_2_0, arg_2_1, arg_2_2)
	FightController.instance:registerCallback(FightEvent.EntrustTempEntity, arg_2_0._onEntrustTempEntity, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, arg_2_0._onRestartStageBefore, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, arg_2_0._onSkillPlayStart, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_2_0._onSkillPlayFinish, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnCameraFocusChanged, arg_2_0._onCameraFocusChanged, arg_2_0)
	FightController.instance:registerCallback(FightEvent.ReleaseAllEntrustedEntity, arg_2_0._releaseAllEntity, arg_2_0)
end

function var_0_0._onLevelLoaded(arg_3_0)
	arg_3_0._fightScene = GameSceneMgr.instance:getCurScene()
	arg_3_0._sceneObj = arg_3_0._fightScene.level:getSceneGo()
end

function var_0_0._onEntrustTempEntity(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.id

	if arg_4_0._entityDic[var_4_0] then
		arg_4_0:_releaseEntity(arg_4_0._entityDic[var_4_0])
	end

	arg_4_0._entityDic[var_4_0] = arg_4_1
	arg_4_0._entityVisible[var_4_0] = 0

	arg_4_1.spine:play(arg_4_1.spine._curAnimState, true)
end

function var_0_0._onSkillPlayStart(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._entityDic) do
		arg_5_0._entityVisible[iter_5_1.id] = (arg_5_0._entityVisible[iter_5_1.id] or 0) + 1

		iter_5_1:setVisibleByPos(false)
	end
end

function var_0_0._onSkillPlayFinish(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._entityDic) do
		if arg_6_0._entityVisible[iter_6_1.id] then
			arg_6_0._entityVisible[iter_6_1.id] = arg_6_0._entityVisible[iter_6_1.id] - 1

			if arg_6_0._entityVisible[iter_6_1.id] < 0 then
				arg_6_0._entityVisible[iter_6_1.id] = 0
			end
		end

		if arg_6_0._entityVisible[iter_6_1.id] == 0 then
			iter_6_1:setVisibleByPos(true)
			arg_6_0._entityMgr:adjustSpineLookRotation(iter_6_1)
		end
	end
end

function var_0_0._onCameraFocusChanged(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0:_onSkillPlayStart()
	else
		arg_7_0:_onSkillPlayFinish()
	end
end

function var_0_0._releaseEntity(arg_8_0, arg_8_1)
	arg_8_0._entityMgr:removeUnit(arg_8_1:getTag(), arg_8_1.id)

	arg_8_0._entityDic[arg_8_1.id] = nil
	arg_8_0._entityVisible[arg_8_1.id] = nil
end

function var_0_0._releaseAllEntity(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._entityDic) do
		arg_9_0:_releaseEntity(iter_9_1)
	end
end

function var_0_0._onRestartStageBefore(arg_10_0)
	arg_10_0:_releaseAllEntity()
end

function var_0_0.onSceneClose(arg_11_0, arg_11_1, arg_11_2)
	FightController.instance:unregisterCallback(FightEvent.EntrustTempEntity, arg_11_0._onEntrustTempEntity, arg_11_0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, arg_11_0._onRestartStageBefore, arg_11_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, arg_11_0._onSkillPlayStart, arg_11_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_11_0._onSkillPlayFinish, arg_11_0)
	FightController.instance:unregisterCallback(FightEvent.OnCameraFocusChanged, arg_11_0._onCameraFocusChanged, arg_11_0)
	FightController.instance:unregisterCallback(FightEvent.ReleaseAllEntrustedEntity, arg_11_0._releaseAllEntity, arg_11_0)
	arg_11_0:_releaseAllEntity()
end

return var_0_0
