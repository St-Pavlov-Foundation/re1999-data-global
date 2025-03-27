module("modules.logic.versionactivity2_4.pinball.view.PinballGameResItem", package.seeall)

slot0 = class("PinballGameResItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._txtNum = gohelper.findChildTextMesh(slot1, "#txt_num")
	slot0._imageicon = gohelper.findChildImage(slot1, "#image_icon")
	slot0._imageiconbg = gohelper.findChildImage(slot1, "#image_iconbg")
	slot0._imageball = gohelper.findChildImage(slot1, "#image_ball")
	slot0._anim = gohelper.findChildAnim(slot1, "")
end

function slot0.addEventListeners(slot0)
	PinballController.instance:registerCallback(PinballEvent.GameResChange, slot0._refreshUI, slot0)
end

function slot0.removeEventListeners(slot0)
	PinballController.instance:unregisterCallback(PinballEvent.GameResChange, slot0._refreshUI, slot0)
end

slot1 = {
	[PinballEnum.ResType.Wood] = "v2a4_tutushizi_resourcebg_1",
	[PinballEnum.ResType.Mine] = "v2a4_tutushizi_resourcebg_3",
	[PinballEnum.ResType.Stone] = "v2a4_tutushizi_resourcebg_2",
	[PinballEnum.ResType.Food] = "v2a4_tutushizi_resourcebg_4"
}
slot2 = {
	[PinballEnum.ResType.Wood] = "v2a4_tutushizi_smallball_3",
	[PinballEnum.ResType.Mine] = "v2a4_tutushizi_smallball_1",
	[PinballEnum.ResType.Stone] = "v2a4_tutushizi_smallball_4",
	[PinballEnum.ResType.Food] = "v2a4_tutushizi_smallball_2"
}

function slot0.setData(slot0, slot1)
	slot0._resType = slot1

	slot0:_refreshUI()

	if not lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot0._resType] then
		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(slot0._imageicon, slot2.icon)
	UISpriteSetMgr.instance:setAct178Sprite(slot0._imageiconbg, uv0[slot0._resType])
	UISpriteSetMgr.instance:setAct178Sprite(slot0._imageball, uv1[slot0._resType])
end

function slot0._refreshUI(slot0)
	slot1 = PinballModel.instance:getGameRes(slot0._resType)

	if slot0._cacheNum and slot0._cacheNum < slot1 and (not slot0._playAnimDt or UnityEngine.Time.realtimeSinceStartup - slot0._playAnimDt > 2) then
		slot0._anim:Play("refresh", 0, 0)

		slot0._playAnimDt = UnityEngine.Time.realtimeSinceStartup
	end

	slot0._cacheNum = slot1
	slot0._txtNum.text = slot1
end

return slot0
