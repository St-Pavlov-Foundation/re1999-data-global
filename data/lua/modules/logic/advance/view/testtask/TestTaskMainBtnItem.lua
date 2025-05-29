module("modules.logic.advance.view.testtask.TestTaskMainBtnItem", package.seeall)

local var_0_0 = class("TestTaskMainBtnItem", ActCenterItemBase)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, gohelper.cloneInPlace(arg_1_1))

	local var_1_0 = gohelper.findChild(arg_1_0.go, "bg")

	arg_1_0._btnitem = gohelper.getClick(var_1_0)
end

function var_0_0.onInit(arg_2_0, arg_2_1)
	arg_2_0:_refreshItem()
end

function var_0_0.onClick(arg_3_0)
	TestTaskController.instance:openTestTaskView()
end

function var_0_0._refreshItem(arg_4_0)
	UISpriteSetMgr.instance:setMainSprite(arg_4_0._imgitem, "icon_3")
	RedDotController.instance:addRedDot(arg_4_0._goactivityreddot, RedDotEnum.DotNode.TestTaskBtn)
end

function var_0_0.isShowRedDot(arg_5_0)
	return RedDotModel.instance:isDotShow(RedDotEnum.DotNode.TestTaskBtn)
end

return var_0_0
