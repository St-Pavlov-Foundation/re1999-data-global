module("modules.logic.handbook.view.HandbookStoryView", package.seeall)

local var_0_0 = class("HandbookStoryView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "#scroll_storylist/viewport/content/linelayout/#go_line")
	arg_1_0._btnswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_switch")
	arg_1_0._gochapteritem = gohelper.findChild(arg_1_0.viewGO, "#scroll_chapterlist/viewport/content/#go_chapteritem")
	arg_1_0._scrollstorylist = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_storylist")
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnswitch:AddClickListener(arg_2_0._btnswitchOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnswitch:RemoveClickListener()
end

function var_0_0._btnswitchOnClick(arg_4_0)
	HandbookController.instance:openCGView()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._goStoryListContent = gohelper.findChild(arg_5_0.viewGO, "#scroll_storylist/viewport/content")

	gohelper.setActive(arg_5_0._gochapteritem, false)

	arg_5_0._chapterItemList = {}
	arg_5_0._storyItemList = arg_5_0:getUserDataTb_()
	arg_5_0._delayStoryAnimList = arg_5_0:getUserDataTb_()

	gohelper.setActive(arg_5_0._goline.gameObject, false)

	arg_5_0._lineSingleImageList = arg_5_0:getUserDataTb_()
	arg_5_0._lineAnimList = arg_5_0:getUserDataTb_()

	arg_5_0._simagebg:LoadImage(ResUrl.getStoryBg("story_bg/bg/huashengdunguangchang.jpg"))

	arg_5_0.itemPrefab = arg_5_0:_getStoryItemPrefab()

	gohelper.addUIClickAudio(arg_5_0._btnswitch.gameObject, AudioEnum.UI.play_ui_screenplay_plot_switch)
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_6_0._onOpenViewFinish, arg_6_0)

	arg_6_0._playLineAnim = true

	arg_6_0:_refreshUI()
end

function var_0_0._getStoryItemPrefab(arg_7_0)
	local var_7_0 = ViewMgr.instance:getContainer(ViewName.HandbookStoryView)
	local var_7_1 = var_7_0:getSetting().otherRes[1]

	return (var_7_0._abLoader:getAssetItem(var_7_1):GetResource())
end

function var_0_0.onOpenFinish(arg_8_0)
	arg_8_0._anim.enabled = true
end

function var_0_0._onOpenViewFinish(arg_9_0, arg_9_1)
	if arg_9_1 == ViewName.HandbookCGView then
		ViewMgr.instance:closeView(ViewName.HandbookStoryView, true)
	end
end

function var_0_0._refreshLine(arg_10_0, arg_10_1)
	local var_10_0 = 170 + arg_10_1 * 480 - 58 * (arg_10_1 - 1)
	local var_10_1 = recthelper.getWidth(arg_10_0._goline.transform)
	local var_10_2 = math.ceil(var_10_0 / var_10_1)

	for iter_10_0 = 1, var_10_2 do
		local var_10_3 = arg_10_0._lineSingleImageList[iter_10_0]

		if not var_10_3 then
			local var_10_4 = gohelper.cloneInPlace(arg_10_0._goline, "item" .. iter_10_0)
			local var_10_5 = var_10_4:GetComponent(typeof(UnityEngine.Animation))

			var_10_3 = gohelper.getSingleImage(var_10_4)

			var_10_3:LoadImage(ResUrl.getHandbookBg("bg_timeline"))
			table.insert(arg_10_0._lineSingleImageList, var_10_3)
			table.insert(arg_10_0._lineAnimList, var_10_5)
		end

		gohelper.setActive(var_10_3.gameObject, true)

		if arg_10_0._playLineAnim then
			arg_10_0._lineAnimList[iter_10_0]:Play()

			arg_10_0._playLineAnim = false
		end
	end

	for iter_10_1 = var_10_2 + 1, #arg_10_0._lineSingleImageList do
		local var_10_6 = arg_10_0._lineSingleImageList[iter_10_1]

		gohelper.setActive(var_10_6.gameObject, false)
		arg_10_0._lineAnimList[iter_10_1]:Stop()
	end
end

function var_0_0._refreshUI(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = HandbookConfig.instance:getStoryChapterList()

	for iter_11_0, iter_11_1 in pairs(var_11_1) do
		if HandbookModel.instance:getStoryGroupUnlockCount(iter_11_1.id) > 0 then
			table.insert(var_11_0, iter_11_1.id)
		end
	end

	for iter_11_2 = 1, #var_11_0 do
		local var_11_2 = var_11_0[iter_11_2]
		local var_11_3 = arg_11_0._chapterItemList[iter_11_2]

		if not var_11_3 then
			var_11_3 = arg_11_0:getUserDataTb_()
			var_11_3.go = gohelper.cloneInPlace(arg_11_0._gochapteritem, "item" .. iter_11_2)
			var_11_3.gobeselected = gohelper.findChild(var_11_3.go, "beselected")
			var_11_3.gounselected = gohelper.findChild(var_11_3.go, "unselected")
			var_11_3.chapternamecn1 = gohelper.findChildText(var_11_3.go, "beselected/chapternamecn")
			var_11_3.chapternameen1 = gohelper.findChildText(var_11_3.go, "beselected/chapternameen")
			var_11_3.chapternamecn2 = gohelper.findChildText(var_11_3.go, "unselected/chapternamecn")
			var_11_3.chapternameen2 = gohelper.findChildText(var_11_3.go, "unselected/chapternameen")
			var_11_3.btnclick = gohelper.findChildButtonWithAudio(var_11_3.go, "btnclick", AudioEnum.UI.Play_UI_Universal_Click)

			var_11_3.btnclick:AddClickListener(arg_11_0._btnclickOnClick, arg_11_0, var_11_3)
			table.insert(arg_11_0._chapterItemList, var_11_3)
		end

		var_11_3.storyChapterId = var_11_2

		local var_11_4 = HandbookConfig.instance:getStoryChapterConfig(var_11_2)

		var_11_3.chapternamecn1.text = var_11_4.name
		var_11_3.chapternamecn2.text = var_11_4.name
		var_11_3.chapternameen1.text = var_11_4.nameEn
		var_11_3.chapternameen2.text = var_11_4.nameEn

		gohelper.setActive(var_11_3.go, true)
	end

	for iter_11_3 = #var_11_0 + 1, #arg_11_0._chapterItemList do
		local var_11_5 = arg_11_0._chapterItemList[iter_11_3]

		gohelper.setActive(var_11_5.go, false)
	end

	if #arg_11_0._chapterItemList > 0 then
		arg_11_0:_btnclickOnClick(arg_11_0._chapterItemList[1])
	else
		HandbookStoryListModel.instance:clearStoryList()
	end
end

function var_0_0._btnclickOnClick(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.storyChapterId
	local var_12_1 = HandbookConfig.instance:getStoryGroupList()

	HandbookStoryListModel.instance:setStoryList(var_12_1, var_12_0)

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._chapterItemList) do
		gohelper.setActive(iter_12_1.gobeselected, var_12_0 == iter_12_1.storyChapterId)
		gohelper.setActive(iter_12_1.gounselected, var_12_0 ~= iter_12_1.storyChapterId)
	end

	local var_12_2 = HandbookModel.instance:getStoryGroupUnlockCount(var_12_0)

	arg_12_0:_refreshLine(var_12_2)

	arg_12_0._scrollstorylist.horizontalNormalizedPosition = 0

	arg_12_0:_cloneStoryItem()
end

function var_0_0._cloneStoryItem(arg_13_0)
	arg_13_0:_stopStoryItemEnterAnim()

	local var_13_0 = HandbookStoryListModel.instance:getStoryList()

	arg_13_0.storyItemMoList = var_13_0

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_1 = arg_13_0._storyItemList[iter_13_0]

		if not var_13_1 then
			var_13_1 = {
				go = gohelper.clone(arg_13_0.itemPrefab, arg_13_0._goStoryListContent, "item" .. iter_13_0)
			}
			var_13_1.anim = var_13_1.go:GetComponent(typeof(UnityEngine.Animator))
			var_13_1.item = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_1.go, HandbookStoryItem, arg_13_0)
			var_13_1.anim.enabled = false

			table.insert(arg_13_0._storyItemList, var_13_1)
		end

		gohelper.setActive(var_13_1.go, false)
		var_13_1.item:onInitView(var_13_1.go)
		var_13_1.item:onUpdateMO(iter_13_1)
	end

	arg_13_0.playedAnimIndex = 0

	arg_13_0:_showStoryItemEnterAnim()
end

function var_0_0._stopStoryItemEnterAnim(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._showStoryItemEnterAnim, arg_14_0)

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._storyItemList) do
		iter_14_1.anim.enabled = false

		gohelper.setActive(iter_14_1.go, false)
	end
end

function var_0_0._showStoryItemEnterAnim(arg_15_0)
	if arg_15_0.playedAnimIndex >= #arg_15_0.storyItemMoList then
		return
	end

	arg_15_0.playedAnimIndex = arg_15_0.playedAnimIndex + 1

	gohelper.setActive(arg_15_0._storyItemList[arg_15_0.playedAnimIndex].go, true)

	arg_15_0._storyItemList[arg_15_0.playedAnimIndex].anim.enabled = true

	TaskDispatcher.runDelay(arg_15_0._showStoryItemEnterAnim, arg_15_0, 0.03)
end

function var_0_0.onClose(arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0._showStoryItemEnterAnim, arg_16_0)
end

function var_0_0.onDestroyView(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0._lineSingleImageList) do
		iter_17_1:UnLoadImage()
	end

	for iter_17_2, iter_17_3 in ipairs(arg_17_0._chapterItemList) do
		iter_17_3.btnclick:RemoveClickListener()
	end

	arg_17_0._simagebg:UnLoadImage()
end

return var_0_0
