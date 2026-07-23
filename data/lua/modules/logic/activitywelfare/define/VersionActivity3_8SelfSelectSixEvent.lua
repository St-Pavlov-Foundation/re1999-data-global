-- chunkname: @modules/logic/activitywelfare/define/VersionActivity3_8SelfSelectSixEvent.lua

module("modules.logic.activitywelfare.define.VersionActivity3_8SelfSelectSixEvent", package.seeall)

local VersionActivity3_8SelfSelectSixEvent = _M

VersionActivity3_8SelfSelectSixEvent.onPreviewSelectHero = GameUtil.getUniqueTb()
VersionActivity3_8SelfSelectSixEvent.onChoiceHeroChanged = GameUtil.getUniqueTb()

return VersionActivity3_8SelfSelectSixEvent
