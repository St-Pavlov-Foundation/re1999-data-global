module("modules.logic.rouge.view.RougeReviewView", package.seeall)

local var_0_0 = class("RougeReviewView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_view")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content")
	arg_1_0._goMask = gohelper.findChild(arg_1_0.viewGO, "#go_Mask")
	arg_1_0._simageMask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Mask/#simage_Mask")
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "#go_Mask/#txt_Tips")
	arg_1_0._goLeftTop = gohelper.findChild(arg_1_0.viewGO, "#go_LeftTop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._initStoryStatus(arg_4_0)
	arg_4_0._unlockStageId = 0

	local var_4_0 = RougeFavoriteConfig.instance:getStoryList()

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if arg_4_0:_sotryListIsPass(iter_4_1.storyIdList) then
			arg_4_0._unlockStageId = iter_4_1.config.stageId
		end
	end
end

function var_0_0._sotryListIsPass(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		if RougeOutsideModel.instance:storyIsPass(iter_5_1) then
			return true
		end
	end
end

function var_0_0._initStoryItems(arg_6_0)
	local var_6_0 = RougeFavoriteConfig.instance:getStoryList()

	arg_6_0.storyList = var_6_0

	local var_6_1 = arg_6_0.viewContainer:getSetting().otherRes[1]
	local var_6_2 = false
	local var_6_3 = arg_6_0:_splitStorysToStageList(var_6_0)
	local var_6_4 = var_6_3 and #var_6_3 or 0

	arg_6_0._unlockStageCount = 0

	for iter_6_0 = 1, var_6_4 - 1 do
		local var_6_5 = var_6_3[iter_6_0][1]
		local var_6_6 = arg_6_0:_getStoryItem(iter_6_0, var_6_1)
		local var_6_7 = var_6_3[iter_6_0 + 1]

		var_6_2 = iter_6_0 >= var_6_4 - 1

		var_6_6.item:setMaxUnlockStateId(arg_6_0._unlockStageId)
		var_6_6.item:onUpdateMO(var_6_5, var_6_2, arg_6_0, var_6_7, var_6_1)

		if not var_6_6.item:isUnlock() then
			var_6_2 = false

			break
		end

		arg_6_0._unlockStageCount = arg_6_0._unlockStageCount + 1
	end

	gohelper.setActive(arg_6_0._goMask, not var_6_2)

	arg_6_0._isEnd = var_6_2
end

function var_0_0._getStoryItem(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._storyItemList[arg_7_1]

	if not var_7_0 then
		var_7_0 = {
			go = arg_7_0:getResInst(arg_7_2, arg_7_0._gocontent, "item" .. arg_7_1)
		}
		var_7_0.item = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_0.go, RougeReviewItem)

		var_7_0.item:setIndex(arg_7_1)
		table.insert(arg_7_0._storyItemList, var_7_0)
	end

	return var_7_0
end

function var_0_0._splitStorysToStageList(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = 1
	local var_8_2 = #arg_8_1

	while var_8_1 <= var_8_2 do
		local var_8_3, var_8_4 = arg_8_0:_findNextSameStageStory(var_8_1, arg_8_1)

		var_8_1 = var_8_3 + 1

		table.insert(var_8_0, var_8_4)
	end

	return var_8_0
end

function var_0_0._findNextSameStageStory(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2 and #arg_9_2 or 0
	local var_9_1
	local var_9_2

	for iter_9_0 = arg_9_1, var_9_0 do
		local var_9_3 = arg_9_2[iter_9_0].config.stageId

		if var_9_2 and var_9_2 ~= var_9_3 then
			break
		end

		var_9_2 = var_9_3
		var_9_1 = var_9_1 or {}

		table.insert(var_9_1, arg_9_2[iter_9_0])
	end

	local var_9_4 = var_9_1 and #var_9_1 or 0
	local var_9_5 = arg_9_1 + var_9_4 - 1

	if not var_9_4 or var_9_4 <= 0 then
		var_9_5 = var_9_5 + 1
	end

	return var_9_5, var_9_1
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._initX = 220
	arg_10_0._initY = -450
	arg_10_0._itemContentWidth = 700
	arg_10_0._itemIconWidth = 400
	arg_10_0._storyItemList = arg_10_0:getUserDataTb_()
	arg_10_0._horizontalLayoutGroup = arg_10_0._gocontent:GetComponent(gohelper.Type_HorizontalLayoutGroup)
end

function var_0_0._resetPos(arg_11_0)
	arg_11_0._rootWidth = recthelper.getWidth(arg_11_0.viewGO.transform)
	arg_11_0._viewportWidth = recthelper.getWidth(arg_11_0._scrollview.transform)
	arg_11_0._curViewportWidth = arg_11_0._viewportWidth

	local var_11_0 = (arg_11_0._unlockStageCount - 1) * arg_11_0._itemContentWidth + arg_11_0._itemIconWidth
	local var_11_1 = math.max(arg_11_0._viewportWidth - var_11_0, 0)
	local var_11_2 = var_11_0 + var_11_1

	if arg_11_0._isEnd then
		var_11_2 = var_11_2 + arg_11_0._itemContentWidth + arg_11_0._itemIconWidth
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._storyItemList) do
		local var_11_3 = iter_11_1.go

		recthelper.setAnchor(var_11_3.transform, (iter_11_0 - 1) * arg_11_0._itemContentWidth + arg_11_0._initX + var_11_1, arg_11_0._initY)
	end

	recthelper.setWidth(arg_11_0._gocontent.transform, var_11_2)
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0:_initStoryStatus()
	arg_13_0:_initStoryItems()

	if not arg_13_0._isEnd then
		local var_13_0 = arg_13_0._scrollview.transform.offsetMax

		var_13_0.x = -670
		arg_13_0._scrollview.transform.offsetMax = var_13_0
	end

	arg_13_0:_resetPos()

	arg_13_0._scrollview.horizontalNormalizedPosition = 1
	arg_13_0._scrollX = 1

	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio2)
	arg_13_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_13_0._onScreenSizeChange, arg_13_0)
	arg_13_0._scrollview:AddOnValueChanged(arg_13_0._onScrollRectValueChanged, arg_13_0)
end

function var_0_0._onScrollRectValueChanged(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0._curViewportWidth == recthelper.getWidth(arg_14_0._scrollview.transform) then
		arg_14_0._scrollX = arg_14_1
	end
end

function var_0_0._onScreenSizeChange(arg_15_0)
	arg_15_0:_resetPos()

	arg_15_0._scrollview.horizontalNormalizedPosition = arg_15_0._scrollX
end

function var_0_0.onClose(arg_16_0)
	if RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Story) > 0 then
		local var_16_0 = RougeOutsideModel.instance:season()

		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(var_16_0, RougeEnum.FavoriteType.Story, 0)
	end

	arg_16_0._scrollview:RemoveOnValueChanged()
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
