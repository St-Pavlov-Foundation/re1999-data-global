module("modules.logic.survival.view.shelter.SurvivalMainView", package.seeall)

local var_0_0 = class("SurvivalMainView", SurvivalMapDragBaseView)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0.igoreViewList = {
		ViewName.SurvivalToastView,
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor,
		ViewName.GMGuideStatusView
	}
	arg_1_0.BossInvasionContainer = gohelper.findChild(arg_1_0.viewGO, "go_normalroot/Right/BossInvasionContainer")

	local var_1_0 = arg_1_0.viewContainer:getSetting().otherRes.survivalbossinvasionview
	local var_1_1 = arg_1_0:getResInst(var_1_0, arg_1_0.BossInvasionContainer)

	arg_1_0.survivalBossInvasionView = MonoHelper.addNoUpdateLuaComOnceToGo(var_1_1, SurvivalBossInvasionView, 1)
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.CameraFollowerTarget, arg_2_0._onCameraFollowerTarget, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.CameraFollowerTarget, arg_3_0._onCameraFollowerTarget, arg_3_0)
end

function var_0_0.calcSceneBoard(arg_4_0)
	local var_4_0 = SurvivalMapHelper.instance:getSceneCameraComp()

	arg_4_0._mapMinX = var_4_0.mapMinX
	arg_4_0._mapMaxX = var_4_0.mapMaxX
	arg_4_0._mapMinY = var_4_0.mapMinY
	arg_4_0._mapMaxY = var_4_0.mapMaxY
	arg_4_0._maxDis = var_4_0.maxDis
	arg_4_0._minDis = var_4_0.minDis
	arg_4_0._mapMaxPitch = 60
	arg_4_0._mapMinPitch = 45
	arg_4_0._mapYaw = 0

	arg_4_0:_setScale(0, true)

	local var_4_1 = SurvivalShelterModel.instance:getPlayerMo()
	local var_4_2 = var_4_1 and var_4_1:getPos()
	local var_4_3, var_4_4, var_4_5 = SurvivalHelper.instance:hexPointToWorldPoint(var_4_2 and var_4_2.q or 0, var_4_2 and var_4_2.r or 0)
	local var_4_6 = Vector3(var_4_3, var_4_4, var_4_5)

	arg_4_0:setScenePosSafety(var_4_6)
end

function var_0_0._onDrag(arg_5_0, ...)
	if not ViewHelper.instance:checkViewOnTheTop(arg_5_0.viewName) then
		return
	end

	var_0_0.super._onDrag(arg_5_0, ...)
end

function var_0_0.onClickScene(arg_6_0, arg_6_1, arg_6_2)
	if not ViewHelper.instance:checkViewOnTheTop(arg_6_0.viewName, arg_6_0.igoreViewList) then
		return
	end

	arg_6_0.viewContainer:dispatchEvent(SurvivalEvent.OnClickShelterScene)

	local var_6_0 = SurvivalMapHelper.instance:getScene()

	if not var_6_0 then
		return
	end

	if not var_6_0.block:isClickBlock(arg_6_2) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_qiutu_general_click)

	if SurvivalMapHelper.instance:getSurvivalBubbleComp():isPlayerBubbleIntercept() then
		return
	end

	if var_6_0.unit:checkClickUnit(arg_6_2) then
		return
	end

	var_6_0.unit:getPlayer():moveToByPos(arg_6_2)
end

function var_0_0._setScale(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_2 and not ViewHelper.instance:checkViewOnTheTop(arg_7_0.viewName) then
		return
	end

	arg_7_1 = Mathf.Clamp(arg_7_1, 0, 1)

	if arg_7_1 == arg_7_0._scale then
		return
	end

	arg_7_0._lastScale = arg_7_0._scale
	arg_7_0._scale = arg_7_1

	SurvivalMapHelper.instance:setDistance(arg_7_0._maxDis - (arg_7_0._maxDis - arg_7_0._minDis) * arg_7_0._scale)
	SurvivalMapHelper.instance:setRotate(arg_7_0._mapYaw, arg_7_0._mapMinPitch + (arg_7_0._mapMaxPitch - arg_7_0._mapMinPitch) * arg_7_0._scale)
	arg_7_0:onSceneScaleChange()
end

function var_0_0.setScenePosSafety(arg_8_0, arg_8_1)
	var_0_0.super.setScenePosSafety(arg_8_0, arg_8_1)

	local var_8_0 = SurvivalMapHelper.instance:getSceneFogComp()

	if not var_8_0 then
		return
	end

	var_8_0:updateCenterPos(arg_8_1)
	var_8_0:updateTexture()
end

function var_0_0.onSceneScaleChange(arg_9_0)
	SurvivalMapHelper.instance:getSceneFogComp():updateTexture()
end

function var_0_0._onCameraFollowerTarget(arg_10_0, arg_10_1)
	arg_10_0:setFollower(arg_10_1)
end

return var_0_0
