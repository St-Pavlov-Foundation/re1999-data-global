module("modules.logic.rouge.dlc.101.view.RougeResultReView_1_101", package.seeall)

slot0 = class("RougeResultReView_1_101", BaseViewExtended)
slot0.AssetUrl = "ui/viewres/rouge/dlc/101/rougelimiteritem.prefab"
slot0.ParentObjPath = "Left/#go_dlc/#go_dlc_101/#go_limiterroot"
slot0.LimiterDifficultyFontSize = 144

function slot0.onInitView(slot0)
	slot0._golimiteritem = gohelper.findChild(slot0.viewGO, "#go_dlc_101")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	slot0._buffEntry = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewGO, RougeResultReViewLimiterBuff, slot0._reviewInfo and slot0._reviewInfo:getLimiterRiskValue() or 0)

	slot0._buffEntry:setDifficultyTxtFontSize(uv0.LimiterDifficultyFontSize)
	slot0._buffEntry:setDifficultyVisible(false)
	slot0._buffEntry:refreshUI()
	slot0._buffEntry:setInteractable(false)
end

function slot0.onRefreshViewParam(slot0, slot1)
	slot0._reviewInfo = slot1 and slot1.reviewInfo
end

function slot0.onDestroyView(slot0)
end

return slot0
