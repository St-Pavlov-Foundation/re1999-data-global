module("modules.logic.survival.view.map.comp.SurvivalShowBagInfoPart", package.seeall)

local var_0_0 = class("SurvivalShowBagInfoPart", SurvivalBagInfoPart)

function var_0_0._onSelectClick(arg_1_0)
	SurvivalShelterChooseEquipListModel.instance:setSelectIdToPos(arg_1_0.mo.id)
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)

	local var_2_0 = gohelper.findChild(arg_2_1, "root/#go_info/Frequency")

	gohelper.setActive(var_2_0, false)
end

function var_0_0.updateBaseInfo(arg_3_0)
	var_0_0.super.updateBaseInfo(arg_3_0)
	gohelper.setActive(arg_3_0._btnselect, arg_3_0._showUseBtn)
	arg_3_0:_refreshUseState()
end

function var_0_0._onUnEquipClick(arg_4_0)
	SurvivalShelterChooseEquipListModel.instance:setSelectIdToPos(nil)
end

function var_0_0._refreshUseState(arg_5_0)
	local var_5_0 = SurvivalShelterChooseEquipListModel.instance:getSelectIdByPos(1)

	gohelper.setActive(arg_5_0._btnselect, var_5_0 == nil or var_5_0 ~= arg_5_0.mo.id)
	gohelper.setActive(arg_5_0._btnunequip, var_5_0 ~= nil and var_5_0 == arg_5_0.mo.id)
end

return var_0_0
