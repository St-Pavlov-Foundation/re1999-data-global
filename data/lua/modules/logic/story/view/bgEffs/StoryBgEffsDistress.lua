module("modules.logic.story.view.bgEffs.StoryBgEffsDistress", package.seeall)

local var_0_0 = class("StoryBgEffsDistress", StoryBgEffsBase)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)

	arg_2_0._distressPrefabPath = "ui/viewres/story/bg/storybg_vignette.prefab"

	table.insert(arg_2_0._resList, arg_2_0._distressPrefabPath)

	arg_2_0._effLoaded = false
end

function var_0_0.start(arg_3_0, arg_3_1, arg_3_2)
	var_0_0.super.start(arg_3_0)

	arg_3_0._finishedCallback = arg_3_1
	arg_3_0._finishedCallbackObj = arg_3_2

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:loadRes()
end

function var_0_0._onOpenView(arg_4_0, arg_4_1)
	local var_4_0 = ViewMgr.instance:getSetting(arg_4_1)

	if var_4_0.layer == UILayerName.Message or var_4_0.layer == UILayerName.IDCanvasPopUp then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
	end
end

function var_0_0._onCloseView(arg_5_0, arg_5_1)
	local var_5_0 = ViewMgr.instance:getSetting(arg_5_1)

	if var_5_0.layer == UILayerName.Message or var_5_0.layer == UILayerName.IDCanvasPopUp then
		StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)
	end
end

local var_0_1 = {
	0,
	0.6,
	0.8,
	1
}

function var_0_0.onLoadFinished(arg_6_0)
	var_0_0.super.onLoadFinished(arg_6_0)

	arg_6_0._effLoaded = true

	StoryTool.enablePostProcess(true)

	local var_6_0 = StoryViewMgr.instance:getStoryFrontView()
	local var_6_1 = arg_6_0._loader:getAssetItem(arg_6_0._distressPrefabPath)

	arg_6_0._distressGo = gohelper.clone(var_6_1:GetResource(), var_6_0)

	gohelper.setAsFirstSibling(arg_6_0._distressGo)

	arg_6_0._img = arg_6_0._distressGo:GetComponent(gohelper.Type_Image)

	local var_6_2 = StoryViewMgr.instance:getStoryBlitEffSecond()

	arg_6_0:_setDistressUpdate(0)
	arg_6_0._img.material:SetTexture("_MainTex", var_6_2.capturedTexture)
	arg_6_0:_killTween()

	if arg_6_0._bgCo.effDegree < 1 then
		return
	end

	local var_6_3 = var_0_1[arg_6_0._bgCo.effDegree + 1]
	local var_6_4 = arg_6_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	arg_6_0._distressTweenId = ZProj.TweenHelper.DOTweenFloat(0, var_6_3, var_6_4, arg_6_0._setDistressUpdate, arg_6_0._onBgEffDistressFinished, arg_6_0)
end

function var_0_0.reset(arg_7_0, arg_7_1)
	var_0_0.super.reset(arg_7_0, arg_7_1)
	arg_7_0:_killTween()

	if not arg_7_0._effLoaded then
		return
	end

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UITop)

	local var_7_0 = arg_7_0._img.material:GetFloat("_TotalFator")
	local var_7_1 = var_0_1[arg_7_1.effDegree + 1]
	local var_7_2 = arg_7_0._bgCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	arg_7_0._distressTweenId = ZProj.TweenHelper.DOTweenFloat(var_7_0, var_7_1, var_7_2, arg_7_0._setDistressUpdate, arg_7_0._onBgEffDistressFinished, arg_7_0)
end

function var_0_0._setDistressUpdate(arg_8_0, arg_8_1)
	if not arg_8_0._img or not arg_8_0._img.material then
		return
	end

	arg_8_0._img.material:SetFloat("_TotalFator", arg_8_1)
end

function var_0_0._onBgEffDistressFinished(arg_9_0)
	arg_9_0:_killTween()

	if arg_9_0._img.material:GetFloat("_TotalFator") <= 0.05 and arg_9_0._finishedCallback then
		arg_9_0._finishedCallback(arg_9_0._finishedCallbackObj)

		arg_9_0._finishedCallback = nil
		arg_9_0._finishedCallbackObj = nil
	end
end

function var_0_0._killTween(arg_10_0)
	if arg_10_0._distressTweenId then
		ZProj.TweenHelper.KillById(arg_10_0._distressTweenId)

		arg_10_0._distressTweenId = nil
	end
end

function var_0_0.destroy(arg_11_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_11_0._onOpenView, arg_11_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_11_0._onCloseView, arg_11_0)
	var_0_0.super.destroy(arg_11_0)

	if arg_11_0._distressGo then
		gohelper.destroy(arg_11_0._distressGo)

		arg_11_0._distressGo = nil
	end

	StoryViewMgr.instance:setStoryViewLayer(UnityLayer.UISecond)
	arg_11_0:_setDistressUpdate(0)
	arg_11_0:_killTween()

	arg_11_0._finishedCallback = nil
	arg_11_0._finishedCallbackObj = nil
end

return var_0_0
