module("modules.logic.playercard.view.PlayerCardShowView", package.seeall)

local var_0_0 = class("PlayerCardShowView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0.btnConfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0.txtNum = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_bottom/#txt_num")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClose, arg_2_0.onClickBtnClose, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnConfirm, arg_2_0.onClickBtnConfirm, arg_2_0)
	arg_2_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SelectNumChange, arg_2_0._onNumChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onClickBtnClose(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onClickBtnConfirm(arg_5_0)
	PlayerCardProgressModel.instance:confirmData()
	arg_5_0:closeThis()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:_updateParam()

	local var_6_0 = arg_6_0:getCardInfo()

	PlayerCardProgressModel.instance:initSelectData(var_6_0)
	arg_6_0:refreshView()
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:_updateParam()
	arg_7_0:refreshView()
end

function var_0_0._updateParam(arg_8_0)
	arg_8_0.userId = PlayerModel.instance:getMyUserId()
end

function var_0_0.getCardInfo(arg_9_0)
	return PlayerCardModel.instance:getCardInfo(arg_9_0.userId)
end

function var_0_0.refreshView(arg_10_0)
	PlayerCardProgressModel.instance:refreshList()
	arg_10_0:refreshNum()
end

function var_0_0._onNumChange(arg_11_0)
	arg_11_0:refreshNum()
end

function var_0_0.refreshNum(arg_12_0)
	local var_12_0 = PlayerCardProgressModel.instance:getSelectNum()
	local var_12_1 = PlayerCardEnum.MaxCardNum

	arg_12_0.txtNum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_custompick_selectnum"), {
		var_12_0,
		var_12_1
	})
end

function var_0_0.onClose(arg_13_0)
	return
end

return var_0_0
