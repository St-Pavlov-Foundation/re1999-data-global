module("modules.logic.gm.view.GMCommandView", package.seeall)
require("modules/logic/gm/view/GMToolCommands")

slot0 = class("GMCommandView", BaseView)
slot0.OpenCommand = 1910
slot0.ClickItem = 1911
slot0.ClickItemAgain = 1912

function slot0.onInitView(slot0)
	slot0._maskGO = gohelper.findChild(slot0.viewGO, "gmcommand")
	slot0._inpCommand = gohelper.findChildInputField(slot0.viewGO, "viewport/content/item1/inpText")
	slot0._txtCommandStr = gohelper.findChildText(slot0.viewGO, "gmcommand/txtCommandStr")
	slot0._txtCommandName = gohelper.findChildText(slot0.viewGO, "gmcommand/txtCommandName")
	slot0._txtCommandDesc = gohelper.findChildText(slot0.viewGO, "gmcommand/txtCommandDesc")

	slot0:_hideScroll()
end

function slot0.addEvents(slot0)
	SLFramework.UGUI.UIClickListener.Get(slot0._maskGO):AddClickListener(slot0._onClickMask, slot0, nil)
end

function slot0.removeEvents(slot0)
	SLFramework.UGUI.UIClickListener.Get(slot0._maskGO):RemoveClickListener()
end

function slot0.onOpen(slot0)
	GMController.instance:registerCallback(uv0.OpenCommand, slot0._showScroll, slot0)
	GMController.instance:registerCallback(uv0.ClickItem, slot0._onClickItem, slot0)
	GMController.instance:registerCallback(uv0.ClickItemAgain, slot0._hideScroll, slot0)
end

function slot0.onClose(slot0)
	GMController.instance:unregisterCallback(uv0.OpenCommand, slot0._showScroll, slot0)
	GMController.instance:unregisterCallback(uv0.ClickItem, slot0._onClickItem, slot0)
	GMController.instance:unregisterCallback(uv0.ClickItemAgain, slot0._hideScroll, slot0)
end

function slot0._onClickMask(slot0)
	slot0:_hideScroll()
end

function slot0._onClickItem(slot0, slot1)
	slot0._txtCommandStr.text = slot1.command
	slot0._txtCommandName.text = slot1.name
	slot0._txtCommandDesc.text = slot1.desc

	slot0._inpCommand:SetText(slot1.command)
end

function slot0._showScroll(slot0)
	gohelper.setActive(slot0._maskGO, true)
	GMCommandModel.instance:checkInitList()
end

function slot0._hideScroll(slot0)
	gohelper.setActive(slot0._maskGO, false)
end

return slot0
