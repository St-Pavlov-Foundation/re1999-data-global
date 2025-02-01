module("modules.logic.versionactivity1_7.enter.view.VersionActivity1_7EnterViewTabItem1", package.seeall)

slot0 = class("VersionActivity1_7EnterViewTabItem1", VersionActivity1_7EnterViewBaseTabItem)

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0.simageSelectTabImg = gohelper.findChildSingleImage(slot0.rootGo, "#go_select/#simage_tabimg")
	slot0.simageUnSelectTabImg = gohelper.findChildSingleImage(slot0.rootGo, "#go_unselect/#simage_tabimg")

	slot0.simageSelectTabImg:LoadImage(VersionActivity1_7Enum.ActId2SelectImgPath[slot0.actId])
	slot0.simageUnSelectTabImg:LoadImage(VersionActivity1_7Enum.ActId2UnSelectImgPath[slot0.actId])
end

function slot0.dispose(slot0)
	slot0.simageSelectTabImg:UnLoadImage()
	slot0.simageUnSelectTabImg:UnLoadImage()
	uv0.super.dispose(slot0)
end

return slot0
