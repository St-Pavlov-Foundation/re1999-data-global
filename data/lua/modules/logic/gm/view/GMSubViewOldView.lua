module("modules.logic.gm.view.GMSubViewOldView", package.seeall)

local var_0_0 = Color.New(0.88, 0.84, 0.5, 1)
local var_0_1 = Color.New(0.75, 0.75, 0.75, 0.75)
local var_0_2 = class("GMSubViewOldView", GMSubViewBase)

function var_0_2.onOpen(arg_1_0)
	arg_1_0:addSubViewGo("ALL")
end

function var_0_2._onToggleValueChanged(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 then
		if not arg_2_0._subViewContent then
			arg_2_0:initViewContent()
		end

		arg_2_0.viewContainer:selectToggle(arg_2_0._toggleWrap)
	end

	gohelper.setActive(arg_2_0._mainViewBg, arg_2_2)
	gohelper.setActive(arg_2_0._mainViewPort, arg_2_2)

	arg_2_0._toggleImage.color = arg_2_2 and var_0_0 or var_0_1
end

return var_0_2
