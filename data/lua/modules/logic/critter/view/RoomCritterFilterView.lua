module("modules.logic.critter.view.RoomCritterFilterView", package.seeall)

slot0 = class("RoomCritterFilterView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclosefilterview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_searchfilter/#btn_closefilterview")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content")
	slot0._gofilterCategoryItem = gohelper.findChild(slot0.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/filterTypeItem")
	slot0._btnok = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_searchfilter/container/#btn_ok")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_searchfilter/container/#btn_reset")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclosefilterview:AddClickListener(slot0._btnclosefilterviewOnClick, slot0)
	slot0._btnok:AddClickListener(slot0._btnokOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclosefilterview:RemoveClickListener()
	slot0._btnok:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()

	for slot4, slot5 in pairs(slot0.filterCategoryItemDict) do
		for slot9, slot10 in pairs(slot5.tagItemDict) do
			slot10.btnClick:RemoveClickListener()
		end
	end
end

function slot0._btnclosefilterviewOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnokOnClick(slot0)
	CritterFilterModel.instance:applyMO(slot0.filterMO)
	slot0:closeThis()
end

function slot0._btnresetOnClick(slot0)
	slot0.filterMO:reset()
	slot0:refresh()
end

function slot0.onClickTagItem(slot0, slot1)
	if slot0:isSelectTag(slot1.filterType, slot1.tagId) then
		slot0.filterMO:unselectedTag(slot2, slot3)
	else
		slot0.filterMO:selectedTag(slot2, slot3)
	end

	slot0:refreshTag(slot1)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
	slot0.filterTypeList = slot0.viewParam.filterTypeList
	slot0.parentViewName = slot0.viewParam.viewName
end

function slot0.onOpen(slot0)
	slot0:onUpdateParam()

	slot0.filterCategoryItemDict = {}
	slot0.filterMO = CritterFilterModel.instance:getFilterMO(slot0.parentViewName, true):clone()

	gohelper.CreateObjList(slot0, slot0._onSetFilterCategoryItem, slot0.filterTypeList, slot0._gocontent, slot0._gofilterCategoryItem)
	slot0:refresh()
end

function slot0._onSetFilterCategoryItem(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot4.go = slot1
	slot4.filterType = slot2
	slot5 = CritterConfig.instance:getCritterFilterTypeCfg(slot2, true)
	gohelper.findChildText(slot4.go, "title/dmgTypeCn").text = slot5.name
	gohelper.findChildText(slot4.go, "title/dmgTypeCn/dmgTypeEn").text = slot5.nameEn
	slot8 = gohelper.findChild(slot4.go, "layout")

	gohelper.setActive(gohelper.findChild(slot4.go, "layout/#go_tabItem1"), false)
	gohelper.setActive(gohelper.findChild(slot4.go, "layout/#go_tabItem2"), false)

	slot4.tagItemDict = {}

	for slot15, slot16 in ipairs(CritterConfig.instance:getCritterTabDataList(slot4.filterType)) do
		slot17 = slot16.filterTab
		slot18 = slot9

		if not string.nilorempty(slot16.icon) then
			slot18 = slot10
		end

		slot4.tagItemDict[slot17] = slot0:getTagItem(slot16, gohelper.clone(slot18, slot8, slot17), slot4.filterType)
	end

	slot0.filterCategoryItemDict[slot2] = slot4
end

function slot0.getTagItem(slot0, slot1, slot2, slot3)
	slot4 = slot1.name
	slot6 = slot0:getUserDataTb_()
	slot6.go = slot2
	slot6.tagId = slot1.filterTab
	slot6.filterType = slot3
	slot6.gounselected = gohelper.findChild(slot6.go, "unselected")
	slot6.goselected = gohelper.findChild(slot6.go, "selected")
	slot6.btnClick = gohelper.findChildClickWithAudio(slot6.go, "click", AudioEnum.UI.UI_Common_Click)

	slot6.btnClick:AddClickListener(slot0.onClickTagItem, slot0, slot6)

	gohelper.findChildText(slot6.go, "unselected/info1").text = slot4
	gohelper.findChildText(slot6.go, "selected/info2").text = slot4

	if not string.nilorempty(slot1.icon) then
		UISpriteSetMgr.instance:setCritterSprite(gohelper.findChildImage(slot6.go, "unselected/#image_icon"), slot5)
		UISpriteSetMgr.instance:setCritterSprite(gohelper.findChildImage(slot6.go, "selected/#image_icon"), slot5)
	end

	gohelper.setActive(slot6.go, true)

	return slot6
end

function slot0.refresh(slot0)
	for slot4, slot5 in pairs(slot0.filterCategoryItemDict) do
		for slot9, slot10 in pairs(slot5.tagItemDict) do
			slot0:refreshTag(slot10)
		end
	end
end

function slot0.refreshTag(slot0, slot1)
	slot4 = slot0:isSelectTag(slot1.filterType, slot1.tagId)

	gohelper.setActive(slot1.goselected, slot4)
	gohelper.setActive(slot1.gounselected, not slot4)
end

function slot0.isSelectTag(slot0, slot1, slot2)
	return slot0.filterMO:isSelectedTag(slot1, slot2)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
