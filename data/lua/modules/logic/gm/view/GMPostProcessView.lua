module("modules.logic.gm.view.GMPostProcessView", package.seeall)

slot0 = class("GMPostProcessView", BaseView)
slot0.Pos = {
	Normal = {
		x = 0,
		y = 0
	},
	Hide = {
		x = -536,
		y = -571
	},
	Large = {
		x = 0,
		y = 451
	}
}
slot0.SrcHeight = {
	Large = 1027,
	Hide = 568,
	Normal = 568
}
slot0.State = {
	Large = "Large",
	Hide = "Hide",
	Normal = "Normal"
}

function slot0.onInitView(slot0)
	slot0._state = uv0.State.Normal
	slot0._btnNormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "Title/btnNormal")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "Title/btnClose")
	slot0._btnHide = gohelper.findChildButtonWithAudio(slot0.viewGO, "Title/btnHide")
	slot0._btnLarge = gohelper.findChildButtonWithAudio(slot0.viewGO, "Title/btnLarge")
	slot0._scrollGO = gohelper.findChild(slot0.viewGO, "scroll")
end

function slot0.addEvents(slot0)
	slot0._btnNormal:AddClickListener(slot0._onClickNormal, slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
	slot0._btnHide:AddClickListener(slot0._onClickHide, slot0)
	slot0._btnLarge:AddClickListener(slot0._onClickLarge, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnNormal:RemoveClickListener()
	slot0._btnClose:RemoveClickListener()
	slot0._btnHide:RemoveClickListener()
	slot0._btnLarge:RemoveClickListener()
end

function slot0.onOpen(slot0)
	slot0:_updateUI()
end

function slot0.onClose(slot0)
end

function slot0._updateUI(slot0)
	gohelper.setActive(slot0._btnNormal.gameObject, slot0._state == uv0.State.Large)
	gohelper.setActive(slot0._btnLarge.gameObject, slot0._state ~= uv0.State.Large)

	slot1 = uv0.Pos[slot0._state]

	recthelper.setAnchor(slot0.viewGO.transform, slot1.x, slot1.y)
	recthelper.setHeight(slot0._scrollGO.transform, uv0.SrcHeight[slot0._state])
end

function slot0._onClickNormal(slot0)
	slot0._state = uv0.State.Normal

	slot0:_updateUI()
end

function slot0._onClickHide(slot0)
	slot0._state = uv0.State.Hide

	slot0:_updateUI()
end

function slot0._onClickLarge(slot0)
	slot0._state = uv0.State.Large

	slot0:_updateUI()
end

return slot0
