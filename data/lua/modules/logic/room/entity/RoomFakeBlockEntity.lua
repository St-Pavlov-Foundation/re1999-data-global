module("modules.logic.room.entity.RoomFakeBlockEntity", package.seeall)

local var_0_0 = class("RoomFakeBlockEntity", RoomBaseBlockEntity)

function var_0_0.getTag(arg_1_0)
	return SceneTag.RoomFakeBlock
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)
end

function var_0_0.initComponents(arg_3_0)
	var_0_0.super.initComponents(arg_3_0)
end

function var_0_0.refreshLand(arg_4_0)
	var_0_0.super.refreshLand(arg_4_0)
	arg_4_0.effect:changeParams({
		landGO = {
			shadow = false,
			batch = false,
			layer = UnityLayer.SceneOrthogonalOpaque
		}
	})
	arg_4_0.effect:refreshEffect()
end

function var_0_0.getMO(arg_5_0)
	return RoomInventoryBlockModel.instance:getFakeBlockMOById(arg_5_0.id)
end

return var_0_0
