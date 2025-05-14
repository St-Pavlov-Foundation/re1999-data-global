module("modules.logic.playercard.view.PlayerCardBaseInfoView", package.seeall)

local var_0_0 = class("PlayerCardBaseInfoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._btntips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_tips")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_tips")
	arg_1_0._btntipsclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_tips/#btn_close")
	arg_1_0._txtchoose = gohelper.findChildText(arg_1_0.viewGO, "#btn_confirm/#txt_choose")
	arg_1_0.animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._tipopen = false

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btntips:AddClickListener(arg_2_0._btntipsOnClick, arg_2_0)
	arg_2_0._btntipsclose:AddClickListener(arg_2_0._btntipsOnClick, arg_2_0)
	arg_2_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SelectNumChange, arg_2_0._onNumChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btntips:RemoveClickListener()
	arg_3_0._btntipsclose:RemoveClickListener()
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	PlayerCardBaseInfoModel.instance:confirmData()
	arg_4_0:closeThis()
end

function var_0_0._btntipsOnClick(arg_5_0)
	arg_5_0._tipopen = not arg_5_0._tipopen

	gohelper.setActive(arg_5_0._gotips, arg_5_0._tipopen)
end

function var_0_0._btncloseOnClick(arg_6_0)
	arg_6_0.viewContainer:checkCloseFunc()
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0.playercardinfo = arg_9_0.viewParam

	arg_9_0.animator:Play("open")
	PlayerCardBaseInfoModel.instance:initSelectData(arg_9_0.playercardinfo)
	arg_9_0:refreshView()
	arg_9_0:refreshNum()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_leimi_unlock)
end

function var_0_0.refreshView(arg_10_0)
	PlayerCardBaseInfoModel.instance:refreshList()
end

function var_0_0._onNumChange(arg_11_0)
	arg_11_0:refreshNum()
end

function var_0_0.refreshNum(arg_12_0)
	local var_12_0 = PlayerCardBaseInfoModel.instance:getSelectNum()
	local var_12_1 = PlayerCardEnum.MaxBaseInfoNum

	arg_12_0._txtchoose.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_custompick_selectnum"), {
		var_12_0,
		var_12_1
	})
end

function var_0_0.onClose(arg_13_0)
	arg_13_0.animator:Play("close")
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.OnCloseBaseInfoView)
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
