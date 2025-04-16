module("modules.logic.activity.view.Vxax_Role_SignItem_SignViewContainer", package.seeall)

slot0 = string.format
slot1 = class("Vxax_Role_SignItem_SignViewContainer", Activity101SignViewBaseContainer)

function slot1.onModifyListScrollParam(slot0, slot1)
	slot1.cellClass = Vxax_Role_SignItem
	slot1.scrollGOPath = "Root/#scroll_ItemList"
	slot1.cellWidth = 220
	slot1.cellHeight = 600
	slot1.cellSpaceH = -16
end

function slot1.onBuildViews(slot0)
	return {
		slot0:getMainView()
	}
end

function slot2(slot0, slot1, slot2)
	return uv0("singlebg/v%sa%s_sign_singlebg/%s.png", slot0, slot1, slot2)
end

function slot3(slot0, slot1, slot2)
	return uv0("singlebg_lang/txt_v%sa%s_sign_singlebg/%s.png", slot0, slot1, slot2)
end

function slot1.Vxax_Role_xxxSignView_Container(slot0, slot1)
	function slot0.onGetMainViewClassType(slot0)
		return uv0
	end
end

function slot1.Vxax_Role_FullSignView_PartX(slot0, slot1, slot2, slot3)
	function slot0._editableInitView(slot0)
		GameUtil.loadSImage(slot0._simageFullBG, uv4(uv1, uv2, uv0("v%sa%s_sign_fullbg%s", uv1, uv2, uv3)))
		GameUtil.loadSImage(slot0._simageTitle, uv5(uv1, uv2, uv0("v%sa%s_sign_title_%s", uv1, uv2, uv3)))
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect1"), true)
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect2"), false)
	end
end

function slot1.Vxax_Role_PanelSignView_PartX(slot0, slot1, slot2, slot3)
	function slot0._editableInitView(slot0)
		GameUtil.loadSImage(slot0._simagePanelBG, uv4(uv1, uv2, uv0("v%sa%s_sign_panelbg%s", uv1, uv2, uv3)))
		GameUtil.loadSImage(slot0._simageTitle, uv5(uv1, uv2, uv0("v%sa%s_sign_title_%s", uv1, uv2, uv3)))
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect1"), true)
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "Root/vx_effect2"), false)
	end
end

function slot4(slot0, slot1)
	return _G[uv0(slot0, GameBranchMgr.instance:getMajorVer(), GameBranchMgr.instance:getMinorVer(), slot1)]
end

function slot1.Vxax_Role_FullSignView_PartX_ContainerImpl(slot0)
	return uv0("V%sa%s_Role_FullSignView_Part%s_Container", slot0)
end

function slot1.Vxax_Role_PanelSignView_PartX_ContainerImpl(slot0)
	return uv0("V%sa%s_Role_PanelSignView_Part%s_Container", slot0)
end

return slot1
