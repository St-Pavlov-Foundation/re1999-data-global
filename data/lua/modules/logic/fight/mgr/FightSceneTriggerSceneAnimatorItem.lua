module("modules.logic.fight.mgr.FightSceneTriggerSceneAnimatorItem", package.seeall)

local var_0_0 = class("FightSceneTriggerSceneAnimatorItem", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.activeState = true
	arg_1_0.cacheAni = {}

	arg_1_0:com_registFightEvent(FightEvent.TriggerSceneAnimator, arg_1_0._onTriggerSceneAnimator)
	arg_1_0:com_registFightEvent(FightEvent.OnRestartStageBefore, arg_1_0._onRestartStageBefore)
	arg_1_0:_onLevelLoaded()
end

function var_0_0._onLevelLoaded(arg_2_0)
	arg_2_0._fightScene = GameSceneMgr.instance:getCurScene()

	if not arg_2_0._fightScene then
		return
	end

	if not arg_2_0._fightScene.level then
		return
	end

	local var_2_0 = arg_2_0._fightScene.level:getSceneGo()

	if not var_2_0 then
		return
	end

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

		if not gohelper.isNil(var_3_0) then
			local var_3_1 = gohelper.findChildComponent(var_3_0, arg_3_1.param1, typeof(UnityEngine.Animator))

			if var_3_1 then
				var_3_1.speed = FightModel.instance:getSpeed()

				var_3_1:Play(arg_3_1.param2, 0, 0)

				arg_3_0.cacheAni[arg_3_1.param1] = arg_3_1.param2
			end
		end
	end
end

function var_0_0._onSceneStateChange(arg_4_0, arg_4_1)
	FightController.instance:dispatchEvent(FightEvent.ChangeSceneVisible, arg_4_1)

	if arg_4_0._fightScene then
		local var_4_0 = arg_4_0._fightScene.level:getSceneGo()

		if not gohelper.isNil(var_4_0) and arg_4_0.activeState ~= arg_4_1 then
			arg_4_0.activeState = arg_4_1

			if arg_4_0.activeState then
				for iter_4_0, iter_4_1 in pairs(arg_4_0.cacheAni) do
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
	arg_5_0.activeState = true
	arg_5_0.cacheAni = {}
end

function var_0_0.onDestructor(arg_6_0)
	if arg_6_0.listenClass then
		arg_6_0.listenClass:releaseCallback()

		arg_6_0.listenClass = nil
	end
end

return var_0_0
