module("modules.logic.advance.view.testtask.TestTaskMainBtnItem", package.seeall)

local var_0_0 = class("TestTaskMainBtnItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = gohelper.cloneInPlace(arg_1_1)

	gohelper.setActive(arg_1_0.go, true)

	arg_1_0._imgitem = gohelper.findChildImage(arg_1_0.go, "bg")

	local var_1_0 = gohelper.findChild(arg_1_0.go, "bg")

	arg_1_0._btnitem = gohelper.getClick(var_1_0)
	arg_1_0._reddotitem = gohelper.findChild(arg_1_0.go, "go_activityreddot")
	arg_1_0._txttheme = gohelper.findChildText(arg_1_0.go, "txt_theme")

	arg_1_0:_refreshItem()
	arg_1_0:addEvent()
end

function var_0_0.addEvent(arg_2_0)
	arg_2_0._btnitem:AddClickListener(arg_2_0._onItemClick, arg_2_0)
end

function var_0_0.removeEvent(arg_3_0)
	arg_3_0._btnitem:RemoveClickListener()
end

function var_0_0._onItemClick(arg_4_0)
	TestTaskController.instance:openTestTaskView()
end

function var_0_0._refreshItem(arg_5_0)
	UISpriteSetMgr.instance:setMainSprite(arg_5_0._imgitem, "icon_3")
	RedDotController.instance:addRedDot(arg_5_0._reddotitem, RedDotEnum.DotNode.TestTaskBtn)
end

function var_0_0.destroy(arg_6_0)
	arg_6_0:removeEvent()
	gohelper.setActive(arg_6_0.go, false)
	gohelper.destroy(arg_6_0.go)

	arg_6_0.go = nil
	arg_6_0._imgitem = nil
	arg_6_0._btnitem = nil
	arg_6_0._reddotitem = nil
end

function var_0_0.isShowRedDot(arg_7_0)
	return RedDotModel.instance:isDotShow(RedDotEnum.DotNode.TestTaskBtn)
end

return var_0_0
