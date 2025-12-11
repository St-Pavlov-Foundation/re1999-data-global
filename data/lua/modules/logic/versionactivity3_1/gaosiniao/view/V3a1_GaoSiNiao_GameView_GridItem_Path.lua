module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_GameView_GridItem_Path", package.seeall)

local var_0_0 = class("V3a1_GaoSiNiao_GameView_GridItem_Path", V3a1_GaoSiNiao_GameView_GridItem_PieceBase)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.ctor(arg_4_0, arg_4_1)
	var_0_0.super.ctor(arg_4_0, arg_4_1)

	arg_4_0._selectedPathType = nil
	arg_4_0._selectedPathSpriteId = nil
	arg_4_0._isFixedPath = nil
end

function var_0_0.setIsFixedPath(arg_5_0, arg_5_1)
	if arg_5_0._isFixedPath == arg_5_1 then
		return
	end

	arg_5_0._isFixedPath = arg_5_1

	if arg_5_1 then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._ePathSpriteId2BloodItem) do
			iter_5_1:setActive(false)
		end
	else
		for iter_5_2, iter_5_3 in pairs(arg_5_0._ePathSpriteId2DisableBloodItem) do
			iter_5_3:setActive(false)
		end
	end

	local var_5_0 = arg_5_0._selectedPathType

	arg_5_0._selectedPathType = nil
	arg_5_0._selectedPathSpriteId = nil

	arg_5_0:selectPathType(var_5_0)
end

function var_0_0._editableInitView(arg_6_0)
	var_0_0.super._editableInitView(arg_6_0)

	arg_6_0._ePathSpriteId2BloodItem = {}
	arg_6_0._ePathSpriteId2DisableBloodItem = {}

	local var_6_0 = arg_6_0:transform()

	if isDebugBuild then
		local var_6_1 = var_6_0.childCount

		assert(var_6_1 == 8)
	end

	local var_6_2 = 0

	for iter_6_0 = GaoSiNiaoEnum.PathSpriteId.None + 1, GaoSiNiaoEnum.PathSpriteId.__End - 1 do
		local var_6_3 = var_6_0:GetChild(var_6_2)
		local var_6_4 = arg_6_0:newObject(V3a1_GaoSiNiao_GameView_GridItem_Blood)

		var_6_4:init(var_6_3.gameObject)
		var_6_4:setActive(false)

		arg_6_0._ePathSpriteId2BloodItem[iter_6_0] = var_6_4
		var_6_2 = var_6_2 + 1
	end

	for iter_6_1 = GaoSiNiaoEnum.PathSpriteId.None + 1, GaoSiNiaoEnum.PathSpriteId.__End - 1 do
		local var_6_5 = var_6_0:GetChild(var_6_2)
		local var_6_6 = arg_6_0:newObject(V3a1_GaoSiNiao_GameView_GridItem_Blood)

		var_6_6:init(var_6_5.gameObject)
		var_6_6:setActive(false)

		arg_6_0._ePathSpriteId2DisableBloodItem[iter_6_1] = var_6_6
		var_6_2 = var_6_2 + 1
	end
end

function var_0_0._getBloodItem(arg_7_0, arg_7_1)
	if arg_7_0._isFixedPath then
		return arg_7_0._ePathSpriteId2DisableBloodItem[arg_7_1]
	else
		return arg_7_0._ePathSpriteId2BloodItem[arg_7_1]
	end
end

function var_0_0.getPieceSprite(arg_8_0)
	if not arg_8_0._selectedPathType then
		return nil
	end

	local var_8_0 = arg_8_0:_getBloodItem(arg_8_0._selectedPathType)

	if not var_8_0 then
		return nil
	end

	return var_8_0:getPieceSprite()
end

function var_0_0.selectPathType(arg_9_0, arg_9_1)
	if arg_9_0._selectedPathType == arg_9_1 then
		return
	end

	arg_9_0._selectedPathType = arg_9_1

	local var_9_0 = arg_9_1 and GaoSiNiaoEnum.PathInfo[arg_9_1]
	local var_9_1
	local var_9_2 = 0

	if var_9_0 then
		var_9_1 = var_9_0.spriteId
		var_9_2 = var_9_0.zRot
	end

	arg_9_0:_selectPathType(var_9_1)
	arg_9_0:localRotateZ(var_9_2)
end

function var_0_0._selectPathType(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._selectedPathSpriteId

	if var_10_0 == arg_10_1 then
		return
	end

	arg_10_0._selectedPathSpriteId = arg_10_1

	if var_10_0 then
		arg_10_0:_getBloodItem(var_10_0):setActive(false)
	end

	if arg_10_1 then
		arg_10_0:_getBloodItem(arg_10_1):setActive(true)
	end
end

function var_0_0.setGray_Blood(arg_11_0, arg_11_1)
	if not arg_11_0._selectedPathSpriteId then
		arg_11_0:_setGray_Blood(arg_11_1)
	else
		local var_11_0 = arg_11_0:_getBloodItem(arg_11_0._selectedPathSpriteId)

		if not var_11_0 then
			arg_11_0:_setGray_Blood(arg_11_1)

			return nil
		end

		var_11_0:setGray_Blood(arg_11_1)
	end
end

function var_0_0.hideBlood(arg_12_0)
	if not arg_12_0._selectedPathSpriteId then
		arg_12_0:_hideBlood()
	else
		local var_12_0 = arg_12_0:_getBloodItem(arg_12_0._selectedPathSpriteId)

		if not var_12_0 then
			arg_12_0:_hideBlood()

			return nil
		end

		var_12_0:hideBlood()
	end
end

function var_0_0._hideBlood(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0._ePathSpriteId2BloodItem) do
		iter_13_1:hideBlood()
	end

	for iter_13_2, iter_13_3 in pairs(arg_13_0._ePathSpriteId2DisableBloodItem) do
		iter_13_3:hideBlood()
	end
end

function var_0_0._setGray_Blood(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in pairs(arg_14_0._ePathSpriteId2BloodItem) do
		iter_14_1:setGray_Blood(arg_14_1)
	end

	for iter_14_2, iter_14_3 in pairs(arg_14_0._ePathSpriteId2DisableBloodItem) do
		iter_14_3:setGray_Blood(arg_14_1)
	end
end

return var_0_0
