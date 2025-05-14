module("modules.logic.room.entity.comp.RoomBuildingInteractComp", package.seeall)

local var_0_0 = class("RoomBuildingInteractComp", RoomBaseEffectKeyComp)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0.entity = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
end

function var_0_0.addEventListeners(arg_3_0)
	return
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0.beforeDestroy(arg_5_0)
	arg_5_0:removeEventListeners()
end

function var_0_0.onRebuildEffectGO(arg_6_0)
	return
end

function var_0_0.onReturnEffectGO(arg_7_0)
	return
end

function var_0_0.startInteract(arg_8_0)
	local var_8_0 = arg_8_0.entity:getMO()

	if not var_8_0 then
		return
	end

	local var_8_1 = var_8_0:getInteractMO()

	if not var_8_1 then
		return
	end

	local var_8_2 = var_8_1:getHeroIdList()
	local var_8_3 = RoomCameraController.instance:getRoomScene()

	if not var_8_3 then
		return
	end

	for iter_8_0, iter_8_1 in ipairs(var_8_2) do
		local var_8_4 = var_8_3.charactermgr:getCharacterEntity(iter_8_1, SceneTag.RoomCharacter)

		if var_8_4 and var_8_4.interactActionComp then
			var_8_4.interactActionComp:startInteract(var_8_0.buildingUid, iter_8_0, var_8_1.config.showTime * 0.001)
		end
	end

	if var_8_1.config and not string.nilorempty(var_8_1.config.buildingAnim) then
		arg_8_0.entity:playAnimator(var_8_1.config.buildingAnim)
	end
end

function var_0_0.getPointGOByName(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.entity.effect:getGameObjectsByName(arg_9_0._effectKey, arg_9_1)

	if var_9_0 and #var_9_0 > 0 then
		return var_9_0[1]
	end
end

function var_0_0.getPointGOTrsByName(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.entity.effect:getGameObjectsTrsByName(arg_10_0._effectKey, arg_10_1)

	if var_10_0 and #var_10_0 > 0 then
		return var_10_0[1]
	end
end

return var_0_0
