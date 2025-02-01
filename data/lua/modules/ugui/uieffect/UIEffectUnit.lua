module("modules.ugui.uieffect.UIEffectUnit", package.seeall)

slot0 = class("UIEffectUnit", LuaCompBase)
slot1 = SLFramework.EffectPhotographerPool.Instance

function slot0.Refresh(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if slot0._rawImage == nil then
		slot7 = gohelper.onceAddComponent(slot1, gohelper.Type_RawImage)
		slot7.raycastTarget = false
		slot0._rawImage = slot7
	end

	recthelper.setSize(slot1.transform, slot5 or slot3, slot6 or slot4)

	if slot0._effectPath and slot0._effectPath == slot2 and slot0._width == slot3 and slot0._height == slot4 then
		return
	end

	slot0:_releaseEffect()

	slot0._effectPath = slot2
	slot0._width = slot3
	slot0._height = slot4

	UIEffectManager.instance:_getEffect(slot2, slot3, slot4, slot0._rawImage)
end

function slot0.onDestroy(slot0)
	slot0:_releaseEffect()
end

function slot0._releaseEffect(slot0)
	if slot0._effectPath then
		UIEffectManager.instance:_putEffect(slot0._effectPath, slot0._width, slot0._height)

		slot0._effectPath = nil
	end
end

return slot0
