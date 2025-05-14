﻿module("modules.logic.fight.entity.comp.FightNameUIExPointItem", package.seeall)

local var_0_0 = class("FightNameUIExPointItem", FightNameUIExPointBaseItem)

function var_0_0.GetExPointItem(arg_1_0)
	local var_1_0 = var_0_0.New()

	var_1_0:init(arg_1_0)

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)

	arg_2_0.goFull2 = gohelper.findChild(arg_2_0.exPointGo, "full2")
	arg_2_0.imageFull2 = arg_2_0.goFull2:GetComponent(gohelper.Type_Image)
end

function var_0_0.resetToEmpty(arg_3_0)
	var_0_0.super.resetToEmpty(arg_3_0)
	gohelper.setActive(arg_3_0.goFull2, false)

	arg_3_0.imageFull2.color = Color.white
end

function var_0_0.directSetStoredState(arg_4_0, arg_4_1)
	var_0_0.super.directSetStoredState(arg_4_0)
	gohelper.setActive(arg_4_0.goFull2, true)
end

function var_0_0.switchToStoredState(arg_5_0, arg_5_1)
	var_0_0.super.switchToStoredState(arg_5_0)
	gohelper.setActive(arg_5_0.goFull2, true)
end

return var_0_0
