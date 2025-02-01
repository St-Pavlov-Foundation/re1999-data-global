module("modules.logic.rouge.dlc.101.view.RougeMainView_1_101", package.seeall)

slot0 = class("RougeMainView_1_101", BaseViewExtended)
slot0.AssetUrl = "ui/viewres/rouge/dlc/101/rougelimiteritem.prefab"
slot0.ParentObjPath = "Right/#go_dlc/#go_dlc_101/go_limiterroot/go_pos"

function slot0.onInitView(slot0)
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0:getParentView().viewGO, "Right/#go_dlc/#go_dlc_101/go_limiterroot/btn_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

slot1 = 61

function slot0.createAndInitDLCRes(slot0)
	slot0._buffEntry = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewGO, RougeLimiterBuffEntry)

	slot0._buffEntry:refreshUI(true)
	slot0._buffEntry:setDifficultyTxtFontSize(uv0)
	slot0._buffEntry:setInteractable(false)
	AudioMgr.instance:trigger(AudioEnum.UI.ShowRougeLimiter)
end

function slot0._btnclickOnClick(slot0)
	if RougeModel.instance:inRouge() then
		GameFacade.showToast(ToastEnum.CantUpdateVersion)

		return
	end

	RougeDLCController101.instance:openRougeLimiterView()
end

function slot0.onOpen(slot0)
	slot0:createAndInitDLCRes()
end

return slot0
