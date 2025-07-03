module("modules.logic.reactivity.define.ReactivityEnum", package.seeall)

local var_0_0 = _M

var_0_0.ActivityDefine = {
	[VersionActivity2_6Enum.ActivityId.Reactivity] = {
		storeCurrency = CurrencyEnum.CurrencyType.V1a8Dungeon,
		storeActId = VersionActivity2_6Enum.ActivityId.ReactivityStore
	},
	[VersionActivity2_7Enum.ActivityId.Reactivity] = {
		storeCurrency = CurrencyEnum.CurrencyType.V2a0Dungeon,
		storeActId = VersionActivity2_7Enum.ActivityId.ReactivityStore
	}
}

return var_0_0
