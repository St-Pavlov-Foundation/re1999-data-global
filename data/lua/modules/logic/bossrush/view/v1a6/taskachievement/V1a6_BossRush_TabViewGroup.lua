module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_TabViewGroup", package.seeall)

slot0 = class("V1a6_BossRush_TabViewGroup", TabViewGroup)

function slot0._openTabView(slot0, slot1)
	if slot0.__tabId == slot1 then
		return
	end

	slot0.__tabId = slot1

	uv0.super._openTabView(slot0, slot1)
end

function slot0._setVisible(slot0, slot1, slot2)
	if not slot0._tabCanvasGroup[slot1] then
		slot0._tabCanvasGroup[slot1] = gohelper.onceAddComponent(slot0._tabViews[slot1].viewGO, typeof(UnityEngine.CanvasGroup))
	end

	slot3.interactable = slot2
	slot3.blocksRaycasts = slot2
end

return slot0
