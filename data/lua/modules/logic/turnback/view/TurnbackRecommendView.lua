module("modules.logic.turnback.view.TurnbackRecommendView", package.seeall)

local var_0_0 = class("TurnbackRecommendView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc")
	arg_1_0._gobanner = gohelper.findChild(arg_1_0.viewGO, "#go_banner")
	arg_1_0._gobannercontent = gohelper.findChild(arg_1_0.viewGO, "#go_banner/#go_bannercontent")
	arg_1_0._gobannerIcon = gohelper.findChild(arg_1_0.viewGO, "#go_banner/#go_bannercontent/#go_bannerIcon")
	arg_1_0._goslider = gohelper.findChild(arg_1_0.viewGO, "#go_banner/#go_slider")
	arg_1_0._goindexItem = gohelper.findChild(arg_1_0.viewGO, "#go_banner/#go_slider/#go_indexItem")
	arg_1_0._gobannerscroll = gohelper.findChild(arg_1_0.viewGO, "#go_banner/#go_bannerscroll")
	arg_1_0._btnjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_jump")
	arg_1_0._btnleftArrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_leftArrow")
	arg_1_0._btnrightArrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_rightArrow")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbanner:AddClickListener(arg_2_0._btnjumpOnClick, arg_2_0)
	arg_2_0._btnjump:AddClickListener(arg_2_0._btnjumpOnClick, arg_2_0)
	arg_2_0._btnleftArrow:AddClickListener(arg_2_0._btnleftArrowOnClick, arg_2_0)
	arg_2_0._btnrightArrow:AddClickListener(arg_2_0._btnrightArrowOnClick, arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0.dailyResetData, arg_2_0)
	arg_2_0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, arg_2_0.dailyResetData, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbanner:RemoveClickListener()
	arg_3_0._btnjump:RemoveClickListener()
	arg_3_0._btnleftArrow:RemoveClickListener()
	arg_3_0._btnrightArrow:RemoveClickListener()
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_3_0.dailyResetData, arg_3_0)
	arg_3_0:removeEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, arg_3_0.dailyResetData, arg_3_0)
end

var_0_0.bannerWidth = 1332
var_0_0.moveDistance = 100

function var_0_0._btnjumpOnClick(arg_4_0)
	if arg_4_0.scrollStartPos then
		return
	end

	local var_4_0 = {
		config = arg_4_0.bannerConfigTab[arg_4_0.targetIndex]
	}

	arg_4_0:onBannerClick(var_4_0)
end

function var_0_0._btnleftArrowOnClick(arg_5_0)
	if arg_5_0.configCount == 1 then
		return
	end

	arg_5_0:slidePre()
	arg_5_0:statRecommendPage(StatEnum.RecommendType.Return, StatEnum.DragType.Manual)
end

function var_0_0._btnrightArrowOnClick(arg_6_0)
	if arg_6_0.configCount == 1 then
		return
	end

	arg_6_0:slideNext()
	arg_6_0:statRecommendPage(StatEnum.RecommendType.Return, StatEnum.DragType.Manual)
end

function var_0_0.slideNext(arg_7_0)
	if arg_7_0.configCount == 1 then
		return
	end

	if arg_7_0.targetIndex >= arg_7_0.configCount then
		arg_7_0.targetIndex = 1
	else
		arg_7_0.targetIndex = arg_7_0.targetIndex + 1
	end

	arg_7_0:setBannerPos(true)
	arg_7_0:autoMoveBanner()
end

function var_0_0.slidePre(arg_8_0)
	if arg_8_0.configCount == 1 then
		return
	end

	if arg_8_0.targetIndex <= 1 then
		arg_8_0.targetIndex = arg_8_0.configCount
	else
		arg_8_0.targetIndex = arg_8_0.targetIndex - 1
	end

	arg_8_0:setBannerPos(false)
	arg_8_0:autoMoveBanner()
end

function var_0_0._onScrollDragBegin(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.scrollStartPos = arg_9_2.position
end

function var_0_0._onScrollDragEnd(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_2.position - arg_10_0.scrollStartPos
	local var_10_1 = Mathf.Abs(var_10_0.x) - var_0_0.moveDistance >= 0

	if var_10_0.x > 0 and var_10_1 then
		arg_10_0:slidePre()
		arg_10_0:statRecommendPage(StatEnum.RecommendType.Return, StatEnum.DragType.Manual)
	elseif var_10_0.x < 0 and var_10_1 then
		arg_10_0:slideNext()
		arg_10_0:statRecommendPage(StatEnum.RecommendType.Return, StatEnum.DragType.Manual)
	end

	arg_10_0.scrollStartPos = nil

	arg_10_0:autoMoveBanner()
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0.turnbackId = TurnbackModel.instance:getCurTurnbackId()

	TurnbackRecommendModel.instance:initReommendShowState(arg_11_0.turnbackId)

	arg_11_0.bannerConfigTab = {}
	arg_11_0.indexItemTab = arg_11_0:getUserDataTb_()
	arg_11_0.bannerTab = arg_11_0:getUserDataTb_()

	gohelper.setActive(arg_11_0._gobannerIcon, false)
	gohelper.setActive(arg_11_0._goindexItem, false)

	arg_11_0.targetIndex = 1
	arg_11_0.configCount = 0
	arg_11_0.layoutGroup = arg_11_0._gobannercontent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	arg_11_0.bannerContentTrans = arg_11_0._gobannercontent:GetComponent(gohelper.Type_RectTransform)
	arg_11_0._btnbanner = gohelper.getClickWithAudio(arg_11_0._gobannerscroll)
	arg_11_0._scroll = SLFramework.UGUI.UIDragListener.Get(arg_11_0._gobannerscroll)

	arg_11_0._scroll:AddDragBeginListener(arg_11_0._onScrollDragBegin, arg_11_0)
	arg_11_0._scroll:AddDragEndListener(arg_11_0._onScrollDragEnd, arg_11_0)

	arg_11_0.isMoving = false
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	local var_13_0 = arg_13_0.viewParam.parent

	arg_13_0.actId = arg_13_0.viewParam.actId

	gohelper.addChild(var_13_0, arg_13_0.viewGO)
	arg_13_0:refreshUI()
	arg_13_0:initBannerItem()
	arg_13_0:autoMoveBanner()
end

function var_0_0.refreshUI(arg_14_0)
	arg_14_0:creatAndRefreshIndexItem()

	local var_14_0 = TurnbackConfig.instance:getTurnbackSubModuleCo(arg_14_0.actId)

	arg_14_0._txtdesc.text = var_14_0.actDesc

	arg_14_0:refreshIndexItem()
	gohelper.setActive(arg_14_0._btnleftArrow.gameObject, arg_14_0.configCount > 1)
	gohelper.setActive(arg_14_0._btnrightArrow.gameObject, arg_14_0.configCount > 1)
end

function var_0_0.initBannerItem(arg_15_0)
	if GameUtil.getTabLen(arg_15_0.bannerConfigTab) == 0 then
		return
	end

	for iter_15_0 = 1, 2 do
		if not arg_15_0.bannerTab[iter_15_0] then
			local var_15_0 = {
				go = gohelper.clone(arg_15_0._gobannerIcon, arg_15_0._gobannercontent, "banner" .. iter_15_0)
			}

			var_15_0.simage = gohelper.findChildSingleImage(var_15_0.go, "simage_bannerIcon")
			var_15_0.trans = var_15_0.go:GetComponent(gohelper.Type_RectTransform)

			gohelper.setActive(var_15_0.go, true)

			arg_15_0.bannerTab[iter_15_0] = var_15_0
		end
	end

	arg_15_0.mainBanner = arg_15_0.bannerTab[1]
	arg_15_0.helpBanner = arg_15_0.bannerTab[2]
	arg_15_0.centerBannerPosX = 0
	arg_15_0.leftBannerPosX = -(var_0_0.bannerWidth + arg_15_0.layoutGroup.spacing)
	arg_15_0.rightBannerPosX = var_0_0.bannerWidth + arg_15_0.layoutGroup.spacing

	recthelper.setAnchorX(arg_15_0.mainBanner.trans, arg_15_0.centerBannerPosX)
	recthelper.setAnchorX(arg_15_0.helpBanner.trans, arg_15_0.rightBannerPosX)
	arg_15_0.mainBanner.simage:LoadImage(SLFramework.LanguageMgr.Instance:GetLangPathFromAssetPath(ResUrl.getTurnbackRecommendLangPath(arg_15_0.bannerConfigTab[arg_15_0.targetIndex].icon)))
	arg_15_0:statRecommendPage(StatEnum.RecommendType.Return, StatEnum.DragType.First)
end

function var_0_0.creatAndRefreshIndexItem(arg_16_0)
	local var_16_0 = TurnbackRecommendModel.instance:getCanShowRecommendList() or {}
	local var_16_1 = TurnbackConfig.instance:getAllRecommendList(arg_16_0.turnbackId)[1].limitCount

	arg_16_0.configCount = Mathf.Min(var_16_1, #var_16_0)

	table.sort(var_16_0, var_0_0.sortRecommend)

	for iter_16_0 = 1, arg_16_0.configCount do
		arg_16_0.bannerConfigTab[iter_16_0] = var_16_0[iter_16_0]

		local var_16_2 = arg_16_0.indexItemTab[iter_16_0]

		if not var_16_2 then
			var_16_2 = {
				go = gohelper.clone(arg_16_0._goindexItem, arg_16_0._goslider, "index" .. iter_16_0)
			}
			var_16_2.nomalstar = gohelper.findChild(var_16_2.go, "go_nomalstar")
			var_16_2.lightstar = gohelper.findChild(var_16_2.go, "go_lightstar")
			arg_16_0.indexItemTab[iter_16_0] = var_16_2
		end

		gohelper.setActive(var_16_2.go, true)
	end

	for iter_16_1 = arg_16_0.configCount + 1, #arg_16_0.indexItemTab do
		gohelper.setActive(arg_16_0.indexItemTab[iter_16_1].go, false)
	end
end

function var_0_0.onBannerClick(arg_17_0, arg_17_1)
	if arg_17_1.config and arg_17_1.config.jumpId > 0 then
		StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
			[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Return,
			[StatEnum.EventProperties.RecommendPageId] = tostring(arg_17_1.config.id),
			[StatEnum.EventProperties.RecommendPageName] = ""
		})
		GameFacade.jump(arg_17_1.config.jumpId)
	end
end

function var_0_0.sortRecommend(arg_18_0, arg_18_1)
	return arg_18_0.order < arg_18_1.order
end

function var_0_0.autoMoveBanner(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0.autoSwitch, arg_19_0)
	TaskDispatcher.runRepeat(arg_19_0.autoSwitch, arg_19_0, 5)
end

function var_0_0.autoSwitch(arg_20_0)
	arg_20_0:slideNext()

	if ViewHelper.instance:checkViewOnTheTop(arg_20_0.viewName) then
		arg_20_0:statRecommendPage(StatEnum.RecommendType.Return, StatEnum.DragType.Auto)
	end
end

function var_0_0.setBannerPos(arg_21_0, arg_21_1)
	if GameUtil.getTabLen(arg_21_0.bannerConfigTab) == 0 or arg_21_0.configCount <= 1 then
		return
	end

	recthelper.setAnchorX(arg_21_0.mainBanner.trans, arg_21_0.centerBannerPosX)

	local var_21_0 = arg_21_0.bannerConfigTab[arg_21_0.targetIndex]

	arg_21_0:refreshIndexItem()

	if arg_21_0.isMoving then
		arg_21_0:killMoveTween()
		arg_21_0:changeBanner()
		recthelper.setAnchorX(arg_21_0.mainBanner.trans, arg_21_0.centerBannerPosX)
		recthelper.setAnchorX(arg_21_0.helpBanner.trans, arg_21_1 and arg_21_0.rightBannerPosX or arg_21_0.leftBannerPosX)
	end

	arg_21_0.helpBanner.simage:LoadImage(SLFramework.LanguageMgr.Instance:GetLangPathFromAssetPath(ResUrl.getTurnbackRecommendLangPath(var_21_0.icon)))
	recthelper.setAnchorX(arg_21_0.helpBanner.trans, arg_21_1 and arg_21_0.rightBannerPosX or arg_21_0.leftBannerPosX)

	arg_21_0.helpBannerMoveTweenId = ZProj.TweenHelper.DOAnchorPosX(arg_21_0.helpBanner.trans, arg_21_0.centerBannerPosX, 0.5, arg_21_0.changeBanner, arg_21_0)
	arg_21_0.mainBannerMoveTweenId = ZProj.TweenHelper.DOAnchorPosX(arg_21_0.mainBanner.trans, arg_21_1 and arg_21_0.leftBannerPosX or arg_21_0.rightBannerPosX, 0.5)
	arg_21_0.isMoving = true
end

function var_0_0.refreshIndexItem(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.indexItemTab) do
		gohelper.setActive(iter_22_1.nomalstar, iter_22_0 ~= arg_22_0.targetIndex)
		gohelper.setActive(iter_22_1.lightstar, iter_22_0 == arg_22_0.targetIndex)
	end

	local var_22_0 = arg_22_0.bannerConfigTab[arg_22_0.targetIndex]

	gohelper.setActive(arg_22_0._btnjump.gameObject, var_22_0 and var_22_0.jumpId > 0)
end

function var_0_0.changeBanner(arg_23_0)
	arg_23_0.mainBanner, arg_23_0.helpBanner = arg_23_0.helpBanner, arg_23_0.mainBanner
	arg_23_0.isMoving = false
end

function var_0_0.dailyResetData(arg_24_0)
	arg_24_0.targetIndex = 1

	TurnbackRecommendModel.instance:initReommendShowState(arg_24_0.turnbackId)
	arg_24_0:refreshUI()
	arg_24_0:initBannerItem()
	arg_24_0:setBannerPos(true)
	arg_24_0:autoMoveBanner()
end

function var_0_0.killMoveTween(arg_25_0)
	if arg_25_0.mainBannerMoveTweenId then
		ZProj.TweenHelper.KillById(arg_25_0.mainBannerMoveTweenId)
	end

	if arg_25_0.helpBannerMoveTweenId then
		ZProj.TweenHelper.KillById(arg_25_0.helpBannerMoveTweenId)
	end
end

function var_0_0.onClose(arg_26_0)
	arg_26_0._scroll:RemoveDragBeginListener()
	arg_26_0._scroll:RemoveDragEndListener()
	TaskDispatcher.cancelTask(arg_26_0.autoSwitch, arg_26_0)
end

function var_0_0.onDestroyView(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(arg_27_0.bannerTab) do
		iter_27_1.simage:UnLoadImage()
	end

	arg_27_0:killMoveTween()
end

function var_0_0.statRecommendPage(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0.bannerConfigTab[arg_28_0.targetIndex]

	StatController.instance:track(StatEnum.EventName.ShowRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = arg_28_1,
		[StatEnum.EventProperties.ShowType] = arg_28_2,
		[StatEnum.EventProperties.RecommendPageId] = tostring(var_28_0.id)
	})
end

return var_0_0
