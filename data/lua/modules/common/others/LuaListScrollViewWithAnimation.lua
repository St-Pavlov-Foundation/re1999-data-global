module("modules.common.others.LuaListScrollViewWithAnimation", package.seeall)

slot0 = class("LuaListScrollViewWithAnimation", LuaListScrollView)

function slot0.ctor(slot0, slot1, slot2, slot3)
	uv0.super.ctor(slot0, slot1, slot2)

	slot0._animationDelayTimes = slot3
	slot0._animationHasPlayed = {}
end

function slot0._onUpdateCell(slot0, slot1, slot2)
	uv0.super._onUpdateCell(slot0, slot1, slot2)

	if not gohelper.findChild(slot1, LuaListScrollView.PrefabInstName) then
		return
	end

	if not (slot0._animationDelayTimes and slot0._animationDelayTimes[MonoHelper.getLuaComFromGo(slot3, slot0._param.cellClass)._index]) then
		return
	end

	if slot0._animationHasPlayed[slot4._index] then
		return
	end

	if slot4.getAnimation then
		slot6, slot7 = slot4:getAnimation()

		if slot6 and not string.nilorempty(slot7) and slot4.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup)) then
			slot8.alpha = 0
		end
	end
end

function slot0.onUpdateFinish(slot0)
	for slot4, slot5 in pairs(slot0._cellCompDict) do
		if slot0._animationDelayTimes and slot0._animationDelayTimes[slot4._index] and not slot0._animationHasPlayed[slot4._index] then
			TaskDispatcher.runDelay(uv0._delayPlayOpenAnimation, slot4, slot6)

			slot0._animationHasPlayed[slot4._index] = true
		end
	end
end

function slot0._delayPlayOpenAnimation(slot0)
	if slot0.getAnimation then
		slot1, slot2 = slot0:getAnimation()

		if slot1 and not string.nilorempty(slot2) then
			slot1:Play(slot2)
		end
	end
end

function slot0.onClose(slot0)
	uv0.super.onClose(slot0)

	for slot4, slot5 in pairs(slot0._cellCompDict) do
		TaskDispatcher.cancelTask(uv0._delayPlayOpenAnimation, slot4)
	end
end

return slot0
