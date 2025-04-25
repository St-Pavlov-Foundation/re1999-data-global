module("modules.logic.versionactivity2_5.liangyue.view.LiangYueMeshItem", package.seeall)

slot0 = class("LiangYueMeshItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._rectTran = gohelper.findChildComponent(slot0._go, "", gohelper.Type_RectTransform)
	slot0._goEnableBg = gohelper.findChild(slot1, "lattice")
	slot0._imageEnableBg = gohelper.findChildImage(slot1, "lattice")
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0._goEnableBg, slot1)
end

function slot0.setBgColor(slot0, slot1)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imageEnableBg, slot1)
	ZProj.UGUIHelper.SetColorAlpha(slot0._imageEnableBg, LiangYueEnum.MeshAlpha)
end

function slot0.setPos(slot0, slot1, slot2)
	recthelper.setAnchor(slot0._rectTran, slot1, slot2)
end

function slot0.onDestroy(slot0)
end

return slot0
