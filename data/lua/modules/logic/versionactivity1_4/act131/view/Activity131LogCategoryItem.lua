module("modules.logic.versionactivity1_4.act131.view.Activity131LogCategoryItem", package.seeall)

slot0 = class("Activity131LogCategoryItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._btnCategory = gohelper.findChildButtonWithAudio(slot1, "btnclick")
	slot0.goSelected = gohelper.findChild(slot1, "beselected")
	slot0.goUnSelected = gohelper.findChild(slot1, "unselected")
	slot0.txtTitleS = gohelper.findChildTextMesh(slot1, "beselected/chapternamecn")
	slot0.txtTitleUS = gohelper.findChildTextMesh(slot1, "unselected/chapternamecn")
end

function slot0.addEventListeners(slot0)
	slot0._btnCategory:AddClickListener(slot0._onItemClick, slot0)
	slot0:addEventCb(Activity131Controller.instance, Activity131Event.SelectCategory, slot0.onSelectCategory, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnCategory:RemoveClickListener()
	slot0:removeEventCb(Activity131Controller.instance, Activity131Event.SelectCategory, slot0.onSelectCategory, slot0)
end

function slot0.setInfo(slot0, slot1)
	slot0.logType = slot1
	slot2 = string.split(slot1, "_")
	slot3 = Activity131Config.instance:getActivity131DialogCo(tonumber(slot2[1]), tonumber(slot2[2]))
	slot0.txtTitleS.text = slot3.content
	slot0.txtTitleUS.text = slot3.content

	gohelper.setActive(slot0.goSelected, slot0:_isSelected())
	gohelper.setActive(slot0.goUnSelected, not slot0:_isSelected())
end

function slot0.onDestroy(slot0)
end

function slot0._isSelected(slot0)
	return slot0.logType == Activity131Model.instance:getSelectLogType()
end

function slot0._onItemClick(slot0)
	if slot0:_isSelected() then
		return
	end

	Activity131Model.instance:setSelectLogType(slot0.logType)
end

function slot0.onSelectCategory(slot0)
	gohelper.setActive(slot0.goSelected, slot0:_isSelected())
	gohelper.setActive(slot0.goUnSelected, not slot0:_isSelected())
end

return slot0
