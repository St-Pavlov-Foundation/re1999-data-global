module("modules.logic.scene.fight.comp.FightSceneMagicCircleComp", package.seeall)

local var_0_0 = class("FightSceneMagicCircleComp", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._effectDic = {}
end

function var_0_0.onScenePrepared(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._entity = FightHelper.getEntity(FightEntityScene.MySideId)

	FightController.instance:registerCallback(FightEvent.AddMagicCircile, arg_2_0._onAddMagicCircile, arg_2_0)
	FightController.instance:registerCallback(FightEvent.DeleteMagicCircile, arg_2_0._onDeleteMagicCircile, arg_2_0)
	FightController.instance:registerCallback(FightEvent.UpdateMagicCircile, arg_2_0._onUpdateMagicCircile, arg_2_0)
	FightController.instance:registerCallback(FightEvent.UpgradeMagicCircile, arg_2_0._onUpgradeMagicCircile, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, arg_2_0._onRestartStageBefore, arg_2_0)
	FightController.instance:registerCallback(FightEvent.ChangeSceneVisible, arg_2_0._onChangeSceneVisible, arg_2_0)
	FightController.instance:registerCallback(FightEvent.BeforeEnterStepBehaviour, arg_2_0._onBeforeEnterStepBehaviour, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, arg_2_0._onSkillPlayStart, arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_2_0._onSkillPlayFinish, arg_2_0)
	FightController.instance:registerCallback(FightEvent.StartFightEnd, arg_2_0._onStartFightEnd, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
end

function var_0_0._onLevelLoaded(arg_3_0)
	arg_3_0._fightScene = GameSceneMgr.instance:getCurScene()
	arg_3_0._sceneObj = arg_3_0._fightScene.level:getSceneGo()
end

function var_0_0.createEffect(arg_4_0, arg_4_1, arg_4_2)
	if not string.nilorempty(arg_4_1) then
		arg_4_2 = arg_4_2 and arg_4_2 / 1000

		local var_4_0 = FightModel.instance:getMagicCircleInfo()
		local var_4_1 = arg_4_0._config.posArr
		local var_4_2 = {
			x = var_4_1[1],
			y = var_4_1[2],
			z = var_4_1[3]
		}
		local var_4_3 = FightHelper.getMagicSide(var_4_0.createUid)
		local var_4_4 = arg_4_0._entity.effect:addGlobalEffect(arg_4_1, var_4_3, arg_4_2)

		var_4_4:setLocalPos(var_4_3 == FightEnum.EntitySide.MySide and var_4_2.x or -var_4_2.x, var_4_2.y, var_4_2.z)

		if not arg_4_2 then
			arg_4_0._effectDic[var_4_4.uniqueId] = var_4_4
		end

		return var_4_4
	end
end

function var_0_0._onBeforeEnterStepBehaviour(arg_5_0)
	local var_5_0 = FightModel.instance:getMagicCircleInfo()

	if var_5_0.magicCircleId then
		arg_5_0:_onAddMagicCircile(var_5_0.magicCircleId)
	end
end

function var_0_0._getConfig(arg_6_0, arg_6_1)
	local var_6_0 = FightModel.instance:getMagicCircleInfo()
	local var_6_1 = FightDataHelper.entityMgr:getById(var_6_0.createUid)
	local var_6_2 = var_6_1 and var_6_1.skin

	return lua_fight_skin_replace_magic_effect.configDict[arg_6_1] and lua_fight_skin_replace_magic_effect.configDict[arg_6_1][var_6_2] or lua_magic_circle.configDict[arg_6_1]
end

function var_0_0._onAddMagicCircile(arg_7_0, arg_7_1)
	arg_7_0:clearLastLoopEffect()

	arg_7_0._config = arg_7_0:_getConfig(arg_7_1)

	arg_7_0:createEffect(arg_7_0._config.enterEffect, arg_7_0._config.enterTime)

	arg_7_0._loopEffect = arg_7_0:createEffect(arg_7_0._config.loopEffect, nil)

	arg_7_0:_playAudio(arg_7_0._config.enterAudio)
end

function var_0_0.clearLastLoopEffect(arg_8_0)
	if arg_8_0._loopEffect then
		arg_8_0:_releaseEffect(arg_8_0._loopEffect)

		arg_8_0._loopEffect = nil
	end

	if arg_8_0._removeEffectWrap then
		arg_8_0:_releaseEffect(arg_8_0._removeEffectWrap)

		arg_8_0._removeEffectWrap = nil
	end

	TaskDispatcher.cancelTask(arg_8_0._releaseLoopAfterCloseAni, arg_8_0)
	FightController.instance:unregisterCallback(FightEvent.EntityEffectLoaded, arg_8_0._onRemoveEffectLoaded, arg_8_0)
end

function var_0_0._playAudio(arg_9_0, arg_9_1)
	if arg_9_1 ~= 0 then
		AudioMgr.instance:trigger(arg_9_1)
	end
end

function var_0_0._onDeleteMagicCircile(arg_10_0, arg_10_1)
	arg_10_0._config = arg_10_0:_getConfig(arg_10_1)

	if not string.nilorempty(arg_10_0._config.closeAniName) then
		if arg_10_0._loopEffect and arg_10_0._loopEffect.effectGO then
			local var_10_0 = gohelper.onceAddComponent(arg_10_0._loopEffect.effectGO, typeof(UnityEngine.Animator))

			if var_10_0 then
				var_10_0:Play(arg_10_0._config.closeAniName)
			end

			TaskDispatcher.runDelay(arg_10_0._releaseLoopAfterCloseAni, arg_10_0, arg_10_0._config.closeTime / 1000)
		else
			arg_10_0:_releaseLoopEffect()
		end
	else
		arg_10_0._removeEffectWrap = arg_10_0:createEffect(arg_10_0._config.closeEffect, arg_10_0._config.closeTime)

		if arg_10_0._removeEffectWrap then
			if arg_10_0._removeEffectWrap.effectGO then
				arg_10_0:_releaseLoopEffect()
			else
				FightController.instance:registerCallback(FightEvent.EntityEffectLoaded, arg_10_0._onRemoveEffectLoaded, arg_10_0)
			end
		else
			arg_10_0:_releaseLoopEffect()
		end
	end

	arg_10_0:_playAudio(arg_10_0._config.closeAudio)
end

function var_0_0._releaseLoopAfterCloseAni(arg_11_0)
	arg_11_0:_releaseLoopEffect()
end

function var_0_0._releaseLoopEffect(arg_12_0)
	if arg_12_0._loopEffect then
		arg_12_0:_releaseEffect(arg_12_0._loopEffect)

		arg_12_0._loopEffect = nil
	end
end

function var_0_0._onRemoveEffectLoaded(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0._removeEffectWrap == arg_13_2 then
		FightController.instance:unregisterCallback(FightEvent.EntityEffectLoaded, arg_13_0._onRemoveEffectLoaded, arg_13_0)
		arg_13_0:_releaseLoopEffect()
	end
end

function var_0_0._onOpenView(arg_14_0, arg_14_1)
	if arg_14_1 == ViewName.FightFocusView and arg_14_0._loopEffect then
		arg_14_0._loopEffect:setActive(false, "FightSceneMagicCircleComp_FightFocusView")
	end
end

function var_0_0._onCloseViewFinish(arg_15_0, arg_15_1)
	if arg_15_1 == ViewName.FightFocusView and arg_15_0._loopEffect then
		arg_15_0._loopEffect:setActive(true, "FightSceneMagicCircleComp_FightFocusView")
	end
end

function var_0_0._onSkillPlayStart(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_1:getMO() and FightCardDataHelper.isBigSkill(arg_16_2) and arg_16_0._loopEffect then
		arg_16_0._loopEffect:setActive(false, "FightSceneMagicCircleComp_onSkillPlayStart" .. arg_16_3.stepUid)
	end
end

function var_0_0._onSkillPlayFinish(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_1:getMO() and FightCardDataHelper.isBigSkill(arg_17_2) and arg_17_0._loopEffect then
		arg_17_0._loopEffect:setActive(true, "FightSceneMagicCircleComp_onSkillPlayStart" .. arg_17_3.stepUid)
	end
end

function var_0_0._onChangeSceneVisible(arg_18_0, arg_18_1)
	return
end

function var_0_0._onUpdateMagicCircile(arg_19_0, arg_19_1)
	return
end

function var_0_0._onUpgradeMagicCircile(arg_20_0, arg_20_1)
	arg_20_0:clearLastLoopEffect()

	arg_20_0._config = arg_20_0:_getConfig(arg_20_1.magicCircleId)

	arg_20_0:createEffect(arg_20_0._config.enterEffect, arg_20_0._config.enterTime)

	arg_20_0._loopEffect = arg_20_0:createEffect(arg_20_0._config.loopEffect, nil)

	arg_20_0:_playAudio(arg_20_0._config.enterAudio)
end

function var_0_0._onRestartStageBefore(arg_21_0)
	arg_21_0:releaseAllEffect()
end

function var_0_0._releaseEffect(arg_22_0, arg_22_1)
	arg_22_0._effectDic[arg_22_1.uniqueId] = nil

	if arg_22_0._entity then
		arg_22_0._entity.effect:removeEffect(arg_22_1)
	end
end

function var_0_0.releaseAllEffect(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0._effectDic) do
		arg_23_0:_releaseEffect(iter_23_1)
	end

	arg_23_0._effectDic = {}
	arg_23_0._loopEffect = nil
end

function var_0_0._onStartFightEnd(arg_24_0)
	arg_24_0:releaseAllEffect()
end

function var_0_0.onSceneClose(arg_25_0, arg_25_1, arg_25_2)
	TaskDispatcher.cancelTask(arg_25_0._releaseLoopAfterCloseAni, arg_25_0)
	FightController.instance:unregisterCallback(FightEvent.EntityEffectLoaded, arg_25_0._onRemoveEffectLoaded, arg_25_0)
	FightController.instance:unregisterCallback(FightEvent.AddMagicCircile, arg_25_0._onAddMagicCircile, arg_25_0)
	FightController.instance:unregisterCallback(FightEvent.DeleteMagicCircile, arg_25_0._onDeleteMagicCircile, arg_25_0)
	FightController.instance:unregisterCallback(FightEvent.UpdateMagicCircile, arg_25_0._onUpdateMagicCircile, arg_25_0)
	FightController.instance:unregisterCallback(FightEvent.UpgradeMagicCircile, arg_25_0._onUpgradeMagicCircile, arg_25_0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, arg_25_0._onRestartStageBefore, arg_25_0)
	FightController.instance:unregisterCallback(FightEvent.ChangeSceneVisible, arg_25_0._onChangeSceneVisible, arg_25_0)
	FightController.instance:unregisterCallback(FightEvent.BeforeEnterStepBehaviour, arg_25_0._onBeforeEnterStepBehaviour, arg_25_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, arg_25_0._onSkillPlayStart, arg_25_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_25_0._onSkillPlayFinish, arg_25_0)
	FightController.instance:unregisterCallback(FightEvent.StartFightEnd, arg_25_0._onStartFightEnd, arg_25_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_25_0._onOpenView, arg_25_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_25_0._onCloseViewFinish, arg_25_0)
	arg_25_0:releaseAllEffect()

	arg_25_0._entity = nil
end

return var_0_0
