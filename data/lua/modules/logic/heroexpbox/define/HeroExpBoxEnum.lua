-- chunkname: @modules/logic/heroexpbox/define/HeroExpBoxEnum.lua

module("modules.logic.heroexpbox.define.HeroExpBoxEnum", package.seeall)

local HeroExpBoxEnum = _M

HeroExpBoxEnum.ItemSubType = {
	ItemEnum.SubType.HeroExpBox,
	ItemEnum.SubType.HeroExpBoxKey,
	ItemEnum.SubType.HeroExpBoxCurrency
}
HeroExpBoxEnum.BoxIds = {
	793401,
	793402
}
HeroExpBoxEnum.KeyIds = {
	770001,
	770002
}
HeroExpBoxEnum.CurrencyId = 780001
HeroExpBoxEnum.HeroStatus = {
	EnoughHeroItem = 3,
	MAX = 4,
	Lock = 1,
	Normal = 2
}

return HeroExpBoxEnum
