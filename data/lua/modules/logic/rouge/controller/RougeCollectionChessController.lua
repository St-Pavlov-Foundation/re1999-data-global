module("modules.logic.rouge.controller.RougeCollectionChessController", package.seeall)

local var_0_0 = class("RougeCollectionChessController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.onOpen(arg_3_0)
	RougeCollectionBagListModel.instance:onInitData()
end

function var_0_0.placeCollection2SlotArea(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = RougeCollectionModel.instance:getCollectionByUid(arg_4_1)

	if not var_4_0 then
		return
	end

	local var_4_1 = var_4_0:getLeftTopPos()

	if var_4_1.x ~= arg_4_2.x or var_4_1.y ~= arg_4_2.y then
		RougeController.instance:dispatchEvent(RougeEvent.AdjustBackPack)
	else
		local var_4_2 = var_4_0:getRotation()

		if arg_4_3 and arg_4_3 ~= var_4_2 then
			RougeController.instance:dispatchEvent(RougeEvent.AdjustBackPack)
		end
	end

	RougeRpc.instance:sendRougeAddToBarRequest(arg_4_1, arg_4_2, arg_4_3)
end

function var_0_0.removeCollectionFromSlotArea(arg_5_0, arg_5_1)
	if RougeCollectionModel.instance:isCollectionPlaceInBag(arg_5_1) then
		return
	end

	RougeRpc.instance:sendRougeRemoveFromBarRequest(arg_5_1)
end

function var_0_0.rotateCollection(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1 then
		return
	end

	local var_6_0 = arg_6_1.id
	local var_6_1 = arg_6_1.cfgId
	local var_6_2 = arg_6_1:getCenterSlotPos()
	local var_6_3 = RougeCollectionHelper.getCollectionTopLeftSlotPos(var_6_1, var_6_2, arg_6_2)

	RougeRpc.instance:sendRougeAddToBarRequest(var_6_0, var_6_3, arg_6_2)
end

function var_0_0.onKeyPlaceCollection2SlotArea(arg_7_0)
	local var_7_0 = RougeModel.instance:getSeason()
	local var_7_1 = RougeCollectionModel.instance:getBagAreaCollectionCount()

	if var_7_0 and var_7_1 > 0 then
		RougeRpc.instance:sendRougeOneKeyAddToBarRequest(var_7_0)
	end
end

function var_0_0.onKeyClearCollectionSlotArea(arg_8_0)
	local var_8_0 = RougeModel.instance:getSeason()
	local var_8_1 = RougeCollectionModel.instance:getSlotAreaCollectionCount()

	if var_8_0 and var_8_1 > 0 then
		local var_8_2 = RougeCollectionModel.instance:getSlotAreaCollection()
		local var_8_3 = {}
		local var_8_4 = {}

		for iter_8_0 = #var_8_2, 1, -1 do
			local var_8_5 = var_8_2[iter_8_0]
			local var_8_6 = var_8_5 and var_8_5.cfgId
			local var_8_7 = RougeCollectionConfig.instance:getCollectionCfg(var_8_6)

			if var_8_7 and not var_8_7.unremovable then
				table.insert(var_8_3, var_8_5.id)
			else
				table.insert(var_8_4, var_8_5.cfgId)
			end
		end

		if var_8_1 > #var_8_3 then
			for iter_8_1 = #var_8_3, 1, -1 do
				var_0_0.instance:removeCollectionFromSlotArea(var_8_3[iter_8_1])
			end

			for iter_8_2, iter_8_3 in ipairs(var_8_4) do
				local var_8_8 = RougeCollectionConfig.instance:getCollectionName(iter_8_3)

				GameFacade.showToast(ToastEnum.RougeUnRemovableCollection, var_8_8)
			end
		else
			RougeRpc.instance:sendRougeOneKeyRemoveFromBarRequest(var_8_0)
		end
	end
end

function var_0_0.autoPlaceCollection2SlotArea(arg_9_0, arg_9_1)
	if not RougeCollectionModel.instance:getCollectionByUid(arg_9_1) then
		return
	end

	local var_9_0 = Vector2(-1, -1)
	local var_9_1 = 0

	RougeRpc.instance:sendRougeAddToBarRequest(arg_9_1, var_9_0, var_9_1)
end

function var_0_0.try2OpenCollectionTipView(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_1 or arg_10_1 <= 0 then
		return
	end

	RougeController.instance:openRougeCollectionTipView(arg_10_2)
end

function var_0_0.closeCollectionTipView(arg_11_0)
	ViewMgr.instance:closeView(ViewName.RougeCollectionTipView)
end

function var_0_0.selectCollection(arg_12_0, arg_12_1)
	RougeCollectionBagListModel.instance:markCurSelectCollectionId(arg_12_1)
	var_0_0.instance:dispatchEvent(RougeEvent.SelectCollection)

	if not arg_12_1 or arg_12_1 <= 0 then
		arg_12_0:closeCollectionTipView()
	end
end

function var_0_0.deselectCollection(arg_13_0)
	arg_13_0:selectCollection(nil)
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
