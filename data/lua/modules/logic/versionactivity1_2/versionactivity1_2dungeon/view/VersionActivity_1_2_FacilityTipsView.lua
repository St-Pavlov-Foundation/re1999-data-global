module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_FacilityTipsView", package.seeall)

slot0 = class("VersionActivity_1_2_FacilityTipsView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._goroot = gohelper.findChild(slot0.viewGO, "#go_root")
	slot0._scrollinfo = gohelper.findChildScrollRect(slot0.viewGO, "#go_root/area/container/#scroll_info")
	slot0._goinfoitemcontent = gohelper.findChild(slot0.viewGO, "#go_root/area/container/#scroll_info/Viewport/Content")
	slot0._goinfoitem = gohelper.findChild(slot0.viewGO, "#go_root/area/container/#scroll_info/Viewport/Content/#go_infoitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onRefreshViewParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._configList = VersionActivity1_2DungeonModel.instance:getBuildingGainList()

	slot0:com_createObjList(slot0._onItemShow, slot0._configList, slot0._goinfoitemcontent, slot0._goinfoitem)
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	slot5 = gohelper.findChild(slot1, "tips")
	slot6 = gohelper.findChildText(slot1, "tips/txt_info")

	if LangSettings.instance:isEn() then
		gohelper.findChildText(slot1, "txt_title").text = slot2.name
	else
		slot4.text = "【" .. slot2.name .. "】"
	end

	if slot2.buildingType == 2 then
		slot0:com_createObjList(slot0._showType2DesItem, string.split(slot2.configType, "|"), slot5, slot6.gameObject)
	else
		slot0:com_createObjList(slot0._showType3DesItem, string.split(slot2.configType, "|"), slot5, slot6.gameObject)
	end
end

function slot0._showType2DesItem(slot0, slot1, slot2, slot3)
	slot5 = string.splitToNumber(slot2, "#")

	if lua_character_attribute.configDict[slot5[1]].type ~= 1 then
		gohelper.findChildText(slot1, "").text = slot7.name .. " <color=#d65f3c>+" .. tonumber(string.format("%.3f", slot5[2] / 10)) .. "%</color>"
	else
		slot4.text = slot7.name .. " <color=#d65f3c>+" .. math.floor(slot6) .. "</color>"
	end
end

function slot0._showType3DesItem(slot0, slot1, slot2, slot3)
	gohelper.findChildText(slot1, "").text = lua_rule.configDict[string.splitToNumber(slot2, "#")[2]].desc
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
