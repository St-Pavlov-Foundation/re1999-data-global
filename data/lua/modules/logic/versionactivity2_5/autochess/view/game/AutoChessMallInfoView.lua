module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessMallInfoView", package.seeall)

slot0 = class("AutoChessMallInfoView", BaseView)

function slot0.onInitView(slot0)
	slot0._goTopRight = gohelper.findChild(slot0.viewGO, "#go_TopRight")
	slot0._txtCoin = gohelper.findChildText(slot0.viewGO, "#go_TopRight/price/#txt_Coin")
	slot0._goCardRoot = gohelper.findChild(slot0.viewGO, "#go_CardRoot")
	slot0._btnLeft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Left")
	slot0._btnRight = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Right")
	slot0._txtPage = gohelper.findChildText(slot0.viewGO, "#txt_Page")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnLeft:AddClickListener(slot0._btnLeftOnClick, slot0)
	slot0._btnRight:AddClickListener(slot0._btnRightOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnLeft:RemoveClickListener()
	slot0._btnRight:RemoveClickListener()
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._btnLeftOnClick(slot0)
	slot0.curIndex = slot0.curIndex - 1

	slot0:refreshMallUI()
end

function slot0._btnRightOnClick(slot0)
	slot0.curIndex = slot0.curIndex + 1

	slot0:refreshMallUI()
end

function slot0._editableInitView(slot0)
	slot0.card = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(AutoChessEnum.ChessCardPath, slot0._goCardRoot), AutoChessCard, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if not slot0.viewParam then
		return
	end

	slot0._txtCoin.text = AutoChessModel.instance:getChessMo().svrMall.coin

	if slot0.viewParam.mall then
		slot0.mall = slot0.viewParam.mall
		slot0.mallItems = slot0.mall.items
		slot0.itemUId = slot0.viewParam.itemUId

		for slot5, slot6 in ipairs(slot0.mallItems) do
			if slot6.uid == slot0.itemUId then
				slot0.curIndex = slot5
			end
		end

		slot0.maxCnt = #slot0.mallItems

		slot0:refreshMallUI()
	else
		slot0:refreshChessUI()
	end

	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.BuyChessReply, slot0.closeThis, slot0)
	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.BuildReply, slot0.closeThis, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.refreshChessUI(slot0)
	gohelper.setActive(slot0._btnLeft, false)
	gohelper.setActive(slot0._btnRight, false)
	gohelper.setActive(slot0._txtPage, false)
	gohelper.setActive(slot0._goTopRight, slot0.viewParam.chessEntity.teamType == AutoChessEnum.TeamType.Player)
	slot0.card:setData({
		type = AutoChessCard.ShowType.Sell,
		entity = slot1
	})
end

function slot0.refreshMallUI(slot0)
	gohelper.setActive(slot0._btnLeft, slot0.curIndex > 1)
	gohelper.setActive(slot0._btnRight, slot0.curIndex < slot0.maxCnt)

	slot0._txtPage.text = string.format("%d/%d", slot0.curIndex, slot0.maxCnt)

	slot0.card:setData({
		type = AutoChessCard.ShowType.Buy,
		mallId = slot0.mall.mallId,
		data = slot0.mallItems[slot0.curIndex]
	})
end

return slot0
