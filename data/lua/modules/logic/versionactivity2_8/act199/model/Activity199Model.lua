module("modules.logic.versionactivity2_8.act199.model.Activity199Model", package.seeall)

local var_0_0 = class("Activity199Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._selectHeroId = 0
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.getActivity199Id(arg_3_0)
	return Activity2ndEnum.ActivityId.welfareActivity
end

function var_0_0.isActivity199Open(arg_4_0)
	local var_4_0 = false
	local var_4_1 = arg_4_0:getActivity199Id()

	if ActivityHelper.isOpen(var_4_1) then
		var_4_0 = true
	end

	return var_4_0
end

function var_0_0.setActInfo(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.heroId

	if var_5_0 then
		arg_5_0._selectHeroId = var_5_0
	end
end

function var_0_0.updateHeroId(arg_6_0, arg_6_1)
	arg_6_0._selectHeroId = arg_6_1
end

function var_0_0.getSelectHeroId(arg_7_0)
	return arg_7_0._selectHeroId
end

function var_0_0.isShowRedDot(arg_8_0)
	return arg_8_0:isActivity199Open() and arg_8_0._selectHeroId == 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
