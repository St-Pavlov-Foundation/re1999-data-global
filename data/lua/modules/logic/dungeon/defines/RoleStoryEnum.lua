module("modules.logic.dungeon.defines.RoleStoryEnum", package.seeall)

local var_0_0 = _M

var_0_0.DispatchType = {
	Normal = 2,
	Story = 1
}
var_0_0.TalkType = {
	Special = 2,
	Normal = 1
}
var_0_0.DispatchState = {
	Locked = 5,
	Canget = 4,
	Finish = 1,
	Dispatching = 2,
	Normal = 3
}
var_0_0.EffectConditionType = {
	Career = 2,
	Heros = 1
}

return var_0_0
