module("modules.logic.playercard.view.PlayerCardProgressView", package.seeall)

local var_0_0 = class("PlayerCardProgressView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagetop = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_top")
	arg_1_0._simagebottom = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bottom")
	arg_1_0._scrollprogress = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_progress")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._txtchoose = gohelper.findChildText(arg_1_0.viewGO, "#btn_confirm/#txt_choose")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0.animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SelectNumChange, arg_2_0._onNumChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	PlayerCardProgressModel.instance:confirmData()
	arg_4_0:closeThis()
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0.viewContainer:checkCloseFunc()
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.playercardinfo = arg_8_0.viewParam

	arg_8_0.animator:Play("open")
	PlayerCardProgressModel.instance:initSelectData(arg_8_0.playercardinfo)
	arg_8_0:refreshView()
	arg_8_0:refreshNum()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_leimi_unlock)
end

function var_0_0.refreshView(arg_9_0)
	PlayerCardProgressModel.instance:refreshList()
end

function var_0_0._onNumChange(arg_10_0)
	arg_10_0:refreshNum()
end

function var_0_0.refreshNum(arg_11_0)
	local var_11_0 = PlayerCardProgressModel.instance:getSelectNum()
	local var_11_1 = PlayerCardEnum.MaxProgressCardNum

	arg_11_0._txtchoose.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_custompick_selectnum"), {
		var_11_0,
		var_11_1
	})
end

function var_0_0.onClose(arg_12_0)
	arg_12_0.animator:Play("close")
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.OnCloseProgressView)
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
