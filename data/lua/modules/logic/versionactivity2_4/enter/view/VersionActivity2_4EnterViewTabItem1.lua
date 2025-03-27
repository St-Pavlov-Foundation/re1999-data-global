module("modules.logic.versionactivity2_4.enter.view.VersionActivity2_4EnterViewTabItem1", package.seeall)

slot0 = class("VersionActivity2_4EnterViewTabItem1", VersionActivity2_4EnterViewTabItemBase)

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0.simageSelectTabImg = gohelper.findChildSingleImage(slot0.go, "#go_select/#simage_tabimg")
	slot0._goUnSelectTab = gohelper.findChild(slot0.go, "#go_unselect/#simage_tabimg")
	slot0.simageUnSelectTabImg = slot0._goUnSelectTab:GetComponent(typeof(SLFramework.UGUI.SingleImage))
end

function slot0._getTagPath(slot0)
	return "#go_tag"
end

function slot0.afterSetData(slot0)
	uv0.super.afterSetData(slot0)

	if not slot0.actId then
		return
	end

	slot1 = VersionActivity2_4Enum.TabSetting

	slot0:setTabImg("simageSelectTabImg", slot1.select.act2TabImg[slot0.actId])

	if slot1.unselect.act2TabImg[slot0.actId] then
		slot0:setTabImg("simageUnSelectTabImg", slot3)
	end
end

function slot0.setTabImg(slot0, slot1, slot2)
	if string.nilorempty(slot1) or string.nilorempty(slot2) or not slot0[slot1] then
		return
	end

	slot0[slot1]:LoadImage(slot2)
end

function slot0.dispose(slot0)
	if slot0.simageSelectTabImg then
		slot0.simageSelectTabImg:UnLoadImage()
	end

	if slot0.simageUnSelectTabImg then
		slot0.simageUnSelectTabImg:UnLoadImage()
	end

	uv0.super.dispose(slot0)
end

return slot0
