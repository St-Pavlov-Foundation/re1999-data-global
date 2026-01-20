-- chunkname: @modules/logic/reactivity/define/ReactivityEnum.lua

module("modules.logic.reactivity.define.ReactivityEnum", package.seeall)

local ReactivityEnum = _M

ReactivityEnum.ActivityDefine = {
	[VersionActivity3_1Enum.ActivityId.Reactivity] = {
		storeCurrency = CurrencyEnum.CurrencyType.V2a4Dungeon,
		storeActId = VersionActivity3_1Enum.ActivityId.ReactivityStore
	}
}

if SettingsModel.instance:isOverseas() then
	if GameBranchMgr.instance:isOnVer(2, 6) then
		ReactivityEnum.ActivityDefine = {
			[VersionActivity2_6Enum.ActivityId.Reactivity] = {
				storeCurrency = CurrencyEnum.CurrencyType.V1a8Dungeon,
				storeActId = VersionActivity2_6Enum.ActivityId.ReactivityStore
			}
		}
	elseif GameBranchMgr.instance:isOnVer(2, 9) then
		ReactivityEnum.ActivityDefine = {
			[VersionActivity3_0Enum.ActivityId.Reactivity] = {
				storeCurrency = CurrencyEnum.CurrencyType.V2a1Dungeon,
				storeActId = VersionActivity3_0Enum.ActivityId.ReactivityStore
			}
		}
	elseif GameBranchMgr.instance:isOnVer(3, 0) then
		ReactivityEnum.ActivityDefine = {
			[VersionActivity2_9Enum.ActivityId.Reactivity] = {
				storeCurrency = CurrencyEnum.CurrencyType.V2a3Dungeon,
				storeActId = VersionActivity2_9Enum.ActivityId.ReactivityStore
			}
		}
	end
end

return ReactivityEnum
