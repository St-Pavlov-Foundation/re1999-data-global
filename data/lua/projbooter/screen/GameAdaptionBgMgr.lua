module("projbooter.screen.GameAdaptionBgMgr", package.seeall)

slot0 = class("GameAdaptionBgMgr")

function slot0.ctor(slot0)
	slot0.standRate = 1.7777777777777777
	slot0.imageRate = 2.4
	slot0.loaded = false
end

function slot0.onAssetResLoaded(slot0, slot1)
	slot0.assetItem = slot1

	slot0.assetItem:Retain()

	slot0.prefab = slot1:GetResource()
end

function slot0.checkNeedLoadAdaptionBg(slot0)
	return UnityEngine.Screen.width / UnityEngine.Screen.height < slot0.standRate
end

function slot0.loadAdaptionBg(slot0)
	if slot0.loaded then
		return
	end

	if not slot0:checkNeedLoadAdaptionBg() then
		return
	end

	slot2 = SLFramework.GameObjectHelper.Clone(slot0.prefab, UnityEngine.GameObject.Find("UIRoot/Adaption"), nil)
	slot0.loaded = true
	slot3 = UnityEngine.GameObject.Find("UIRoot/Adaption")
	slot4 = SLFramework.GameObjectHelper.FindChild(slot3, "Up")
	slot5 = SLFramework.GameObjectHelper.FindChild(slot3, "Bottom")
	slot6 = 1920 / slot0.imageRate

	SLFramework.UGUI.RectTrHelper.SetHeight(slot4.transform, slot6)
	SLFramework.UGUI.RectTrHelper.SetHeight(slot5.transform, slot6)

	slot7 = typeof(UnityEngine.UI.Image)
	slot8 = slot2:GetComponent(slot7)
	slot9 = slot4:GetComponent(slot7)
	slot10 = slot5:GetComponent(slot7)
	slot9.sprite = slot8.sprite
	slot10.sprite = slot8.sprite
	slot9.color = Color.white
	slot10.color = Color.white
	slot11 = slot5.transform

	SLFramework.TransformHelper.SetLocalScale(slot11, 1, 1, 1)

	slot11.pivot = Vector2(0.5, 1)

	UnityEngine.GameObject.Destroy(slot2)
end

function slot0.tryAddEvents(slot0)
	if slot0.loaded then
		return
	end

	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, slot0.onScreenSizeChanged, slot0)
end

function slot0.onScreenSizeChanged(slot0, slot1, slot2)
	slot0:loadAdaptionBg()

	if slot0.loaded then
		GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, slot0.onScreenSizeChanged, slot0)
	end
end

slot0.instance = slot0.New()

return slot0
