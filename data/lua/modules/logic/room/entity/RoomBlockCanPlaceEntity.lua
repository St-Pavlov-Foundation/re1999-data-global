module("modules.logic.room.entity.RoomBlockCanPlaceEntity", package.seeall)

local var_0_0 = class("RoomBlockCanPlaceEntity", RoomBaseEntity)

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
	arg_4_0:addComp("placeBuildingEffectComp", RoomPlaceBuildingEffectComp)
	arg_4_0:addComp("placeBlockEffectComp", RoomPlaceBlockEffectComp)
	arg_4_0:addComp("transportPathLinkEffectComp", RoomTransportPathLinkEffectComp)
	arg_4_0:addComp("transportPathEffectComp", RoomTransportPathEffectComp)
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

return var_0_0
