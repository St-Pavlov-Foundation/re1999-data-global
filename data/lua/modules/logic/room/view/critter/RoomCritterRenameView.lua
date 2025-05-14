module("modules.logic.room.view.critter.RoomCritterRenameView", package.seeall)

local var_0_0 = class("RoomCritterRenameView", RoomLayoutInputBaseView)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0._txttips = gohelper.findChildText(arg_1_0.viewGO, "tips/txt_tips")
end

function var_0_0._btnsureOnClick(arg_2_0)
	local var_2_0 = arg_2_0._inputsignature:GetText()

	if string.nilorempty(var_2_0) then
		GameFacade.showToast(ToastEnum.RoomCritterRenameEmpty)

		return
	end

	if arg_2_0._critterMO then
		RoomCritterController.instance:sendCritterRename(arg_2_0._critterMO.id, var_2_0)
	end
end

function var_0_0._getInputLimit(arg_3_0)
	return CommonConfig.instance:getConstNum(ConstEnum.RoomCritterNameLimit)
end

function var_0_0._refreshInitUI(arg_4_0)
	local var_4_0 = arg_4_0.viewParam.critterMO

	arg_4_0._critterMO = var_4_0

	if var_4_0 then
		arg_4_0._inputsignature:SetText(var_4_0:getName())
	end

	arg_4_0._txttitlecn.text = luaLang("room_critter_inputtip_rename_title")
	arg_4_0._txttitleen.text = "RENAME"
	arg_4_0._txttips.text = luaLang("room_critter_rename_fontcount_desc")
end

return var_0_0
