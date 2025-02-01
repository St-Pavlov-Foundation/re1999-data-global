module("modules.logic.minors.config.MinorsConfig", package.seeall)

slot0 = class("MinorsConfig", BaseConfig)
slot0.DateCmpType = {
	Day = 3,
	Month = 2,
	Year = 1
}

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"const"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
end

function slot0.getDateOfBirthSelectionViewStartYear(slot0)
	return tonumber(CommonConfig.instance:getConstStr(ConstEnum.dateOfBirthSelectionViewStartYear)) or 1970
end

slot0.instance = slot0.New()

return slot0
