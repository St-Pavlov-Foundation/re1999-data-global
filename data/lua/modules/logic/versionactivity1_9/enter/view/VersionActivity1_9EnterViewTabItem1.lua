module("modules.logic.versionactivity1_9.enter.view.VersionActivity1_9EnterViewTabItem1", package.seeall)

slot0 = class("VersionActivity1_9EnterViewTabItem1", VersionActivity1_9EnterViewBaseTabItem)

function slot0._editableInitView(slot0)
	slot0.simageSelectTabImg = gohelper.findChildSingleImage(slot0.rootGo, "#go_select/#simage_tabimg")
	slot0.simageUnSelectTabImg = gohelper.findChildSingleImage(slot0.rootGo, "#go_unselect/#simage_tabimg")

	uv0.super._editableInitView(slot0)
end

function slot0.refreshData(slot0)
	uv0.super.refreshData(slot0)
	slot0.simageSelectTabImg:LoadImage(VersionActivity1_9Enum.ActId2SelectImgPath[slot0.actId])
	slot0.simageUnSelectTabImg:LoadImage(VersionActivity1_9Enum.ActId2UnSelectImgPath[slot0.actId])
end

function slot0.dispose(slot0)
	slot0.simageSelectTabImg:UnLoadImage()
	slot0.simageUnSelectTabImg:UnLoadImage()
	uv0.super.dispose(slot0)
end

return slot0
