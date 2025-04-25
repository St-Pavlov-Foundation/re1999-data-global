module("modules.logic.room.view.critter.RoomCritterRenameView", package.seeall)

slot0 = class("RoomCritterRenameView", RoomLayoutInputBaseView)

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0._txttips = gohelper.findChildText(slot0.viewGO, "tips/txt_tips")
end

function slot0._btnsureOnClick(slot0)
	if string.nilorempty(slot0._inputsignature:GetText()) then
		GameFacade.showToast(ToastEnum.RoomCritterRenameEmpty)

		return
	end

	if slot0._critterMO then
		RoomCritterController.instance:sendCritterRename(slot0._critterMO.id, slot1)
	end
end

function slot0._getInputLimit(slot0)
	return CommonConfig.instance:getConstNum(ConstEnum.RoomCritterNameLimit)
end

function slot0._refreshInitUI(slot0)
	slot1 = slot0.viewParam.critterMO
	slot0._critterMO = slot1

	if slot1 then
		slot0._inputsignature:SetText(slot1:getName())
	end

	slot0._txttitlecn.text = luaLang("room_critter_inputtip_rename_title")
	slot0._txttitleen.text = "RENAME"
	slot0._txttips.text = luaLang("room_critter_rename_fontcount_desc")
end

return slot0
