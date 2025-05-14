module("modules.logic.versionactivity1_8.dungeon.controller.Activity157Controller", package.seeall)

local var_0_0 = class("Activity157Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._openBlueprintAfterFactoryMapView = false
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.getAct157ActInfo(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity157Model.instance:getActId()

	if ActivityModel.instance:isActOnLine(var_3_0) then
		Activity157Rpc.instance:sendGet157InfoRequest(var_3_0, arg_3_3, arg_3_4)
	else
		if arg_3_1 then
			GameFacade.showToast(ToastEnum.ActivityNotOpen)
		end

		if arg_3_2 and arg_3_3 then
			arg_3_3(arg_3_4)
		end
	end
end

function var_0_0.openFactoryMapView(arg_4_0, arg_4_1)
	arg_4_0._openBlueprintAfterFactoryMapView = arg_4_1

	HandbookRpc.instance:sendGetHandbookInfoRequest()
	arg_4_0:getAct157ActInfo(true, false, arg_4_0._openFactoryMapViewAfterRpc, arg_4_0)
end

function var_0_0._openFactoryMapViewAfterRpc(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_2 or arg_5_2 ~= 0 then
		arg_5_0._openBlueprintAfterFactoryMapView = false

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_8FactoryMapView)
end

function var_0_0.onFactoryMapViewOpen(arg_6_0)
	if arg_6_0._openBlueprintAfterFactoryMapView then
		arg_6_0:openFactoryBlueprintView()
	end

	arg_6_0._openBlueprintAfterFactoryMapView = false
end

function var_0_0.openFactoryBlueprintView(arg_7_0)
	if Activity157Model.instance:getIsUnlockFactoryBlueprint() then
		ViewMgr.instance:openView(ViewName.VersionActivity1_8FactoryBlueprintView)
	else
		GameFacade.showToast(ToastEnum.V1a8Activity157LockedFactoryEntrance)
	end
end

function var_0_0.getFactoryProduction(arg_8_0)
	if not Activity157Model.instance:getIsUnlockFactoryBlueprint() then
		GameFacade.showToast(ToastEnum.V1a8Activity157NotUnlockFactoryBlueprint)

		return
	end

	local var_8_0 = Activity157Model.instance:getFactoryProductionNum() > 0
	local var_8_1 = Activity157Model.instance:getFactoryNextRecoverCountdown()
	local var_8_2 = string.nilorempty(var_8_1)

	if not var_8_0 and var_8_2 then
		GameFacade.showToast(ToastEnum.V1a8Activity157FactoryProductFinish)

		return
	end

	if not var_8_0 then
		GameFacade.showToast(ToastEnum.V1a8Activity157NoFactoryProduction)

		return
	end

	local var_8_3 = Activity157Model.instance:getActId()

	Activity157Rpc.instance:sendAct157AcceptProductionRequest(var_8_3)
end

function var_0_0.openCompositeView(arg_9_0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_8FactoryCompositeView)
end

function var_0_0.enterFactoryRepairGame(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return
	end

	if Activity157Model.instance:isRepairComponent(arg_10_1) then
		GameFacade.showToast(ToastEnum.V1a8Activity157RepairComplete)

		return
	end

	Activity157RepairGameModel.instance:setGameDataBeforeEnter(arg_10_1)
	arg_10_0:initRule()
	arg_10_0:refreshAllConnection()
	arg_10_0:updateConnection()
	ViewMgr.instance:openView(ViewName.VersionActivity1_8FactoryRepairView)
end

function var_0_0.factoryComposite(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	if not arg_11_1 or not arg_11_2 then
		return
	end

	local var_11_0 = Activity157Model.instance:getActId()
	local var_11_1 = 0
	local var_11_2 = Activity157Config.instance:getAct157Const(var_11_0, Activity157Enum.ConstId.FactoryCompositeCost)
	local var_11_3 = var_11_2 and string.split(var_11_2, "#")

	if var_11_3 then
		var_11_1 = ItemModel.instance:getItemQuantity(var_11_3[1], var_11_3[2])
	end

	if var_11_1 < arg_11_2 then
		GameFacade.showToast(ToastEnum.V1a8Activity157NotEnoughMaterial)

		return
	end

	Activity157Rpc.instance:sendAct157CompoundRequest(var_11_0, arg_11_1, arg_11_3, arg_11_4)
end

function var_0_0.initRule(arg_12_0)
	arg_12_0._rule = arg_12_0._rule or Activity157GameRule.New()

	local var_12_0, var_12_1 = Activity157RepairGameModel.instance:getGameSize()

	arg_12_0._rule:setGameSize(var_12_0, var_12_1)
end

function var_0_0.resetGame(arg_13_0)
	Activity157RepairGameModel.instance:resetGameData()
	arg_13_0:refreshAllConnection()
	arg_13_0:updateConnection()
	arg_13_0:dispatchEvent(ArmPuzzlePipeEvent.ResetGameRefresh)
end

function var_0_0.refreshAllConnection(arg_14_0)
	local var_14_0, var_14_1 = Activity157RepairGameModel.instance:getGameSize()

	for iter_14_0 = 1, var_14_0 do
		for iter_14_1 = 1, var_14_1 do
			local var_14_2 = Activity157RepairGameModel.instance:getData(iter_14_0, iter_14_1)

			arg_14_0:refreshConnection(var_14_2)
		end
	end
end

local var_0_1 = ArmPuzzlePipeEnum.dir.left
local var_0_2 = ArmPuzzlePipeEnum.dir.right
local var_0_3 = ArmPuzzlePipeEnum.dir.down
local var_0_4 = ArmPuzzlePipeEnum.dir.up

function var_0_0.refreshConnection(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.x
	local var_15_1 = arg_15_1.y

	arg_15_0._rule:setSingleConnection(var_15_0 - 1, var_15_1, var_0_2, var_0_1, arg_15_1)
	arg_15_0._rule:setSingleConnection(var_15_0 + 1, var_15_1, var_0_1, var_0_2, arg_15_1)
	arg_15_0._rule:setSingleConnection(var_15_0, var_15_1 + 1, var_0_3, var_0_4, arg_15_1)
	arg_15_0._rule:setSingleConnection(var_15_0, var_15_1 - 1, var_0_4, var_0_3, arg_15_1)
end

function var_0_0.updateConnection(arg_16_0)
	Activity157RepairGameModel.instance:resetEntryConnect()

	local var_16_0, var_16_1 = arg_16_0._rule:getReachTable()

	arg_16_0._rule:_mergeReachDir(var_16_0)
	arg_16_0._rule:_unmarkBranch()

	local var_16_2 = arg_16_0._rule:isGameClear(var_16_1)

	Activity157RepairGameModel.instance:setGameClear(var_16_2)
end

function var_0_0.changeDirection(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_0._rule:changeDirection(arg_17_1, arg_17_2)

	if arg_17_3 then
		arg_17_0:refreshConnection(var_17_0)
	end
end

function var_0_0.checkDispatchClear(arg_18_0)
	if Activity157RepairGameModel.instance:getGameClear() then
		arg_18_0:dispatchEvent(ArmPuzzlePipeEvent.PipeGameClear)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
