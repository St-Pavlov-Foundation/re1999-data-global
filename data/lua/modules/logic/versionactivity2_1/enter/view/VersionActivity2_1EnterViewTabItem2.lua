module("modules.logic.versionactivity2_1.enter.view.VersionActivity2_1EnterViewTabItem2", package.seeall)

slot0 = class("VersionActivity2_1EnterViewTabItem2", VersionActivity2_1EnterViewTabItemBase)

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0.goselect = gohelper.findChild(slot0.go, "#go_unselect")
	slot0.gounselect = gohelper.findChild(slot0.go, "#go_unselect")
	slot0.txtselectName = gohelper.findChildText(slot0.go, "#go_select/#txt_name")
	slot0.txtselectNameEn = gohelper.findChildText(slot0.go, "#go_select/#txt_nameen")
	slot0.txtunselectName = gohelper.findChildText(slot0.go, "#go_unselect/#txt_name")
	slot0.txtunselectNameEn = gohelper.findChildText(slot0.go, "#go_unselect/#txt_nameen")
end

function slot0.afterSetData(slot0)
	uv0.super.afterSetData(slot0)

	slot0.txtselectName.text = slot0.activityCo and slot0.activityCo.name or ""
	slot0.txtselectNameEn.text = slot0.activityCo and slot0.activityCo.nameEn or ""
	slot0.txtunselectName.text = slot0.activityCo and slot0.activityCo.name or ""
	slot0.txtunselectNameEn.text = slot0.activityCo and slot0.activityCo.nameEn or ""
end

function slot0.childRefreshSelect(slot0, slot1)
	uv0.super.childRefreshSelect(slot0, slot1)
	gohelper.setActive(slot0.goselect, slot0.isSelect)
	gohelper.setActive(slot0.gounselect, not slot0.isSelect)
end

return slot0
