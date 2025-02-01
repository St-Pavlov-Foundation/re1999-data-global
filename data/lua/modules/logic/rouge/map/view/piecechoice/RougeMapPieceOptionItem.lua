module("modules.logic.rouge.map.view.piecechoice.RougeMapPieceOptionItem", package.seeall)

slot0 = class("RougeMapPieceOptionItem", UserDataDispose)

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.tr = slot1:GetComponent(gohelper.Type_RectTransform)

	slot0:_editableInitView()
end

function slot0._editableInitView(slot0)
	slot0._refreshClick = gohelper.findChildClickWithDefaultAudio(slot0.go, "#go_refresh")
	slot0._exitClick = gohelper.findChildClickWithDefaultAudio(slot0.go, "#go_exit")

	slot0._refreshClick:AddClickListener(slot0.onClickRefreshBtn, slot0)
	slot0._exitClick:AddClickListener(slot0.onClickExitBtn, slot0)

	slot0.goNormal = gohelper.findChild(slot0.go, "#go_refresh/normal")
	slot0.goLock = gohelper.findChild(slot0.go, "#go_refresh/locked")
	slot0.txtNormalTime = gohelper.findChildText(slot0.go, "#go_refresh/normal/txt_refresh/#txt_times")
	slot0.txtLockTime = gohelper.findChildText(slot0.go, "#go_refresh/locked/txt_refresh/#txt_times")
	slot0.goRefresh = slot0._refreshClick.gameObject

	slot0:setRefreshActive()
end

function slot0.setRefreshActive(slot0)
	gohelper.setActive(slot0.goRefresh, RougeMapEffectHelper.checkHadEffect(RougeMapEnum.EffectType.UnlockRestRefresh))
end

function slot0.onClickRefreshBtn(slot0)
	if not RougeMapEffectHelper.checkHadEffect(RougeMapEnum.EffectType.UnlockRestRefresh) then
		return
	end

	if slot0.isLock then
		return
	end

	slot0:clearCallback()

	slot0.callbackId = RougeRpc.instance:sendRougeRepairShopRandomRequest(slot0.onReceiveMsg, slot0)
end

function slot0.onReceiveMsg(slot0)
	slot0.callbackId = nil

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onRefreshPieceChoiceEvent)
end

function slot0.onClickExitBtn(slot0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onChoiceViewStatusChange, RougeMapEnum.PieceChoiceViewStatus.Choice)
end

function slot0.update(slot0, slot1, slot2)
	slot0.pieceMo = slot2

	recthelper.setAnchor(slot0.tr, slot1.x, slot1.y)
	slot0:refreshExchangeUI()
end

function slot0.refreshExchangeUI(slot0)
	slot0.isLock = RougeMapConfig.instance:getRestStoreRefreshCount() <= (slot0.pieceMo.triggerStr and slot0.pieceMo.triggerStr.repairRandomNum or 0)

	gohelper.setActive(slot0.goNormal, not slot0.isLock)
	gohelper.setActive(slot0.goLock, slot0.isLock)

	if slot0.isLock then
		slot0.txtLockTime.text = string.format("(<color=#d97373>0</color>/%s)", slot2)
	else
		slot0.txtNormalTime.text = string.format("(%s/%s)", slot2 - slot1, slot2)
	end
end

function slot0.show(slot0)
	gohelper.setActive(slot0.go, true)
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.clearCallback(slot0)
	if slot0.callbackId then
		RougeRpc.instance:removeCallbackById(slot0.callbackId)

		slot0.callbackId = nil
	end
end

function slot0.destroy(slot0)
	slot0:clearCallback()
	slot0._refreshClick:RemoveClickListener()
	slot0._exitClick:RemoveClickListener()
	slot0:__onDispose()
end

return slot0
