module("modules.logic.versionactivity2_5.warmup.view.V2a5_WarmUp_rewarditem", package.seeall)

slot0 = class("V2a5_WarmUp_rewarditem", RougeSimpleItemBase)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0._go_hasget = gohelper.findChild(slot0.viewGO, "go_receive/go_hasget")
	slot0._goreceive = gohelper.findChild(slot0.viewGO, "go_receive")
	slot0._gocanget = gohelper.findChild(slot0.viewGO, "go_canget")
	slot0._icon = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot0.viewGO, "go_icon"))
	slot0._hasgetAnim = slot0._go_hasget:GetComponent(gohelper.Type_Animator)

	gohelper.setActive(slot0._goreceive, true)
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goDateSelected, slot1)
	gohelper.setActive(slot0._txtDateUnSelectedGo, not slot1)
end

function slot0._getRLOC(slot0, slot1)
	return slot0:_assetGetViewContainer():getRLOC(slot1)
end

function slot0._getCurSelectedEpisode(slot0)
	return slot0:_assetGetViewContainer():getCurSelectedEpisode()
end

function slot0._isWaitingPlayHasGetAnim(slot0)
	return slot0:_assetGetViewContainer():isWaitingPlayHasGetAnim()
end

function slot0.setData(slot0, slot1)
	slot0._mo = slot1
	slot2 = slot1
	slot4, slot5, slot6, slot7 = slot0:_getRLOC(slot0:_getCurSelectedEpisode())
	slot8 = slot4 and not slot0:_isWaitingPlayHasGetAnim()

	slot0._icon:setMOValue(slot2[1], slot2[2], slot2[3])
	slot0._icon:setCountFontSize(42)
	slot0._icon:setScale(0.5)
	slot0:_setActive_canget(slot7)
	slot0:_setActive_hasget(slot8)

	if slot8 then
		slot0:_set_Received()
	end
end

slot1 = "go_hasget_in"
slot2 = "go_hasget_idle"

function slot0.playAnim_hasget(slot0, slot1)
	slot0:_setActive_canget(false)
	slot0:_setActive_hasget(not slot1)
	slot0._hasgetAnim:Play(slot1 and uv0 or uv1, 0, 0)
end

function slot0._set_Received(slot0)
	slot0._hasgetAnim:Play(uv0, 0, 1)
end

function slot0._setActive_canget(slot0, slot1)
	gohelper.setActive(slot0._gocanget, slot1)
end

function slot0._setActive_hasget(slot0, slot1)
	gohelper.setActive(slot0._go_hasget, slot1)
end

return slot0
