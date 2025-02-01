module("modules.logic.turnback.view.TurnbackRecommendView", package.seeall)

slot0 = class("TurnbackRecommendView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#txt_desc")
	slot0._gobanner = gohelper.findChild(slot0.viewGO, "#go_banner")
	slot0._gobannercontent = gohelper.findChild(slot0.viewGO, "#go_banner/#go_bannercontent")
	slot0._gobannerIcon = gohelper.findChild(slot0.viewGO, "#go_banner/#go_bannercontent/#go_bannerIcon")
	slot0._goslider = gohelper.findChild(slot0.viewGO, "#go_banner/#go_slider")
	slot0._goindexItem = gohelper.findChild(slot0.viewGO, "#go_banner/#go_slider/#go_indexItem")
	slot0._gobannerscroll = gohelper.findChild(slot0.viewGO, "#go_banner/#go_bannerscroll")
	slot0._btnjump = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_jump")
	slot0._btnleftArrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_leftArrow")
	slot0._btnrightArrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_rightArrow")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbanner:AddClickListener(slot0._btnjumpOnClick, slot0)
	slot0._btnjump:AddClickListener(slot0._btnjumpOnClick, slot0)
	slot0._btnleftArrow:AddClickListener(slot0._btnleftArrowOnClick, slot0)
	slot0._btnrightArrow:AddClickListener(slot0._btnrightArrowOnClick, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.dailyResetData, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, slot0.dailyResetData, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbanner:RemoveClickListener()
	slot0._btnjump:RemoveClickListener()
	slot0._btnleftArrow:RemoveClickListener()
	slot0._btnrightArrow:RemoveClickListener()
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0.dailyResetData, slot0)
	slot0:removeEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, slot0.dailyResetData, slot0)
end

slot0.bannerWidth = 1332
slot0.moveDistance = 100

function slot0._btnjumpOnClick(slot0)
	if slot0.scrollStartPos then
		return
	end

	slot0:onBannerClick({
		config = slot0.bannerConfigTab[slot0.targetIndex]
	})
end

function slot0._btnleftArrowOnClick(slot0)
	if slot0.configCount == 1 then
		return
	end

	slot0:slidePre()
	slot0:statRecommendPage(StatEnum.RecommendType.Return, StatEnum.DragType.Manual)
end

function slot0._btnrightArrowOnClick(slot0)
	if slot0.configCount == 1 then
		return
	end

	slot0:slideNext()
	slot0:statRecommendPage(StatEnum.RecommendType.Return, StatEnum.DragType.Manual)
end

function slot0.slideNext(slot0)
	if slot0.configCount == 1 then
		return
	end

	if slot0.configCount <= slot0.targetIndex then
		slot0.targetIndex = 1
	else
		slot0.targetIndex = slot0.targetIndex + 1
	end

	slot0:setBannerPos(true)
	slot0:autoMoveBanner()
end

function slot0.slidePre(slot0)
	if slot0.configCount == 1 then
		return
	end

	if slot0.targetIndex <= 1 then
		slot0.targetIndex = slot0.configCount
	else
		slot0.targetIndex = slot0.targetIndex - 1
	end

	slot0:setBannerPos(false)
	slot0:autoMoveBanner()
end

function slot0._onScrollDragBegin(slot0, slot1, slot2)
	slot0.scrollStartPos = slot2.position
end

function slot0._onScrollDragEnd(slot0, slot1, slot2)
	if slot3.x > 0 and Mathf.Abs((slot2.position - slot0.scrollStartPos).x) - uv0.moveDistance >= 0 then
		slot0:slidePre()
		slot0:statRecommendPage(StatEnum.RecommendType.Return, StatEnum.DragType.Manual)
	elseif slot3.x < 0 and slot4 then
		slot0:slideNext()
		slot0:statRecommendPage(StatEnum.RecommendType.Return, StatEnum.DragType.Manual)
	end

	slot0.scrollStartPos = nil

	slot0:autoMoveBanner()
end

function slot0._editableInitView(slot0)
	slot0.turnbackId = TurnbackModel.instance:getCurTurnbackId()

	TurnbackRecommendModel.instance:initReommendShowState(slot0.turnbackId)

	slot0.bannerConfigTab = {}
	slot0.indexItemTab = slot0:getUserDataTb_()
	slot0.bannerTab = slot0:getUserDataTb_()

	gohelper.setActive(slot0._gobannerIcon, false)
	gohelper.setActive(slot0._goindexItem, false)

	slot0.targetIndex = 1
	slot0.configCount = 0
	slot0.layoutGroup = slot0._gobannercontent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	slot0.bannerContentTrans = slot0._gobannercontent:GetComponent(gohelper.Type_RectTransform)
	slot0._btnbanner = gohelper.getClickWithAudio(slot0._gobannerscroll)
	slot0._scroll = SLFramework.UGUI.UIDragListener.Get(slot0._gobannerscroll)

	slot0._scroll:AddDragBeginListener(slot0._onScrollDragBegin, slot0)
	slot0._scroll:AddDragEndListener(slot0._onScrollDragEnd, slot0)

	slot0.isMoving = false
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId

	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
	slot0:refreshUI()
	slot0:initBannerItem()
	slot0:autoMoveBanner()
end

function slot0.refreshUI(slot0)
	slot0:creatAndRefreshIndexItem()

	slot0._txtdesc.text = TurnbackConfig.instance:getTurnbackSubModuleCo(slot0.actId).actDesc

	slot0:refreshIndexItem()
	gohelper.setActive(slot0._btnleftArrow.gameObject, slot0.configCount > 1)
	gohelper.setActive(slot0._btnrightArrow.gameObject, slot0.configCount > 1)
end

function slot0.initBannerItem(slot0)
	if GameUtil.getTabLen(slot0.bannerConfigTab) == 0 then
		return
	end

	for slot4 = 1, 2 do
		if not slot0.bannerTab[slot4] then
			slot5 = {
				go = gohelper.clone(slot0._gobannerIcon, slot0._gobannercontent, "banner" .. slot4)
			}
			slot5.simage = gohelper.findChildSingleImage(slot5.go, "simage_bannerIcon")
			slot5.trans = slot5.go:GetComponent(gohelper.Type_RectTransform)

			gohelper.setActive(slot5.go, true)

			slot0.bannerTab[slot4] = slot5
		end
	end

	slot0.mainBanner = slot0.bannerTab[1]
	slot0.helpBanner = slot0.bannerTab[2]
	slot0.centerBannerPosX = 0
	slot0.leftBannerPosX = -(uv0.bannerWidth + slot0.layoutGroup.spacing)
	slot0.rightBannerPosX = uv0.bannerWidth + slot0.layoutGroup.spacing

	recthelper.setAnchorX(slot0.mainBanner.trans, slot0.centerBannerPosX)
	recthelper.setAnchorX(slot0.helpBanner.trans, slot0.rightBannerPosX)
	slot0.mainBanner.simage:LoadImage(SLFramework.LanguageMgr.Instance:GetLangPathFromAssetPath(ResUrl.getTurnbackRecommendLangPath(slot0.bannerConfigTab[slot0.targetIndex].icon)))
	slot0:statRecommendPage(StatEnum.RecommendType.Return, StatEnum.DragType.First)
end

function slot0.creatAndRefreshIndexItem(slot0)
	slot1 = TurnbackRecommendModel.instance:getCanShowRecommendList() or {}
	slot0.configCount = Mathf.Min(TurnbackConfig.instance:getAllRecommendList(slot0.turnbackId)[1].limitCount, #slot1)

	table.sort(slot1, uv0.sortRecommend)

	for slot6 = 1, slot0.configCount do
		slot0.bannerConfigTab[slot6] = slot1[slot6]

		if not slot0.indexItemTab[slot6] then
			slot7 = {
				go = gohelper.clone(slot0._goindexItem, slot0._goslider, "index" .. slot6)
			}
			slot7.nomalstar = gohelper.findChild(slot7.go, "go_nomalstar")
			slot7.lightstar = gohelper.findChild(slot7.go, "go_lightstar")
			slot0.indexItemTab[slot6] = slot7
		end

		gohelper.setActive(slot7.go, true)
	end

	for slot6 = slot0.configCount + 1, #slot0.indexItemTab do
		gohelper.setActive(slot0.indexItemTab[slot6].go, false)
	end
end

function slot0.onBannerClick(slot0, slot1)
	if slot1.config and slot1.config.jumpId > 0 then
		StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
			[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Return,
			[StatEnum.EventProperties.RecommendPageId] = tostring(slot1.config.id),
			[StatEnum.EventProperties.RecommendPageName] = ""
		})
		GameFacade.jump(slot1.config.jumpId)
	end
end

function slot0.sortRecommend(slot0, slot1)
	return slot0.order < slot1.order
end

function slot0.autoMoveBanner(slot0)
	TaskDispatcher.cancelTask(slot0.autoSwitch, slot0)
	TaskDispatcher.runRepeat(slot0.autoSwitch, slot0, 5)
end

function slot0.autoSwitch(slot0)
	slot0:slideNext()

	if ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		slot0:statRecommendPage(StatEnum.RecommendType.Return, StatEnum.DragType.Auto)
	end
end

function slot0.setBannerPos(slot0, slot1)
	if GameUtil.getTabLen(slot0.bannerConfigTab) == 0 or slot0.configCount <= 1 then
		return
	end

	recthelper.setAnchorX(slot0.mainBanner.trans, slot0.centerBannerPosX)

	slot2 = slot0.bannerConfigTab[slot0.targetIndex]

	slot0:refreshIndexItem()

	if slot0.isMoving then
		slot0:killMoveTween()
		slot0:changeBanner()
		recthelper.setAnchorX(slot0.mainBanner.trans, slot0.centerBannerPosX)
		recthelper.setAnchorX(slot0.helpBanner.trans, slot1 and slot0.rightBannerPosX or slot0.leftBannerPosX)
	end

	slot0.helpBanner.simage:LoadImage(SLFramework.LanguageMgr.Instance:GetLangPathFromAssetPath(ResUrl.getTurnbackRecommendLangPath(slot2.icon)))
	recthelper.setAnchorX(slot0.helpBanner.trans, slot1 and slot0.rightBannerPosX or slot0.leftBannerPosX)

	slot0.helpBannerMoveTweenId = ZProj.TweenHelper.DOAnchorPosX(slot0.helpBanner.trans, slot0.centerBannerPosX, 0.5, slot0.changeBanner, slot0)
	slot0.mainBannerMoveTweenId = ZProj.TweenHelper.DOAnchorPosX(slot0.mainBanner.trans, slot1 and slot0.leftBannerPosX or slot0.rightBannerPosX, 0.5)
	slot0.isMoving = true
end

function slot0.refreshIndexItem(slot0)
	for slot4, slot5 in ipairs(slot0.indexItemTab) do
		gohelper.setActive(slot5.nomalstar, slot4 ~= slot0.targetIndex)
		gohelper.setActive(slot5.lightstar, slot4 == slot0.targetIndex)
	end

	gohelper.setActive(slot0._btnjump.gameObject, slot0.bannerConfigTab[slot0.targetIndex] and slot1.jumpId > 0)
end

function slot0.changeBanner(slot0)
	slot0.helpBanner = slot0.mainBanner
	slot0.mainBanner = slot0.helpBanner
	slot0.isMoving = false
end

function slot0.dailyResetData(slot0)
	slot0.targetIndex = 1

	TurnbackRecommendModel.instance:initReommendShowState(slot0.turnbackId)
	slot0:refreshUI()
	slot0:initBannerItem()
	slot0:setBannerPos(true)
	slot0:autoMoveBanner()
end

function slot0.killMoveTween(slot0)
	if slot0.mainBannerMoveTweenId then
		ZProj.TweenHelper.KillById(slot0.mainBannerMoveTweenId)
	end

	if slot0.helpBannerMoveTweenId then
		ZProj.TweenHelper.KillById(slot0.helpBannerMoveTweenId)
	end
end

function slot0.onClose(slot0)
	slot0._scroll:RemoveDragBeginListener()
	slot0._scroll:RemoveDragEndListener()
	TaskDispatcher.cancelTask(slot0.autoSwitch, slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0.bannerTab) do
		slot5.simage:UnLoadImage()
	end

	slot0:killMoveTween()
end

function slot0.statRecommendPage(slot0, slot1, slot2)
	StatController.instance:track(StatEnum.EventName.ShowRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = slot1,
		[StatEnum.EventProperties.ShowType] = slot2,
		[StatEnum.EventProperties.RecommendPageId] = tostring(slot0.bannerConfigTab[slot0.targetIndex].id)
	})
end

return slot0
