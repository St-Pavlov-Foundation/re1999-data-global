module("modules.logic.room.view.layout.RoomLayoutRenameView", package.seeall)

local var_0_0 = class("RoomLayoutRenameView", RoomLayoutInputBaseView)

function var_0_0._btnsureOnClick(arg_1_0)
	local var_1_0 = arg_1_0._inputsignature:GetText()

	if string.nilorempty(var_1_0) then
		GameFacade.showToast(RoomEnum.Toast.LayoutRenameEmpty)

		return
	end

	if arg_1_0._layoutMO then
		RoomLayoutController.instance:sendSetRoomPlanNameRpc(arg_1_0._layoutMO.id, var_1_0)
	end
end

function var_0_0._refreshInitUI(arg_2_0)
	local var_2_0 = RoomLayoutListModel.instance:getSelectMO()

	arg_2_0._layoutMO = var_2_0

	if var_2_0 then
		arg_2_0._inputsignature:SetText(var_2_0:getName())
	end

	arg_2_0._txttitlecn.text = luaLang("room_layoutplan_rename_title")
	arg_2_0._txttitleen.text = "RENAME"
	arg_2_0._txtbtnsurecn.text = luaLang("sure")
end

return var_0_0
