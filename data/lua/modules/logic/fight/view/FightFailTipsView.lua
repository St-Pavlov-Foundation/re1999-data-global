module("modules.logic.fight.view.FightFailTipsView", package.seeall)

local var_0_0 = class("FightFailTipsView", BaseView)
local var_0_1 = "m_s63_zjmzd/m_s63_zjmzd"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagetipbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_tipbg")
	arg_1_0._simagetipbg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_outofround/ani/#simage_tipbg")
	arg_1_0._simagetipbg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_fail/#simage_tipbg")
	arg_1_0._gooutofround = gohelper.findChild(arg_1_0.viewGO, "#go_outofround")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onOpen(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.Summon.Play_UI_CallFor_Open)
	arg_4_0._simagetipbg:LoadImage(ResUrl.getFightQuitResultIcon("zhandou_icon_di"))
	arg_4_0._simagetipbg1:LoadImage(ResUrl.getFightQuitResultIcon("zhandou_icon_di"))
	arg_4_0._simagetipbg2:LoadImage(ResUrl.getFightQuitResultIcon("zhandou_icon_di"))

	local var_4_0 = arg_4_0.viewParam.fight_result

	gohelper.setActive(arg_4_0._gofail, var_4_0 ~= FightEnum.FightResult.OutOfRoundFail)
	gohelper.setActive(arg_4_0._gooutofround, var_4_0 == FightEnum.FightResult.OutOfRoundFail)
	TaskDispatcher.runDelay(arg_4_0._waitForFailAnimFinish, arg_4_0, 2)
end

function var_0_0._waitForFailAnimFinish(arg_5_0)
	FightController.instance:GuideFlowPauseAndContinue("OnGuideFightEndPause_sp", FightEvent.OnGuideFightEndPause_sp, FightEvent.OnGuideFightEndContinue_sp, arg_5_0._onGuideContinue, arg_5_0)
end

function var_0_0._onGuideContinue(arg_6_0)
	if arg_6_0.viewParam.show_scene_dissolve_effect then
		local var_6_0 = GameSceneMgr.instance:getCurScene().level._sceneId

		if var_6_0 and var_6_0 == 11501 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_effects_fight_backtime)
			arg_6_0:_showDissolveEffect()
		else
			arg_6_0:_restartSpAndCloseView()
		end
	else
		arg_6_0:closeThis()
	end
end

function var_0_0._restartSpAndCloseView(arg_7_0)
	arg_7_0:_requestRestart()
	arg_7_0:closeThis()
end

function var_0_0._showDissolveEffect(arg_8_0)
	if GameSceneMgr.instance:useDefaultScene() then
		arg_8_0:_removeEntity()
		arg_8_0:_requestRestart()
		arg_8_0:_onFinish()

		return
	end

	gohelper.setActive(arg_8_0.viewGO, false)

	arg_8_0._loader = MultiAbLoader.New()

	arg_8_0._loader:addPath(FightHelper.getCameraAniPath(var_0_1))
	arg_8_0._loader:startLoad(arg_8_0._onLoaded, arg_8_0)
	TaskDispatcher.runDelay(arg_8_0.closeThis, arg_8_0, 10)
end

function var_0_0._onLoaded(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.closeThis, arg_9_0, 10)
	UnityEngine.Shader.EnableKeyword("_USEPOP_ON")

	arg_9_0.scene_animation = GameSceneMgr.instance:getCurScene().level:getSceneGo().transform:GetComponent(typeof(UnityEngine.Animation))

	arg_9_0.scene_animation:Play("m_s63_ani")

	local var_9_0 = arg_9_0._loader:getFirstAssetItem():GetResource(ResUrl.getCameraAnim(var_0_1))

	arg_9_0._animComp = CameraMgr.instance:getCameraRootAnimator()
	arg_9_0._animComp.enabled = true
	arg_9_0._animComp.runtimeAnimatorController = nil
	arg_9_0._animComp.runtimeAnimatorController = var_9_0
	arg_9_0._animComp.speed = FightModel.instance:getSpeed()

	arg_9_0._animComp:Play("popcam")

	local var_9_1 = arg_9_0.scene_animation.clip.length

	TaskDispatcher.runDelay(arg_9_0._onFinish, arg_9_0, var_9_1)
	TaskDispatcher.runDelay(arg_9_0._removeEntity, arg_9_0, var_9_1 - 2.5)
	TaskDispatcher.runDelay(arg_9_0._requestRestart, arg_9_0, var_9_1 - 1.5)
end

function var_0_0._requestRestart(arg_10_0)
	FightController.instance:dispatchEvent(FightEvent.OnEndFightForGuide)
	FightSystem.instance:dispose()
	DungeonFightController.instance.restartSpStage()
end

function var_0_0._removeEntity(arg_11_0)
	GameSceneMgr.instance:getCurScene().entityMgr:removeAllUnits()
end

function var_0_0._onFinish(arg_12_0)
	UnityEngine.Shader.DisableKeyword("_USEPOP_ON")
	arg_12_0:closeThis()
end

function var_0_0.onClose(arg_13_0)
	if arg_13_0.viewParam.callback then
		arg_13_0.viewParam.callback()

		arg_13_0.viewParam.callback = nil
	end

	TaskDispatcher.cancelTask(arg_13_0.closeThis, arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._onFinish, arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._removeEntity, arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._requestRestart, arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._waitForFailAnimFinish, arg_13_0)

	if arg_13_0._loader then
		arg_13_0._loader:dispose()
	end

	UnityEngine.Shader.DisableKeyword("_USEPOP_ON")
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0._simagetipbg:UnLoadImage()
	arg_14_0._simagetipbg1:UnLoadImage()
	arg_14_0._simagetipbg2:UnLoadImage()
end

return var_0_0
