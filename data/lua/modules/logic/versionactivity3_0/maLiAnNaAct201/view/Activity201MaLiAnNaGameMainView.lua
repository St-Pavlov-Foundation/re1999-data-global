module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.Activity201MaLiAnNaGameMainView", package.seeall)

local var_0_0 = class("Activity201MaLiAnNaGameMainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_BG")
	arg_1_0._gov3a0maliannalevelview = gohelper.findChild(arg_1_0.viewGO, "#go_v3a0_malianna_levelview")
	arg_1_0._gov3a0maliannanoticeview = gohelper.findChild(arg_1_0.viewGO, "#go_v3a0_malianna_noticeview")
	arg_1_0._gov3a0maliannagameview = gohelper.findChild(arg_1_0.viewGO, "#go_v3a0_malianna_gameview")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._ani = arg_4_0.viewGO:GetComponent(gohelper.Type_Animator)
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	return
end

function var_0_0._onCloseView(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.Activity201MaLiAnNaGameView and arg_7_0._ani then
		arg_7_0._ani:Play("open")
	end
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
