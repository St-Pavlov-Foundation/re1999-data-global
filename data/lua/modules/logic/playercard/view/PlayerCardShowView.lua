module("modules.logic.playercard.view.PlayerCardShowView", package.seeall)

slot0 = class("PlayerCardShowView", BaseView)

function slot0.onInitView(slot0)
	slot0.btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0.btnConfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm")
	slot0.txtNum = gohelper.findChildTextMesh(slot0.viewGO, "#go_bottom/#txt_num")
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnClose, slot0.onClickBtnClose, slot0)
	slot0:addClickCb(slot0.btnConfirm, slot0.onClickBtnConfirm, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SelectNumChange, slot0._onNumChange, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClickBtnClose(slot0)
	slot0:closeThis()
end

function slot0.onClickBtnConfirm(slot0)
	PlayerCardProgressModel.instance:confirmData()
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	slot0:_updateParam()
	PlayerCardProgressModel.instance:initSelectData(slot0:getCardInfo())
	slot0:refreshView()
end

function slot0.onUpdateParam(slot0)
	slot0:_updateParam()
	slot0:refreshView()
end

function slot0._updateParam(slot0)
	slot0.userId = PlayerModel.instance:getMyUserId()
end

function slot0.getCardInfo(slot0)
	return PlayerCardModel.instance:getCardInfo(slot0.userId)
end

function slot0.refreshView(slot0)
	PlayerCardProgressModel.instance:refreshList()
	slot0:refreshNum()
end

function slot0._onNumChange(slot0)
	slot0:refreshNum()
end

function slot0.refreshNum(slot0)
	slot0.txtNum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_custompick_selectnum"), {
		PlayerCardProgressModel.instance:getSelectNum(),
		PlayerCardEnum.MaxCardNum
	})
end

function slot0.onClose(slot0)
end

return slot0
