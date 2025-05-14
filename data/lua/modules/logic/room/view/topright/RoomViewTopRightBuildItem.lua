module("modules.logic.room.view.topright.RoomViewTopRightBuildItem", package.seeall)

local var_0_0 = class("RoomViewTopRightBuildItem", RoomViewTopRightBaseItem)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
end

function var_0_0._customOnInit(arg_2_0)
	arg_2_0._resourceItem.simageicon = gohelper.findChildImage(arg_2_0._resourceItem.go, "icon")
	arg_2_0._resourceItem.govxvitality = gohelper.findChild(arg_2_0._resourceItem.go, "vx_vitality")

	UISpriteSetMgr.instance:setRoomSprite(arg_2_0._resourceItem.simageicon, "jianshezhi")
	arg_2_0:_setShow(true)
end

function var_0_0._onClick(arg_3_0)
	if RoomController.instance:isVisitMode() then
		return
	end

	local var_3_0 = RoomMapModel.instance:getAllBuildDegree()
	local var_3_1 = RoomConfig.instance:getCharacterLimitAddByBuildDegree(var_3_0)
	local var_3_2, var_3_3, var_3_4 = RoomConfig.instance:getBuildBonusByBuildDegree(var_3_0)
	local var_3_5 = ""

	if var_3_3 > 0 then
		local var_3_6 = RoomConfig.instance:getCharacterLimitAddByBuildDegree(var_3_0 + var_3_3)
		local var_3_7 = RoomConfig.instance:getBuildBonusByBuildDegree(var_3_0 + var_3_3)
		local var_3_8 = {
			var_3_4,
			var_3_2 / 10,
			var_3_1,
			var_3_0,
			var_3_0 + var_3_3,
			var_3_7 / 10,
			var_3_6
		}
		local var_3_9 = GameUtil.getSubPlaceholderLuaLang(luaLang("room_topright_build_next"), var_3_8)
	else
		local var_3_10 = {
			var_3_4,
			var_3_2 / 10,
			var_3_1
		}
		local var_3_11 = GameUtil.getSubPlaceholderLuaLang(luaLang("room_topright_build_desc"), var_3_10)
	end

	ViewMgr.instance:openView(ViewName.RoomTipsView, {
		type = RoomTipsView.ViewType.BuildDegree
	})
end

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0:addEventCb(RoomMapController.instance, RoomEvent.ConfirmBackBlock, arg_4_0._refreshUI, arg_4_0)
	arg_4_0:addEventCb(RoomMapController.instance, RoomEvent.ConfirmBlock, arg_4_0._refreshUI, arg_4_0)
	arg_4_0:addEventCb(RoomBuildingController.instance, RoomEvent.ConfirmBuilding, arg_4_0._refreshUI, arg_4_0)
	arg_4_0:addEventCb(RoomBuildingController.instance, RoomEvent.UnUseBuilding, arg_4_0._refreshUI, arg_4_0)
	arg_4_0:addEventCb(RoomMapController.instance, RoomEvent.ClientPlaceBlock, arg_4_0._refreshAddNumUI, arg_4_0)
	arg_4_0:addEventCb(RoomMapController.instance, RoomEvent.ClientCancelBlock, arg_4_0._refreshAddNumUI, arg_4_0)
	arg_4_0:addEventCb(RoomBuildingController.instance, RoomEvent.ClientPlaceBuilding, arg_4_0._refreshAddNumUI, arg_4_0)
	arg_4_0:addEventCb(RoomBuildingController.instance, RoomEvent.ClientCancelBuilding, arg_4_0._refreshAddNumUI, arg_4_0)
	arg_4_0:addEventCb(RoomLayoutController.instance, RoomEvent.UISwitchLayoutPlanBuildDegree, arg_4_0._onSwitchBuildDegree, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	return
end

function var_0_0._onSwitchBuildDegree(arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._onSwitchLayoutAnim, arg_6_0, 1)
end

function var_0_0._onSwitchLayoutAnim(arg_7_0)
	gohelper.setActive(arg_7_0._resourceItem.govxvitality, false)
	gohelper.setActive(arg_7_0._resourceItem.govxvitality, true)
end

function var_0_0._getPlaceDegree(arg_8_0)
	if not RoomController.instance:isEditMode() then
		return 0
	end

	local var_8_0 = 0
	local var_8_1 = RoomMapBlockModel.instance:getTempBlockMO()

	if var_8_1 then
		local var_8_2 = RoomConfig.instance:getPackageConfigByBlockId(var_8_1.blockId)

		var_8_0 = var_8_0 + (var_8_2 and var_8_2.blockBuildDegree or 0)
	end

	local var_8_3 = RoomMapBuildingModel.instance:getTempBuildingMO()

	if var_8_3 and var_8_3.buildingState == RoomBuildingEnum.BuildingState.Temp then
		var_8_0 = var_8_0 + var_8_3.config.buildDegree
	end

	return var_8_0
end

function var_0_0._refreshUI(arg_9_0)
	local var_9_0 = RoomMapModel.instance:getAllBuildDegree()
	local var_9_1 = arg_9_0._lastDegree or var_9_0

	arg_9_0._lastDegree = var_9_0
	arg_9_0._resourceItem.txtquantity.text = GameUtil.numberDisplay(var_9_0)

	arg_9_0:_refreshAddNumUI()

	if var_9_1 < var_9_0 then
		gohelper.setActive(arg_9_0._resourceItem.goeffect, false)
		gohelper.setActive(arg_9_0._resourceItem.goeffect, true)

		local var_9_2 = RoomConfig.instance:getBuildBonusByBuildDegree(var_9_1)
		local var_9_3 = RoomConfig.instance:getBuildBonusByBuildDegree(var_9_0)

		if var_9_2 < var_9_3 then
			local var_9_4 = ResUrl.getRoomImage("icon_ziyuan")

			GameFacade.showToastWithIcon(ToastEnum.RoomEditDegreeBonusTip, var_9_4, var_9_3 * 0.1)
		end
	end
end

function var_0_0._refreshAddNumUI(arg_10_0)
	local var_10_0 = arg_10_0:_getPlaceDegree()

	if var_10_0 > 0 then
		arg_10_0._resourceItem.txtaddNum.text = "+" .. var_10_0
	end

	gohelper.setActive(arg_10_0._resourceItem.txtaddNum, var_10_0 > 0)
end

function var_0_0._customOnDestory(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._onSwitchLayoutAnim, arg_11_0)
end

return var_0_0
