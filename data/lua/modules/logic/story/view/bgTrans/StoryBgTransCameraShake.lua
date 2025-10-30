module("modules.logic.story.view.bgTrans.StoryBgTransCameraShake", package.seeall)

local var_0_0 = class("StoryBgTransCameraShake", StoryBgTransBase)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)
end

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0)

	arg_2_0._transInTime = 0.267
	arg_2_0._transOutTime = 0.267
	arg_2_0._transType = StoryEnum.BgTransType.ShakeCamera
	arg_2_0._transMo = StoryBgEffectTransModel.instance:getStoryBgEffectTransByType(arg_2_0._transType)
	arg_2_0._shakeCameraPrefabPath = ResUrl.getStoryBgEffect(arg_2_0._transMo.prefab)
	arg_2_0._shakeCameraAnimPath = "ui/animations/dynamic/story_avg_shake.controller"
	arg_2_0._shakeCameraMatPath = "ui/materials/dynamic/storybg_edge_stretch.mat"

	table.insert(arg_2_0._resList, arg_2_0._shakeCameraPrefabPath)
	table.insert(arg_2_0._resList, arg_2_0._shakeCameraAnimPath)
	table.insert(arg_2_0._resList, arg_2_0._shakeCameraMatPath)
end

function var_0_0.start(arg_3_0, arg_3_1, arg_3_2)
	var_0_0.super.start(arg_3_0)

	arg_3_0._finishedCallback = arg_3_1
	arg_3_0._finishedCallbackObj = arg_3_2

	arg_3_0:loadRes()
	GameUtil.setActiveUIBlock("bgTrans", true, false)
end

function var_0_0.onLoadFinished(arg_4_0)
	var_0_0.super.onLoadFinished(arg_4_0)
	StoryTool.enablePostProcess(true)

	local var_4_0 = StoryViewMgr.instance:getStoryBackgroundView()

	arg_4_0._rootGo = gohelper.findChild(var_4_0, "#go_upbg/#simage_bgimg")
	arg_4_0._shakeCameraBgGo = gohelper.cloneInPlace(arg_4_0._rootGo, "shakeCameraBg")

	gohelper.destroyAllChildren(arg_4_0._shakeCameraBgGo)
	gohelper.setAsFirstSibling(arg_4_0._shakeCameraBgGo)

	arg_4_0._shakeCameraBgGo:GetComponent(gohelper.Type_Image).material = arg_4_0._loader:getAssetItem(arg_4_0._shakeCameraMatPath):GetResource()

	local var_4_1 = arg_4_0._loader:getAssetItem(arg_4_0._shakeCameraPrefabPath)

	arg_4_0._shakeCameraGo = gohelper.clone(var_4_1:GetResource(), arg_4_0._rootGo)
	arg_4_0._shakeCameraGo.name = "v3a0_dynamicblur_controller"

	gohelper.setActive(arg_4_0._shakeCameraGo, true)

	local var_4_2 = arg_4_0._loader:getAssetItem(arg_4_0._shakeCameraAnimPath):GetResource()

	arg_4_0._shakeCameraAnim = gohelper.onceAddComponent(arg_4_0._rootGo, typeof(UnityEngine.Animator))
	arg_4_0._shakeCameraAnim.runtimeAnimatorController = var_4_2

	arg_4_0._shakeCameraAnim:Play("shake", 0, 0)
	PostProcessingMgr.instance:setUIPPValue("customPassActive", true)
	PostProcessingMgr.instance:setUIPPValue("CustomPassActive", true)
	PostProcessingMgr.instance:setUIPPValue("customPassIndex", 0)
	PostProcessingMgr.instance:setUIPPValue("CustomPassIndex", 0)
	TaskDispatcher.runDelay(arg_4_0.onSwitchBg, arg_4_0, arg_4_0._transInTime)
end

function var_0_0.onSwitchBg(arg_5_0)
	var_0_0.super.onSwitchBg(arg_5_0)
	TaskDispatcher.runDelay(arg_5_0.onTransFinished, arg_5_0, arg_5_0._transOutTime)
end

function var_0_0.onTransFinished(arg_6_0)
	var_0_0.super.onTransFinished(arg_6_0)

	if arg_6_0._finishedCallback then
		arg_6_0._finishedCallback(arg_6_0._finishedCallbackObj)
	end

	arg_6_0:_clearTrans()
end

function var_0_0._clearTrans(arg_7_0)
	GameUtil.setActiveUIBlock("bgTrans", false, false)
	gohelper.removeComponent(arg_7_0._rootGo, typeof(UnityEngine.Animator))
	PostProcessingMgr.instance:setUIPPValue("customPassActive", false)
	PostProcessingMgr.instance:setUIPPValue("CustomPassActive", false)

	if arg_7_0._shakeCameraGo then
		gohelper.destroy(arg_7_0._shakeCameraGo)

		arg_7_0._shakeCameraGo = nil
	end

	if arg_7_0._shakeCameraBgGo then
		gohelper.destroy(arg_7_0._shakeCameraBgGo)

		arg_7_0._shakeCameraBgGo = nil
	end

	arg_7_0._finishedCallback = nil
	arg_7_0._finishedCallbackObj = nil
end

function var_0_0.destroy(arg_8_0)
	var_0_0.super.destroy(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.onSwitchBg, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.onTransFinished, arg_8_0)
	arg_8_0:_clearTrans()
end

return var_0_0
