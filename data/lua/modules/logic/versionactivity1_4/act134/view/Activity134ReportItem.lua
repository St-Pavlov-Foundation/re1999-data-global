module("modules.logic.versionactivity1_4.act134.view.Activity134ReportItem", package.seeall)

local var_0_0 = class("Activity134ReportItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.template = arg_1_1
	arg_1_0.viewGO = arg_1_2

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	return
end

function var_0_0.onDestroy(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.charaterIcon) do
		iter_7_1:UnLoadImage()
	end
end

function var_0_0.initMo(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.index = arg_8_1
	arg_8_0.mo = arg_8_2
	arg_8_0.typeList = {}

	local var_8_0 = arg_8_2.storyType

	arg_8_0.charaterIcon = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_2.desc) do
		local var_8_1 = gohelper.clone(arg_8_0.template, arg_8_0.viewGO, iter_8_0)

		gohelper.setActive(var_8_1.gameObject, true)

		if var_8_0 == 1 then
			arg_8_0:setItemOneType(iter_8_1, var_8_1)
		elseif var_8_0 == 2 then
			arg_8_0:setItemTwoType(iter_8_1, var_8_1)
		elseif var_8_0 == 3 then
			arg_8_0:setItemThreeType(iter_8_1, var_8_1)
		else
			arg_8_0:setItemFourType(iter_8_1, var_8_1)
		end
	end
end

function var_0_0.setItemOneType(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = gohelper.findChildSingleImage(arg_9_2, "bg/#simage_role")
	local var_9_1 = gohelper.findChildText(arg_9_2, "right/#txt_title")
	local var_9_2 = gohelper.findChildText(arg_9_2, "right/#txt_dec")

	if not string.nilorempty(arg_9_1.charaterIcon) then
		local var_9_3 = string.format("v1a4_dustyrecords_role_" .. arg_9_1.charaterIcon)

		var_9_0:LoadImage(ResUrl.getV1a4DustRecordsIcon(var_9_3))
		table.insert(arg_9_0.charaterIcon, var_9_0)
	end

	local var_9_4 = string.split(arg_9_1.desc, "<split>")

	if #var_9_4 > 1 then
		var_9_1.text = var_9_4[1]
		var_9_2.text = var_9_4[2]
	end
end

function var_0_0.setItemTwoType(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = gohelper.findChildText(arg_10_2, "bg/#txt_dec")
	local var_10_1 = gohelper.findChildText(arg_10_2, "bg/#txt_name")

	var_10_0.text = arg_10_1.desc
	var_10_1.text = arg_10_1.formMan and arg_10_1.formMan or ""
end

function var_0_0.setItemThreeType(arg_11_0, arg_11_1, arg_11_2)
	gohelper.findChildText(arg_11_2, "#txt_dec").text = arg_11_1.desc
end

function var_0_0.setItemFourType(arg_12_0, arg_12_1, arg_12_2)
	gohelper.findChildText(arg_12_2, "#txt_dec").text = arg_12_1.desc
end

return var_0_0
