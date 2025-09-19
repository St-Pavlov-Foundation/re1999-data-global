module("modules.logic.survival.view.map.comp.SurvivalFightUIItem", package.seeall)

local var_0_0 = class("SurvivalFightUIItem", SurvivalUnitUIItem)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._fightArrow = gohelper.findChild(arg_1_1, "#go_canSkip")

	var_0_0.super.init(arg_1_0, arg_1_1)
end

function var_0_0.addEventListeners(arg_2_0)
	var_0_0.super.addEventListeners(arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnAttrUpdate, arg_2_0.refreshInfo, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	var_0_0.super.removeEventListeners(arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnAttrUpdate, arg_3_0.refreshInfo, arg_3_0)
end

function var_0_0.refreshInfo(arg_4_0)
	var_0_0.super.refreshInfo(arg_4_0)

	if arg_4_0._unitMo.visionVal == 8 then
		gohelper.setActive(arg_4_0._fightArrow, false)

		return
	end

	gohelper.setActive(arg_4_0._golevel, true)

	arg_4_0._txtlevel.text = "LV." .. arg_4_0._unitMo.co.fightLevel

	local var_4_0 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.HeroFightLevel)
	local var_4_1 = arg_4_0._unitMo.co.fightLevel

	gohelper.setActive(arg_4_0._fightArrow, var_4_1 <= var_4_0 and arg_4_0._unitMo.co.skip == 1)
	arg_4_0:updateIconAndBg()
end

return var_0_0
