module("modules.logic.rouge.view.RougeIllustrationListView", package.seeall)

slot0 = class("RougeIllustrationListView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageListBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_ListBG")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_view")
	slot0._sliderprogress = gohelper.findChildSlider(slot0.viewGO, "#slider_progress")
	slot0._goLeftTop = gohelper.findChild(slot0.viewGO, "#go_LeftTop")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_LeftBottom/normal")
	slot0._godlc = gohelper.findChild(slot0.viewGO, "#go_LeftBottom/dlc")
	slot0._btnnormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_LeftBottom/normal/btn_click")
	slot0._gonormalunselect = gohelper.findChild(slot0.viewGO, "#go_LeftBottom/normal/unselect")
	slot0._gonormalselected = gohelper.findChild(slot0.viewGO, "#go_LeftBottom/normal/selected")
	slot0._btndlc = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_LeftBottom/dlc/btn_click")
	slot0._godlcunselect = gohelper.findChild(slot0.viewGO, "#go_LeftBottom/dlc/unselect")
	slot0._godlcselected = gohelper.findChild(slot0.viewGO, "#go_LeftBottom/dlc/selected")
	slot0._goscrollcontent = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/Content")
	slot0._simagedlcbg = gohelper.findChildSingleImage(slot0.viewGO, "#scroll_view/Viewport/Content/#simage_dlcbg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnormal:AddClickListener(slot0._btnnormalOnClick, slot0)
	slot0._btndlc:AddClickListener(slot0._btndlcOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnormal:RemoveClickListener()
	slot0._btndlc:RemoveClickListener()
end

function slot0._btnnormalOnClick(slot0)
	slot0:refreshButtons(RougeEnum.IllustrationType.Normal)
	slot0:focus2TargetPos(true, RougeEnum.IllustrationType.Normal)
end

function slot0._btndlcOnClick(slot0)
	slot0:refreshButtons(RougeEnum.IllustrationType.DLC)
	slot0:focus2TargetPos(true, RougeEnum.IllustrationType.DLC)
end

function slot0.refreshButtons(slot0, slot1)
	gohelper.setActive(slot0._gonormalselected, slot1 == RougeEnum.IllustrationType.Normal)
	gohelper.setActive(slot0._gonormalunselect, slot1 ~= RougeEnum.IllustrationType.Normal)
	gohelper.setActive(slot0._godlcselected, slot1 == RougeEnum.IllustrationType.DLC)
	gohelper.setActive(slot0._godlcunselect, slot1 ~= RougeEnum.IllustrationType.DLC)
end

slot1 = 0.01
slot2 = 1
slot3 = 0
slot4 = 100

function slot0.focus2TargetPos(slot0, slot1, slot2)
	slot3 = uv0

	if slot2 == RougeEnum.IllustrationType.DLC then
		slot3 = Mathf.Clamp(RougeIllustrationListModel.instance:getSplitEmptySpaceStartPosX() / (recthelper.getWidth(slot0._goscrollcontent.transform) - recthelper.getWidth(slot0._scrollview.transform)), 0, 1)
	end

	slot0:_moveScroll2TargetPos(slot1, slot3)
end

function slot0._moveScroll2TargetPos(slot0, slot1, slot2)
	slot0:killTween()
	slot0:endUIBlock()

	if slot1 then
		slot3 = true

		if uv0 < math.abs(slot2 - slot0._scrollview.horizontalNormalizedPosition) then
			slot0:startUIBlock()

			slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot4, slot2, uv1, slot0.tweenFrame, slot0.tweenFinish, slot0)
		end
	else
		slot0._scrollview.horizontalNormalizedPosition = slot2
	end
end

function slot0.tweenFrame(slot0, slot1)
	if not slot0._scrollview then
		return
	end

	slot0._scrollview.horizontalNormalizedPosition = slot1
end

function slot0.tweenFinish(slot0)
	slot0._tweenId = nil

	slot0:endUIBlock()
end

function slot0.killTween(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0.startUIBlock(slot0)
	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("RougeIllustrationTween")
end

function slot0.endUIBlock(slot0)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("RougeIllustrationTween")
end

function slot0._editableInitView(slot0)
	RougeIllustrationListModel.instance.startFrameCount = UnityEngine.Time.frameCount

	RougeIllustrationListModel.instance:initList()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio4)
	slot0:focus2TargetPos(false, RougeEnum.IllustrationType.Normal)
	slot0:setSplitImagePos()
end

function slot0.setSplitImagePos(slot0)
	slot2 = RougeFavoriteConfig.instance:getDLCIllustationPageCount() and slot1 > 0

	gohelper.setActive(slot0._simagedlcbg.gameObject, slot2)

	if not slot2 then
		return
	end

	recthelper.setAnchorX(slot0._simagedlcbg.transform, RougeIllustrationListModel.instance:getSplitEmptySpaceStartPosX() + uv0)
end

function slot0.onClose(slot0)
	if RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Illustration) > 0 then
		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(RougeOutsideModel.instance:season(), RougeEnum.FavoriteType.Illustration, 0)
	end

	slot0:killTween()
	slot0:endUIBlock()
end

function slot0.onDestroyView(slot0)
end

return slot0
