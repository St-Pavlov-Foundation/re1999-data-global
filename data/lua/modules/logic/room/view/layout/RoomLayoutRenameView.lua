module("modules.logic.room.view.layout.RoomLayoutRenameView", package.seeall)

slot0 = class("RoomLayoutRenameView", RoomLayoutInputBaseView)

function slot0._btnsureOnClick(slot0)
	if string.nilorempty(slot0._inputsignature:GetText()) then
		GameFacade.showToast(RoomEnum.Toast.LayoutRenameEmpty)

		return
	end

	if slot0._layoutMO then
		RoomLayoutController.instance:sendSetRoomPlanNameRpc(slot0._layoutMO.id, slot1)
	end
end

function slot0._refreshInitUI(slot0)
	slot1 = RoomLayoutListModel.instance:getSelectMO()
	slot0._layoutMO = slot1

	if slot1 then
		slot0._inputsignature:SetText(slot1:getName())
	end

	slot0._txttitlecn.text = luaLang("room_layoutplan_rename_title")
	slot0._txttitleen.text = "RENAME"
	slot0._txtbtnsurecn.text = luaLang("sure")
end

return slot0
