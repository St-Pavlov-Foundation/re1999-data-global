module("modules.logic.scene.fight.comp.FightSceneBossEntityEvolutionMgrComp", package.seeall)

local var_0_0 = class("FightSceneBossEntityEvolutionMgrComp", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._entityDic = {}
	arg_1_0._entityVisible = {}
	arg_1_0._skinId2Entity = {}
	arg_1_0._skinIds = {}
	arg_1_0._delayReleaseEntity = {}
	arg_1_0._entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
end

function var_0_0.onScenePrepared(arg_2_0, arg_2_1, arg_2_2)
	FightController.instance:registerCallback(FightEvent.SetBossEvolution, arg_2_0._onSetBossEvolution, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, arg_2_0._onRestartStageBefore, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, arg_2_0._onSkillPlayStart, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_2_0._onSkillPlayFinish, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnCameraFocusChanged, arg_2_0._onCameraFocusChanged, arg_2_0)
	FightController.instance:registerCallback(FightEvent.ReleaseAllEntrustedEntity, arg_2_0._releaseAllEntity, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_2_0._onSpineLoaded, arg_2_0)
end

function var_0_0._onLevelLoaded(arg_3_0)
	arg_3_0._fightScene = GameSceneMgr.instance:getCurScene()
	arg_3_0._sceneObj = arg_3_0._fightScene.level:getSceneGo()
end

function var_0_0.isEvolutionSkin(arg_4_0, arg_4_1)
	return arg_4_0._skinIds[arg_4_1]
end

function var_0_0._onSetBossEvolution(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1.id

	if arg_5_0._entityDic[var_5_0] then
		arg_5_0:_releaseEntity(arg_5_0._entityDic[var_5_0])
	end

	arg_5_0._entityDic[var_5_0] = arg_5_1
	arg_5_0._entityVisible[var_5_0] = 0

	arg_5_1.spine:play(arg_5_1.spine._curAnimState, true)

	arg_5_0._skinId2Entity[arg_5_2] = arg_5_0._skinId2Entity[arg_5_2] or {}

	table.insert(arg_5_0._skinId2Entity[arg_5_2], arg_5_1)

	arg_5_0._skinIds[arg_5_2] = true
end

function var_0_0._onSpineLoaded(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.unitSpawn
	local var_6_1 = var_6_0 and var_6_0:getMO()

	if var_6_1 and arg_6_0._skinId2Entity[var_6_1.skin] then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0._skinId2Entity[var_6_1.skin]) do
			local var_6_2 = iter_6_1.spine
			local var_6_3 = var_6_2 and var_6_2._skeletonAnim and var_6_2._skeletonAnim.state:GetCurrent(0)

			if var_6_3 and arg_6_1._skeletonAnim then
				arg_6_1._skeletonAnim:Jump2Time(var_6_3.TrackTime)
			end

			local var_6_4 = {
				entity = iter_6_1
			}
			local var_6_5 = arg_6_1:getSpineGO()

			var_6_4.spineGO = var_6_5

			transformhelper.setLocalPos(var_6_5.transform, -10000, 0, 0)
			table.insert(arg_6_0._delayReleaseEntity, var_6_4)
		end

		TaskDispatcher.runDelay(arg_6_0._delayRelease, arg_6_0, 0.01)

		arg_6_0._skinId2Entity[var_6_1.skin] = nil
	end
end

function var_0_0._delayRelease(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._delayReleaseEntity) do
		arg_7_0:_releaseEntity(iter_7_1.entity)
		transformhelper.setLocalPos(iter_7_1.spineGO.transform, 0, 0, 0)
	end

	arg_7_0._delayReleaseEntity = {}
end

function var_0_0._onSkillPlayStart(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._entityDic) do
		arg_8_0._entityVisible[iter_8_1.id] = (arg_8_0._entityVisible[iter_8_1.id] or 0) + 1

		iter_8_1:setAlpha(0, 0.2)
	end
end

function var_0_0._onSkillPlayFinish(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._entityDic) do
		if arg_9_0._entityVisible[iter_9_1.id] then
			arg_9_0._entityVisible[iter_9_1.id] = arg_9_0._entityVisible[iter_9_1.id] - 1

			if arg_9_0._entityVisible[iter_9_1.id] < 0 then
				arg_9_0._entityVisible[iter_9_1.id] = 0
			end
		end

		if arg_9_0._entityVisible[iter_9_1.id] == 0 then
			iter_9_1:setAlpha(1, 0.2)
			arg_9_0._entityMgr:adjustSpineLookRotation(iter_9_1)
		end
	end
end

function var_0_0._onCameraFocusChanged(arg_10_0, arg_10_1)
	if arg_10_1 then
		arg_10_0:_onSkillPlayStart()
	else
		arg_10_0:_onSkillPlayFinish()
	end
end

function var_0_0._releaseEntity(arg_11_0, arg_11_1)
	if arg_11_0._entityDic[arg_11_1.id] then
		arg_11_0._entityMgr:destroyUnit(arg_11_1)

		arg_11_0._entityDic[arg_11_1.id] = nil
		arg_11_0._entityVisible[arg_11_1.id] = nil
	end
end

function var_0_0._releaseAllEntity(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._entityDic) do
		arg_12_0:_releaseEntity(iter_12_1)
	end

	arg_12_0._skinId2Entity = {}
	arg_12_0._skinIds = {}
	arg_12_0._delayReleaseEntity = {}
end

function var_0_0._onRestartStageBefore(arg_13_0)
	arg_13_0:_releaseAllEntity()
end

function var_0_0.onSceneClose(arg_14_0, arg_14_1, arg_14_2)
	TaskDispatcher.cancelTask(arg_14_0._delayRelease, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.SetBossEvolution, arg_14_0._onSetBossEvolution, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, arg_14_0._onRestartStageBefore, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, arg_14_0._onSkillPlayStart, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_14_0._onSkillPlayFinish, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.OnCameraFocusChanged, arg_14_0._onCameraFocusChanged, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.ReleaseAllEntrustedEntity, arg_14_0._releaseAllEntity, arg_14_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_14_0._onSpineLoaded, arg_14_0)
	arg_14_0:_releaseAllEntity()
end

return var_0_0
