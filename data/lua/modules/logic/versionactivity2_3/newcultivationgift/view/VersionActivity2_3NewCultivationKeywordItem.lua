module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationKeywordItem", package.seeall)

local var_0_0 = class("VersionActivity2_3NewCultivationKeywordItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goKeyword = gohelper.findChild(arg_1_1, "#go_keyword")
	arg_1_0._keywordTxtItemList = arg_1_0:getUserDataTb_()
	arg_1_0._keywordParentGoList = arg_1_0:getUserDataTb_()

	arg_1_0:addKeyWordItem(arg_1_0._goKeyword)
end

function var_0_0.addKeyWordItem(arg_2_0, arg_2_1)
	table.insert(arg_2_0._keywordParentGoList, arg_2_1)

	local var_2_0 = gohelper.findChildText(arg_2_1, "#txt_tag")

	table.insert(arg_2_0._keywordTxtItemList, var_2_0)
end

function var_0_0.refreshKeyword(arg_3_0, arg_3_1)
	local var_3_0 = string.nilorempty(arg_3_1)

	gohelper.setActive(arg_3_0.go, not var_3_0)

	if var_3_0 then
		return
	end

	local var_3_1 = string.split(arg_3_1, "#")

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		local var_3_2

		if not arg_3_0._keywordParentGoList[iter_3_0] then
			var_3_2 = gohelper.clone(arg_3_0._goKeyword, arg_3_0.go, tostring(iter_3_0))

			arg_3_0:addKeyWordItem(var_3_2)
		else
			var_3_2 = arg_3_0._keywordParentGoList[iter_3_0]
		end

		gohelper.setActive(var_3_2, true)

		arg_3_0._keywordTxtItemList[iter_3_0].text = iter_3_1
	end

	local var_3_3 = #arg_3_0._keywordParentGoList
	local var_3_4 = #var_3_1

	if var_3_4 < var_3_3 then
		for iter_3_2 = var_3_4 + 1, var_3_3 do
			gohelper.setActive(arg_3_0._keywordParentGoList[iter_3_2], false)
		end
	end
end

function var_0_0.onDestroy(arg_4_0)
	arg_4_0._keywordParentGoList = nil
	arg_4_0._keywordTxtItemList = nil
end

return var_0_0
