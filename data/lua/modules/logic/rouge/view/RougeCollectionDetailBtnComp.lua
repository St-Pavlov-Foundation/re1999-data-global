module("modules.logic.rouge.view.RougeCollectionDetailBtnComp", package.seeall)

slot0 = class("RougeCollectionDetailBtnComp", BaseView)

function slot0.onInitView(slot0)
	slot0._btndetails = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_details")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btndetails:AddClickListener(slot0._btndetailsOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndetails:RemoveClickListener()
end

function slot0._btndetailsOnClick(slot0)
	RougeCollectionModel.instance:switchCollectionInfoType()
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, slot0._onSwitchCollectionInfoType, slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshDetailBtnUI()
end

function slot0.refreshDetailBtnUI(slot0)
	gohelper.setActive(gohelper.findChild(slot0._btndetails.gameObject, "circle/select"), RougeCollectionModel.instance:getCurCollectionInfoType() == RougeEnum.CollectionInfoType.Complex)
end

function slot0._onSwitchCollectionInfoType(slot0)
	slot0:refreshDetailBtnUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
