module("modules.logic.rouge.view.RougeCollectionInitialView", package.seeall)

local var_0_0 = class("RougeCollectionInitialView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagemaskbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_maskbg")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "scroll_view/Viewport/#go_content")
	arg_1_0._gocollectionitem = gohelper.findChild(arg_1_0.viewGO, "scroll_view/Viewport/#go_content/#go_collectionitem")
	arg_1_0._btnemptyBlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyBlock")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnemptyBlock:AddClickListener(arg_2_0._btnemptyBlockOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnemptyBlock:RemoveClickListener()
end

function var_0_0._btnemptyBlockOnClick(arg_4_0)
	arg_4_0:setActiveBlock(false)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._btnemptyBlockGo = arg_5_0._btnemptyBlock.gameObject
	arg_5_0._collectionObjList = {}
	arg_5_0._scrollView = gohelper.findChildScrollRect(arg_5_0.viewGO, "scroll_view")
	arg_5_0._scrollViewGo = arg_5_0._scrollView.gameObject

	arg_5_0._simagemaskbg:LoadImage("singlebg/rouge/rouge_talent_bg.png")
	gohelper.setActive(arg_5_0._gocollectionitem, false)
	arg_5_0:setActiveBlock(false)
end

function var_0_0.setActiveBlock(arg_6_0, arg_6_1)
	if arg_6_0._isBlocked == arg_6_1 then
		return
	end

	arg_6_0._isBlocked = arg_6_1

	gohelper.setActive(arg_6_0._btnemptyBlockGo, arg_6_1)

	if not arg_6_1 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0._collectionObjList) do
			iter_6_1:onCloseBlock()
		end
	end
end

function var_0_0.getScrollViewGo(arg_7_0)
	return arg_7_0._scrollViewGo
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:_refresh()
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._isBlocked = nil

	arg_9_0:onUpdateParam()

	arg_9_0._scrollView.horizontalNormalizedPosition = 0
end

function var_0_0.onOpenFinish(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_open_20190323)
end

function var_0_0._refresh(arg_11_0)
	arg_11_0:_refreshList()
end

function var_0_0._refreshList(arg_12_0)
	local var_12_0 = arg_12_0:_collectionCfgIdList()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_1

		if iter_12_0 > #arg_12_0._collectionObjList then
			var_12_1 = arg_12_0:_create_RougeCollectionInitialCollectionItem(iter_12_0)

			table.insert(arg_12_0._collectionObjList, var_12_1)
		else
			var_12_1 = arg_12_0._collectionObjList[iter_12_0]
		end

		var_12_1:onUpdateMO(iter_12_1)
		var_12_1:setActive(true)
	end

	for iter_12_2 = #var_12_0 + 1, #arg_12_0._collectionObjList do
		arg_12_0._collectionObjList[iter_12_2]:setActive(false)
	end
end

function var_0_0._collectionCfgIdList(arg_13_0)
	return arg_13_0.viewParam and arg_13_0.viewParam.collectionCfgIds or {}
end

function var_0_0.onClose(arg_14_0)
	GameUtil.onDestroyViewMember_SImage(arg_14_0, "_simagemaskbg")
	GameUtil.onDestroyViewMemberList(arg_14_0, "_collectionObjList")
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

function var_0_0._create_RougeCollectionInitialCollectionItem(arg_16_0, arg_16_1)
	local var_16_0 = gohelper.cloneInPlace(arg_16_0._gocollectionitem)
	local var_16_1 = RougeCollectionInitialCollectionItem.New({
		parent = arg_16_0,
		baseViewContainer = arg_16_0.viewContainer
	})

	var_16_1:setIndex(arg_16_1)
	var_16_1:init(var_16_0)

	return var_16_1
end

return var_0_0
