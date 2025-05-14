module("modules.logic.rouge.view.RougeCollectionDragItem", package.seeall)

local var_0_0 = class("RougeCollectionDragItem", RougeCollectionSizeBagItem)

function var_0_0.onInit(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:createCollectionGO(arg_1_1, arg_1_2)
	var_0_0.super.onInit(arg_1_0, arg_1_0.viewGO)

	arg_1_0._gocenter = gohelper.findChild(arg_1_0.viewGO, "go_center")
	arg_1_0._simageiconeffect = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_center/simage_icon/icon_effect")
	arg_1_0._godisconnect = gohelper.findChild(arg_1_0.viewGO, "go_center/go_disconnect")
	arg_1_0._animator = gohelper.onceAddComponent(arg_1_0.viewGO, gohelper.Type_Animator)
	arg_1_0._animator.enabled = false
	arg_1_0._activeEffectMap = {}

	arg_1_0:setAnimatorEnabled(false)
	arg_1_0:setShowTypeFlagVisible(false)
	arg_1_0:setPivot(0, 1)
	arg_1_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.UpdateActiveEffect, arg_1_0.updateActiveEffectTag, arg_1_0)
end

function var_0_0.createCollectionGO(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_2._gochessitem

	if var_2_0 then
		arg_2_0.viewGO = gohelper.cloneInPlace(var_2_0, arg_2_1)
		arg_2_0.viewGO.transform.anchorMin = Vector2.New(0.5, 0.5)
		arg_2_0.viewGO.transform.anchorMax = Vector2.New(0.5, 0.5)
		arg_2_0.viewGO.transform.pivot = Vector2.New(0.5, 0.5)

		gohelper.setActive(arg_2_0.viewGO, true)
	end
end

function var_0_0.getCollectionTransform(arg_3_0)
	return arg_3_0.viewGO and arg_3_0.viewGO.transform
end

function var_0_0.setPivot(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.viewGO.transform.pivot = Vector2(arg_4_1, arg_4_2)
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	var_0_0.super.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0:updateCollectionPosition()

	local var_5_0 = RougeCollectionHelper.getCollectionIconUrl(arg_5_0._mo.cfgId)

	arg_5_0._simageiconeffect:LoadImage(var_5_0)
	arg_5_0:_selectCollection()
end

function var_0_0.onUpdateRotateAngle(arg_6_0)
	var_0_0.super.onUpdateRotateAngle(arg_6_0)
	arg_6_0:updateElectirDisconnnectFlagPos()
end

function var_0_0.updateCollectionRotation(arg_7_0, arg_7_1)
	transformhelper.setLocalRotation(arg_7_0._gocenter.transform, 0, 0, arg_7_1)
end

function var_0_0.refreshSlotCell(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0:setCellAnchor(arg_8_1, arg_8_2, arg_8_3)
	arg_8_0:checkAndPlaceAroundLine(arg_8_1, arg_8_2)
end

function var_0_0.setParent(arg_9_0, arg_9_1)
	if not arg_9_1 or arg_9_0._curParentTran == arg_9_1 then
		return
	end

	arg_9_0.viewGO.transform:SetParent(arg_9_1)

	arg_9_0._curParentTran = arg_9_1
end

function var_0_0.setShowTypeFlagVisible(arg_10_0, arg_10_1)
	arg_10_0._isElectriDisconnect = arg_10_1 and arg_10_0._activeEffectMap[RougeEnum.EffectActiveType.Electric] == false

	local var_10_0 = arg_10_1 and arg_10_0._activeEffectMap[RougeEnum.EffectActiveType.LevelUp]
	local var_10_1 = arg_10_1 and arg_10_0._activeEffectMap[RougeEnum.EffectActiveType.Engulf]

	gohelper.setActive(arg_10_0._simageiconeffect.gameObject, var_10_0 or var_10_1)
	gohelper.setActive(arg_10_0._godisconnect, arg_10_0._isElectriDisconnect)
	arg_10_0:updateElectirDisconnnectFlagPos()
end

var_0_0.BaseElectricDisconnectFlagPosX = 0

function var_0_0.updateElectirDisconnnectFlagPos(arg_11_0)
	if not arg_11_0._isElectriDisconnect then
		return
	end

	local var_11_0 = arg_11_0._mo:getRotation()
	local var_11_1 = RougeCollectionConfig.instance:getShapeMatrix(arg_11_0._mo.cfgId, var_11_0)[1]
	local var_11_2 = 0

	for iter_11_0 = 1, #var_11_1 do
		if var_11_1[iter_11_0] and var_11_1[iter_11_0] > 0 then
			var_11_2 = iter_11_0 - 1

			break
		end
	end

	local var_11_3 = var_11_2 * RougeCollectionHelper.CollectionSlotCellSize.x
	local var_11_4 = var_0_0.BaseElectricDisconnectFlagPosX + var_11_3

	recthelper.setAnchorX(arg_11_0._godisconnect.transform, var_11_4)
end

function var_0_0.updateActiveEffectTag(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_0._mo and arg_12_1 == arg_12_0._mo.id then
		arg_12_0._activeEffectMap = arg_12_0._activeEffectMap or {}
		arg_12_0._activeEffectMap[arg_12_2] = arg_12_3

		arg_12_0:setShowTypeFlagVisible(true)
	end
end

function var_0_0.setSelectFrameVisible(arg_13_0, arg_13_1)
	var_0_0.super.setSelectFrameVisible(arg_13_0, arg_13_1)
	arg_13_0:setShapeCellsVisible(arg_13_1)
end

function var_0_0.setAnimatorEnabled(arg_14_0, arg_14_1)
	arg_14_0._animator.enabled = arg_14_1
end

function var_0_0.playAnim(arg_15_0, arg_15_1)
	arg_15_0:setAnimatorEnabled(true)
	arg_15_0._animator:Play(arg_15_1, 0, 0)
end

function var_0_0.reset(arg_16_0)
	var_0_0.super.reset(arg_16_0)
	transformhelper.setLocalRotation(arg_16_0._gocenter.transform, 0, 0, 0)
	arg_16_0:setAnimatorEnabled(false)
	arg_16_0:setShowTypeFlagVisible(false)
	gohelper.setActive(arg_16_0._simageiconeffect.gameObject, false)
	tabletool.clear(arg_16_0._activeEffectMap)
end

function var_0_0.destroy(arg_17_0)
	var_0_0.super.destroy(arg_17_0)
end

return var_0_0
