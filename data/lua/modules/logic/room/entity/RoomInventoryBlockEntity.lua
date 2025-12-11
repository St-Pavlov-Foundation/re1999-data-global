module("modules.logic.room.entity.RoomInventoryBlockEntity", package.seeall)

local var_0_0 = class("RoomInventoryBlockEntity", RoomBaseBlockEntity)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1.entityId)

	arg_1_0.isWaterReform = arg_1_1.isWaterReform
end

function var_0_0.getTag(arg_2_0)
	return SceneTag.RoomInventoryBlock
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0._scene = GameSceneMgr.instance:getCurScene()

	var_0_0.super.init(arg_3_0, arg_3_1)
end

function var_0_0.initComponents(arg_4_0)
	var_0_0.super.initComponents(arg_4_0)
end

function var_0_0.onReviseResParams(arg_5_0, arg_5_1)
	arg_5_1.layer = UnityLayer.SceneOrthogonalOpaque
	arg_5_1.batch = false
	arg_5_1.highlight = false
	arg_5_1.isInventory = true
end

function var_0_0.onEffectRebuild(arg_6_0)
	var_0_0.super.onEffectRebuild(arg_6_0)
	arg_6_0:_refreshLinkGO()
	arg_6_0._scene.inventorymgr:refreshInventoryBlock()
end

function var_0_0._refreshLinkGO(arg_7_0)
	local var_7_0 = arg_7_0:getMO()

	if not var_7_0 then
		return
	end

	local var_7_1 = RoomEnum.EffectKey.BlockLandKey
	local var_7_2 = var_7_0:getResourceList()

	for iter_7_0 = 1, #var_7_2 do
		local var_7_3 = var_7_2[iter_7_0]

		if RoomResourceEnum.ResourceLinkGOPath[var_7_3] and RoomResourceEnum.ResourceLinkGOPath[var_7_3][iter_7_0] then
			local var_7_4 = arg_7_0.effect:getGameObjectByPath(var_7_1, RoomResourceEnum.ResourceLinkGOPath[var_7_3][iter_7_0])

			if var_7_4 then
				gohelper.setActive(var_7_4, false)
			end
		end
	end

	local var_7_5 = var_7_0:getDefineBlockType()

	if RoomBlockEnum.BlockLinkEffectGOPath[var_7_5] then
		local var_7_6 = arg_7_0.effect:getGameObjectByPath(var_7_1, RoomBlockEnum.BlockLinkEffectGOPath[var_7_5])

		if var_7_6 then
			gohelper.setActive(var_7_6, false)
		end
	end

	local var_7_7 = arg_7_0.effect:getGameObjectsByName(var_7_1, RoomEnum.EntityChildKey.NightLightGOKey)

	if var_7_7 then
		for iter_7_1, iter_7_2 in ipairs(var_7_7) do
			gohelper.setActive(iter_7_2, false)
		end
	end
end

function var_0_0.refreshRotation(arg_8_0, arg_8_1)
	var_0_0.super.refreshRotation(arg_8_0, arg_8_1)
	arg_8_0._scene.inventorymgr:refreshInventoryBlock()
end

function var_0_0.getMO(arg_9_0)
	if arg_9_0.isWaterReform then
		if not arg_9_0._reformTypeBlockMO then
			local var_9_0
			local var_9_1 = RoomBlockMO.New()

			if RoomWaterReformModel.instance:getReformMode() == RoomEnum.ReformMode.Water then
				local var_9_2 = RoomConfig.instance:getWaterTypeByBlockId(arg_9_0.id)

				var_9_0 = RoomConfig.instance:getWaterReformTypeBlockCfg(var_9_2)
			else
				local var_9_3 = RoomConfig.instance:getBlockColorByBlockId(arg_9_0.id)

				var_9_0 = RoomConfig.instance:getBlockColorReformBlockCfg(var_9_3)
			end

			var_9_1:init(var_9_0)

			var_9_1.blockState = RoomBlockEnum.BlockState.WaterReform
			arg_9_0._reformTypeBlockMO = var_9_1
		end

		return arg_9_0._reformTypeBlockMO
	else
		return RoomInventoryBlockModel.instance:getInventoryBlockMOById(arg_9_0.id)
	end
end

return var_0_0
