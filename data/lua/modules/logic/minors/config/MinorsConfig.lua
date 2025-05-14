module("modules.logic.minors.config.MinorsConfig", package.seeall)

local var_0_0 = class("MinorsConfig", BaseConfig)

var_0_0.DateCmpType = {
	Day = 3,
	Month = 2,
	Year = 1
}

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"const"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	return
end

function var_0_0.getDateOfBirthSelectionViewStartYear(arg_4_0)
	return tonumber(CommonConfig.instance:getConstStr(ConstEnum.dateOfBirthSelectionViewStartYear)) or 1970
end

var_0_0.instance = var_0_0.New()

return var_0_0
