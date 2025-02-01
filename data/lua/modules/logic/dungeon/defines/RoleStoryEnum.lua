module("modules.logic.dungeon.defines.RoleStoryEnum", package.seeall)

slot0 = _M
slot0.DispatchType = {
	Normal = 2,
	Story = 1
}
slot0.TalkType = {
	Special = 2,
	Normal = 1
}
slot0.DispatchState = {
	Locked = 5,
	Canget = 4,
	Finish = 1,
	Dispatching = 2,
	Normal = 3
}
slot0.EffectConditionType = {
	Career = 2,
	Heros = 1
}

return slot0
