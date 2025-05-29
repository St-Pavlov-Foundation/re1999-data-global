module("modules.logic.reactivity.define.ReactivityEnum", package.seeall)

local var_0_0 = _M

var_0_0.ActivityDefine = {
	[VersionActivity2_6Enum.ActivityId.Reactivity] = {
		storeCurrency = CurrencyEnum.CurrencyType.V1a8Dungeon,
		storeActId = VersionActivity2_6Enum.ActivityId.ReactivityStore
	},
	[VersionActivity2_5Enum.ActivityId.Reactivity] = {
		storeCurrency = CurrencyEnum.CurrencyType.V1a6Dungeon,
		storeActId = VersionActivity2_5Enum.ActivityId.ReactivityStore
	}
}

return var_0_0
