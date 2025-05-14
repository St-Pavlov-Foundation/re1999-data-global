module("modules.logic.scene.fight.FightScene", package.seeall)

local var_0_0 = class("FightScene", BaseScene)

function var_0_0._createAllComps(arg_1_0)
	arg_1_0:_addComp("director", FightSceneDirector)
	arg_1_0:_addComp("level", FightSceneLevelComp)
	arg_1_0:_addComp("camera", FightSceneCameraComp)
	arg_1_0:_addComp("bloom", FightSceneBloomComp)
	arg_1_0:_addComp("view", FightSceneViewComp)
	arg_1_0:_addComp("entityMgr", FightSceneEntityMgr)
	arg_1_0:_addComp("previewEntityMgr", FightScenePreviewEntityMgr)
	arg_1_0:_addComp("preloader", FightScenePreloader)
	arg_1_0:_addComp("bgm", FightSceneBgmComp)
	arg_1_0:_addComp("spineMat", FightSceneSpineMat)
	arg_1_0:_addComp("weatherEffect", FightSceneWeatherEffect)
	arg_1_0:_addComp("entityFootRing", FightSceneEntityFootRing)
	arg_1_0:_addComp("SceneCtrl02", FightSceneCtrl02)
	arg_1_0:_addComp("scenectrl", CommonSceneCtrlComp)
	arg_1_0:_addComp("specialIdleMgr", FightSceneSpecialIdleMgr)
	arg_1_0:_addComp("specialEffectMgr", FightSceneSpecialEffectMgr)
	arg_1_0:_addComp("cardCamera", FightSceneCardCameraComp)
	arg_1_0:_addComp("wadingEffect", FightSceneWadingEffect)

	if GameSceneMgr.instance:useDefaultScene() == false then
		arg_1_0:_addComp("triggerSceneAnimator", FightSceneTriggerSceneAnimatorComp)
	end

	arg_1_0:_addComp("magicCircle", FightSceneMagicCircleComp)
	arg_1_0:_addComp("deadEntityMgr", FightSceneDeadEntityMgrComp)
	arg_1_0:_addComp("tempEntityMgr", FightSceneTempEntityMgrComp)
	arg_1_0:_addComp("fightStatus", FightSceneFightStatusComp)

	if isDebugBuild then
		arg_1_0:_addComp("fightLog", FightSceneFightLogComp)
	end

	arg_1_0:_addComp("mgr", FightSceneMgrComp)
	arg_1_0:addLowPhoneMemoryComp()
end

function var_0_0.addLowPhoneMemoryComp(arg_2_0)
	if not SLFramework.FrameworkSettings.IsIOSPlayer() then
		return
	end

	local var_2_0 = UnityEngine.SystemInfo.systemMemorySize / 1024

	if var_2_0 > 2 then
		return
	end

	logNormal(string.format("add FightSceneLowPhoneMemoryComp, memory : %G", var_2_0))
	arg_2_0:_addComp("lowPhoneMemoryMgr", FightSceneLowPhoneMemoryComp)
end

function var_0_0.onClose(arg_3_0)
	arg_3_0.mgr:onSceneClose()
	var_0_0.super.onClose(arg_3_0)
	FightTLEventPool.dispose()
	FightSkillBehaviorMgr.instance:dispose()
	FightRenderOrderMgr.instance:dispose()
	FightNameMgr.instance:dispose()
	FightFloatMgr.instance:dispose()
	FightAudioMgr.instance:dispose()
	FightVideoMgr.instance:dispose()
	FightSkillMgr.instance:dispose()
	FightResultModel.instance:clear()
	FightCardDissolveEffect.clear()
	ZProj.GameHelper.ClearFloorReflect()
	FightStrUtil.instance:dispose()
end

return var_0_0
