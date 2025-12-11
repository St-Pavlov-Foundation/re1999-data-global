module("modules.logic.story.view.bgEffs.StoryBgEffsEagleEye", package.seeall)

local var_0_0 = class("StoryBgEffsEagleEye", StoryBgEffsBase)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)

	arg_2_0._eagleEyePrefabPath = "ui/viewres/story/bg/radial_blur_controller.prefab"

	table.insert(arg_2_0._resList, arg_2_0._eagleEyePrefabPath)

	arg_2_0._effInTime = 0.5
	arg_2_0._effKeepTime = arg_2_1.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
end

function var_0_0.start(arg_3_0, arg_3_1, arg_3_2)
	var_0_0.super.start(arg_3_0)

	arg_3_0._finishedCallback = arg_3_1
	arg_3_0._finishedCallbackObj = arg_3_2

	arg_3_0:_setViewTop(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:loadRes()
end

function var_0_0._onOpenView(arg_4_0, arg_4_1)
	local var_4_0 = ViewMgr.instance:getSetting(arg_4_1)

	if var_4_0.layer == UILayerName.Message or var_4_0.layer == UILayerName.IDCanvasPopUp then
		arg_4_0:_setViewTop(false)
	end
end

function var_0_0._onCloseView(arg_5_0, arg_5_1)
	local var_5_0 = ViewMgr.instance:getSetting(arg_5_1)

	if var_5_0.layer == UILayerName.Message or var_5_0.layer == UILayerName.IDCanvasPopUp then
		arg_5_0:_setViewTop(true)
	end
end

function var_0_0._setViewTop(arg_6_0, arg_6_1)
	if arg_6_1 then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
	else
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
		StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)
	end
end

function var_0_0.onLoadFinished(arg_7_0)
	var_0_0.super.onLoadFinished(arg_7_0)
	StoryTool.enablePostProcess(true)

	local var_7_0 = StoryViewMgr.instance:getStoryBackgroundView()

	arg_7_0._rootGo = gohelper.findChild(var_7_0, "#go_upbg/#simage_bgimg")

	local var_7_1 = arg_7_0._loader:getAssetItem(arg_7_0._eagleEyePrefabPath)

	arg_7_0._eagleEyeGo = gohelper.clone(var_7_1:GetResource(), arg_7_0._rootGo)
	arg_7_0._eagleCtrl = arg_7_0._eagleEyeGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	arg_7_0._eagleCtrl.float_01 = 0.2
	arg_7_0._eagleCtrl.float_02 = 1.5

	local var_7_2 = Vector2(0.5, 0.5)

	PostProcessingMgr.instance:setUIPPValue("rgbSplitCenter", var_7_2)
	PostProcessingMgr.instance:setUIPPValue("RgbSplitCenter", var_7_2)
	arg_7_0:_setBlurLevel(1)

	if arg_7_0._eyeTweenId then
		ZProj.TweenHelper.KillById(arg_7_0._eyeTweenId)

		arg_7_0._eyeTweenId = nil
	end

	arg_7_0._eyeTweenId = ZProj.TweenHelper.DOTweenFloat(1, 10, arg_7_0._effInTime, arg_7_0._setBlurLevel, arg_7_0.onEffInFinished, arg_7_0)
end

function var_0_0._setBlurLevel(arg_8_0, arg_8_1)
	PostProcessingMgr.instance:setUIPPValue("radialBlurLevel", arg_8_1)
	PostProcessingMgr.instance:setUIPPValue("RadialBlurLevel", arg_8_1)
end

function var_0_0.onEffInFinished(arg_9_0)
	arg_9_0:_setBlurLevel(10)

	if arg_9_0._eyeTweenId then
		ZProj.TweenHelper.KillById(arg_9_0._eyeTweenId)

		arg_9_0._eyeTweenId = nil
	end

	TaskDispatcher.runDelay(arg_9_0.onEffKeepFinished, arg_9_0, arg_9_0._effKeepTime)
end

function var_0_0.onEffKeepFinished(arg_10_0)
	if arg_10_0._eyeTweenId then
		ZProj.TweenHelper.KillById(arg_10_0._eyeTweenId)

		arg_10_0._eyeTweenId = nil
	end

	arg_10_0._eyeTweenId = ZProj.TweenHelper.DOTweenFloat(10, 1, arg_10_0._effOutTime, arg_10_0._setBlurLevel, arg_10_0.onEffOutFinished, arg_10_0)
end

function var_0_0.onEffOutFinished(arg_11_0)
	var_0_0.super.onEffOutFinished(arg_11_0)

	if arg_11_0._finishedCallback then
		arg_11_0._finishedCallback(arg_11_0._finishedCallbackObj)

		arg_11_0._finishedCallback = nil
		arg_11_0._finishedCallbackObj = nil
	end
end

function var_0_0._clearEffs(arg_12_0)
	arg_12_0:_setBlurLevel(1)
	arg_12_0:_setViewTop(false)

	if arg_12_0._eagleCtrl then
		arg_12_0._eagleCtrl.float_01 = 0
		arg_12_0._eagleCtrl.float_02 = 0.001
		arg_12_0._eagleCtrl = nil
	end

	if arg_12_0._eagleEyeGo then
		gohelper.destroy(arg_12_0._eagleEyeGo)

		arg_12_0._eagleEyeGo = nil
	end

	arg_12_0._finishedCallback = nil
	arg_12_0._finishedCallbackObj = nil
end

function var_0_0.destroy(arg_13_0)
	var_0_0.super.destroy(arg_13_0)

	if arg_13_0._eyeTweenId then
		ZProj.TweenHelper.KillById(arg_13_0._eyeTweenId)

		arg_13_0._eyeTweenId = nil
	end

	TaskDispatcher.cancelTask(arg_13_0.onEffKeepFinished, arg_13_0)
	arg_13_0:_clearEffs()
end

return var_0_0
