module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessForcePickView", package.seeall)

slot0 = class("AutoChessForcePickView", BaseView)

function slot0.onInitView(slot0)
	slot0._goView = gohelper.findChild(slot0.viewGO, "#go_View")
	slot0._btnGiveUp = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_View/#btn_GiveUp")
	slot0._btnView = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_View/#btn_View")
	slot0._txtTip = gohelper.findChildText(slot0.viewGO, "#go_View/panelbg/#txt_Tip")
	slot0._txtWarningTip = gohelper.findChildText(slot0.viewGO, "#go_View/panelbg/#txt_WarningTip")
	slot0._goCardRoot = gohelper.findChild(slot0.viewGO, "#go_View/Card/Viewport/#go_CardRoot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnGiveUp:AddClickListener(slot0._btnGiveUpOnClick, slot0)
	slot0._btnView:AddClickListener(slot0._btnViewOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnGiveUp:RemoveClickListener()
	slot0._btnView:RemoveClickListener()
end

function slot0.onClickModalMask(slot0)
end

function slot0._btnGiveUpOnClick(slot0)
	GameFacade.showOptionMessageBox(MessageBoxIdDefine.AutoChessGiveUpForcePick, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, slot0._yesCallback, nil, , slot0)
end

function slot0._yesCallback(slot0)
	AutoChessRpc.instance:sendAutoChessMallRegionSelectItemRequest(AutoChessModel.instance:getCurModuleId(), 0)
	slot0:closeThis()
end

function slot0._btnViewOnClick(slot0)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.ForcePickViewBoard)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.contentSizeFitter = slot0._goCardRoot:GetComponent(gohelper.Type_ContentSizeFitter)
	slot0.layoutGroup = slot0._goCardRoot:GetComponent(gohelper.Type_HorizontalLayoutGroup)
end

function slot0.onOpen(slot0)
	if not slot0.viewParam then
		return
	end

	slot0:addEventCb(AutoChessController.instance, AutoChessEvent.ForcePickReply, slot0.closeThis, slot0)

	slot0.freeMall = slot0.viewParam

	slot0:refreshUI()
	TaskDispatcher.runDelay(slot0.delayDisabled, slot0, 0.1)
end

function slot0.delayDisabled(slot0)
	slot0.contentSizeFitter.enabled = false
	slot0.layoutGroup.enabled = false
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.delayDisabled, slot0)
end

function slot0.refreshUI(slot0)
	slot0._txtTip.text = luaLang("autochess_forcepick_tip")

	if #slot0.freeMall.items ~= 0 then
		slot0._txtWarningTip.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_forcepick_warningtip"), AutoChessConfig.instance:getChessCoByItemId(slot0.freeMall.items[1].id).name)
	end

	for slot6, slot7 in ipairs(slot0.freeMall.selectItems) do
		MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(AutoChessEnum.ChessCardPath, slot0._goCardRoot, "card" .. slot7), AutoChessCard):setData({
			type = AutoChessCard.ShowType.ForcePick,
			itemId = slot7
		})
	end

	gohelper.setActive(slot0._txtTip, slot1 == 0)
	gohelper.setActive(slot0._txtWarningTip, slot1 ~= 0)
end

return slot0
