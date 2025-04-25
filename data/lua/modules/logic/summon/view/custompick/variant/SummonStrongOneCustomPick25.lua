module("modules.logic.summon.view.custompick.variant.SummonStrongOneCustomPick25", package.seeall)

slot0 = class("SummonStrongOneCustomPick25", SummonStrongOneCustomPickView)
slot0.preloadList = {
	"singlebg/summon/heroversion_2_3/v2a3_selfselectsix/v2a3_selfselectsix_fullbg.png",
	"singlebg/summon/heroversion_2_5/v2a5_selfselectsix2/v2a5_selfselectsix_role.png"
}

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0._btncheck1 = gohelper.findChildButton(slot0.viewGO, "#go_ui/current/#go_unselected/#btn_check_1")
	slot0._btncheck2 = gohelper.findChildButton(slot0.viewGO, "#go_ui/current/#go_selected/#btn_check_2")
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0._btncheck1:AddClickListener(slot0._btnOpenOnClick1, slot0)
	slot0._btncheck2:AddClickListener(slot0._btnOpenOnClick2, slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
	slot0._btncheck1:RemoveClickListener()
	slot0._btncheck2:RemoveClickListener()
end

function slot0._btnOpenOnClick1(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, {
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Effect,
		heroId = SummonConfig.instance:getStrongCustomChoiceIds(SummonMainModel.instance:getCurPool().id)
	})
end

function slot0._btnOpenOnClick2(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity2_3NewCultivationDetailView, {
		showType = VersionActivity2_3NewCultivationDetailView.DISPLAY_TYPE.Effect,
		heroId = slot0:getPickHeroIds(SummonMainModel.instance:getCurPool())
	})
end

return slot0
