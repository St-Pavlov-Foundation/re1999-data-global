module("modules.logic.advance.view.testtask.TestTaskMainBtnItem", package.seeall)

slot0 = class("TestTaskMainBtnItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = gohelper.cloneInPlace(slot1)

	gohelper.setActive(slot0.go, true)

	slot0._imgitem = gohelper.findChildImage(slot0.go, "bg")
	slot0._btnitem = gohelper.getClick(gohelper.findChild(slot0.go, "bg"))
	slot0._reddotitem = gohelper.findChild(slot0.go, "go_activityreddot")
	slot0._txttheme = gohelper.findChildText(slot0.go, "txt_theme")

	slot0:_refreshItem()
	slot0:addEvent()
end

function slot0.addEvent(slot0)
	slot0._btnitem:AddClickListener(slot0._onItemClick, slot0)
end

function slot0.removeEvent(slot0)
	slot0._btnitem:RemoveClickListener()
end

function slot0._onItemClick(slot0)
	TestTaskController.instance:openTestTaskView()
end

function slot0._refreshItem(slot0)
	UISpriteSetMgr.instance:setMainSprite(slot0._imgitem, "icon_3")
	RedDotController.instance:addRedDot(slot0._reddotitem, RedDotEnum.DotNode.TestTaskBtn)
end

function slot0.destroy(slot0)
	slot0:removeEvent()
	gohelper.setActive(slot0.go, false)
	gohelper.destroy(slot0.go)

	slot0.go = nil
	slot0._imgitem = nil
	slot0._btnitem = nil
	slot0._reddotitem = nil
end

function slot0.isShowRedDot(slot0)
	return RedDotModel.instance:isDotShow(RedDotEnum.DotNode.TestTaskBtn)
end

return slot0
