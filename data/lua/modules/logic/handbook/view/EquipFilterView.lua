module("modules.logic.handbook.view.EquipFilterView", package.seeall)

slot0 = class("EquipFilterView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._goobtain = gohelper.findChild(slot0.viewGO, "container/layoutgroup/#go_obtain")
	slot0._goget = gohelper.findChild(slot0.viewGO, "container/layoutgroup/#go_obtain/obtainContainer/#go_get")
	slot0._gonotget = gohelper.findChild(slot0.viewGO, "container/layoutgroup/#go_obtain/obtainContainer/#go_notget")
	slot0._goTag = gohelper.findChild(slot0.viewGO, "container/layoutgroup/#go_tag")
	slot0._goTagContainer = gohelper.findChild(slot0.viewGO, "container/layoutgroup/#go_tag/#go_tagContainer")
	slot0._gotagItem = gohelper.findChild(slot0.viewGO, "container/layoutgroup/#go_tag/#go_tagContainer/#go_tagItem")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/#btn_reset")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/#btn_confirm")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
end

slot0.Color = {
	SelectColor = Color.New(1, 0.486, 0.25, 1),
	NormalColor = Color.New(0.898, 0.898, 0.898, 1)
}

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnresetOnClick(slot0)
	slot0.filterMo:reset()
	slot0:refreshUI()
end

function slot0._btnconfirmOnClick(slot0)
	EquipFilterModel.instance:applyMo(slot0.filterMo)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gotagItem, false)
end

function slot0.initObtainItem(slot0)
	if not slot0.obtainItemGet then
		slot0.obtainItemGet = slot0:createObtainItem(slot0._goget)
		slot0.obtainItemGet.type = EquipFilterModel.ObtainEnum.Get
	end

	if not slot0.obtainItemNotGet then
		slot0.obtainItemNotGet = slot0:createObtainItem(slot0._gonotget)
		slot0.obtainItemNotGet.type = EquipFilterModel.ObtainEnum.NotGet
	end
end

function slot0.createObtainItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = slot1
	slot2.goUnSelect = gohelper.findChild(slot2.go, "unselected")
	slot2.goSelect = gohelper.findChild(slot2.go, "selected")
	slot2.btnClick = gohelper.findChildClick(slot2.go, "click")

	slot2.btnClick:AddClickListener(slot0.onClickObtainTypeItem, slot0, slot2)

	return slot2
end

function slot0.initTagItem(slot0)
	if slot0.tagItemList then
		return
	end

	slot0.tagItemList = {}
	slot1 = nil

	for slot5, slot6 in ipairs(EquipFilterModel.getAllTagList()) do
		slot1 = slot0:createTypeItem()
		slot1.tagCo = slot6

		gohelper.setActive(slot1.go, true)

		slot1.tagText.text = slot6.name

		table.insert(slot0.tagItemList, slot1)
	end
end

function slot0.createTypeItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0._gotagItem)
	slot1.tagText = gohelper.findChildText(slot1.go, "tagText")
	slot1.goSelect = gohelper.findChild(slot1.go, "selected")
	slot1.goUnSelect = gohelper.findChild(slot1.go, "unselected")
	slot1.btnClick = gohelper.findChildClickWithAudio(slot1.go, "click", AudioEnum.UI.UI_Common_Click)

	slot1.btnClick:AddClickListener(slot0.onClickTagItem, slot0, slot1)

	return slot1
end

function slot0.onClickTagItem(slot0, slot1)
	if slot0:isSelectTag(slot1.tagCo.id) then
		tabletool.removeValue(slot0.filterMo.selectTagList, slot1.tagCo.id)
	else
		table.insert(slot0.filterMo.selectTagList, slot1.tagCo.id)
	end

	slot0:refreshTagIsSelect(slot1)
end

function slot0.onClickObtainTypeItem(slot0, slot1)
	if slot0.filterMo.obtainShowType == slot1.type then
		slot0.filterMo.obtainShowType = EquipFilterModel.ObtainEnum.All
	else
		slot0.filterMo.obtainShowType = slot1.type
	end

	slot0:refreshObtainTypeUIContainer()
end

function slot0.initViewParam(slot0)
	slot0.isNotShowObtain = slot0.viewContainer.viewParam and slot0.viewContainer.viewParam.isNotShowObtain
	slot0.parentViewName = slot0.viewContainer.viewParam and slot0.viewContainer.viewParam.viewName
end

function slot0.onOpen(slot0)
	slot0:initViewParam()

	slot0.filterMo = EquipFilterModel.instance:getFilterMo(slot0.parentViewName):clone()

	if slot0.isNotShowObtain then
		gohelper.setActive(slot0._goobtain, false)
	else
		gohelper.setActive(slot0._goobtain, true)
		slot0:initObtainItem()
	end

	slot0:initTagItem()
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	if not slot0.isNotShowObtain then
		slot0:refreshObtainTypeUIContainer()
	end

	slot0:refreshTagUIContainer()
end

function slot0.refreshObtainTypeUIContainer(slot0)
	slot0:refreshObtainTypeItemIsSelect(slot0.obtainItemGet)
	slot0:refreshObtainTypeItemIsSelect(slot0.obtainItemNotGet)
end

function slot0.refreshTagUIContainer(slot0)
	for slot4, slot5 in ipairs(slot0.tagItemList) do
		slot0:refreshTagIsSelect(slot5)
	end
end

function slot0.refreshObtainTypeItemIsSelect(slot0, slot1)
	slot2 = slot0.filterMo.obtainShowType == slot1.type

	gohelper.setActive(slot1.goSelect, slot2)
	gohelper.setActive(slot1.goUnSelect, not slot2)
end

function slot0.refreshTagIsSelect(slot0, slot1)
	slot2 = slot0:isSelectTag(slot1.tagCo.id)

	gohelper.setActive(slot1.goSelect, slot2)
	gohelper.setActive(slot1.goUnSelect, not slot2)

	slot1.tagText.color = slot2 and uv0.Color.SelectColor or uv0.Color.NormalColor
end

function slot0.isSelectTag(slot0, slot1)
	return next(slot0.filterMo.selectTagList) and tabletool.indexOf(slot0.filterMo.selectTagList, slot1)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.tagItemList) do
		slot5.btnClick:RemoveClickListener()
	end

	if not slot0.isNotShowObtain then
		slot0.obtainItemGet.btnClick:RemoveClickListener()
		slot0.obtainItemNotGet.btnClick:RemoveClickListener()
	end
end

return slot0
