module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessForcePickView", package.seeall)

local var_0_0 = class("AutoChessForcePickView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goView = gohelper.findChild(arg_1_0.viewGO, "#go_View")
	arg_1_0._btnGiveUp = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_View/#btn_GiveUp")
	arg_1_0._btnView = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_View/#btn_View")
	arg_1_0._txtTip = gohelper.findChildText(arg_1_0.viewGO, "#go_View/panelbg/#txt_Tip")
	arg_1_0._txtWarningTip = gohelper.findChildText(arg_1_0.viewGO, "#go_View/panelbg/#txt_WarningTip")
	arg_1_0._goCardRoot = gohelper.findChild(arg_1_0.viewGO, "#go_View/Card/Viewport/#go_CardRoot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnGiveUp:AddClickListener(arg_2_0._btnGiveUpOnClick, arg_2_0)
	arg_2_0._btnView:AddClickListener(arg_2_0._btnViewOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnGiveUp:RemoveClickListener()
	arg_3_0._btnView:RemoveClickListener()
end

function var_0_0.onClickModalMask(arg_4_0)
	return
end

function var_0_0._btnGiveUpOnClick(arg_5_0)
	GameFacade.showOptionMessageBox(MessageBoxIdDefine.AutoChessGiveUpForcePick, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, arg_5_0._yesCallback, nil, nil, arg_5_0)
end

function var_0_0._yesCallback(arg_6_0)
	local var_6_0 = AutoChessModel.instance.moduleId

	if var_6_0 then
		AutoChessRpc.instance:sendAutoChessMallRegionSelectItemRequest(var_6_0, 0)
	end

	arg_6_0:closeThis()
end

function var_0_0._btnViewOnClick(arg_7_0)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.ForcePickViewBoard)
	arg_7_0:closeThis()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.contentSizeFitter = arg_8_0._goCardRoot:GetComponent(gohelper.Type_ContentSizeFitter)
	arg_8_0.layoutGroup = arg_8_0._goCardRoot:GetComponent(gohelper.Type_HorizontalLayoutGroup)
end

function var_0_0.onOpen(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_qishou_confirm)

	if arg_9_0.viewParam then
		arg_9_0:addEventCb(AutoChessController.instance, AutoChessEvent.ForcePickReply, arg_9_0.closeThis, arg_9_0)

		arg_9_0.freeMall = arg_9_0.viewParam

		arg_9_0:refreshUI()
		TaskDispatcher.runDelay(arg_9_0.delayDisabled, arg_9_0, 0.1)
	end
end

function var_0_0.delayDisabled(arg_10_0)
	arg_10_0.contentSizeFitter.enabled = false
	arg_10_0.layoutGroup.enabled = false
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.delayDisabled, arg_12_0)
end

function var_0_0.refreshUI(arg_13_0)
	local var_13_0 = #arg_13_0.freeMall.items

	arg_13_0._txtTip.text = luaLang("autochess_forcepick_tip")

	if var_13_0 ~= 0 then
		local var_13_1 = arg_13_0.freeMall.items[1]
		local var_13_2 = AutoChessConfig.instance:getChessCfgById(var_13_1.chess.id, var_13_1.chess.star)
		local var_13_3 = luaLang("autochess_forcepick_warningtip")

		arg_13_0._txtWarningTip.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_13_3, var_13_2.name)
	end

	local var_13_4 = arg_13_0.freeMall.selectItems

	for iter_13_0, iter_13_1 in ipairs(var_13_4) do
		local var_13_5 = arg_13_0:getResInst(AutoChessStrEnum.ResPath.ChessCard, arg_13_0._goCardRoot, "card" .. iter_13_1)
		local var_13_6 = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_5, AutoChessCard)
		local var_13_7 = {
			type = AutoChessCard.ShowType.ForcePick,
			itemId = iter_13_1
		}

		var_13_6:setData(var_13_7)
	end

	gohelper.setActive(arg_13_0._txtTip, var_13_0 == 0)
	gohelper.setActive(arg_13_0._txtWarningTip, var_13_0 ~= 0)
end

return var_0_0
