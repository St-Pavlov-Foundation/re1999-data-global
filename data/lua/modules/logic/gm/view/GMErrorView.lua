module("modules.logic.gm.view.GMErrorView", package.seeall)

local var_0_0 = class("GMErrorView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "panel/detail/btns/btnClose")
	arg_1_0._btnClear = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "panel/detail/btns/btnClear")
	arg_1_0._btnDel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "panel/detail/btns/btnDel")
	arg_1_0._btnSend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "panel/detail/btns/btnSend")
	arg_1_0._btnHide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "panel/detail/btns/btnHide")
	arg_1_0._btnCopy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "panel/detail/btns/btnCopy")
	arg_1_0._btnBlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "panel/detail/btns/btnBlock")
	arg_1_0._txtContent = gohelper.findChildText(arg_1_0.viewGO, "panel/detail/scroll/Viewport/content")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._onClickClose, arg_2_0)
	arg_2_0._btnClear:AddClickListener(arg_2_0._onClickClear, arg_2_0)
	arg_2_0._btnDel:AddClickListener(arg_2_0._onClitkDel, arg_2_0)
	arg_2_0._btnSend:AddClickListener(arg_2_0._onClickSend, arg_2_0)
	arg_2_0._btnHide:AddClickListener(arg_2_0._onClickHide, arg_2_0)
	arg_2_0._btnCopy:AddClickListener(arg_2_0._onClickCopy, arg_2_0)
	arg_2_0._btnBlock:AddClickListener(arg_2_0._onClickBlock, arg_2_0)
	arg_2_0:addEventCb(GMController.instance, GMEvent.GMLogView_Select, arg_2_0._onSelectMO, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnClear:RemoveClickListener()
	arg_3_0._btnDel:RemoveClickListener()
	arg_3_0._btnSend:RemoveClickListener()
	arg_3_0._btnHide:RemoveClickListener()
	arg_3_0._btnCopy:RemoveClickListener()
	arg_3_0._btnBlock:RemoveClickListener()
	arg_3_0:removeEventCb(GMController.instance, GMEvent.GMLogView_Select, arg_3_0._onSelectMO, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	if GMLogModel.instance.errorModel:getCount() > 0 then
		GMLogModel.instance.errorModel:selectCell(1, true)
	end

	arg_4_0:_updateBtns()
end

function var_0_0._onSelectMO(arg_5_0, arg_5_1)
	if arg_5_1 then
		arg_5_0._selectMO = arg_5_1
		arg_5_0._txtContent.text = string.format("%s %s", os.date("%H:%M:%S", arg_5_1.time), arg_5_1.msg)
	else
		arg_5_0._txtContent.text = ""
	end

	arg_5_0:_updateBtns()
end

function var_0_0._onClickClose(arg_6_0)
	arg_6_0:closeThis()
	GMLogController.instance:hideAlert()
end

function var_0_0._onClickClear(arg_7_0)
	arg_7_0._selectMO = nil
	arg_7_0._txtContent.text = ""

	GMLogModel.instance.errorModel:clear()
	arg_7_0:_updateBtns()
	arg_7_0:_updateCount()
end

function var_0_0._onClitkDel(arg_8_0)
	if arg_8_0._selectMO then
		GMLogModel.instance.errorModel:remove(arg_8_0._selectMO)

		arg_8_0._selectMO = nil
		arg_8_0._txtContent.text = ""
	end

	arg_8_0:_updateBtns()
	arg_8_0:_updateCount()
end

function var_0_0._onClickSend(arg_9_0)
	if arg_9_0._selectMO then
		if not arg_9_0._selectMO.hasSend then
			arg_9_0._selectMO.hasSend = true

			GMLogController.instance:sendRobotMsg(arg_9_0._selectMO.msg, arg_9_0._selectMO.stackTrace)
		else
			GameFacade.showToast(ToastEnum.IconId, "had send")
		end
	end

	arg_9_0:_updateBtns()
end

function var_0_0._onClickHide(arg_10_0)
	arg_10_0:closeThis()
	GMLogController.instance:showAlert()
end

function var_0_0._onClickCopy(arg_11_0)
	if arg_11_0._selectMO then
		ZProj.GameHelper.SetSystemBuffer(arg_11_0._selectMO.msg)
		GameFacade.showToast(ToastEnum.IconId, "copy success")
	end
end

function var_0_0._onClickBlock(arg_12_0)
	GMLogController.instance:block()
	arg_12_0:closeThis()
end

function var_0_0._updateBtns(arg_13_0)
	gohelper.setActive(arg_13_0._btnDel.gameObject, arg_13_0._selectMO)
	gohelper.setActive(arg_13_0._btnSend.gameObject, arg_13_0._selectMO and not arg_13_0._selectMO.hasSend and not SLFramework.FrameworkSettings.IsEditor)
	gohelper.setActive(arg_13_0._btnCopy.gameObject, arg_13_0._selectMO)
end

function var_0_0._updateCount(arg_14_0)
	GMController.instance:dispatchEvent(GMEvent.GMLog_UpdateCount)
end

return var_0_0
