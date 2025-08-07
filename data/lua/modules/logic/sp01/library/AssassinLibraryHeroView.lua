module("modules.logic.sp01.library.AssassinLibraryHeroView", package.seeall)

local var_0_0 = class("AssassinLibraryHeroView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goherocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_herocontainer")
	arg_1_0._goinfocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_infocontainer")
	arg_1_0._goinfoitem = gohelper.findChild(arg_1_0.viewGO, "#go_infoitem")

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
	arg_4_0._infoItemTab = arg_4_0:getUserDataTb_()

	gohelper.setActive(arg_4_0._goinfoitem, false)
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:init()
	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._libraryCoList) do
		local var_7_1 = arg_7_0:_getOrCreateInfoItem(iter_7_0)

		var_7_1:onUpdateMO(iter_7_1)

		var_7_0[var_7_1] = true
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_0._infoItemTab) do
		if not var_7_0[iter_7_3] then
			iter_7_3:setIsUsing(false)
		end
	end

	local var_7_2 = AssassinLibraryModel.instance:isUnlockAllLibrarys(arg_7_0._actId, arg_7_0._libType)

	gohelper.setActive(arg_7_0._goall, var_7_2)
	gohelper.setActive(arg_7_0._goempty, not var_7_2)
end

function var_0_0._getOrCreateInfoItem(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._infoItemTab[arg_8_1]
	local var_8_1 = gohelper.findChild(arg_8_0._goheroes, "go_pos" .. arg_8_1)
	local var_8_2 = gohelper.findChild(arg_8_0._goinfos, "go_pos" .. arg_8_1)

	if not var_8_0 then
		local var_8_3 = gohelper.clone(arg_8_0._goinfoitem, var_8_2, "item_" .. arg_8_1)

		if gohelper.isNil(var_8_2) or gohelper.isNil(var_8_1) then
			logError(string.format("缺少挂点 index = %s", arg_8_1))
		end

		var_8_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_3, AssassinLibraryHeroInfoItem)
		arg_8_0._infoItemTab[arg_8_1] = var_8_0
	end

	var_8_0:initRoot(var_8_2)
	var_8_0:initBody(var_8_1)

	return var_8_0
end

function var_0_0.init(arg_9_0)
	arg_9_0._actId = AssassinLibraryModel.instance:getCurActId()
	arg_9_0._libType = AssassinLibraryModel.instance:getCurLibType()
	arg_9_0._libraryCoList = AssassinConfig.instance:getLibraryConfigs(arg_9_0._actId, arg_9_0._libType)
	arg_9_0._goheroes = arg_9_0:_getAndActiveTargetGo(arg_9_0._goherocontainer, tostring(arg_9_0._actId))
	arg_9_0._goinfos = arg_9_0:_getAndActiveTargetGo(arg_9_0._goinfocontainer, tostring(arg_9_0._actId))
	arg_9_0._goall = gohelper.findChild(arg_9_0._goheroes, "#go_All")
	arg_9_0._goempty = gohelper.findChild(arg_9_0._goheroes, "#go_Empty")
end

function var_0_0._getAndActiveTargetGo(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1.transform
	local var_10_1 = var_10_0.childCount
	local var_10_2

	for iter_10_0 = 1, var_10_1 do
		local var_10_3 = var_10_0:GetChild(iter_10_0 - 1).gameObject
		local var_10_4 = var_10_3.name == arg_10_2

		if var_10_4 then
			var_10_2 = var_10_3
		end

		gohelper.setActive(var_10_3, var_10_4)
	end

	if gohelper.isNil(var_10_2) then
		logError(string.format("未找到指定节点 rootGo = %s, targetGoName = %s", arg_10_1.name, arg_10_2))
	end

	return var_10_2
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
