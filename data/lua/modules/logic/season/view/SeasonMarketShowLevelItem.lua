module("modules.logic.season.view.SeasonMarketShowLevelItem", package.seeall)

local var_0_0 = class("SeasonMarketShowLevelItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.go = arg_1_1
	arg_1_0.index = arg_1_2
	arg_1_0.targetIndex = arg_1_3
	arg_1_0.maxIndex = arg_1_4
	arg_1_0._goline = gohelper.findChild(arg_1_1, "#go_line")
	arg_1_0._goselected = gohelper.findChild(arg_1_1, "#go_selected")
	arg_1_0._txtselectindex = gohelper.findChildText(arg_1_1, "#go_selected/#txt_selectindex")
	arg_1_0._gopass = gohelper.findChild(arg_1_1, "#go_pass")
	arg_1_0._animatorPass = arg_1_0._gopass:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._txtpassindex = gohelper.findChildText(arg_1_1, "#go_pass/#txt_passindex")
	arg_1_0._gounpass = gohelper.findChild(arg_1_1, "#go_unpass")
	arg_1_0._txtunpassindex = gohelper.findChildText(arg_1_1, "#go_unpass/#txt_unpassindex")
	arg_1_0.point = gohelper.findChild(arg_1_1, "#go_unpass/point")

	gohelper.setActive(arg_1_0.go, true)
	gohelper.setActive(arg_1_0._goline, false)
	gohelper.setActive(arg_1_0._gopass, false)
	gohelper.setActive(arg_1_0._gounpass, false)
	gohelper.setActive(arg_1_0._goselected, false)
end

function var_0_0.show(arg_2_0)
	gohelper.setActive(arg_2_0._goline, arg_2_0.index < arg_2_0.maxIndex)
	gohelper.setActive(arg_2_0._gopass, arg_2_0.targetIndex > arg_2_0.index)
	gohelper.setActive(arg_2_0._gounpass, arg_2_0.targetIndex < arg_2_0.index)
	gohelper.setActive(arg_2_0._goselected, arg_2_0.targetIndex == arg_2_0.index)

	arg_2_0._txtselectindex.text = string.format("%02d", arg_2_0.index)
	arg_2_0._txtpassindex.text = string.format("%02d", arg_2_0.index)
	arg_2_0._txtunpassindex.text = string.format("%02d", arg_2_0.index)

	if arg_2_0.index + 1 == arg_2_0.targetIndex or arg_2_0.targetIndex == arg_2_0.index then
		arg_2_0._animatorPass:Play(UIAnimationName.Open, 0, 0)
	else
		arg_2_0._animatorPass:Play(UIAnimationName.Idle, 0, 0)
	end
end

function var_0_0.destroy(arg_3_0)
	return
end

return var_0_0
