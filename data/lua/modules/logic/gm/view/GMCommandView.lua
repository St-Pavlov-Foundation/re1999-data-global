module("modules.logic.gm.view.GMCommandView", package.seeall)
require("modules/logic/gm/view/GMToolCommands")

local var_0_0 = class("GMCommandView", BaseView)

var_0_0.OpenCommand = 1910
var_0_0.ClickItem = 1911
var_0_0.ClickItemAgain = 1912

function var_0_0.onInitView(arg_1_0)
	arg_1_0._maskGO = gohelper.findChild(arg_1_0.viewGO, "gmcommand")
	arg_1_0._inpCommand = gohelper.findChildInputField(arg_1_0.viewGO, "viewport/content/item1/inpText")
	arg_1_0._txtCommandStr = gohelper.findChildText(arg_1_0.viewGO, "gmcommand/txtCommandStr")
	arg_1_0._txtCommandName = gohelper.findChildText(arg_1_0.viewGO, "gmcommand/txtCommandName")
	arg_1_0._txtCommandDesc = gohelper.findChildText(arg_1_0.viewGO, "gmcommand/txtCommandDesc")

	arg_1_0:_hideScroll()
end

function var_0_0.addEvents(arg_2_0)
	SLFramework.UGUI.UIClickListener.Get(arg_2_0._maskGO):AddClickListener(arg_2_0._onClickMask, arg_2_0, nil)
end

function var_0_0.removeEvents(arg_3_0)
	SLFramework.UGUI.UIClickListener.Get(arg_3_0._maskGO):RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	GMController.instance:registerCallback(var_0_0.OpenCommand, arg_4_0._showScroll, arg_4_0)
	GMController.instance:registerCallback(var_0_0.ClickItem, arg_4_0._onClickItem, arg_4_0)
	GMController.instance:registerCallback(var_0_0.ClickItemAgain, arg_4_0._hideScroll, arg_4_0)
end

function var_0_0.onClose(arg_5_0)
	GMController.instance:unregisterCallback(var_0_0.OpenCommand, arg_5_0._showScroll, arg_5_0)
	GMController.instance:unregisterCallback(var_0_0.ClickItem, arg_5_0._onClickItem, arg_5_0)
	GMController.instance:unregisterCallback(var_0_0.ClickItemAgain, arg_5_0._hideScroll, arg_5_0)
end

function var_0_0._onClickMask(arg_6_0)
	arg_6_0:_hideScroll()
end

function var_0_0._onClickItem(arg_7_0, arg_7_1)
	arg_7_0._txtCommandStr.text = arg_7_1.command
	arg_7_0._txtCommandName.text = arg_7_1.name
	arg_7_0._txtCommandDesc.text = arg_7_1.desc

	arg_7_0._inpCommand:SetText(arg_7_1.command)
end

function var_0_0._showScroll(arg_8_0)
	gohelper.setActive(arg_8_0._maskGO, true)
	GMCommandModel.instance:checkInitList()
end

function var_0_0._hideScroll(arg_9_0)
	gohelper.setActive(arg_9_0._maskGO, false)
end

return var_0_0
