module("modules.logic.fight.view.FightCardMixIntroduceView", package.seeall)

local var_0_0 = class("FightCardMixIntroduceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gocardcontent1 = gohelper.findChild(arg_1_0.viewGO, "#go_cardcontent1")
	arg_1_0._gocardcontent2 = gohelper.findChild(arg_1_0.viewGO, "#go_cardcontent2")

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
	gohelper.setActive(arg_5_0._gocardcontent1, false)
	gohelper.setActive(arg_5_0._gocardcontent2, false)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam.viewParam
	local var_7_1 = arg_7_0["_gocardcontent" .. tostring(var_7_0)]

	if var_7_1 then
		gohelper.setActive(var_7_1, true)
	end
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
