module("projbooter.screen.GameAdaptionBgMgr", package.seeall)

local var_0_0 = class("GameAdaptionBgMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0.standRate = 1.7777777777777777
	arg_1_0.imageRate = 2.4
	arg_1_0.loaded = false
end

function var_0_0.onAssetResLoaded(arg_2_0, arg_2_1)
	if arg_2_0.assetItem then
		logError("GameAdaptionBgMgr:onAssetResLoaded 已经设置资源 assetItem")

		return
	end

	arg_2_0.assetItem = arg_2_1

	arg_2_0.assetItem:Retain()

	arg_2_0.prefab = arg_2_1:GetResource()
end

function var_0_0.checkNeedLoadAdaptionBg(arg_3_0)
	return UnityEngine.Screen.width / UnityEngine.Screen.height < arg_3_0.standRate
end

function var_0_0.loadAdaptionBg(arg_4_0)
	if arg_4_0.loaded then
		return
	end

	if not arg_4_0:checkNeedLoadAdaptionBg() then
		return
	end

	local var_4_0 = UnityEngine.GameObject.Find("UIRoot/Adaption")
	local var_4_1 = SLFramework.GameObjectHelper.Clone(arg_4_0.prefab, var_4_0, nil)

	arg_4_0.loaded = true

	local var_4_2 = UnityEngine.GameObject.Find("UIRoot/Adaption")
	local var_4_3 = SLFramework.GameObjectHelper.FindChild(var_4_2, "Up")
	local var_4_4 = SLFramework.GameObjectHelper.FindChild(var_4_2, "Bottom")
	local var_4_5 = 1920 / arg_4_0.imageRate

	SLFramework.UGUI.RectTrHelper.SetHeight(var_4_3.transform, var_4_5)
	SLFramework.UGUI.RectTrHelper.SetHeight(var_4_4.transform, var_4_5)

	local var_4_6 = typeof(UnityEngine.UI.Image)
	local var_4_7 = var_4_1:GetComponent(var_4_6)
	local var_4_8 = var_4_3:GetComponent(var_4_6)
	local var_4_9 = var_4_4:GetComponent(var_4_6)

	var_4_8.sprite = var_4_7.sprite
	var_4_9.sprite = var_4_7.sprite
	var_4_8.color = Color.white
	var_4_9.color = Color.white

	local var_4_10 = var_4_4.transform

	SLFramework.TransformHelper.SetLocalScale(var_4_10, 1, 1, 1)

	var_4_10.pivot = Vector2(0.5, 1)

	UnityEngine.GameObject.Destroy(var_4_1)
end

function var_0_0.tryAddEvents(arg_5_0)
	if arg_5_0.loaded then
		return
	end

	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, arg_5_0.onScreenSizeChanged, arg_5_0)
end

function var_0_0.onScreenSizeChanged(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:loadAdaptionBg()

	if arg_6_0.loaded then
		GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, arg_6_0.onScreenSizeChanged, arg_6_0)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
