module("modules.logic.room.entity.RoomMapTransportPathEntity", package.seeall)

local var_0_0 = class("RoomMapTransportPathEntity", RoomBaseEntity)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0.id = arg_1_1
	arg_1_0.entityId = arg_1_0.id
end

function var_0_0.getTag(arg_2_0)
	return SceneTag.Untagged
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.containerGO = gohelper.create3d(arg_3_1, RoomEnum.EntityChildKey.ContainerGOKey)
	arg_3_0.staticContainerGO = gohelper.create3d(arg_3_1, RoomEnum.EntityChildKey.StaticContainerGOKey)
	arg_3_0.goTrs = arg_3_1.transform

	var_0_0.super.init(arg_3_0, arg_3_1)
end

function var_0_0.initComponents(arg_4_0)
	arg_4_0:addComp("effect", RoomEffectComp)
end

function var_0_0.onStart(arg_5_0)
	var_0_0.super.onStart(arg_5_0)
end

function var_0_0.setLocalPos(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	transformhelper.setLocalPos(arg_6_0.goTrs, arg_6_1, arg_6_2, arg_6_3)
end

function var_0_0.getMO(arg_7_0)
	return nil
end

function var_0_0._refreshCanPlaceEffect(arg_8_0)
	local var_8_0 = arg_8_0:_isCanShowPlaceEffect()
	local var_8_1 = RoomMapBlockModel.instance
	local var_8_2
	local var_8_3
	local var_8_4 = arg_8_0.entity.effect
	local var_8_5 = RoomMapTransportPathModel.instance:getTempTransportPathMO():getHexPointList()

	for iter_8_0, iter_8_1 in ipairs(var_8_5) do
		local var_8_6 = arg_8_0:getEffectKeyById(iter_8_0)

		if var_8_0 and arg_8_0:_checkByXY(iter_8_1.x, iter_8_1.y, var_8_1) then
			if not var_8_4:isHasKey(var_8_6) then
				if var_8_2 == nil then
					var_8_2 = {}
				end

				local var_8_7 = HexMath.hexToPosition(iter_8_1, RoomBlockEnum.BlockSize)

				var_8_2[var_8_6] = {
					res = RoomScenePreloader.ResEffectD03,
					localPos = Vector3(var_8_7.x, -0.12, var_8_7.y)
				}
			end
		elseif var_8_4:getEffectRes(var_8_6) then
			if var_8_3 == nil then
				var_8_3 = {}
			end

			table.insert(var_8_3, var_8_6)
		end
	end

	if var_8_2 then
		var_8_4:addParams(var_8_2)
		var_8_4:refreshEffect()
	end

	if var_8_3 then
		arg_8_0:removeParamsAndPlayAnimator(var_8_3, "close", RoomBlockEnum.PlaceEffectAnimatorCloseTime)
	end
end

return var_0_0
