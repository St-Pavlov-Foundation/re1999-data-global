module("modules.logic.room.entity.comp.RoomMapBlockBirthdayComp", package.seeall)

local var_0_0 = class("RoomMapBlockBirthdayComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
end

function var_0_0.addEventListeners(arg_3_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_4_0._onDailyRefresh, arg_4_0)
end

function var_0_0._onDailyRefresh(arg_5_0)
	arg_5_0:refreshBirthday()
end

function var_0_0.onStart(arg_6_0)
	return
end

function var_0_0.refreshBirthday(arg_7_0)
	if arg_7_0.__willDestroy then
		return
	end

	local var_7_0 = arg_7_0.entity:getMO()

	if not (var_7_0 and var_7_0.packageId == RoomBlockPackageEnum.ID.RoleBirthday) then
		return
	end

	if not arg_7_0._birthdayAnimator then
		local var_7_1 = arg_7_0.entity.effect:getGameObjectByPath(RoomEnum.EffectKey.BlockLandKey, RoomEnum.EntityChildKey.BirthdayBlockGOKey)

		if gohelper.isNil(var_7_1) then
			return
		end

		arg_7_0._birthdayAnimator = var_7_1:GetComponent(RoomEnum.ComponentType.Animator)
	end

	if not arg_7_0._birthdayAnimator then
		return
	end

	local var_7_2 = RoomConfig.instance:getSpecialBlockConfig(var_7_0.id)
	local var_7_3 = RoomCharacterModel.instance:isOnBirthday(var_7_2 and var_7_2.heroId) and "v1a9_bxhy_terrain_role_birthday" or "shengri"

	arg_7_0._birthdayAnimator:Play(var_7_3, 0, 0)
end

function var_0_0.beforeDestroy(arg_8_0)
	arg_8_0.__willDestroy = true

	arg_8_0:removeEventListeners()
end

function var_0_0.onDestroy(arg_9_0)
	return
end

return var_0_0
