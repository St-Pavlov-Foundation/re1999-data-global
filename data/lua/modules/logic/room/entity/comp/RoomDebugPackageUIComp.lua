module("modules.logic.room.entity.comp.RoomDebugPackageUIComp", package.seeall)

local var_0_0 = class("RoomDebugPackageUIComp", RoomBaseUIComp)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._res = RoomScenePreloader.ResDebugPackageUI
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)

	arg_2_0._name = "debugpackageui_" .. arg_2_0.go.name

	arg_2_0:refreshUI()
end

function var_0_0.addEventListeners(arg_3_0)
	var_0_0.super.addEventListeners(arg_3_0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugSetPackage, arg_3_0.refreshUI, arg_3_0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugPlaceListShowChanged, arg_3_0.refreshUI, arg_3_0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugPackageListShowChanged, arg_3_0.refreshUI, arg_3_0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugPackageFilterChanged, arg_3_0.refreshUI, arg_3_0)
	RoomDebugController.instance:registerCallback(RoomEvent.DebugPackageOrderChanged, arg_3_0.refreshUI, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	var_0_0.super.removeEventListeners(arg_4_0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugSetPackage, arg_4_0.refreshUI, arg_4_0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPlaceListShowChanged, arg_4_0.refreshUI, arg_4_0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPackageListShowChanged, arg_4_0.refreshUI, arg_4_0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPackageFilterChanged, arg_4_0.refreshUI, arg_4_0)
	RoomDebugController.instance:unregisterCallback(RoomEvent.DebugPackageOrderChanged, arg_4_0.refreshUI, arg_4_0)
end

function var_0_0.refreshUI(arg_5_0)
	if not RoomDebugController.instance:isDebugPackageListShow() and not RoomDebugController.instance:isDebugPlaceListShow() then
		arg_5_0:returnUI()

		return
	end

	if RoomDebugController.instance:isDebugPackageListShow() and not RoomDebugController.instance:isEditPackageOrder() then
		arg_5_0:returnUI()

		return
	end

	local var_5_0 = arg_5_0.entity:getMO()

	if RoomDebugController.instance:isDebugPackageListShow() then
		local var_5_1 = RoomDebugPackageListModel.instance:getFilterPackageId()

		if not var_5_1 or var_5_1 ~= var_5_0.packageId or var_5_1 <= 0 then
			arg_5_0:returnUI()

			return
		end

		local var_5_2 = RoomDebugPackageListModel.instance:getFilterMainRes() or RoomResourceEnum.ResourceId.Empty

		if var_5_0:getMainRes() ~= var_5_2 then
			arg_5_0:returnUI()

			return
		end

		arg_5_0:getUI()

		arg_5_0._txtcount.text = var_5_0.packageOrder

		arg_5_0:refreshPosition()
	elseif RoomDebugController.instance:isDebugPlaceListShow() then
		arg_5_0:getUI()

		local var_5_3 = var_5_0:getBlockDefineCfg()

		arg_5_0._txtcount.text = RoomHelper.getBlockPrefabName(var_5_3.prefabPath)

		arg_5_0:refreshPosition()
	end
end

function var_0_0.initUI(arg_6_0)
	arg_6_0._txtcount = gohelper.findChildText(arg_6_0._gocontainer, "txt_count")
end

function var_0_0.destoryUI(arg_7_0)
	arg_7_0._txtcount = nil
end

function var_0_0.getUIWorldPos(arg_8_0)
	local var_8_0 = arg_8_0.entity:getMO()
	local var_8_1 = HexMath.hexToPosition(var_8_0.hexPoint, RoomBlockEnum.BlockSize)

	return (Vector3(var_8_1.x, 0.5, var_8_1.y))
end

function var_0_0.onClick(arg_9_0)
	if not RoomDebugController.instance:isDebugPackageListShow() then
		return
	end

	local var_9_0 = arg_9_0.entity:getMO()

	RoomDebugController.instance:debugSetPackageOrder(var_9_0.id)
end

return var_0_0
