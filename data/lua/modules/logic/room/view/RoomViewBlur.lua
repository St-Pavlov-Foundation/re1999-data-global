module("modules.logic.room.view.RoomViewBlur", package.seeall)

slot0 = class("RoomViewBlur", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._blurGO = nil
	slot0._material = nil
end

function slot0._refreshUI(slot0)
	if not slot0._blurGO then
		slot0._blurGO = slot0.viewContainer:getResInst("ppassets/uixiaowumask.prefab", slot0.viewGO, "blur")
		slot0._material = slot0._blurGO:GetComponent(typeof(UnityEngine.UI.Image)).material

		slot0:_updateBlur(0)
	end
end

function slot0._updateBlur(slot0, slot1)
	if not slot0._material then
		return
	end

	slot0._material:SetFloat("_ChangeTax", slot1 or 0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.UpdateBlur, slot0._updateBlur, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._material = nil
end

return slot0
