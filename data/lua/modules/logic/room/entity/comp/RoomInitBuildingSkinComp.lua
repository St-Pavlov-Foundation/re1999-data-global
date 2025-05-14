module("modules.logic.room.entity.comp.RoomInitBuildingSkinComp", package.seeall)

local var_0_0 = class("RoomInitBuildingSkinComp", LuaCompBase)
local var_0_1 = 0.3
local var_0_2 = "RoomInitBuildingSkinComp_refreshBuilding_block"

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._effectKey = RoomEnum.EffectKey.BuildingGOKey
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._skinId = arg_2_0:_getRoomSkin()
	arg_2_0._switchTime = CommonConfig.instance:getConstNum(ConstEnum.RoomSkinSwitchTime)

	if not arg_2_0._switchTime or arg_2_0._switchTime == 0 then
		arg_2_0._switchTime = var_0_1
	end
end

function var_0_0.addEventListeners(arg_3_0)
	RoomSkinController.instance:registerCallback(RoomSkinEvent.SkinListViewShowChange, arg_3_0._onSkinChange, arg_3_0)
	RoomSkinController.instance:registerCallback(RoomSkinEvent.ChangePreviewRoomSkin, arg_3_0._onSkinChange, arg_3_0)
	RoomSkinController.instance:registerCallback(RoomSkinEvent.ChangeEquipRoomSkin, arg_3_0._onEquipSkin, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	RoomSkinController.instance:unregisterCallback(RoomSkinEvent.SkinListViewShowChange, arg_4_0._onSkinChange, arg_4_0)
	RoomSkinController.instance:unregisterCallback(RoomSkinEvent.ChangePreviewRoomSkin, arg_4_0._onSkinChange, arg_4_0)
	RoomSkinController.instance:unregisterCallback(RoomSkinEvent.ChangeEquipRoomSkin, arg_4_0._onEquipSkin, arg_4_0)
end

function var_0_0._onSkinChange(arg_5_0)
	if arg_5_0.__willDestroy then
		return
	end

	local var_5_0 = RoomSkinListModel.instance:getSelectPartId()

	if not arg_5_0.entity or var_5_0 ~= arg_5_0.entity.id then
		return
	end

	local var_5_1 = arg_5_0:_getRoomSkin()

	if arg_5_0._skinId ~= var_5_1 then
		TaskDispatcher.cancelTask(arg_5_0.delayPlayChangeEff, arg_5_0)

		arg_5_0._skinId = var_5_1

		arg_5_0.entity:tweenAlphaThreshold(0, 1, arg_5_0._switchTime, arg_5_0.onHideLastSkinFinish, arg_5_0)
	end
end

function var_0_0.onHideLastSkinFinish(arg_6_0)
	if not arg_6_0.entity or arg_6_0.__willDestroy then
		return
	end

	UIBlockMgr.instance:startBlock(var_0_2)

	arg_6_0._needPlayChangeEff = true

	arg_6_0.entity:refreshBuilding(true, 1)
end

function var_0_0.onEffectRebuild(arg_7_0)
	UIBlockMgr.instance:endBlock(var_0_2)

	if arg_7_0.__willDestroy then
		return
	end

	local var_7_0 = arg_7_0.entity.effect

	if not var_7_0:isHasEffectGOByKey(arg_7_0._effectKey) then
		return
	end

	if not var_7_0:isSameResByKey(arg_7_0._effectKey, arg_7_0._effectRes) then
		arg_7_0._effectRes = var_7_0:getEffectRes(arg_7_0._effectKey)
		arg_7_0._skinId = arg_7_0:_getRoomSkin()
	end

	if arg_7_0._needPlayChangeEff then
		TaskDispatcher.cancelTask(arg_7_0.delayPlayChangeEff, arg_7_0)
		TaskDispatcher.runDelay(arg_7_0.delayPlayChangeEff, arg_7_0, 0.01)
	end
end

function var_0_0.delayPlayChangeEff(arg_8_0)
	if arg_8_0.__willDestroy then
		return
	end

	arg_8_0.entity:tweenAlphaThreshold(1, 0, arg_8_0._switchTime)

	arg_8_0._needPlayChangeEff = false
end

function var_0_0._onEquipSkin(arg_9_0)
	if arg_9_0.__willDestroy then
		return
	end

	local var_9_0 = RoomSkinListModel.instance:getSelectPartId()

	if not arg_9_0.entity or var_9_0 ~= arg_9_0.entity.id then
		return
	end

	if RoomSkinModel.instance:isDefaultRoomSkin(var_9_0, arg_9_0._skinId) then
		return
	end

	local var_9_1 = RoomEnum.EffectKey.BuildingEquipSkinEffectKey
	local var_9_2 = arg_9_0.entity.effect

	if var_9_2:isHasEffectGOByKey(var_9_1) then
		local var_9_3 = var_9_2:getEffectGO(var_9_1)

		gohelper.setActive(var_9_3, false)
		gohelper.setActive(var_9_3, true)
	else
		local var_9_4 = 0
		local var_9_5 = 0
		local var_9_6 = 0
		local var_9_7 = RoomConfig.instance:getRoomSkinEquipEffPos(arg_9_0._skinId)

		if var_9_7 and #var_9_7 > 0 then
			var_9_4 = var_9_7[1] or 0
			var_9_5 = var_9_7[2] or 0
			var_9_6 = var_9_7[3] or 0
		end

		local var_9_8
		local var_9_9 = RoomConfig.instance:getRoomSkinEquipEffSize(arg_9_0._skinId)

		if var_9_9 and var_9_9 ~= 0 then
			var_9_8 = Vector3(var_9_9, var_9_9, var_9_9)
		end

		var_9_2:addParams({
			[var_9_1] = {
				res = RoomScenePreloader.ResEquipRoomSkinEffect,
				localPos = Vector3(var_9_4, var_9_5, var_9_6),
				localScale = var_9_8
			}
		})
	end

	var_9_2:refreshEffect()
end

function var_0_0._getRoomSkin(arg_10_0)
	if arg_10_0.__willDestroy then
		return
	end

	return (RoomSkinModel.instance:getShowSkin(arg_10_0.entity.id))
end

function var_0_0.beforeDestroy(arg_11_0)
	UIBlockMgr.instance:endBlock(var_0_2)

	arg_11_0.__willDestroy = true

	arg_11_0:removeEventListeners()
end

function var_0_0.onDestroy(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.delayPlayChangeEff, arg_12_0)

	arg_12_0.go = nil
	arg_12_0._effectRes = nil
	arg_12_0._skinId = nil
	arg_12_0.entity = nil
	arg_12_0._needPlayChangeEff = false
end

return var_0_0
