module("modules.logic.versionactivity1_9.enter.view.VersionActivity1_9EnterViewTabItem2", package.seeall)

slot0 = class("VersionActivity1_9EnterViewTabItem2", VersionActivity1_9EnterViewBaseTabItem)

function slot0._editableInitView(slot0)
	slot0.txtName = gohelper.findChildText(slot0.rootGo, "#txt_name")
	slot0.txtNameEn = gohelper.findChildText(slot0.rootGo, "#txt_nameen")

	uv0.super._editableInitView(slot0)
end

function slot0.refreshData(slot0)
	uv0.super.refreshData(slot0)

	slot0.txtName.text = slot0.activityCo.name
	slot0.txtNameEn.text = slot0.activityCo.nameEn
end

function slot0.refreshSelect(slot0, slot1)
	uv0.super.refreshSelect(slot0, slot1)

	slot2 = slot1 == slot0.actId
	slot0.txtName.color = slot2 and VersionActivity1_9Enum.ActivityNameColor.Select or VersionActivity1_9Enum.ActivityNameColor.UnSelect
	slot0.txtName.fontSize = slot2 and VersionActivity1_9Enum.ActivityNameFontSize.Select or VersionActivity1_9Enum.ActivityNameFontSize.UnSelect
	slot0.txtNameEn.fontSize = slot2 and VersionActivity1_9Enum.ActivityNameEnFontSize.Select or VersionActivity1_9Enum.ActivityNameEnFontSize.UnSelect
end

return slot0
