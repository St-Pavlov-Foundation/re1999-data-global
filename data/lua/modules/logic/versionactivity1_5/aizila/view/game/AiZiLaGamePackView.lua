module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGamePackView", package.seeall)

local var_0_0 = class("AiZiLaGamePackView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnfullClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_fullClose")
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_PanelBG")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "#txt_Title")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._scrollItems = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_Items")
	arg_1_0._goEmpty = gohelper.findChild(arg_1_0.viewGO, "#go_Empty")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnfullClose:AddClickListener(arg_2_0._btnfullCloseOnClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnfullClose:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._btnfullCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnCloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:addEventCb(AiZiLaController.instance, AiZiLaEvent.ExitGame, arg_8_0.closeThis, arg_8_0)

	if arg_8_0.viewContainer then
		NavigateMgr.instance:addEscape(arg_8_0.viewContainer.viewName, arg_8_0.closeThis, arg_8_0)
	end

	AiZiLaGamePackListModel.instance:init()
	gohelper.setActive(arg_8_0._goEmpty, AiZiLaGamePackListModel.instance:getCount() < 1)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
