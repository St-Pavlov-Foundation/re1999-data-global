module("modules.logic.room.controller.RoomBlockGiftController", package.seeall)

local var_0_0 = class("RoomBlockGiftController", BaseController)

function var_0_0.openBlockView(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	if RoomBlockBuildingGiftModel.instance:isAllColloct(arg_1_1) then
		GameFacade.showToast(ToastEnum.RoomBlockAllCollect)
	else
		RoomBlockBuildingGiftModel.instance:initBlockBuilding(arg_1_1)

		local var_1_0 = {
			rare = arg_1_1,
			id = arg_1_2
		}

		ViewMgr.instance:openView(ViewName.RoomBlockGiftChoiceView, var_1_0)
	end

	function arg_1_0._useGiftCallback()
		arg_1_3(arg_1_4)
	end
end

function var_0_0.useItemCallback(arg_3_0)
	RoomBlockBuildingGiftModel.instance:clearSelect()

	if arg_3_0._useGiftCallback then
		arg_3_0._useGiftCallback()

		return
	end

	if ViewMgr.instance:isOpen(ViewName.MaterialTipView) then
		ViewMgr.instance:closeView(ViewName.MaterialTipView)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
