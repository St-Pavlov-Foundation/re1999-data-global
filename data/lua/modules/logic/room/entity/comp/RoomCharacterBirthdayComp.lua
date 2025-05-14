module("modules.logic.room.entity.comp.RoomCharacterBirthdayComp", package.seeall)

local var_0_0 = class("RoomCharacterBirthdayComp", LuaCompBase)
local var_0_1 = 0.1

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.birthdayRes = nil
	arg_2_0.birthdayEffKey = RoomEnum.EffectKey.CharacterBirthdayEffKey
	arg_2_0.goTrs = arg_2_1.transform
	arg_2_0._scene = GameSceneMgr.instance:getCurScene()
end

function var_0_0.addEventListeners(arg_3_0)
	RoomCharacterController.instance:registerCallback(RoomEvent.UpdateCharacterMove, arg_3_0._updateCharacterMove, arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.ConfirmCharacter, arg_3_0.onPlaceCharacter, arg_3_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_3_0._onDailyRefresh, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.UpdateCharacterMove, arg_4_0._updateCharacterMove, arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.ConfirmCharacter, arg_4_0.onPlaceCharacter, arg_4_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_4_0._onDailyRefresh, arg_4_0)
end

function var_0_0._updateCharacterMove(arg_5_0)
	if arg_5_0.entity.isPressing then
		return
	end

	local var_5_0 = arg_5_0.entity:getMO()

	if not var_5_0 then
		return
	end

	if arg_5_0._scene.character:isLock() then
		return
	end

	local var_5_1 = var_5_0:getMoveState()

	if var_5_1 == arg_5_0._lastAnimState then
		return
	end

	arg_5_0._lastAnimState = var_5_1
	arg_5_0._curBlockMO = arg_5_0:_findBlockMO()

	arg_5_0:checkBirthday()
end

function var_0_0.onPlaceCharacter(arg_6_0)
	arg_6_0._curBlockMO = arg_6_0:_findBlockMO()

	arg_6_0:checkBirthday()
end

function var_0_0._findBlockMO(arg_7_0)
	if arg_7_0.__willDestroy then
		return
	end

	if arg_7_0.goTrs then
		local var_7_0, var_7_1, var_7_2 = transformhelper.getPos(arg_7_0.goTrs)
		local var_7_3 = Vector2(var_7_0, var_7_2)
		local var_7_4 = HexMath.positionToRoundHex(var_7_3, RoomBlockEnum.BlockSize)

		return RoomMapBlockModel.instance:getBlockMO(var_7_4.x, var_7_4.y)
	end
end

function var_0_0._onDailyRefresh(arg_8_0)
	if arg_8_0.__willDestroy then
		return
	end

	local var_8_0 = arg_8_0.entity:getMO()

	if not var_8_0 then
		return
	end

	if not RoomCharacterModel.instance:isOnBirthday(var_8_0.id) then
		var_8_0:replaceIdleState()
	end
end

function var_0_0.onStart(arg_9_0)
	return
end

function var_0_0.onEffectRebuild(arg_10_0)
	local var_10_0 = arg_10_0.entity.effect

	if not var_10_0:isHasEffectGOByKey(arg_10_0.birthdayEffKey) then
		return
	end

	local var_10_1 = var_10_0:getEffectGO(arg_10_0.birthdayEffKey)

	arg_10_0:setEffGoDict(var_10_1)

	if arg_10_0.tmpMeetingYear then
		arg_10_0:playBirthdayFirework(arg_10_0.tmpMeetingYear)

		arg_10_0.tmpMeetingYear = nil
	end
end

function var_0_0.setEffGoDict(arg_11_0, arg_11_1)
	arg_11_0.effGoDict = {}

	if gohelper.isNil(arg_11_1) then
		return
	end

	local var_11_0 = gohelper.findChild(arg_11_1, "root").transform
	local var_11_1 = var_11_0.childCount

	for iter_11_0 = 1, var_11_1 do
		local var_11_2 = var_11_0:GetChild(iter_11_0 - 1)
		local var_11_3 = var_11_2.name
		local var_11_4 = tonumber(var_11_3)

		if not string.nilorempty(var_11_4) then
			local var_11_5 = var_11_2.gameObject

			arg_11_0.effGoDict[var_11_4] = var_11_5

			gohelper.setActive(var_11_5, false)
		end
	end
end

function var_0_0.checkBirthday(arg_12_0)
	if arg_12_0.__willDestroy then
		return
	end

	local var_12_0 = arg_12_0.entity:getMO()
	local var_12_1 = RoomCharacterModel.instance:isOnBirthday(var_12_0.id)
	local var_12_2

	if var_12_1 and arg_12_0:_isSelfBirthdayBlock(arg_12_0._curBlockMO, var_12_0.heroId) then
		local var_12_3 = HeroModel.instance:getByHeroId(var_12_0.id)

		if var_12_3 then
			local var_12_4 = var_12_3:getMeetingYear()

			arg_12_0:playBirthdayFirework(var_12_4)

			var_12_2 = RoomCharacterEnum.CharacterMoveState.BirthdayIdle
		end
	end

	var_12_0:replaceIdleState(var_12_2)
end

function var_0_0._isSelfBirthdayBlock(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_1 or arg_13_1:getDefineId() ~= arg_13_1:getDefineId(true) then
		return false
	end

	local var_13_0 = RoomConfig.instance:getSpecialBlockConfig(arg_13_1.blockId)

	return var_13_0 and var_13_0.heroId == arg_13_2
end

function var_0_0.playBirthdayFirework(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	arg_14_1 = math.max(1, arg_14_1)

	if not arg_14_0.effGoDict then
		arg_14_0:initEffect()

		arg_14_0.tmpMeetingYear = arg_14_1

		return
	end

	for iter_14_0, iter_14_1 in pairs(arg_14_0.effGoDict) do
		gohelper.setActive(iter_14_1, false)

		if iter_14_0 == arg_14_1 then
			gohelper.setActive(iter_14_1, true)
		end
	end
end

function var_0_0.initEffect(arg_15_0)
	local var_15_0 = arg_15_0.entity.effect

	if var_15_0:isHasEffectGOByKey(arg_15_0.birthdayEffKey) then
		local var_15_1 = var_15_0:getEffectGO(arg_15_0.birthdayEffKey)

		arg_15_0:setEffGoDict(var_15_1)
	else
		local var_15_2 = Vector3.one * var_0_1

		var_15_0:addParams({
			[arg_15_0.birthdayEffKey] = {
				res = RoomScenePreloader.RecCharacterBirthdayEffect,
				localScale = var_15_2
			}
		})
	end

	var_15_0:refreshEffect()
end

function var_0_0.beforeDestroy(arg_16_0)
	arg_16_0.tmpMeetingYear = nil
	arg_16_0.__willDestroy = true

	arg_16_0:removeEventListeners()
end

function var_0_0.onDestroy(arg_17_0)
	arg_17_0.effGoDict = nil
end

return var_0_0
