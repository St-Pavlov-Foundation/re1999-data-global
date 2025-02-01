module("modules.logic.gm.view.GMAudioBankView", package.seeall)

slot0 = class("GMAudioBankView", BaseView)
slot1 = {
	hide = 3,
	tweening = 2,
	show = 1
}

function slot0.onInitView(slot0)
	slot0._rect = gohelper.findChild(slot0.viewGO, "view").transform
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/btnClose")
	slot0._btnShow = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/btnShow")
	slot0._btnHide = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/btnHide")
	slot0._btnSearch = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/title/btnSearch")
	slot0._inputSearch = gohelper.findChildTextMeshInputField(slot0.viewGO, "view/title/InputField")

	GMAudioBankViewModel.instance:setList({})
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
	slot0._btnShow:AddClickListener(slot0._onClickShow, slot0)
	slot0._btnHide:AddClickListener(slot0._onClickHide, slot0)
	slot0._btnSearch:AddClickListener(slot0._onClickSearch, slot0)
end

function slot0._onClickShow(slot0)
	if slot0._state == uv0.hide then
		slot0._state = uv0.tweening
		slot0._tweenId = ZProj.TweenHelper.DOAnchorPosX(slot0._rect, 0, 0.2, slot0._onShow, slot0)
	end
end

function slot0._onShow(slot0)
	slot0._tweenId = nil
	slot0._state = uv0.show

	slot0:_updateBtns()
end

function slot0._onClickHide(slot0)
	if slot0._state == uv0.show then
		slot0._state = uv0.tweening
		slot0._tweenId = ZProj.TweenHelper.DOAnchorPosX(slot0._rect, -800, 0.2, slot0._onHide, slot0)
	end
end

function slot0._onHide(slot0)
	slot0._tweenId = nil
	slot0._state = uv0.hide

	slot0:_updateBtns()
end

function slot0._updateBtns(slot0)
	gohelper.setActive(slot0._btnShow.gameObject, slot0._state == uv0.hide)
	gohelper.setActive(slot0._btnHide.gameObject, slot0._state == uv0.show)
end

function slot0._onClickSearch(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(AudioConfig.instance._allAudio) do
		if slot7.bankName == slot0._inputSearch:GetText() then
			table.insert(slot2, slot7)
		end
	end

	GMAudioBankViewModel.instance:setList(slot2)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._btnShow:RemoveClickListener()
	slot0._btnHide:RemoveClickListener()
	slot0._btnSearch:RemoveClickListener()
	slot0._inputSearch:RemoveOnValueChanged()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._state = uv0.show

	slot0:_updateBtns()
end

function slot0.onClose(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

return slot0
