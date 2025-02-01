module("modules.logic.gm.view.GMErrorView", package.seeall)

slot0 = class("GMErrorView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "panel/detail/btns/btnClose")
	slot0._btnClear = gohelper.findChildButtonWithAudio(slot0.viewGO, "panel/detail/btns/btnClear")
	slot0._btnDel = gohelper.findChildButtonWithAudio(slot0.viewGO, "panel/detail/btns/btnDel")
	slot0._btnSend = gohelper.findChildButtonWithAudio(slot0.viewGO, "panel/detail/btns/btnSend")
	slot0._btnHide = gohelper.findChildButtonWithAudio(slot0.viewGO, "panel/detail/btns/btnHide")
	slot0._btnCopy = gohelper.findChildButtonWithAudio(slot0.viewGO, "panel/detail/btns/btnCopy")
	slot0._btnBlock = gohelper.findChildButtonWithAudio(slot0.viewGO, "panel/detail/btns/btnBlock")
	slot0._txtContent = gohelper.findChildText(slot0.viewGO, "panel/detail/scroll/Viewport/content")
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0._onClickClose, slot0)
	slot0._btnClear:AddClickListener(slot0._onClickClear, slot0)
	slot0._btnDel:AddClickListener(slot0._onClitkDel, slot0)
	slot0._btnSend:AddClickListener(slot0._onClickSend, slot0)
	slot0._btnHide:AddClickListener(slot0._onClickHide, slot0)
	slot0._btnCopy:AddClickListener(slot0._onClickCopy, slot0)
	slot0._btnBlock:AddClickListener(slot0._onClickBlock, slot0)
	slot0:addEventCb(GMController.instance, GMEvent.GMLogView_Select, slot0._onSelectMO, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._btnClear:RemoveClickListener()
	slot0._btnDel:RemoveClickListener()
	slot0._btnSend:RemoveClickListener()
	slot0._btnHide:RemoveClickListener()
	slot0._btnCopy:RemoveClickListener()
	slot0._btnBlock:RemoveClickListener()
	slot0:removeEventCb(GMController.instance, GMEvent.GMLogView_Select, slot0._onSelectMO, slot0)
end

function slot0.onOpen(slot0)
	if GMLogModel.instance.errorModel:getCount() > 0 then
		GMLogModel.instance.errorModel:selectCell(1, true)
	end

	slot0:_updateBtns()
end

function slot0._onSelectMO(slot0, slot1)
	if slot1 then
		slot0._selectMO = slot1
		slot0._txtContent.text = string.format("%s %s", os.date("%H:%M:%S", slot1.time), slot1.msg)
	else
		slot0._txtContent.text = ""
	end

	slot0:_updateBtns()
end

function slot0._onClickClose(slot0)
	slot0:closeThis()
	GMLogController.instance:hideAlert()
end

function slot0._onClickClear(slot0)
	slot0._selectMO = nil
	slot0._txtContent.text = ""

	GMLogModel.instance.errorModel:clear()
	slot0:_updateBtns()
	slot0:_updateCount()
end

function slot0._onClitkDel(slot0)
	if slot0._selectMO then
		GMLogModel.instance.errorModel:remove(slot0._selectMO)

		slot0._selectMO = nil
		slot0._txtContent.text = ""
	end

	slot0:_updateBtns()
	slot0:_updateCount()
end

function slot0._onClickSend(slot0)
	if slot0._selectMO then
		if not slot0._selectMO.hasSend then
			slot0._selectMO.hasSend = true

			GMLogController.instance:sendRobotMsg(slot0._selectMO.msg, slot0._selectMO.stackTrace)
		else
			GameFacade.showToast(ToastEnum.IconId, "had send")
		end
	end

	slot0:_updateBtns()
end

function slot0._onClickHide(slot0)
	slot0:closeThis()
	GMLogController.instance:showAlert()
end

function slot0._onClickCopy(slot0)
	if slot0._selectMO then
		ZProj.GameHelper.SetSystemBuffer(slot0._selectMO.msg)
		GameFacade.showToast(ToastEnum.IconId, "copy success")
	end
end

function slot0._onClickBlock(slot0)
	GMLogController.instance:block()
	slot0:closeThis()
end

function slot0._updateBtns(slot0)
	gohelper.setActive(slot0._btnDel.gameObject, slot0._selectMO)
	gohelper.setActive(slot0._btnSend.gameObject, slot0._selectMO and not slot0._selectMO.hasSend and not SLFramework.FrameworkSettings.IsEditor)
	gohelper.setActive(slot0._btnCopy.gameObject, slot0._selectMO)
end

function slot0._updateCount(slot0)
	GMController.instance:dispatchEvent(GMEvent.GMLog_UpdateCount)
end

return slot0
