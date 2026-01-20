-- chunkname: @modules/logic/minors/config/MinorsConfig.lua

module("modules.logic.minors.config.MinorsConfig", package.seeall)

local MinorsConfig = class("MinorsConfig", BaseConfig)

MinorsConfig.DateCmpType = {
	Day = 3,
	Month = 2,
	Year = 1
}

function MinorsConfig:ctor()
	return
end

function MinorsConfig:reqConfigNames()
	return {
		"const"
	}
end

function MinorsConfig:onConfigLoaded(configName, configTable)
	return
end

function MinorsConfig:getDateOfBirthSelectionViewStartYear()
	return tonumber(CommonConfig.instance:getConstStr(ConstEnum.dateOfBirthSelectionViewStartYear)) or 1970
end

MinorsConfig.instance = MinorsConfig.New()

return MinorsConfig
