module("modules.logic.versionactivity2_0.enter.view.VersionActivity2_0EnterViewTabItem2", package.seeall)

slot0 = class("VersionActivity2_0EnterViewTabItem2", VersionActivity2_0EnterViewTabItemBase)

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0.txtName = gohelper.findChildText(slot0.go, "#txt_name")
	slot0.txtNameEn = gohelper.findChildText(slot0.go, "#txt_nameen")
end

function slot0.afterSetData(slot0)
	uv0.super.afterSetData(slot0)

	slot0.txtName.text = slot0.activityCo and slot0.activityCo.name or ""
	slot0.txtNameEn.text = slot0.activityCo and slot0.activityCo.nameEn or ""
end

function slot0.childRefreshSelect(slot0, slot1)
	uv0.super.childRefreshSelect(slot0, slot1)

	slot2 = VersionActivity2_0Enum.TabSetting.unselect

	if slot0.isSelect then
		slot2 = VersionActivity2_0Enum.TabSetting.select
	end

	slot0.txtName.color = slot2.color
	slot0.txtName.fontSize = slot2.fontSize
	slot0.txtNameEn.fontSize = slot2.enFontSize
end

return slot0
