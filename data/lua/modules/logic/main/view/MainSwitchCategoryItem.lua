module("modules.logic.main.view.MainSwitchCategoryItem", package.seeall)

slot0 = class("MainSwitchCategoryItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._txtitemcn1 = gohelper.findChildText(slot0.viewGO, "bg1/#txt_itemcn1")
	slot0._goreddot1 = gohelper.findChild(slot0.viewGO, "bg1/#txt_itemcn1/#go_reddot1")
	slot0._txtitemen1 = gohelper.findChildText(slot0.viewGO, "bg1/#txt_itemen1")
	slot0._txtitemcn2 = gohelper.findChildText(slot0.viewGO, "bg2/#txt_itemcn2")
	slot0._goreddot2 = gohelper.findChild(slot0.viewGO, "bg2/#txt_itemcn2/#go_reddot2")
	slot0._txtitemen2 = gohelper.findChildText(slot0.viewGO, "bg2/#txt_itemen2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._btnCategory = SLFramework.UGUI.UIClickListener.Get(slot0.viewGO)
	slot4 = slot0

	slot0._btnCategory:AddClickListener(slot0._onItemClick, slot4)

	slot0._bgs = slot0:getUserDataTb_()

	for slot4 = 1, 2 do
		slot0._bgs[slot4] = gohelper.findChild(slot0.viewGO, "bg" .. tostring(slot4))
	end

	gohelper.setActive(slot0._bgs[2], false)
end

function slot0._editableAddEvents(slot0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, slot0._refreshReddot, slot0)
end

function slot0._editableRemoveEvents(slot0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, slot0._refreshReddot, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshStatus()
end

function slot0.refreshStatus(slot0)
	slot1 = slot0:_isSelected()

	gohelper.setActive(slot0._bgs[1], not slot1)
	gohelper.setActive(slot0._bgs[2], slot1)
	slot0:_refreshReddot()
end

function slot0._refreshReddot(slot0)
	slot1 = false

	if slot0._mo.id == MainEnum.SwitchType.Scene and RedDotModel.instance:isDotShow(RedDotEnum.DotNode.MainSceneSwitch, 0) and slot0:_isSelected() then
		MainSceneSwitchController.closeReddot()

		slot1 = false
	end

	gohelper.setActive(slot0._goreddot1, slot1)
end

function slot0._isSelected(slot0)
	return slot0._mo.id == MainSwitchCategoryListModel.instance:getCategoryId()
end

function slot0.onSelect(slot0, slot1)
end

function slot0._onItemClick(slot0)
	if slot0:_isSelected() then
		return
	end

	MainSwitchCategoryListModel.instance:setCategoryId(slot0._mo.id)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.SwitchCategoryClick, slot0._mo.id)
end

function slot0.onDestroyView(slot0)
	if slot0._btnCategory then
		slot0._btnCategory:RemoveClickListener()
	end
end

return slot0
