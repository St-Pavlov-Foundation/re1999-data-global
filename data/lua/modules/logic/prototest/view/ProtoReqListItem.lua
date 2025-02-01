module("modules.logic.prototest.view.ProtoReqListItem", package.seeall)

slot0 = class("ProtoReqListItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._imgGO1 = gohelper.findChild(slot1, "img1")
	slot0._imgGO2 = gohelper.findChild(slot1, "img2")
	slot0._txtModule = gohelper.findChildText(slot1, "txtModule")
	slot0._txtCmd = gohelper.findChildText(slot1, "txtCmd")
	slot0._txtReq = gohelper.findChildText(slot1, "txtReq")
	slot0._click = gohelper.findChildClick(slot1, "")
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickListener(slot0._onClickThis, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._txtModule.text = slot1.module
	slot0._txtCmd.text = slot1.cmd
	slot0._txtReq.text = slot1.req

	gohelper.setActive(slot0._imgGO1, slot0._index % 2 == 0)
	gohelper.setActive(slot0._imgGO2, slot0._index % 2 == 1)
end

function slot0._onClickThis(slot0)
	ProtoTestMgr.instance:dispatchEvent(ProtoEnum.OnClickReqListItem, slot0._mo)
end

return slot0
