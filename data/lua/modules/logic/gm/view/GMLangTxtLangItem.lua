module("modules.logic.gm.view.GMLangTxtLangItem", package.seeall)

local var_0_0 = class("GMLangTxtLangItem", UserDataDispose)

var_0_0.pattenList = {
	"%[([^%]]*)%]",
	"【([^】]*)】",
	"%d"
}
var_0_0.replacement = "<color=yellow>%0</color>"

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._txtlang = gohelper.findChildText(arg_1_1, "lang")
	arg_1_0._txt = gohelper.findChildText(arg_1_1, "txt")
	arg_1_0._btnCopy = gohelper.findChildButtonWithAudio(arg_1_1, "btnCopy")

	arg_1_0._btnCopy:AddClickListener(arg_1_0._onClickCopy, arg_1_0)

	arg_1_0._txtlang.text = arg_1_2
	arg_1_0.lang = arg_1_2

	gohelper.setActive(arg_1_1, true)
end

function var_0_0.updateStr(arg_2_0, arg_2_1)
	local var_2_0 = GMLangController.instance:getInUseDic()

	if not var_2_0[arg_2_1] or not var_2_0[arg_2_1][arg_2_0.lang] then
		arg_2_0._txt.text = ""
	else
		arg_2_0._langTxt = var_2_0[arg_2_1][arg_2_0.lang]

		local var_2_1 = arg_2_0._langTxt

		for iter_2_0, iter_2_1 in ipairs(var_0_0.pattenList) do
			var_2_1 = string.gsub(var_2_1, iter_2_1, var_0_0.replacement)
		end

		arg_2_0._txt.text = var_2_1
	end
end

function var_0_0._onClickCopy(arg_3_0)
	ZProj.UGUIHelper.CopyText(arg_3_0._langTxt)
end

function var_0_0.onClose(arg_4_0)
	arg_4_0._btnCopy:RemoveClickListener()
end

return var_0_0
