module("modules.logic.notice.view.items.NoticeTxtTopTitleItem", package.seeall)

local var_0_0 = class("NoticeTxtTopTitleItem", NoticeContentBaseItem)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.init(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.goTopTitle = gohelper.findChild(arg_1_1, "#go_topTitle")
	arg_1_0.txtTopTitle = gohelper.findChildText(arg_1_1, "#go_topTitle/#txt_title")
end

function var_0_0.show(arg_2_0)
	gohelper.setActive(arg_2_0.goTopTitle, true)

	local var_2_0 = arg_2_0.mo.content

	arg_2_0.txtTopTitle.text = "<line-indent=-5>" .. var_2_0
end

function var_0_0.hide(arg_3_0)
	gohelper.setActive(arg_3_0.goTopTitle, false)
end

return var_0_0
