module("modules.logic.room.view.layout.RoomLayoutCopyView", package.seeall)

slot0 = class("RoomLayoutCopyView", RoomLayoutInputBaseView)

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
	slot0:_closeInvokeCallback(false)
end

function slot0._btnsureOnClick(slot0)
	if string.nilorempty(slot0._inputsignature:GetText()) then
		GameFacade.showToast(RoomEnum.Toast.LayoutRenameEmpty)
	else
		if not slot0.viewParam or slot0.viewParam.yesBtnNotClose ~= true then
			slot0:closeThis()
		end

		slot0:_closeInvokeCallback(true, slot1)
	end
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0._hyperLinkClick2 = slot0._txtdes.gameObject:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	slot0._hyperLinkClick2:SetClickListener(slot0._onHyperLinkClick, slot0)

	slot0._groupMessage = gohelper.findChildComponent(slot0.viewGO, "message", gohelper.Type_VerticalLayoutGroup)
end

function slot0._refreshInitUI(slot0)
	slot0._txttitlecn.text = formatLuaLang("room_layoutplan_copy_title", slot0.viewParam and slot0.viewParam.playerName or "")
	slot0._txttitleen.text = luaLang("room_layoutplan_copy_title_en")
	slot0._txtbtnsurecn.text = luaLang("room_layoutplan_copy_btn_confirm_txt")

	if slot0.viewParam then
		if string.nilorempty(slot0.viewParam.defaultName) then
			slot0._inputsignature:SetText("")
		else
			slot0._inputsignature:SetText(slot2)
		end

		if slot0:_getDesStr(slot0.viewParam.planInfo) ~= nil then
			slot0._txtdes.text = slot3
			slot0._groupMessage.enabled = false

			TaskDispatcher.runDelay(slot0._onDelayShowMessage, slot0, 0.01)
		end
	end
end

function slot0._onDelayShowMessage(slot0)
	slot0._groupMessage.enabled = true
end

function slot0._onHyperLinkClick(slot0, slot1)
	RoomLayoutController.instance:openCopyTips(slot0.viewParam.planInfo)
end

function slot0._getDesStr(slot0, slot1)
	slot2, slot3, slot4, slot5 = RoomLayoutHelper.comparePlanInfo(slot1)

	if #slot5 > 0 then
		slot6 = {}

		slot0:_addCollStrList("room_layoutplan_blockpackage_lack", slot2, slot6)
		slot0:_addCollStrList("room_layoutplan_birthdayblock_lack", slot3, slot6)
		slot0:_addCollStrList("room_layoutplan_building_lack", slot4, slot6)

		slot7 = luaLang("room_levelup_init_and1")
		slot8 = luaLang("room_levelup_init_and2")

		return GameUtil.getSubPlaceholderLuaLang(luaLang("room_layoutplan_copy_lack_desc"), {
			slot0:_connStrList(slot5, slot7, slot8, RoomEnum.LayoutCopyShowNameMaxCount),
			slot0:_connStrList(slot6, slot7, slot8)
		})
	end

	return nil
end

function slot0._addCollStrList(slot0, slot1, slot2, slot3)
	if slot2 > 0 then
		table.insert(slot3, formatLuaLang(slot1, slot2))
	end
end

function slot0._connStrList(slot0, slot1, slot2, slot3, slot4)
	return RoomLayoutHelper.connStrList(slot1, slot2, slot3, slot4)
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onDelayShowMessage, slot0)
end

return slot0
