module("modules.logic.survival.view.map.comp.SurvivalEquipBtnComp", package.seeall)

local var_0_0 = class("SurvivalEquipBtnComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._gohas = gohelper.findChild(arg_1_1, "#go_icon/#go_Has")
	arg_1_0._goempty = gohelper.findChild(arg_1_1, "#go_icon/#go_Empty")
	arg_1_0._imageIcon = gohelper.findChildSingleImage(arg_1_1, "#go_icon/#go_Has/image_icon")
	arg_1_0._golevel32 = gohelper.findChild(arg_1_1, "#go_icon/#go_Has/#level3_2")
	arg_1_0._golevel1 = gohelper.findChild(arg_1_1, "#go_icon/#go_Has/#level1")
	arg_1_0._golevel2 = gohelper.findChild(arg_1_1, "#go_icon/#go_Has/#level2")
	arg_1_0._golevel3 = gohelper.findChild(arg_1_1, "#go_icon/#go_Has/#level3")
	arg_1_0._txtplan = gohelper.findChildTextMesh(arg_1_1, "#txt_index")
	arg_1_0._gored = gohelper.findChild(arg_1_1, "go_arrow")

	arg_1_0:_refreshView()
end

function var_0_0.addEventListeners(arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEquipInfoUpdate, arg_2_0._refreshView, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEquipRedUpdate, arg_2_0._refreshView, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEquipInfoUpdate, arg_3_0._refreshView, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEquipRedUpdate, arg_3_0._refreshView, arg_3_0)
end

function var_0_0._refreshView(arg_4_0)
	local var_4_0 = SurvivalShelterModel.instance:getWeekInfo().equipBox
	local var_4_1 = lua_survival_equip_found.configDict[var_4_0.maxTagId]
	local var_4_2 = var_4_1 and var_4_1.icon

	gohelper.setActive(arg_4_0._goempty, not var_4_1)
	gohelper.setActive(arg_4_0._gohas, var_4_1)

	if var_4_1 then
		local var_4_3 = 0
		local var_4_4 = var_4_0.values[var_4_1.value] or 0
		local var_4_5 = string.splitToNumber(var_4_1.level, "#") or {}

		for iter_4_0, iter_4_1 in ipairs(var_4_5) do
			if iter_4_1 <= var_4_4 then
				var_4_3 = iter_4_0
			end
		end

		arg_4_0._imageIcon:LoadImage(ResUrl.getSurvivalEquipIcon(var_4_2))
		gohelper.setActive(arg_4_0._golevel32, var_4_3 == 3)
		gohelper.setActive(arg_4_0._golevel1, var_4_3 == 1)
		gohelper.setActive(arg_4_0._golevel2, var_4_3 == 2)
		gohelper.setActive(arg_4_0._golevel3, var_4_3 == 3)
	end

	arg_4_0._txtplan.text = string.format("%02d", var_4_0.currPlanId)

	gohelper.setActive(arg_4_0._gored, SurvivalEquipRedDotHelper.instance.reddotType >= 0)
end

return var_0_0
