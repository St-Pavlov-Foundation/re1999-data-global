module("modules.logic.versionactivity1_8.dungeon.controller.Activity157Controller", package.seeall)

slot0 = class("Activity157Controller", BaseController)

function slot0.onInit(slot0)
	slot0._openBlueprintAfterFactoryMapView = false
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.getAct157ActInfo(slot0, slot1, slot2, slot3, slot4)
	if ActivityModel.instance:isActOnLine(Activity157Model.instance:getActId()) then
		Activity157Rpc.instance:sendGet157InfoRequest(slot5, slot3, slot4)
	else
		if slot1 then
			GameFacade.showToast(ToastEnum.ActivityNotOpen)
		end

		if slot2 and slot3 then
			slot3(slot4)
		end
	end
end

function slot0.openFactoryMapView(slot0, slot1)
	slot0._openBlueprintAfterFactoryMapView = slot1

	HandbookRpc.instance:sendGetHandbookInfoRequest()
	slot0:getAct157ActInfo(true, false, slot0._openFactoryMapViewAfterRpc, slot0)
end

function slot0._openFactoryMapViewAfterRpc(slot0, slot1, slot2, slot3)
	if not slot2 or slot2 ~= 0 then
		slot0._openBlueprintAfterFactoryMapView = false

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_8FactoryMapView)
end

function slot0.onFactoryMapViewOpen(slot0)
	if slot0._openBlueprintAfterFactoryMapView then
		slot0:openFactoryBlueprintView()
	end

	slot0._openBlueprintAfterFactoryMapView = false
end

function slot0.openFactoryBlueprintView(slot0)
	if Activity157Model.instance:getIsUnlockFactoryBlueprint() then
		ViewMgr.instance:openView(ViewName.VersionActivity1_8FactoryBlueprintView)
	else
		GameFacade.showToast(ToastEnum.V1a8Activity157LockedFactoryEntrance)
	end
end

function slot0.getFactoryProduction(slot0)
	if not Activity157Model.instance:getIsUnlockFactoryBlueprint() then
		GameFacade.showToast(ToastEnum.V1a8Activity157NotUnlockFactoryBlueprint)

		return
	end

	if not (Activity157Model.instance:getFactoryProductionNum() > 0) and string.nilorempty(Activity157Model.instance:getFactoryNextRecoverCountdown()) then
		GameFacade.showToast(ToastEnum.V1a8Activity157FactoryProductFinish)

		return
	end

	if not slot3 then
		GameFacade.showToast(ToastEnum.V1a8Activity157NoFactoryProduction)

		return
	end

	Activity157Rpc.instance:sendAct157AcceptProductionRequest(Activity157Model.instance:getActId())
end

function slot0.openCompositeView(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_8FactoryCompositeView)
end

function slot0.enterFactoryRepairGame(slot0, slot1)
	if not slot1 then
		return
	end

	if Activity157Model.instance:isRepairComponent(slot1) then
		GameFacade.showToast(ToastEnum.V1a8Activity157RepairComplete)

		return
	end

	Activity157RepairGameModel.instance:setGameDataBeforeEnter(slot1)
	slot0:initRule()
	slot0:refreshAllConnection()
	slot0:updateConnection()
	ViewMgr.instance:openView(ViewName.VersionActivity1_8FactoryRepairView)
end

function slot0.factoryComposite(slot0, slot1, slot2, slot3, slot4)
	if not slot1 or not slot2 then
		return
	end

	slot6 = 0

	if Activity157Config.instance:getAct157Const(Activity157Model.instance:getActId(), Activity157Enum.ConstId.FactoryCompositeCost) and string.split(slot7, "#") then
		slot6 = ItemModel.instance:getItemQuantity(slot8[1], slot8[2])
	end

	if slot6 < slot2 then
		GameFacade.showToast(ToastEnum.V1a8Activity157NotEnoughMaterial)

		return
	end

	Activity157Rpc.instance:sendAct157CompoundRequest(slot5, slot1, slot3, slot4)
end

function slot0.initRule(slot0)
	slot0._rule = slot0._rule or Activity157GameRule.New()
	slot1, slot2 = Activity157RepairGameModel.instance:getGameSize()

	slot0._rule:setGameSize(slot1, slot2)
end

function slot0.resetGame(slot0)
	Activity157RepairGameModel.instance:resetGameData()
	slot0:refreshAllConnection()
	slot0:updateConnection()
	slot0:dispatchEvent(ArmPuzzlePipeEvent.ResetGameRefresh)
end

function slot0.refreshAllConnection(slot0)
	slot1, slot2 = Activity157RepairGameModel.instance:getGameSize()

	for slot6 = 1, slot1 do
		for slot10 = 1, slot2 do
			slot0:refreshConnection(Activity157RepairGameModel.instance:getData(slot6, slot10))
		end
	end
end

slot1 = ArmPuzzlePipeEnum.dir.left
slot2 = ArmPuzzlePipeEnum.dir.right
slot3 = ArmPuzzlePipeEnum.dir.down
slot4 = ArmPuzzlePipeEnum.dir.up

function slot0.refreshConnection(slot0, slot1)
	slot2 = slot1.x
	slot3 = slot1.y

	slot0._rule:setSingleConnection(slot2 - 1, slot3, uv0, uv1, slot1)
	slot0._rule:setSingleConnection(slot2 + 1, slot3, uv1, uv0, slot1)
	slot0._rule:setSingleConnection(slot2, slot3 + 1, uv2, uv3, slot1)
	slot0._rule:setSingleConnection(slot2, slot3 - 1, uv3, uv2, slot1)
end

function slot0.updateConnection(slot0)
	Activity157RepairGameModel.instance:resetEntryConnect()

	slot1, slot2 = slot0._rule:getReachTable()

	slot0._rule:_mergeReachDir(slot1)
	slot0._rule:_unmarkBranch()
	Activity157RepairGameModel.instance:setGameClear(slot0._rule:isGameClear(slot2))
end

function slot0.changeDirection(slot0, slot1, slot2, slot3)
	if slot3 then
		slot0:refreshConnection(slot0._rule:changeDirection(slot1, slot2))
	end
end

function slot0.checkDispatchClear(slot0)
	if Activity157RepairGameModel.instance:getGameClear() then
		slot0:dispatchEvent(ArmPuzzlePipeEvent.PipeGameClear)
	end
end

slot0.instance = slot0.New()

return slot0
