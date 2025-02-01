module("modules.logic.main.view.MainHeroMipView", package.seeall)

slot0 = class("MainHeroMipView", BaseView)

function slot0.addEvents(slot0)
	slot0:addEventCb(MainController.instance, MainEvent.HeroShowInScene, slot0._onHeroShowInScene, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, slot0._onOpenFullView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullViewFinish, slot0._onCloseFullView, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(MainController.instance, MainEvent.HeroShowInScene, slot0._onHeroShowInScene, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenFullViewFinish, slot0._onOpenFullView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseFullViewFinish, slot0._onCloseFullView, slot0)
end

function slot0.onOpen(slot0)
	slot0._showInScene = true

	slot0:_enableMip(true)
end

function slot0.onClose(slot0)
	slot0:_enableMip(false)
end

function slot0._onHeroShowInScene(slot0, slot1)
	slot0._showInScene = slot1

	slot0:_enableMip(true)
end

function slot0._onOpenFullView(slot0, slot1)
	slot0:_enableMip(false)
end

function slot0._onCloseFullView(slot0, slot1)
	slot2 = false

	for slot7, slot8 in ipairs(ViewMgr.instance:getOpenViewNameList()) do
		if ViewMgr.instance:isFull(slot8) then
			slot2 = true

			break
		end
	end

	if not slot2 then
		slot0:_enableMip(true)
	end
end

function slot0._enableMip(slot0, slot1)
	if slot1 then
		if not slot0._showInScene then
			UnityEngine.Shader.EnableKeyword("_USE_SIMULATE_HIGH_MIP")
		else
			UnityEngine.Shader.DisableKeyword("_USE_SIMULATE_HIGH_MIP")
		end

		if slot0._showInScene then
			UnityEngine.Shader.EnableKeyword("_USE_SIMULATE_MIP")
		else
			UnityEngine.Shader.DisableKeyword("_USE_SIMULATE_MIP")
		end

		logNormal(slot0._showInScene and "开启Mip" or "开启HighMip")
	else
		UnityEngine.Shader.DisableKeyword("_USE_SIMULATE_HIGH_MIP")
		UnityEngine.Shader.DisableKeyword("_USE_SIMULATE_MIP")
		logNormal("关闭所有Mip")
	end
end

return slot0
