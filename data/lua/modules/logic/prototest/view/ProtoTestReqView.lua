module("modules.logic.prototest.view.ProtoTestReqView", package.seeall)

slot0 = class("ProtoTestReqView", BaseView)

function slot0.onInitView(slot0)
	slot0._panelNew = gohelper.findChild(slot0.viewGO, "Panel_testcase/Panel_new")
	slot0._bgGO = gohelper.findChild(slot0.viewGO, "Panel_testcase/Panel_new/bg")
	slot0._bgTr = slot0._bgGO.transform
	slot0._inpRequest = gohelper.findChildTextMeshInputField(slot0.viewGO, "Panel_testcase/Panel_new/bg/inpRequest")
	slot0._btnNewCase = gohelper.findChildButtonWithAudio(slot0.viewGO, "Panel_testcase/Panel_oprator/Btn_NewCase")
	slot0._click = gohelper.getClick(slot0._panelNew)
end

function slot0.addEvents(slot0)
	slot0._click:AddClickListener(slot0._onClickMask, slot0)
	slot0._btnNewCase:AddClickListener(slot0._onClickBtnNewCase, slot0)
	slot0._inpRequest:AddOnValueChanged(slot0._onValueChanged, slot0)
	slot0:addEventCb(ProtoTestMgr.instance, ProtoEnum.OnClickReqListItem, slot0._onClickReqListItem, slot0)
end

function slot0.removeEvents(slot0)
	slot0._click:RemoveClickListener()
	slot0._btnNewCase:RemoveClickListener()
	slot0._inpRequest:RemoveOnValueChanged()
	slot0:removeEventCb(ProtoTestMgr.instance, ProtoEnum.OnClickReqListItem, slot0._onClickReqListItem, slot0)
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._panelNew, false)
end

function slot0._onClickMask(slot0)
	gohelper.setActive(slot0._panelNew, false)
end

function slot0._onClickBtnNewCase(slot0)
	gohelper.setActive(slot0._panelNew, true)
	slot0:_updateListView()
end

function slot0._onValueChanged(slot0, slot1)
	slot0:_updateListView()
end

function slot0._onClickReqListItem(slot0, slot1)
	gohelper.setActive(slot0._panelNew, false)

	slot3 = ProtoTestCaseMO.New()

	slot3:initFromProto(slot1.cmd, ProtoParamHelper.buildProtoByStructName(slot1.req))
	ProtoTestCaseModel.instance:addAtLast(slot3)
end

function slot0._updateListView(slot0)
	if #ProtoReqListModel.instance:getFilterList(slot0._inpRequest:GetText()) > 10 then
		slot2 = 10
	end

	if slot2 < 1 then
		slot2 = 1
	end

	recthelper.setHeight(slot0._bgTr, 40 + slot2 * 60)
	ProtoReqListModel.instance:setList(slot1)
end

return slot0
