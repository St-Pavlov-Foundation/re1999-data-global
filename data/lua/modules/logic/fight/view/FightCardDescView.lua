module("modules.logic.fight.view.FightCardDescView", package.seeall)

local var_0_0 = class("FightCardDescView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gocardlist = gohelper.findChild(arg_1_0.viewGO, "#go_cardlist")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(lua_card_description.configList) do
		arg_7_0:_addCardItem(iter_7_1, iter_7_0 == #lua_card_description.configList)
	end
end

function var_0_0._addCardItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.viewContainer:getSetting().otherRes[1]
	local var_8_1 = arg_8_0:getResInst(var_8_0, arg_8_0._gocardlist)

	MonoHelper.addNoUpdateLuaComOnceToGo(var_8_1, FightCardDescItem):onUpdateMO(arg_8_1, arg_8_2)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
