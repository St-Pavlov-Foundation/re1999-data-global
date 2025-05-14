module("modules.logic.versionactivity1_5.act142.view.Activity142CollectView", package.seeall)

local var_0_0 = class("Activity142CollectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#simage_blackbg/#btn_close")
	arg_1_0._goScroll = gohelper.findChild(arg_1_0.viewGO, "#simage_blackbg/#scroll_reward")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#simage_blackbg/#scroll_reward/Viewport/#go_content")
	arg_1_0._scrollRect = gohelper.findChildScrollRect(arg_1_0.viewGO, "#simage_blackbg/#scroll_reward")

	if not gohelper.isNil(arg_1_0._goContent) then
		arg_1_0._gridLayout = arg_1_0._goContent:GetComponentInChildren(gohelper.Type_GridLayoutGroup)
	end

	arg_1_0._gonodeitem = gohelper.findChild(arg_1_0.viewGO, "#simage_blackbg/#scroll_reward/Viewport/#go_content/#go_nodeitem")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#simage_blackbg/bottom/cn/#txt_num")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._gonodeitem, false)

	arg_4_0.collectionItemList = {}
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:refresh()
end

function var_0_0.refresh(arg_6_0)
	local var_6_0 = Activity142Model.instance:getActivityId()
	local var_6_1 = Activity142Config.instance:getCollectionList(var_6_0)
	local var_6_2 = #var_6_1

	arg_6_0._txtnum.text = Activity142Model.instance:getHadCollectionCount() .. "/" .. var_6_2

	local var_6_3

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		local var_6_4 = arg_6_0:createCollectionItem()
		local var_6_5 = iter_6_0 ~= var_6_2

		var_6_4:setData(iter_6_0, iter_6_1, var_6_5, arg_6_0._goScroll)

		local var_6_6 = Activity142Model.instance:isHasCollection(iter_6_1)
		local var_6_7 = string.format("%s_%s", Activity142Enum.COLLECTION_CACHE_KEY, iter_6_1)
		local var_6_8 = not Activity142Controller.instance:havePlayedUnlockAni(var_6_7)

		if var_6_6 and var_6_8 then
			var_6_3 = iter_6_0
		end
	end

	ZProj.UGUIHelper.RebuildLayout(arg_6_0._goContent.transform)

	local var_6_9 = 0

	if var_6_3 and not gohelper.isNil(arg_6_0._goContent) and not gohelper.isNil(arg_6_0._gridLayout) then
		local var_6_10 = recthelper.getWidth(arg_6_0._goScroll.transform)
		local var_6_11 = recthelper.getWidth(arg_6_0._goContent.transform)
		local var_6_12 = arg_6_0._gridLayout.cellSize.x
		local var_6_13 = var_6_11 - var_6_10
		local var_6_14 = var_6_13 - (var_6_2 - var_6_3) * var_6_12

		var_6_9 = Mathf.Clamp(var_6_14 / var_6_13 + Activity142Enum.COLLECTION_VIEW_OFFSET, 0, 1)
	end

	arg_6_0._scrollRect.horizontalNormalizedPosition = var_6_9
end

function var_0_0.createCollectionItem(arg_7_0)
	local var_7_0 = gohelper.cloneInPlace(arg_7_0._gonodeitem)
	local var_7_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_0, Activity142CollectionItem)

	table.insert(arg_7_0.collectionItemList, var_7_1)

	return var_7_1
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0.collectionItemList = {}

	Activity142StatController.instance:statCollectionViewEnd()
end

return var_0_0
