module("modules.logic.gm.view.GMErrorItem", package.seeall)

local var_0_0 = class("GMErrorItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._text = gohelper.findChildText(arg_1_1, "text")
	arg_1_0._click = gohelper.getClickWithAudio(arg_1_1)
	arg_1_0._selectGO = gohelper.findChild(arg_1_1, "select")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickThis, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._click:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1
	arg_4_0._text.text = string.format("%s %s", os.date("%H:%M:%S", arg_4_1.time), arg_4_1.msg)
end

function var_0_0.onSelect(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._selectGO, arg_5_1)

	if arg_5_1 then
		GMController.instance:dispatchEvent(GMEvent.GMLogView_Select, arg_5_0._mo)
	end
end

function var_0_0._onClickThis(arg_6_0)
	arg_6_0._view:setSelect(arg_6_0._mo)
end

return var_0_0
