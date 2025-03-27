module("modules.logic.scene.fight.FightScene", package.seeall)

slot0 = class("FightScene", BaseScene)

function slot0._createAllComps(slot0)
	slot0:_addComp("director", FightSceneDirector)
	slot0:_addComp("level", FightSceneLevelComp)
	slot0:_addComp("camera", FightSceneCameraComp)
	slot0:_addComp("bloom", FightSceneBloomComp)
	slot0:_addComp("view", FightSceneViewComp)
	slot0:_addComp("entityMgr", FightSceneEntityMgr)
	slot0:_addComp("previewEntityMgr", FightScenePreviewEntityMgr)
	slot0:_addComp("preloader", FightScenePreloader)
	slot0:_addComp("bgm", FightSceneBgmComp)
	slot0:_addComp("spineMat", FightSceneSpineMat)
	slot0:_addComp("weatherEffect", FightSceneWeatherEffect)
	slot0:_addComp("entityFootRing", FightSceneEntityFootRing)
	slot0:_addComp("SceneCtrl02", FightSceneCtrl02)
	slot0:_addComp("scenectrl", CommonSceneCtrlComp)
	slot0:_addComp("specialIdleMgr", FightSceneSpecialIdleMgr)
	slot0:_addComp("specialEffectMgr", FightSceneSpecialEffectMgr)
	slot0:_addComp("cardCamera", FightSceneCardCameraComp)
	slot0:_addComp("wadingEffect", FightSceneWadingEffect)

	if GameSceneMgr.instance:useDefaultScene() == false then
		slot0:_addComp("triggerSceneAnimator", FightSceneTriggerSceneAnimatorComp)
	end

	slot0:_addComp("magicCircle", FightSceneMagicCircleComp)
	slot0:_addComp("deadEntityMgr", FightSceneDeadEntityMgrComp)
	slot0:_addComp("tempEntityMgr", FightSceneTempEntityMgrComp)
	slot0:_addComp("fightStatus", FightSceneFightStatusComp)

	if isDebugBuild then
		slot0:_addComp("fightLog", FightSceneFightLogComp)
	end

	slot0:_addComp("mgr", FightSceneMgrComp)
	slot0:addLowPhoneMemoryComp()
end

function slot0.addLowPhoneMemoryComp(slot0)
	if not SLFramework.FrameworkSettings.IsIOSPlayer() then
		return
	end

	if UnityEngine.SystemInfo.systemMemorySize / 1024 > 2 then
		return
	end

	logNormal(string.format("add FightSceneLowPhoneMemoryComp, memory : %G", slot1))
	slot0:_addComp("lowPhoneMemoryMgr", FightSceneLowPhoneMemoryComp)
end

function slot0.onClose(slot0)
	slot0.mgr:onSceneClose()
	uv0.super.onClose(slot0)
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

return slot0
