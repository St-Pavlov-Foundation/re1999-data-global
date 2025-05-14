module("modules.logic.versionactivity1_4.act132.view.Activity132CollectView", package.seeall)

local var_0_0 = class("Activity132CollectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goRoot = gohelper.findChild(arg_1_0.viewGO, "root")
	arg_1_0.rootRectTransform = arg_1_0.goRoot.transform
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "root/Scroll View/Viewport/Content")
	arg_1_0._goMask2d = gohelper.findChild(arg_1_0._goContent, "bg")
	arg_1_0._gobg = gohelper.findChild(arg_1_0._goContent, "bg/#simage_bg")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0._goContent, "bg/#simage_bg")
	arg_1_0._simagebgfull = gohelper.findChildSingleImage(arg_1_0._goContent, "bg/bgfull")
	arg_1_0._bgFullCanvasGroup = gohelper.findChildComponent(arg_1_0._goContent, "bg/bgfull", gohelper.Type_CanvasGroup)
	arg_1_0._gobgmask = gohelper.findChild(arg_1_0._goContent, "#simagebg_mask")
	arg_1_0._simagebgmask = gohelper.findChildSingleImage(arg_1_0._goContent, "#simagebg_mask")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/canvas/#simage_mask")
	arg_1_0._goChapterItem = gohelper.findChild(arg_1_0.viewGO, "root/canvas/line/#scroll_chapterlist/viewport/content/#go_chapteritem")
	arg_1_0._goClueItem = gohelper.findChild(arg_1_0._goContent, "#go_clues/#go_clueitem")
	arg_1_0._goMask = gohelper.findChild(arg_1_0._goContent, "#go_mask")

	gohelper.setActive(arg_1_0._goChapterItem, false)

	arg_1_0.chapterItemList = {}
	arg_1_0.clueItemList = {}
	arg_1_0.tweenDuration = 0.6
	arg_1_0.goSelect = gohelper.findChild(arg_1_0.viewGO, "image_select")
	arg_1_0.goCanvas = gohelper.findChild(arg_1_0.viewGO, "root/canvas")
	arg_1_0.selectPosX, arg_1_0.selectPosY, arg_1_0.selectPosZ = transformhelper.getPos(arg_1_0.goSelect.transform)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Activity132Controller.instance, Activity132Event.OnChangeCollect, arg_2_0.onChangeCollect, arg_2_0)
	arg_2_0:addEventCb(Activity132Controller.instance, Activity132Event.OnForceClueItem, arg_2_0.onForceClueItem, arg_2_0)
	arg_2_0:addEventCb(Activity132Controller.instance, Activity132Event.OnUpdateInfo, arg_2_0.onUpdateInfo, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(Activity132Controller.instance, Activity132Event.OnChangeCollect, arg_3_0.onChangeCollect, arg_3_0)
	arg_3_0:removeEventCb(Activity132Controller.instance, Activity132Event.OnForceClueItem, arg_3_0.onForceClueItem, arg_3_0)
	arg_3_0:removeEventCb(Activity132Controller.instance, Activity132Event.OnUpdateInfo, arg_3_0.onUpdateInfo, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagemask:LoadImage("singlebg/v1a4_collect_singlebg/v1a4_collect_shadow.png")
	arg_4_0._simagebgmask:LoadImage("singlebg/v1a4_collect_singlebg/v1a4_collect_img_fullmask.png")
	arg_4_0._simagebgfull:LoadImage("singlebg/v1a4_collect_singlebg/seasonsecretlandentrance_mask.png")
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0.actId = arg_5_0.viewParam.actId

	ActivityEnterMgr.instance:enterActivity(arg_5_0.actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		arg_5_0.actId
	})
	arg_5_0:refreshChapterList()
end

function var_0_0.onUpdateInfo(arg_6_0)
	arg_6_0:refreshChapterList()
end

function var_0_0.onChangeCollect(arg_7_0)
	local var_7_0 = Activity132Model.instance:getActMoById(arg_7_0.actId)

	if not var_7_0 then
		return
	end

	local var_7_1 = var_7_0:getSelectCollectId()

	if arg_7_0.chapterItemList then
		for iter_7_0, iter_7_1 in pairs(arg_7_0.chapterItemList) do
			iter_7_1:setSelectId(var_7_1)
		end
	end

	arg_7_0:setSelect(var_7_1)
end

function var_0_0.refreshChapterList(arg_8_0)
	local var_8_0 = Activity132Model.instance:getActMoById(arg_8_0.actId)

	if not var_8_0 then
		return
	end

	local var_8_1 = var_8_0:getSelectCollectId()
	local var_8_2 = var_8_0:getCollectList()

	for iter_8_0 = 1, math.max(#var_8_2, #arg_8_0.chapterItemList) do
		local var_8_3 = arg_8_0.chapterItemList[iter_8_0]

		if not var_8_3 then
			var_8_3 = arg_8_0:createChapterItem(iter_8_0)
			arg_8_0.chapterItemList[iter_8_0] = var_8_3
		end

		if var_8_1 == nil then
			var_8_1 = var_8_2[iter_8_0] and var_8_2[iter_8_0].collectId
		end

		var_8_3:setData(var_8_2[iter_8_0], var_8_1)
	end

	var_8_0:setSelectCollectId(var_8_1)
	arg_8_0:setSelect(var_8_1)
end

function var_0_0.setSelect(arg_9_0, arg_9_1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mail_open_1)

	local var_9_0 = Activity132Config.instance:getCollectConfig(arg_9_0.actId, arg_9_1)

	if var_9_0 then
		arg_9_0._simagebg:LoadImage(var_9_0.bg)
	end

	arg_9_0:refreshClueList(arg_9_1)
end

function var_0_0.createChapterItem(arg_10_0, arg_10_1)
	local var_10_0 = gohelper.cloneInPlace(arg_10_0._goChapterItem, string.format("item%s", arg_10_1))

	return Activity132CollectItem.New(var_10_0)
end

function var_0_0.refreshClueList(arg_11_0, arg_11_1)
	arg_11_0.curCollectId = arg_11_1

	local var_11_0 = Activity132Model.instance:getActMoById(arg_11_0.actId)

	if not var_11_0 then
		return
	end

	local var_11_1, var_11_2 = recthelper.getAnchor(arg_11_0._goContent.transform)

	recthelper.setAnchor(arg_11_0._goContent.transform, 0, 0)

	local var_11_3 = var_11_0:getCollectMo(arg_11_1)
	local var_11_4 = var_11_3 and var_11_3:getClueList() or {}

	for iter_11_0 = 1, math.max(#var_11_4, #arg_11_0.clueItemList) do
		local var_11_5 = arg_11_0.clueItemList[iter_11_0]

		if not var_11_5 then
			var_11_5 = arg_11_0:createClueItem(iter_11_0)
			arg_11_0.clueItemList[iter_11_0] = var_11_5
		end

		var_11_5:setData(var_11_4[iter_11_0])
	end

	arg_11_0:refreshMask()
	recthelper.setAnchor(arg_11_0._goContent.transform, var_11_1, var_11_2)
end

function var_0_0.refreshMask(arg_12_0)
	local var_12_0
	local var_12_1

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.clueItemList) do
		if iter_12_1.isVisible then
			local var_12_2 = iter_12_1:getMask()

			if var_12_0 then
				gohelper.addChildPosStay(var_12_0, var_12_2)
			else
				gohelper.addChildPosStay(arg_12_0._goMask, var_12_2)
			end

			var_12_0 = var_12_2
		end
	end

	gohelper.addChild(arg_12_0._goMask, arg_12_0._gobgmask)
	recthelper.setAnchor(arg_12_0._gobgmask.transform, 0, 0)
	transformhelper.setLocalScale(arg_12_0._gobgmask.transform, 1.5, 1.5, 1)

	if var_12_0 then
		gohelper.addChildPosStay(var_12_0, arg_12_0._gobgmask)
	end
end

function var_0_0.createClueItem(arg_13_0, arg_13_1)
	local var_13_0 = gohelper.cloneInPlace(arg_13_0._goClueItem, string.format("item%s", arg_13_1))

	return Activity132ClueItem.New(var_13_0, arg_13_1)
end

function var_0_0.onForceClueItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1 and arg_14_0.clueItemList[arg_14_1]

	arg_14_0.selectIndex = arg_14_1

	UIBlockMgr.instance:startBlock("Activity132CollectView")

	if var_14_0 and var_14_0.data then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)

		local var_14_1 = var_14_0.data.activityId
		local var_14_2 = var_14_0.data.clueId
		local var_14_3 = Activity132Model.instance:getSelectCollectId(var_14_1)

		ViewMgr.instance:openView(ViewName.Activity132CollectDetailView, {
			actId = var_14_1,
			clueId = var_14_2,
			collectId = var_14_3
		})

		local var_14_4, var_14_5, var_14_6 = var_14_0:getPos()
		local var_14_7 = arg_14_0.selectPosX - var_14_4 * 2
		local var_14_8 = arg_14_0.selectPosY - var_14_5 * 2
		local var_14_9 = arg_14_0.selectPosZ - var_14_6 * 2

		arg_14_0:playMoveTween(var_14_7, var_14_8, var_14_9)
		arg_14_0:playScaleTween(2)
		arg_14_0:playDoFade(0, 0.2)
		arg_14_0:playBgFullFade(1)
	else
		arg_14_0:playScaleTween(1)
		arg_14_0:playMoveTween()
		arg_14_0:playDoFade(1, 0.1)
		arg_14_0:playBgFullFade(0)
	end
end

function var_0_0.playScaleTween(arg_15_0, arg_15_1)
	if arg_15_0._scaleTweenId then
		ZProj.TweenHelper.KillById(arg_15_0._scaleTweenId)

		arg_15_0._scaleTweenId = nil
	end

	arg_15_0._scaleTweenId = ZProj.TweenHelper.DOScale(arg_15_0.rootRectTransform, arg_15_1, arg_15_1, arg_15_1, arg_15_0.tweenDuration, arg_15_0.onTweenFinish, arg_15_0, nil, EaseType.OutQuart)
end

function var_0_0.onTweenFinish(arg_16_0)
	UIBlockMgr.instance:endBlock("Activity132CollectView")
end

function var_0_0.playMoveTween(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_0._moveTweenId then
		ZProj.TweenHelper.KillById(arg_17_0._moveTweenId)

		arg_17_0._moveTweenId = nil
	end

	if arg_17_1 and arg_17_2 and arg_17_3 then
		local var_17_0 = recthelper.getAnchorX(arg_17_0._goContent.transform)
		local var_17_1 = recthelper.rectToRelativeAnchorPos(Vector3.New(arg_17_1, arg_17_2, arg_17_3), arg_17_0.viewGO.transform)
		local var_17_2 = var_17_1.x - var_17_0 * 2
		local var_17_3 = var_17_1.y

		arg_17_0._moveTweenId = ZProj.TweenHelper.DOAnchorPos(arg_17_0.rootRectTransform, var_17_2, var_17_3, arg_17_0.tweenDuration, nil, nil, nil, EaseType.OutQuart)
	else
		arg_17_0._moveTweenId = ZProj.TweenHelper.DOAnchorPos(arg_17_0.rootRectTransform, 0, 0, arg_17_0.tweenDuration, nil, nil, nil, EaseType.OutQuart)
	end
end

function var_0_0.playDoFade(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0._fadeTweenId then
		ZProj.TweenHelper.KillById(arg_18_0._fadeTweenId)

		arg_18_0._fadeTweenId = nil
	end

	local var_18_0 = arg_18_0.goCanvas:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha

	arg_18_0._fadeTweenId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_18_0.goCanvas, var_18_0, arg_18_1, arg_18_2, nil, nil, nil, EaseType.OutQuart)

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.clueItemList) do
		if arg_18_0.selectIndex then
			iter_18_1:resetMask()
			iter_18_1:setActive(iter_18_0 == arg_18_0.selectIndex)
			iter_18_1:setRootVisible(false)
		else
			iter_18_1:resetMask()
			iter_18_1:setActive(iter_18_1.data ~= nil)
			iter_18_1:setRootVisible(true)
		end
	end

	arg_18_0:refreshMask()
end

function var_0_0.playBgFullFade(arg_19_0, arg_19_1)
	if arg_19_0._fadeTweenId1 then
		ZProj.TweenHelper.KillById(arg_19_0._fadeTweenId1)

		arg_19_0._fadeTweenId1 = nil
	end

	local var_19_0 = arg_19_0._bgFullCanvasGroup.alpha

	arg_19_0._fadeTweenId1 = ZProj.TweenHelper.DOFadeCanvasGroup(arg_19_0._bgFullCanvasGroup.gameObject, var_19_0, arg_19_1, arg_19_0.tweenDuration, nil, nil, nil, EaseType.OutQuart)
end

function var_0_0.onClose(arg_20_0)
	UIBlockMgr.instance:endBlock("Activity132CollectView")
end

function var_0_0.onDestroyView(arg_21_0)
	Activity132Model.instance:setSelectCollectId(arg_21_0.actId)
	arg_21_0._simagebg:UnLoadImage()
	arg_21_0._simagemask:UnLoadImage()
	arg_21_0._simagebgfull:UnLoadImage()

	if arg_21_0.chapterItemList then
		for iter_21_0, iter_21_1 in pairs(arg_21_0.chapterItemList) do
			iter_21_1:destroy()
		end

		arg_21_0.chapterItemList = nil
	end

	if arg_21_0.clueItemList then
		for iter_21_2, iter_21_3 in pairs(arg_21_0.clueItemList) do
			iter_21_3:destroy()
		end

		arg_21_0.clueItemList = nil
	end

	if arg_21_0._scaleTweenId then
		ZProj.TweenHelper.KillById(arg_21_0._scaleTweenId)

		arg_21_0._scaleTweenId = nil
	end

	if arg_21_0._moveTweenId then
		ZProj.TweenHelper.KillById(arg_21_0._moveTweenId)

		arg_21_0._moveTweenId = nil
	end

	if arg_21_0._fadeTweenId then
		ZProj.TweenHelper.KillById(arg_21_0._fadeTweenId)

		arg_21_0._fadeTweenId = nil
	end

	if arg_21_0._fadeTweenId1 then
		ZProj.TweenHelper.KillById(arg_21_0._fadeTweenId1)

		arg_21_0._fadeTweenId1 = nil
	end
end

return var_0_0
