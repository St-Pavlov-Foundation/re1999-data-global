module("modules.logic.room.view.layout.RoomLayoutFindShareView", package.seeall)

slot0 = class("RoomLayoutFindShareView", RoomLayoutInputBaseView)

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
	gohelper.setActive(gohelper.findChildText(slot0.viewGO, "tips/txt_tips"), false)
end

function slot0._btnsureOnClick(slot0)
	if string.nilorempty(slot0._inputsignature:GetText()) then
		GameFacade.showToast(RoomEnum.Toast.LayoutShareCodeEmpty)

		return
	end

	RoomLayoutController.instance:sendGetShareCodeRpc(slot1)
end

function slot0._refreshInitUI(slot0)
	slot0._txtinputlang.text = luaLang("room_layoutplan_input_sharecode_tip")
	slot0._txtbtnsurecn.text = luaLang("room_layoutplan_create_sharecode_map")
	slot0._txtbtnsureed.text = luaLang("room_layoutplan_create_sharecode_map_en")
	slot0._txttitlecn.text = luaLang("room_layoutplan_use_sharecode_title")
	slot0._txttitleen.text = luaLang("room_layoutplan_use_sharecode_title_en")
end

function slot0._checkLimit(slot0)
	slot1 = slot0._inputsignature:GetText()
	slot2 = string.gsub(slot1, "[^a-zA-Z0-9]", "")

	if GameUtil.utf8sub(slot2, 1, math.min(GameUtil.utf8len(slot2), RoomEnum.LayoutPlanShareCodeLimit)) ~= slot1 then
		slot0._inputsignature:SetText(slot4)
	end
end

return slot0
