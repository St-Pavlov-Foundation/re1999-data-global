module("modules.logic.room.entity.comp.RoomDebugPackageUIComp", package.seeall)

slot0 = class("RoomDebugPackageUIComp", RoomBaseUIComp)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)

	slot0._res = RoomScenePreloader.ResDebugPackageUI
end

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._name = "debugpackageui_" .. slot0.go.name

	slot0:refreshUI()
end

function slot0.addEventListeners(slot0)
	uv0.super.addEventListeners(slot0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugSetPackage, slot0.refreshUI, slot0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugPlaceListShowChanged, slot0.refreshUI, slot0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugPackageListShowChanged, slot0.refreshUI, slot0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugPackageFilterChanged, slot0.refreshUI, slot0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugPackageOrderChanged, slot0.refreshUI, slot0)
end

function slot0.removeEventListeners(slot0)
	uv0.super.removeEventListeners(slot0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugSetPackage, slot0.refreshUI, slot0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPlaceListShowChanged, slot0.refreshUI, slot0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPackageListShowChanged, slot0.refreshUI, slot0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPackageFilterChanged, slot0.refreshUI, slot0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPackageOrderChanged, slot0.refreshUI, slot0)
end

function slot0.refreshUI(slot0)
	if not RoomDebugController.instance:isDebugPackageListShow() and not RoomDebugController.instance:isDebugPlaceListShow() then
		slot0:returnUI()

		return
	end

	if RoomDebugController.instance:isDebugPackageListShow() and not RoomDebugController.instance:isEditPackageOrder() then
		slot0:returnUI()

		return
	end

	slot1 = slot0.entity:getMO()

	if RoomDebugController.instance:isDebugPackageListShow() then
		if not RoomDebugPackageListModel.instance:getFilterPackageId() or slot2 ~= slot1.packageId or slot2 <= 0 then
			slot0:returnUI()

			return
		end

		if slot1:getMainRes() ~= (RoomDebugPackageListModel.instance:getFilterMainRes() or RoomResourceEnum.ResourceId.Empty) then
			slot0:returnUI()

			return
		end

		slot0:getUI()

		slot0._txtcount.text = slot1.packageOrder

		slot0:refreshPosition()
	elseif RoomDebugController.instance:isDebugPlaceListShow() then
		slot0:getUI()

		slot0._txtcount.text = RoomHelper.getBlockPrefabName(slot1:getBlockDefineCfg().prefabPath)

		slot0:refreshPosition()
	end
end

function slot0.initUI(slot0)
	slot0._txtcount = gohelper.findChildText(slot0._gocontainer, "txt_count")
end

function slot0.destoryUI(slot0)
	slot0._txtcount = nil
end

function slot0.getUIWorldPos(slot0)
	slot2 = HexMath.hexToPosition(slot0.entity:getMO().hexPoint, RoomBlockEnum.BlockSize)

	return Vector3(slot2.x, 0.5, slot2.y)
end

function slot0.onClick(slot0)
	if not RoomDebugController.instance:isDebugPackageListShow() then
		return
	end

	RoomDebugController.instance:debugSetPackageOrder(slot0.entity:getMO().id)
end

return slot0
