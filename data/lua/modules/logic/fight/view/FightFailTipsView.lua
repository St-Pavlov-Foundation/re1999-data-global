module("modules.logic.fight.view.FightFailTipsView", package.seeall)

slot0 = class("FightFailTipsView", BaseView)
slot1 = "m_s63_zjmzd/m_s63_zjmzd"

function slot0.onInitView(slot0)
	slot0._simagetipbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_tipbg")
	slot0._simagetipbg1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_outofround/ani/#simage_tipbg")
	slot0._simagetipbg2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_fail/#simage_tipbg")
	slot0._gooutofround = gohelper.findChild(slot0.viewGO, "#go_outofround")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_fail")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Summon.Play_UI_CallFor_Open)
	slot0._simagetipbg:LoadImage(ResUrl.getFightQuitResultIcon("zhandou_icon_di"))
	slot0._simagetipbg1:LoadImage(ResUrl.getFightQuitResultIcon("zhandou_icon_di"))
	slot0._simagetipbg2:LoadImage(ResUrl.getFightQuitResultIcon("zhandou_icon_di"))
	gohelper.setActive(slot0._gofail, slot0.viewParam.fight_result ~= FightEnum.FightResult.OutOfRoundFail)
	gohelper.setActive(slot0._gooutofround, slot1 == FightEnum.FightResult.OutOfRoundFail)
	TaskDispatcher.runDelay(slot0._waitForFailAnimFinish, slot0, 2)
end

function slot0._waitForFailAnimFinish(slot0)
	FightController.instance:GuideFlowPauseAndContinue("OnGuideFightEndPause_sp", FightEvent.OnGuideFightEndPause_sp, FightEvent.OnGuideFightEndContinue_sp, slot0._onGuideContinue, slot0)
end

function slot0._onGuideContinue(slot0)
	if slot0.viewParam.show_scene_dissolve_effect then
		if GameSceneMgr.instance:getCurScene().level._sceneId and slot1 == 11501 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_effects_fight_backtime)
			slot0:_showDissolveEffect()
		else
			slot0:_restartSpAndCloseView()
		end
	else
		slot0:closeThis()
	end
end

function slot0._restartSpAndCloseView(slot0)
	slot0:_requestRestart()
	slot0:closeThis()
end

function slot0._showDissolveEffect(slot0)
	if GameSceneMgr.instance:useDefaultScene() then
		slot0:_removeEntity()
		slot0:_requestRestart()
		slot0:_onFinish()

		return
	end

	gohelper.setActive(slot0.viewGO, false)

	slot0._loader = MultiAbLoader.New()

	slot0._loader:addPath(FightHelper.getCameraAniPath(uv0))
	slot0._loader:startLoad(slot0._onLoaded, slot0)
	TaskDispatcher.runDelay(slot0.closeThis, slot0, 10)
end

function slot0._onLoaded(slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0, 10)
	UnityEngine.Shader.EnableKeyword("_USEPOP_ON")

	slot0.scene_animation = GameSceneMgr.instance:getCurScene().level:getSceneGo().transform:GetComponent(typeof(UnityEngine.Animation))

	slot0.scene_animation:Play("m_s63_ani")

	slot0._animComp = CameraMgr.instance:getCameraRootAnimator()
	slot0._animComp.enabled = true
	slot0._animComp.runtimeAnimatorController = nil
	slot0._animComp.runtimeAnimatorController = slot0._loader:getFirstAssetItem():GetResource(ResUrl.getCameraAnim(uv0))
	slot0._animComp.speed = FightModel.instance:getSpeed()

	slot0._animComp:Play("popcam")

	slot2 = slot0.scene_animation.clip.length

	TaskDispatcher.runDelay(slot0._onFinish, slot0, slot2)
	TaskDispatcher.runDelay(slot0._removeEntity, slot0, slot2 - 2.5)
	TaskDispatcher.runDelay(slot0._requestRestart, slot0, slot2 - 1.5)
end

function slot0._requestRestart(slot0)
	FightController.instance:dispatchEvent(FightEvent.OnEndFightForGuide)
	FightSystem.instance:dispose()
	DungeonFightController.instance.restartSpStage()
end

function slot0._removeEntity(slot0)
	GameSceneMgr.instance:getCurScene().entityMgr:removeAllUnits()
end

function slot0._onFinish(slot0)
	UnityEngine.Shader.DisableKeyword("_USEPOP_ON")
	slot0:closeThis()
end

function slot0.onClose(slot0)
	if slot0.viewParam.callback then
		slot0.viewParam.callback()

		slot0.viewParam.callback = nil
	end

	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
	TaskDispatcher.cancelTask(slot0._onFinish, slot0)
	TaskDispatcher.cancelTask(slot0._removeEntity, slot0)
	TaskDispatcher.cancelTask(slot0._requestRestart, slot0)
	TaskDispatcher.cancelTask(slot0._waitForFailAnimFinish, slot0)

	if slot0._loader then
		slot0._loader:dispose()
	end

	UnityEngine.Shader.DisableKeyword("_USEPOP_ON")
end

function slot0.onDestroyView(slot0)
	slot0._simagetipbg:UnLoadImage()
	slot0._simagetipbg1:UnLoadImage()
	slot0._simagetipbg2:UnLoadImage()
end

return slot0
