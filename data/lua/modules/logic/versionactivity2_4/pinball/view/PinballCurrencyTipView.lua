module("modules.logic.versionactivity2_4.pinball.view.PinballCurrencyTipView", package.seeall)

slot0 = class("PinballCurrencyTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._click = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._rootTrans = gohelper.findChild(slot0.viewGO, "root").transform
	slot0._txtdesc = gohelper.findChildTextMesh(slot0.viewGO, "root/#txt_dec")
end

function slot0.addEvents(slot0)
	slot0._click:AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._click:RemoveClickListener()
end

function slot0.onOpen(slot0)
	if slot0.viewParam.arrow == "BL" then
		slot0._rootTrans.pivot = Vector2(1, 1)
	else
		slot0._rootTrans.pivot = Vector2(0, 0)
	end

	slot1 = recthelper.rectToRelativeAnchorPos(slot0.viewParam.pos, slot0.viewGO.transform.parent)

	recthelper.setAnchor(slot0._rootTrans, slot1.x, slot1.y)

	if slot0.viewParam.isMarbals then
		if not lua_activity178_marbles.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot0.viewParam.type] then
			return
		end

		slot0._txtdesc.text = slot3.desc
	else
		if not lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][slot0.viewParam.type] then
			return
		end

		slot0._txtdesc.text = slot3.tips
	end
end

return slot0
