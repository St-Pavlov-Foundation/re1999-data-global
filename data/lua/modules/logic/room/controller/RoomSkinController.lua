module("modules.logic.room.controller.RoomSkinController", package.seeall)

local var_0_0 = class("RoomSkinController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.clearPreviewRoomSkin(arg_4_0)
	RoomSkinListModel.instance:setCurPreviewSkinId()
	arg_4_0:dispatchEvent(RoomSkinEvent.ChangePreviewRoomSkin)
end

function var_0_0.setRoomSkinListVisible(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1 ~= nil
	local var_5_1 = RoomSkinListModel.instance:getSelectPartId()
	local var_5_2 = RoomSkinModel.instance:getIsShowRoomSkinList() == var_5_0
	local var_5_3 = arg_5_1 == var_5_1

	if var_5_2 and var_5_3 then
		return
	end

	local var_5_4

	RoomSkinModel.instance:setIsShowRoomSkinList(var_5_0)

	if var_5_0 then
		RoomSkinListModel.instance:setRoomSkinList(arg_5_1)

		var_5_4 = RoomSkinModel.instance:getEquipRoomSkin(arg_5_1)
	end

	RoomSkinListModel.instance:setCurPreviewSkinId(var_5_4)
	arg_5_0:setRoomSkinMark(var_5_4)

	local var_5_5 = not var_5_2

	arg_5_0:dispatchEvent(RoomSkinEvent.SkinListViewShowChange, var_5_5)
end

function var_0_0.selectPreviewRoomSkin(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	local var_6_0 = RoomSkinListModel.instance:getCurPreviewSkinId()

	if var_6_0 and var_6_0 == arg_6_1 then
		return
	end

	RoomSkinListModel.instance:setCurPreviewSkinId(arg_6_1)
	arg_6_0:setRoomSkinMark(arg_6_1)
	arg_6_0:dispatchEvent(RoomSkinEvent.ChangePreviewRoomSkin)
end

function var_0_0.setRoomSkinMark(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	if RoomSkinModel.instance:isNewRoomSkin(arg_7_1) then
		RoomRpc.instance:sendReadRoomSkinRequest(arg_7_1)
	end
end

function var_0_0.clearInitBuildingEntranceReddot(arg_8_0, arg_8_1)
	arg_8_1 = arg_8_1 or 0

	local var_8_0 = RoomInitBuildingEnum.InitBuildingSkinReddot[arg_8_1]

	if not var_8_0 then
		return
	end

	if RedDotModel.instance:isDotShow(var_8_0, 0) then
		RedDotRpc.instance:sendShowRedDotRequest(var_8_0, false)
	end
end

function var_0_0.confirmEquipPreviewRoomSkin(arg_9_0)
	local var_9_0 = RoomSkinListModel.instance:getSelectPartId()
	local var_9_1 = RoomSkinListModel.instance:getCurPreviewSkinId()

	if not var_9_0 or not var_9_1 then
		return
	end

	if not RoomSkinModel.instance:isUnlockRoomSkin(var_9_1) then
		GameFacade.showToast(ToastEnum.SeasonEquipUnlock)

		return
	end

	if var_9_1 == RoomSkinModel.instance:getEquipRoomSkin(var_9_0) then
		GameFacade.showToast(ToastEnum.HasChangeRoomSink)

		return
	end

	RoomRpc.instance:sendSetRoomSkinRequest(var_9_0, var_9_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
