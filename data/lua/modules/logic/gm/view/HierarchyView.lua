module("modules.logic.gm.view.HierarchyView", package.seeall)

slot0 = class("HierarchyView", BaseView)
slot1 = 1
slot2 = 2
slot3 = 3

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "go/btnClose")
	slot0._btnShow = gohelper.findChildButtonWithAudio(slot0.viewGO, "go/btnShow")
	slot0._btnHide = gohelper.findChildButtonWithAudio(slot0.viewGO, "go/btnHide")
	slot0._rect = gohelper.findChild(slot0.viewGO, "go").transform
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
	slot0._btnShow:AddClickListener(slot0._onClickShow, slot0)
	slot0._btnHide:AddClickListener(slot0._onClickHide, slot0)
	slot0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, slot0._onTouch, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._btnShow:RemoveClickListener()
	slot0._btnHide:RemoveClickListener()
	slot0:removeEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, slot0._onTouch, slot0)
end

function slot0.onOpen(slot0)
	slot0._state = uv0

	slot0:_updateBtns()
end

function slot0.onClose(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0._onTouch(slot0)
	gohelper.setLayer(slot0.viewGO, UnityLayer.UITop, true)
end

function slot0._onClickShow(slot0)
	if slot0._state == uv0 then
		slot0._state = uv1
		slot0._tweenId = ZProj.TweenHelper.DOAnchorPosX(slot0._rect, 0, 0.2, slot0._onShow, slot0)
	end
end

function slot0._onShow(slot0)
	slot0._tweenId = nil
	slot0._state = uv0

	slot0:_updateBtns()
end

function slot0._onClickHide(slot0)
	if slot0._state == uv0 then
		slot0._state = uv1
		slot0._tweenId = ZProj.TweenHelper.DOAnchorPosX(slot0._rect, 800, 0.2, slot0._onHide, slot0)
	end
end

function slot0._onHide(slot0)
	slot0._tweenId = nil
	slot0._state = uv0

	slot0:_updateBtns()
end

function slot0._updateBtns(slot0)
	gohelper.setActive(slot0._btnShow.gameObject, slot0._state == uv0)
	gohelper.setActive(slot0._btnHide.gameObject, slot0._state == uv1)
end

return slot0
