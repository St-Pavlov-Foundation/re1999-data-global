module("modules.logic.versionactivity1_4.act132.view.Activity132CollectView", package.seeall)

slot0 = class("Activity132CollectView", BaseView)

function slot0.onInitView(slot0)
	slot0.goRoot = gohelper.findChild(slot0.viewGO, "root")
	slot0.rootRectTransform = slot0.goRoot.transform
	slot0._goContent = gohelper.findChild(slot0.viewGO, "root/Scroll View/Viewport/Content")
	slot0._goMask2d = gohelper.findChild(slot0._goContent, "bg")
	slot0._gobg = gohelper.findChild(slot0._goContent, "bg/#simage_bg")
	slot0._simagebg = gohelper.findChildSingleImage(slot0._goContent, "bg/#simage_bg")
	slot0._simagebgfull = gohelper.findChildSingleImage(slot0._goContent, "bg/bgfull")
	slot0._bgFullCanvasGroup = gohelper.findChildComponent(slot0._goContent, "bg/bgfull", gohelper.Type_CanvasGroup)
	slot0._gobgmask = gohelper.findChild(slot0._goContent, "#simagebg_mask")
	slot0._simagebgmask = gohelper.findChildSingleImage(slot0._goContent, "#simagebg_mask")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "root/canvas/#simage_mask")
	slot0._goChapterItem = gohelper.findChild(slot0.viewGO, "root/canvas/line/#scroll_chapterlist/viewport/content/#go_chapteritem")
	slot0._goClueItem = gohelper.findChild(slot0._goContent, "#go_clues/#go_clueitem")
	slot0._goMask = gohelper.findChild(slot0._goContent, "#go_mask")

	gohelper.setActive(slot0._goChapterItem, false)

	slot0.chapterItemList = {}
	slot0.clueItemList = {}
	slot0.tweenDuration = 0.6
	slot0.goSelect = gohelper.findChild(slot0.viewGO, "image_select")
	slot0.goCanvas = gohelper.findChild(slot0.viewGO, "root/canvas")
	slot0.selectPosX, slot0.selectPosY, slot0.selectPosZ = transformhelper.getPos(slot0.goSelect.transform)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Activity132Controller.instance, Activity132Event.OnChangeCollect, slot0.onChangeCollect, slot0)
	slot0:addEventCb(Activity132Controller.instance, Activity132Event.OnForceClueItem, slot0.onForceClueItem, slot0)
	slot0:addEventCb(Activity132Controller.instance, Activity132Event.OnUpdateInfo, slot0.onUpdateInfo, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(Activity132Controller.instance, Activity132Event.OnChangeCollect, slot0.onChangeCollect, slot0)
	slot0:removeEventCb(Activity132Controller.instance, Activity132Event.OnForceClueItem, slot0.onForceClueItem, slot0)
	slot0:removeEventCb(Activity132Controller.instance, Activity132Event.OnUpdateInfo, slot0.onUpdateInfo, slot0)
end

function slot0._editableInitView(slot0)
	slot0._simagemask:LoadImage("singlebg/v1a4_collect_singlebg/v1a4_collect_shadow.png")
	slot0._simagebgmask:LoadImage("singlebg/v1a4_collect_singlebg/v1a4_collect_img_fullmask.png")
	slot0._simagebgfull:LoadImage("singlebg/v1a4_collect_singlebg/seasonsecretlandentrance_mask.png")
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId

	ActivityEnterMgr.instance:enterActivity(slot0.actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		slot0.actId
	})
	slot0:refreshChapterList()
end

function slot0.onUpdateInfo(slot0)
	slot0:refreshChapterList()
end

function slot0.onChangeCollect(slot0)
	if not Activity132Model.instance:getActMoById(slot0.actId) then
		return
	end

	slot2 = slot1:getSelectCollectId()

	if slot0.chapterItemList then
		for slot6, slot7 in pairs(slot0.chapterItemList) do
			slot7:setSelectId(slot2)
		end
	end

	slot0:setSelect(slot2)
end

function slot0.refreshChapterList(slot0)
	if not Activity132Model.instance:getActMoById(slot0.actId) then
		return
	end

	slot2 = slot1:getSelectCollectId()
	slot7 = #slot0.chapterItemList

	for slot7 = 1, math.max(#slot1:getCollectList(), slot7) do
		if not slot0.chapterItemList[slot7] then
			slot0.chapterItemList[slot7] = slot0:createChapterItem(slot7)
		end

		if slot2 == nil then
			slot2 = slot3[slot7] and slot3[slot7].collectId
		end

		slot8:setData(slot3[slot7], slot2)
	end

	slot1:setSelectCollectId(slot2)
	slot0:setSelect(slot2)
end

function slot0.setSelect(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mail_open_1)

	if Activity132Config.instance:getCollectConfig(slot0.actId, slot1) then
		slot0._simagebg:LoadImage(slot2.bg)
	end

	slot0:refreshClueList(slot1)
end

function slot0.createChapterItem(slot0, slot1)
	return Activity132CollectItem.New(gohelper.cloneInPlace(slot0._goChapterItem, string.format("item%s", slot1)))
end

function slot0.refreshClueList(slot0, slot1)
	slot0.curCollectId = slot1

	if not Activity132Model.instance:getActMoById(slot0.actId) then
		return
	end

	slot3, slot4 = recthelper.getAnchor(slot0._goContent.transform)

	recthelper.setAnchor(slot0._goContent.transform, 0, 0)

	slot6 = slot2:getCollectMo(slot1) and slot5:getClueList() or {}
	slot10 = #slot0.clueItemList

	for slot10 = 1, math.max(#slot6, slot10) do
		if not slot0.clueItemList[slot10] then
			slot0.clueItemList[slot10] = slot0:createClueItem(slot10)
		end

		slot11:setData(slot6[slot10])
	end

	slot0:refreshMask()
	recthelper.setAnchor(slot0._goContent.transform, slot3, slot4)
end

function slot0.refreshMask(slot0)
	slot1, slot2 = nil

	for slot6, slot7 in ipairs(slot0.clueItemList) do
		if slot7.isVisible then
			if slot1 then
				gohelper.addChildPosStay(slot1, slot7:getMask())
			else
				gohelper.addChildPosStay(slot0._goMask, slot2)
			end

			slot1 = slot2
		end
	end

	gohelper.addChild(slot0._goMask, slot0._gobgmask)
	recthelper.setAnchor(slot0._gobgmask.transform, 0, 0)
	transformhelper.setLocalScale(slot0._gobgmask.transform, 1.5, 1.5, 1)

	if slot1 then
		gohelper.addChildPosStay(slot1, slot0._gobgmask)
	end
end

function slot0.createClueItem(slot0, slot1)
	return Activity132ClueItem.New(gohelper.cloneInPlace(slot0._goClueItem, string.format("item%s", slot1)), slot1)
end

function slot0.onForceClueItem(slot0, slot1)
	slot0.selectIndex = slot1

	UIBlockMgr.instance:startBlock("Activity132CollectView")

	if slot1 and slot0.clueItemList[slot1] and slot2.data then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)

		slot3 = slot2.data.activityId

		ViewMgr.instance:openView(ViewName.Activity132CollectDetailView, {
			actId = slot3,
			clueId = slot2.data.clueId,
			collectId = Activity132Model.instance:getSelectCollectId(slot3)
		})

		slot6, slot7, slot8 = slot2:getPos()

		slot0:playMoveTween(slot0.selectPosX - slot6 * 2, slot0.selectPosY - slot7 * 2, slot0.selectPosZ - slot8 * 2)
		slot0:playScaleTween(2)
		slot0:playDoFade(0, 0.2)
		slot0:playBgFullFade(1)
	else
		slot0:playScaleTween(1)
		slot0:playMoveTween()
		slot0:playDoFade(1, 0.1)
		slot0:playBgFullFade(0)
	end
end

function slot0.playScaleTween(slot0, slot1)
	if slot0._scaleTweenId then
		ZProj.TweenHelper.KillById(slot0._scaleTweenId)

		slot0._scaleTweenId = nil
	end

	slot0._scaleTweenId = ZProj.TweenHelper.DOScale(slot0.rootRectTransform, slot1, slot1, slot1, slot0.tweenDuration, slot0.onTweenFinish, slot0, nil, EaseType.OutQuart)
end

function slot0.onTweenFinish(slot0)
	UIBlockMgr.instance:endBlock("Activity132CollectView")
end

function slot0.playMoveTween(slot0, slot1, slot2, slot3)
	if slot0._moveTweenId then
		ZProj.TweenHelper.KillById(slot0._moveTweenId)

		slot0._moveTweenId = nil
	end

	if slot1 and slot2 and slot3 then
		slot5 = recthelper.rectToRelativeAnchorPos(Vector3.New(slot1, slot2, slot3), slot0.viewGO.transform)
		slot0._moveTweenId = ZProj.TweenHelper.DOAnchorPos(slot0.rootRectTransform, slot5.x - recthelper.getAnchorX(slot0._goContent.transform) * 2, slot5.y, slot0.tweenDuration, nil, , , EaseType.OutQuart)
	else
		slot0._moveTweenId = ZProj.TweenHelper.DOAnchorPos(slot0.rootRectTransform, 0, 0, slot0.tweenDuration, nil, , , EaseType.OutQuart)
	end
end

function slot0.playDoFade(slot0, slot1, slot2)
	if slot0._fadeTweenId then
		ZProj.TweenHelper.KillById(slot0._fadeTweenId)

		slot0._fadeTweenId = nil
	end

	slot8 = slot1
	slot9 = slot2
	slot0._fadeTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(slot0.goCanvas, slot0.goCanvas:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha, slot8, slot9, nil, , , EaseType.OutQuart)

	for slot8, slot9 in ipairs(slot0.clueItemList) do
		if slot0.selectIndex then
			slot9:resetMask()
			slot9:setActive(slot8 == slot0.selectIndex)
			slot9:setRootVisible(false)
		else
			slot9:resetMask()
			slot9:setActive(slot9.data ~= nil)
			slot9:setRootVisible(true)
		end
	end

	slot0:refreshMask()
end

function slot0.playBgFullFade(slot0, slot1)
	if slot0._fadeTweenId1 then
		ZProj.TweenHelper.KillById(slot0._fadeTweenId1)

		slot0._fadeTweenId1 = nil
	end

	slot0._fadeTweenId1 = ZProj.TweenHelper.DOFadeCanvasGroup(slot0._bgFullCanvasGroup.gameObject, slot0._bgFullCanvasGroup.alpha, slot1, slot0.tweenDuration, nil, , , EaseType.OutQuart)
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock("Activity132CollectView")
end

function slot0.onDestroyView(slot0)
	Activity132Model.instance:setSelectCollectId(slot0.actId)
	slot0._simagebg:UnLoadImage()
	slot0._simagemask:UnLoadImage()
	slot0._simagebgfull:UnLoadImage()

	if slot0.chapterItemList then
		for slot4, slot5 in pairs(slot0.chapterItemList) do
			slot5:destroy()
		end

		slot0.chapterItemList = nil
	end

	if slot0.clueItemList then
		for slot4, slot5 in pairs(slot0.clueItemList) do
			slot5:destroy()
		end

		slot0.clueItemList = nil
	end

	if slot0._scaleTweenId then
		ZProj.TweenHelper.KillById(slot0._scaleTweenId)

		slot0._scaleTweenId = nil
	end

	if slot0._moveTweenId then
		ZProj.TweenHelper.KillById(slot0._moveTweenId)

		slot0._moveTweenId = nil
	end

	if slot0._fadeTweenId then
		ZProj.TweenHelper.KillById(slot0._fadeTweenId)

		slot0._fadeTweenId = nil
	end

	if slot0._fadeTweenId1 then
		ZProj.TweenHelper.KillById(slot0._fadeTweenId1)

		slot0._fadeTweenId1 = nil
	end
end

return slot0
