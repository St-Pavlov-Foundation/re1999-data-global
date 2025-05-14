module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_FacilityTipsView", package.seeall)

local var_0_0 = class("VersionActivity_1_2_FacilityTipsView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goroot = gohelper.findChild(arg_1_0.viewGO, "#go_root")
	arg_1_0._scrollinfo = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_root/area/container/#scroll_info")
	arg_1_0._goinfoitemcontent = gohelper.findChild(arg_1_0.viewGO, "#go_root/area/container/#scroll_info/Viewport/Content")
	arg_1_0._goinfoitem = gohelper.findChild(arg_1_0.viewGO, "#go_root/area/container/#scroll_info/Viewport/Content/#go_infoitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onRefreshViewParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._configList = VersionActivity1_2DungeonModel.instance:getBuildingGainList()

	arg_7_0:com_createObjList(arg_7_0._onItemShow, arg_7_0._configList, arg_7_0._goinfoitemcontent, arg_7_0._goinfoitem)
end

function var_0_0._onItemShow(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = gohelper.findChildText(arg_8_1, "txt_title")
	local var_8_1 = gohelper.findChild(arg_8_1, "tips")
	local var_8_2 = gohelper.findChildText(arg_8_1, "tips/txt_info")

	if LangSettings.instance:isEn() then
		var_8_0.text = arg_8_2.name
	else
		var_8_0.text = "【" .. arg_8_2.name .. "】"
	end

	if arg_8_2.buildingType == 2 then
		local var_8_3 = string.split(arg_8_2.configType, "|")

		arg_8_0:com_createObjList(arg_8_0._showType2DesItem, var_8_3, var_8_1, var_8_2.gameObject)
	else
		local var_8_4 = string.split(arg_8_2.configType, "|")

		arg_8_0:com_createObjList(arg_8_0._showType3DesItem, var_8_4, var_8_1, var_8_2.gameObject)
	end
end

function var_0_0._showType2DesItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = gohelper.findChildText(arg_9_1, "")
	local var_9_1 = string.splitToNumber(arg_9_2, "#")
	local var_9_2 = var_9_1[2]
	local var_9_3 = lua_character_attribute.configDict[var_9_1[1]]

	if var_9_3.type ~= 1 then
		var_9_0.text = var_9_3.name .. " <color=#d65f3c>+" .. tonumber(string.format("%.3f", var_9_2 / 10)) .. "%</color>"
	else
		var_9_0.text = var_9_3.name .. " <color=#d65f3c>+" .. math.floor(var_9_2) .. "</color>"
	end
end

function var_0_0._showType3DesItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = gohelper.findChildText(arg_10_1, "")
	local var_10_1 = string.splitToNumber(arg_10_2, "#")

	var_10_0.text = lua_rule.configDict[var_10_1[2]].desc
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
