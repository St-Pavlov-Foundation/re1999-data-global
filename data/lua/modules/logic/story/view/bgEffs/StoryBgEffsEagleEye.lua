module("modules.logic.story.view.bgEffs.StoryBgEffsEagleEye", package.seeall)

local var_0_0 = class("StoryBgEffsEagleEye", StoryBgEffsBase)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)

	arg_2_0._effsType = StoryEnum.BgEffectType.EagleEye
	arg_2_0._eagleEyePrefabPath = "ui/viewres/story/bg/radial_blur_controller.prefab"

	table.insert(arg_2_0._resList, arg_2_0._eagleEyePrefabPath)

	arg_2_0._effInTime = 0.5
	arg_2_0._effKeepTime = arg_2_1.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
end

function var_0_0.start(arg_3_0, arg_3_1, arg_3_2)
	var_0_0.super.start(arg_3_0)

	arg_3_0._finishedCallback = arg_3_1
	arg_3_0._finishedCallbackObj = arg_3_2

	arg_3_0:loadRes()
end

function var_0_0.onLoadFinished(arg_4_0)
	var_0_0.super.onLoadFinished(arg_4_0)
	StoryTool.enablePostProcess(true)

	local var_4_0 = StoryViewMgr.instance:getStoryBackgroundView()

	arg_4_0._rootGo = gohelper.findChild(var_4_0, "#go_upbg/#simage_bgimg")

	local var_4_1 = arg_4_0._loader:getAssetItem(arg_4_0._eagleEyePrefabPath)

	arg_4_0._eagleEyeGo = gohelper.clone(var_4_1:GetResource(), arg_4_0._rootGo)
	arg_4_0._eagleCtrl = arg_4_0._eagleEyeGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	arg_4_0._eagleCtrl.float_01 = 0.2
	arg_4_0._eagleCtrl.float_02 = 1.5

	local var_4_2 = Vector2(0.5, 0.5)

	PostProcessingMgr.instance:setUIPPValue("rgbSplitCenter", var_4_2)
	PostProcessingMgr.instance:setUIPPValue("RgbSplitCenter", var_4_2)
	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
	StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UITop)
	arg_4_0:_setBlurLevel(1)

	if arg_4_0._eyeTweenId then
		ZProj.TweenHelper.KillById(arg_4_0._eyeTweenId)

		arg_4_0._eyeTweenId = nil
	end

	arg_4_0._eyeTweenId = ZProj.TweenHelper.DOTweenFloat(1, 10, arg_4_0._effInTime, arg_4_0._setBlurLevel, arg_4_0.onEffInFinished, arg_4_0)
end

function var_0_0._setBlurLevel(arg_5_0, arg_5_1)
	PostProcessingMgr.instance:setUIPPValue("radialBlurLevel", arg_5_1)
	PostProcessingMgr.instance:setUIPPValue("RadialBlurLevel", arg_5_1)
end

function var_0_0.onEffInFinished(arg_6_0)
	arg_6_0:_setBlurLevel(10)

	if arg_6_0._eyeTweenId then
		ZProj.TweenHelper.KillById(arg_6_0._eyeTweenId)

		arg_6_0._eyeTweenId = nil
	end

	TaskDispatcher.runDelay(arg_6_0.onEffKeepFinished, arg_6_0, arg_6_0._effKeepTime)
end

function var_0_0.onEffKeepFinished(arg_7_0)
	if arg_7_0._eyeTweenId then
		ZProj.TweenHelper.KillById(arg_7_0._eyeTweenId)

		arg_7_0._eyeTweenId = nil
	end

	arg_7_0._eyeTweenId = ZProj.TweenHelper.DOTweenFloat(10, 1, arg_7_0._effOutTime, arg_7_0._setBlurLevel, arg_7_0.onEffOutFinished, arg_7_0)
end

function var_0_0.onEffOutFinished(arg_8_0)
	var_0_0.super.onEffOutFinished(arg_8_0)

	if arg_8_0._finishedCallback then
		arg_8_0._finishedCallback(arg_8_0._finishedCallbackObj)
	end
end

function var_0_0._clearEffs(arg_9_0)
	arg_9_0:_setBlurLevel(1)
	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
	StoryViewMgr.instance:setStoryLeadRoleSpineViewLayer(UnityLayer.UIThird)

	if arg_9_0._eagleCtrl then
		arg_9_0._eagleCtrl.float_01 = 0
		arg_9_0._eagleCtrl.float_02 = 0.001
		arg_9_0._eagleCtrl = nil
	end

	if arg_9_0._eagleEyeGo then
		gohelper.destroy(arg_9_0._eagleEyeGo)

		arg_9_0._eagleEyeGo = nil
	end

	arg_9_0._finishedCallback = nil
	arg_9_0._finishedCallbackObj = nil
end

function var_0_0.destroy(arg_10_0)
	var_0_0.super.destroy(arg_10_0)

	if arg_10_0._eyeTweenId then
		ZProj.TweenHelper.KillById(arg_10_0._eyeTweenId)

		arg_10_0._eyeTweenId = nil
	end

	TaskDispatcher.cancelTask(arg_10_0.onEffKeepFinished, arg_10_0)
	arg_10_0:_clearEffs()
end

return var_0_0
