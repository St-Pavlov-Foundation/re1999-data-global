module("modules.logic.dungeon.view.rolestory.RoleStoryActivityBgView", package.seeall)

slot0 = class("RoleStoryActivityBgView", BaseView)

function slot0.onInitView(slot0)
	slot0.bgNode = gohelper.findChild(slot0.viewGO, "fullbg")
	slot0.bg1 = gohelper.findChild(slot0.bgNode, "#simage_fullbg1")
	slot0.bg2 = gohelper.findChild(slot0.bgNode, "#simage_fullbg2")
	slot0._showActView = true

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ChangeMainViewShow, slot0._onChangeMainViewShow, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.ChangeMainViewShow, slot0._onChangeMainViewShow, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	if slot0.viewParam and slot0.viewParam[1] == 1 then
		slot0._showActView = false
	end
end

function slot0._onChangeMainViewShow(slot0, slot1)
	if slot0._showActView == slot1 then
		return
	end

	slot0._showActView = slot1
end

function slot0.refreshBg(slot0)
	gohelper.setActive(slot0.bg1, slot0._showActView)
	gohelper.setActive(slot0.bg2, not slot0._showActView)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
