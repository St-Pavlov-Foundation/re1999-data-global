module("modules.logic.room.entity.comp.base.RoomBaseSpineEffectComp", package.seeall)

local var_0_0 = class("RoomBaseSpineEffectComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._isHasEffectGODict = {}
	arg_1_0._prefabNameDict = {}
	arg_1_0._animNameDict = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._effectCfgList = {}

	local var_2_0 = arg_2_0:getEffectCfgList()

	tabletool.addValues(arg_2_0._effectCfgList, var_2_0)
	arg_2_0:onInit()
end

function var_0_0._logNotPoint(arg_3_0, arg_3_1)
	return
end

function var_0_0._logResError(arg_4_0, arg_4_1)
	return
end

function var_0_0.getEffectCfgList(arg_5_0)
	return nil
end

function var_0_0.getSpineComp(arg_6_0)
	return nil
end

function var_0_0.onPlayShowEffect(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	return
end

function var_0_0.addResToLoader(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0._effectCfgList) do
		arg_8_1:addPath(arg_8_0:_getEffecResAb(iter_8_1.effectRes))
	end
end

function var_0_0._getEffecRes(arg_9_0, arg_9_1)
	return RoomResHelper.getCharacterEffectPath(arg_9_1)
end

function var_0_0._getEffecResAb(arg_10_0, arg_10_1)
	return RoomResHelper.getCharacterEffectABPath(arg_10_1)
end

function var_0_0.addEventListeners(arg_11_0)
	return
end

function var_0_0.removeEventListeners(arg_12_0)
	return
end

function var_0_0.isHasEffectGO(arg_13_0, arg_13_1)
	if arg_13_0._isHasEffectGODict[arg_13_1] then
		return true
	end

	return false
end

function var_0_0.play(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._isHasEffectGODict[arg_14_0._curAnimState] or arg_14_0._isHasEffectGODict[arg_14_1]

	arg_14_0._curAnimState = arg_14_1

	if var_14_0 then
		for iter_14_0, iter_14_1 in pairs(arg_14_0._animEffectGODic) do
			gohelper.setActive(iter_14_1, false)

			if arg_14_0._animNameDict[iter_14_0] == arg_14_1 then
				gohelper.setActive(iter_14_1, true)
				arg_14_0:onPlayShowEffect(arg_14_1, iter_14_1, iter_14_0)
			end
		end
	end
end

function var_0_0.spawnEffect(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getSpineComp()
	local var_15_1 = var_15_0 and var_15_0:getSpineGO()

	arg_15_0._animEffectGODic = arg_15_0._animEffectGODic or {}
	arg_15_0._prefabNameDict = arg_15_0._prefabNameDict or {}
	arg_15_0._isHasEffectGODict = arg_15_0._isHasEffectGODict or {}
	arg_15_0._animNameDict = arg_15_0._animNameDict or {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._effectCfgList) do
		local var_15_2 = iter_15_1.id

		if gohelper.isNil(arg_15_0._animEffectGODic[var_15_2]) then
			local var_15_3 = arg_15_0:_getEffecResAb(iter_15_1.effectRes)
			local var_15_4 = arg_15_1:getAssetItem(var_15_3)
			local var_15_5 = true

			if var_15_4 then
				local var_15_6 = arg_15_0:_getEffecRes(iter_15_1.effectRes)
				local var_15_7 = var_15_4:GetResource(var_15_6)

				if var_15_7 then
					var_15_5 = false

					local var_15_8 = RoomCharacterHelper.getSpinePointPath(iter_15_1.point)
					local var_15_9 = gohelper.findChild(var_15_1, var_15_8)

					if gohelper.isNil(var_15_9) then
						arg_15_0:_logNotPoint(iter_15_1)

						var_15_9 = var_15_1 or arg_15_0.entity.containerGO
					end

					local var_15_10 = var_15_7.name
					local var_15_11 = gohelper.clone(var_15_7, var_15_9, var_15_10)

					arg_15_0._animNameDict[var_15_2] = iter_15_1.animName
					arg_15_0._animEffectGODic[var_15_2] = var_15_11
					arg_15_0._prefabNameDict[var_15_2] = var_15_10
					arg_15_0._isHasEffectGODict[iter_15_1.animName] = true

					gohelper.setActive(var_15_11, false)
				end
			end

			if var_15_5 then
				arg_15_0:_logResError(iter_15_1)
			end
		end
	end
end

function var_0_0.clearEffect(arg_16_0)
	if arg_16_0._animEffectGODic then
		for iter_16_0, iter_16_1 in pairs(arg_16_0._animEffectGODic) do
			rawset(arg_16_0._animEffectGODic, iter_16_0, nil)
			gohelper.destroy(iter_16_1)
		end

		arg_16_0._animEffectGODic = nil
		arg_16_0._isHasEffectGODict = {}
		arg_16_0._prefabNameDict = {}
		arg_16_0._animNameDict = {}
	end
end

function var_0_0.beforeDestroy(arg_17_0)
	arg_17_0:removeEventListeners()
	arg_17_0:clearEffect()
end

return var_0_0
