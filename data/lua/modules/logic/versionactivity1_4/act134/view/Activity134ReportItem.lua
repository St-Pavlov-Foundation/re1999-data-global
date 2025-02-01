module("modules.logic.versionactivity1_4.act134.view.Activity134ReportItem", package.seeall)

slot0 = class("Activity134ReportItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2)
	slot0.template = slot1
	slot0.viewGO = slot2

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onDestroy(slot0)
	for slot4, slot5 in ipairs(slot0.charaterIcon) do
		slot5:UnLoadImage()
	end
end

function slot0.initMo(slot0, slot1, slot2)
	slot0.index = slot1
	slot0.mo = slot2
	slot0.typeList = {}
	slot0.charaterIcon = {}

	for slot7, slot8 in ipairs(slot2.desc) do
		gohelper.setActive(gohelper.clone(slot0.template, slot0.viewGO, slot7).gameObject, true)

		if slot2.storyType == 1 then
			slot0:setItemOneType(slot8, slot9)
		elseif slot3 == 2 then
			slot0:setItemTwoType(slot8, slot9)
		elseif slot3 == 3 then
			slot0:setItemThreeType(slot8, slot9)
		else
			slot0:setItemFourType(slot8, slot9)
		end
	end
end

function slot0.setItemOneType(slot0, slot1, slot2)
	slot3 = gohelper.findChildSingleImage(slot2, "bg/#simage_role")
	slot4 = gohelper.findChildText(slot2, "right/#txt_title")
	slot5 = gohelper.findChildText(slot2, "right/#txt_dec")

	if not string.nilorempty(slot1.charaterIcon) then
		slot3:LoadImage(ResUrl.getV1a4DustRecordsIcon(string.format("v1a4_dustyrecords_role_" .. slot1.charaterIcon)))
		table.insert(slot0.charaterIcon, slot3)
	end

	if #string.split(slot1.desc, "<split>") > 1 then
		slot4.text = slot6[1]
		slot5.text = slot6[2]
	end
end

function slot0.setItemTwoType(slot0, slot1, slot2)
	gohelper.findChildText(slot2, "bg/#txt_dec").text = slot1.desc
	gohelper.findChildText(slot2, "bg/#txt_name").text = slot1.formMan and slot1.formMan or ""
end

function slot0.setItemThreeType(slot0, slot1, slot2)
	gohelper.findChildText(slot2, "#txt_dec").text = slot1.desc
end

function slot0.setItemFourType(slot0, slot1, slot2)
	gohelper.findChildText(slot2, "#txt_dec").text = slot1.desc
end

return slot0
