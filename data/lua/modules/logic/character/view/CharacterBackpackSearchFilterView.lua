module("modules.logic.character.view.CharacterBackpackSearchFilterView", package.seeall)

slot0 = class("CharacterBackpackSearchFilterView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclosefilterview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closefilterview")
	slot0._godmg1 = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg1")
	slot0._godmg2 = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg2")
	slot0._goattr1 = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr1")
	slot0._goattr2 = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr2")
	slot0._goattr3 = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr3")
	slot0._goattr4 = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr4")
	slot0._goattr5 = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr5")
	slot0._goattr6 = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr6")
	slot0._golocation1 = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location1")
	slot0._golocation2 = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location2")
	slot0._golocation3 = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location3")
	slot0._golocation4 = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location4")
	slot0._golocation5 = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location5")
	slot0._golocation6 = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location6")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/#btn_reset")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/#btn_confirm")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclosefilterview:AddClickListener(slot0._btnclosefilterviewOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclosefilterview:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
end

function slot0._btnclosefilterviewOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnresetOnClick(slot0)
	for slot4 = 1, 2 do
		slot0._selectDmgs[slot4] = false
	end

	for slot4 = 1, 6 do
		slot0._selectAttrs[slot4] = false
	end

	for slot4 = 1, 6 do
		slot0._selectLocations[slot4] = false
	end

	slot0:_refreshView()
end

function slot0._btnconfirmOnClick(slot0)
	for slot5 = 1, 2 do
		if slot0._selectDmgs[slot5] then
			table.insert({}, slot5)
		end
	end

	for slot6 = 1, 6 do
		if slot0._selectAttrs[slot6] then
			table.insert({}, slot6)
		end
	end

	for slot7 = 1, 6 do
		if slot0._selectLocations[slot7] then
			table.insert({}, slot7)
		end
	end

	if #slot1 == 0 then
		slot1 = {
			1,
			2
		}
	end

	if #slot2 == 0 then
		slot2 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #slot3 == 0 then
		slot3 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	CharacterModel.instance:filterCardListByDmgAndCareer({
		dmgs = slot1,
		careers = slot2,
		locations = slot3
	}, false, CharacterEnum.FilterType.BackpackHero)
	CharacterController.instance:dispatchEvent(CharacterEvent.FilterBackpack, {
		dmgs = slot0._selectDmgs,
		attrs = slot0._selectAttrs,
		locations = slot0._selectLocations
	})
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._dmgSelects = slot0:getUserDataTb_()
	slot0._dmgUnselects = slot0:getUserDataTb_()
	slot0._dmgBtnClicks = slot0:getUserDataTb_()
	slot0._attrSelects = slot0:getUserDataTb_()
	slot0._attrUnselects = slot0:getUserDataTb_()
	slot0._attrBtnClicks = slot0:getUserDataTb_()
	slot0._locationSelects = slot0:getUserDataTb_()
	slot0._locationUnselects = slot0:getUserDataTb_()
	slot0._locationBtnClicks = slot0:getUserDataTb_()

	for slot4 = 1, 2 do
		slot0._dmgUnselects[slot4] = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. slot4 .. "/unselected")
		slot0._dmgSelects[slot4] = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. slot4 .. "/selected")
		slot0._dmgBtnClicks[slot4] = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. slot4 .. "/click")

		slot0._dmgBtnClicks[slot4]:AddClickListener(slot0._dmgBtnOnClick, slot0, slot4)
	end

	for slot4 = 1, 6 do
		slot0._attrUnselects[slot4] = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. slot4 .. "/unselected")
		slot0._attrSelects[slot4] = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. slot4 .. "/selected")
		slot0._attrBtnClicks[slot4] = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. slot4 .. "/click")

		slot0._attrBtnClicks[slot4]:AddClickListener(slot0._attrBtnOnClick, slot0, slot4)
	end

	for slot4 = 1, 6 do
		slot0._locationUnselects[slot4] = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. slot4 .. "/unselected")
		slot0._locationSelects[slot4] = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. slot4 .. "/selected")
		slot0._locationBtnClicks[slot4] = gohelper.findChildButtonWithAudio(slot0.viewGO, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. slot4 .. "/click")

		slot0._locationBtnClicks[slot4]:AddClickListener(slot0._locationBtnOnClick, slot0, slot4)
	end
end

function slot0._attrBtnOnClick(slot0, slot1)
	slot0._selectAttrs[slot1] = not slot0._selectAttrs[slot1]

	slot0:_refreshView()
end

function slot0._dmgBtnOnClick(slot0, slot1)
	if not slot0._selectDmgs[slot1] then
		slot0._selectDmgs[3 - slot1] = slot0._selectDmgs[slot1]
	end

	slot0._selectDmgs[slot1] = not slot0._selectDmgs[slot1]

	slot0:_refreshView()
end

function slot0._locationBtnOnClick(slot0, slot1)
	slot0._selectLocations[slot1] = not slot0._selectLocations[slot1]

	slot0:_refreshView()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._selectDmgs = slot0.viewParam.dmgs
	slot0._selectAttrs = slot0.viewParam.attrs
	slot0._selectLocations = slot0.viewParam.locations

	slot0:_refreshView()
end

function slot0._refreshView(slot0)
	for slot4 = 1, 2 do
		gohelper.setActive(slot0._dmgUnselects[slot4], not slot0._selectDmgs[slot4])
		gohelper.setActive(slot0._dmgSelects[slot4], slot0._selectDmgs[slot4])
	end

	for slot4 = 1, 6 do
		gohelper.setActive(slot0._attrUnselects[slot4], not slot0._selectAttrs[slot4])
		gohelper.setActive(slot0._attrSelects[slot4], slot0._selectAttrs[slot4])
	end

	for slot4 = 1, 6 do
		gohelper.setActive(slot0._locationUnselects[slot4], not slot0._selectLocations[slot4])
		gohelper.setActive(slot0._locationSelects[slot4], slot0._selectLocations[slot4])
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4 = 1, 2 do
		slot0._dmgBtnClicks[slot4]:RemoveClickListener()
	end

	for slot4 = 1, 6 do
		slot0._attrBtnClicks[slot4]:RemoveClickListener()
	end

	for slot4 = 1, 6 do
		slot0._locationBtnClicks[slot4]:RemoveClickListener()
	end
end

return slot0
