module("modules.logic.scene.fight.comp.FightSceneTriggerSceneAnimatorComp", package.seeall)

local var_0_0 = class("FightSceneTriggerSceneAnimatorComp", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._activeState = true

	FightController.instance:registerCallback(FightEvent.TriggerSceneAnimator, arg_1_0._onTriggerSceneAnimator, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, arg_1_0._onRestartStageBefore, arg_1_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, arg_1_0._onLevelLoaded, arg_1_0)

	arg_1_0._cacheAni = {}
end

function var_0_0._onLevelLoaded(arg_2_0)
	arg_2_0._fightScene = GameSceneMgr.instance:getCurScene()

	local var_2_0 = arg_2_0._fightScene.level:getSceneGo()

	arg_2_0.listenClass = gohelper.onceAddComponent(var_2_0, typeof(ZProj.FightSceneActiveState))

	if BootNativeUtil.isWindows() and GameGlobalMgr.instance:getScreenState():getLocalQuality() == ModuleEnum.Performance.High then
		RenderPipelineSetting.AddRCASSceneCompoment(var_2_0)
	end

	arg_2_0.listenClass:releaseCallback()
	arg_2_0.listenClass:setCallback(arg_2_0._onSceneStateChange, arg_2_0)
end

function var_0_0._onTriggerSceneAnimator(arg_3_0, arg_3_1)
	arg_3_0._fightScene = arg_3_0._fightScene or GameSceneMgr.instance:getCurScene()

	if arg_3_0._fightScene then
		local var_3_0 = arg_3_0._fightScene.level:getSceneGo()
		local var_3_1 = gohelper.findChildComponent(var_3_0, arg_3_1.param1, typeof(UnityEngine.Animator))

		if var_3_1 then
			var_3_1.speed = FightModel.instance:getSpeed()

			var_3_1:Play(arg_3_1.param2, 0, 0)

			arg_3_0._cacheAni[arg_3_1.param1] = arg_3_1.param2
		end
	end
end

function var_0_0._onSceneStateChange(arg_4_0, arg_4_1)
	FightController.instance:dispatchEvent(FightEvent.ChangeSceneVisible, arg_4_1)

	if arg_4_0._fightScene then
		local var_4_0 = arg_4_0._fightScene.level:getSceneGo()

		if not gohelper.isNil(var_4_0) and arg_4_0._activeState ~= arg_4_1 then
			arg_4_0._activeState = arg_4_1

			if arg_4_0._activeState then
				for iter_4_0, iter_4_1 in pairs(arg_4_0._cacheAni) do
					local var_4_1 = gohelper.findChildComponent(var_4_0, iter_4_0, typeof(UnityEngine.Animator))

					if var_4_1 then
						var_4_1.speed = FightModel.instance:getSpeed()

						var_4_1:Play(iter_4_1 .. "_idle", 0, 0)
					end
				end
			end
		end
	end
end

function var_0_0._onRestartStageBefore(arg_5_0)
	arg_5_0._activeState = true
	arg_5_0._cacheAni = {}
end

function var_0_0.onSceneClose(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.listenClass then
		arg_6_0.listenClass:releaseCallback()

		arg_6_0.listenClass = nil
	end

	arg_6_0._cacheAni = nil

	FightController.instance:unregisterCallback(FightEvent.TriggerSceneAnimator, arg_6_0._onTriggerSceneAnimator, arg_6_0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, arg_6_0._onRestartStageBefore, arg_6_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, arg_6_0._onLevelLoaded, arg_6_0)
end

return var_0_0
