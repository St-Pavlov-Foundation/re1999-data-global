module("modules.logic.dungeon.view.DungeonEquipEntryView", package.seeall)

local var_0_0 = class("DungeonEquipEntryView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "#go_scroll")
	arg_1_0._goslider = gohelper.findChild(arg_1_0.viewGO, "#go_slider")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._btnright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_right")
	arg_1_0._btnleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_left")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnright:AddClickListener(arg_2_0._btnrightOnClick, arg_2_0)
	arg_2_0._btnleft:AddClickListener(arg_2_0._btnleftOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnright:RemoveClickListener()
	arg_3_0._btnleft:RemoveClickListener()
end

function var_0_0.playBtnLeftOrRightAudio(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
end

function var_0_0.setTargetPageIndex(arg_5_0, arg_5_1)
	arg_5_0._pageIndex = arg_5_1
end

function var_0_0.getTargetPageIndex(arg_6_0)
	return arg_6_0._pageIndex
end

function var_0_0._btnleftOnClick(arg_7_0)
	arg_7_0:setTargetPageIndex(arg_7_0:getTargetPageIndex() - 1)
	arg_7_0:selectHelpItem()
end

function var_0_0._btnrightOnClick(arg_8_0)
	arg_8_0:setTargetPageIndex(arg_8_0:getTargetPageIndex() + 1)
	arg_8_0:selectHelpItem()
end

function var_0_0._editableInitView(arg_9_0)
	gohelper.addUIClickAudio(arg_9_0._btnleft.gameObject, AudioEnum.UI.Play_UI_help_switch)
	gohelper.addUIClickAudio(arg_9_0._btnright.gameObject, AudioEnum.UI.Play_UI_help_switch)

	arg_9_0._selectItems = arg_9_0:getUserDataTb_()
	arg_9_0._helpItems = arg_9_0:getUserDataTb_()
	arg_9_0._space = recthelper.getWidth(arg_9_0.viewGO.transform) + 400
	arg_9_0._scroll = SLFramework.UGUI.UIDragListener.Get(arg_9_0._goscroll)

	arg_9_0._scroll:AddDragBeginListener(arg_9_0._onScrollDragBegin, arg_9_0)
	arg_9_0._scroll:AddDragEndListener(arg_9_0._onScrollDragEnd, arg_9_0)
end

function var_0_0._onScrollDragBegin(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._scrollStartPos = arg_10_2.position
end

function var_0_0._onScrollDragEnd(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2.position
	local var_11_1 = var_11_0.x - arg_11_0._scrollStartPos.x
	local var_11_2 = var_11_0.y - arg_11_0._scrollStartPos.y

	if math.abs(var_11_1) < math.abs(var_11_2) then
		return
	end

	if var_11_1 > 100 and arg_11_0._btnleft.gameObject.activeInHierarchy then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
		arg_11_0:setTargetPageIndex(arg_11_0:getTargetPageIndex() - 1)
		arg_11_0:selectHelpItem()
	elseif var_11_1 < -100 and arg_11_0._btnright.gameObject.activeInHierarchy then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
		arg_11_0:setTargetPageIndex(arg_11_0:getTargetPageIndex() + 1)
		arg_11_0:selectHelpItem()
	end
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0._chapterId = arg_13_0.viewParam
	arg_13_0._pagesCo = {}

	local var_13_0 = DungeonConfig.instance:getChapterEpisodeCOList(arg_13_0._chapterId)

	arg_13_0._episodeCount = #var_13_0

	local var_13_1 = 0

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		table.insert(arg_13_0._pagesCo, iter_13_1.id)

		local var_13_2 = DungeonModel.instance:getEpisodeInfo(iter_13_1.id)

		if DungeonModel.instance:hasPassLevel(iter_13_1.id) and var_13_2.challengeCount == 1 then
			var_13_1 = var_13_1 + 1
		else
			arg_13_0._readyChapterId = iter_13_1.id

			break
		end
	end

	arg_13_0:setTargetPageIndex(var_13_1 + 1)
	arg_13_0:setSelectItem()
	arg_13_0:setHelpItem()
	arg_13_0:setBtnItem()
	arg_13_0:selectHelpItem(true)
	NavigateMgr.instance:addEscape(ViewName.DungeonEquipEntryView, arg_13_0.closeThis, arg_13_0)
end

function var_0_0.setSelectItem(arg_14_0)
	local var_14_0 = arg_14_0.viewContainer:getSetting().otherRes[1]

	for iter_14_0 = 1, #arg_14_0._pagesCo do
		local var_14_1 = arg_14_0:getResInst(var_14_0, arg_14_0._goslider, "DungeonEquipEntryViewSelectItem")
		local var_14_2 = DungeonEquipEntryViewSelectItem.New()

		var_14_2:init({
			go = var_14_1,
			index = iter_14_0,
			config = arg_14_0._pagesCo[iter_14_0],
			pos = 55 * (iter_14_0 - 0.5 * (#arg_14_0._pagesCo + 1))
		})
		var_14_2:updateItem(arg_14_0:getTargetPageIndex())
		table.insert(arg_14_0._selectItems, var_14_2)
	end
end

function var_0_0.setHelpItem(arg_15_0)
	local var_15_0 = arg_15_0.viewContainer:getSetting().otherRes[2]

	for iter_15_0 = 1, #arg_15_0._pagesCo do
		local var_15_1 = arg_15_0:getResInst(var_15_0, arg_15_0._gocontent, "DungeonEquipEntryItem")
		local var_15_2 = arg_15_0._space * (iter_15_0 - 1)

		transformhelper.setLocalPos(var_15_1.transform, var_15_2, 0, 0)

		local var_15_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_1, DungeonEquipEntryItem, {
			iter_15_0,
			arg_15_0._episodeCount,
			arg_15_0._pagesCo[iter_15_0],
			#arg_15_0._pagesCo
		})

		table.insert(arg_15_0._helpItems, var_15_3)
	end
end

function var_0_0.setBtnItem(arg_16_0)
	local var_16_0 = arg_16_0:getTargetPageIndex()

	gohelper.setActive(arg_16_0._btnright.gameObject, var_16_0 < #arg_16_0._pagesCo)
	gohelper.setActive(arg_16_0._btnleft.gameObject, var_16_0 > 1)
end

function var_0_0.selectHelpItem(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in pairs(arg_17_0._selectItems) do
		iter_17_1:updateItem(arg_17_0:getTargetPageIndex())
	end

	local var_17_0 = (1 - arg_17_0:getTargetPageIndex()) * arg_17_0._space

	if arg_17_1 then
		recthelper.setAnchorX(arg_17_0._gocontent.transform, var_17_0)
	else
		ZProj.TweenHelper.DOAnchorPosX(arg_17_0._gocontent.transform, var_17_0, 0.25)
	end

	arg_17_0:setBtnItem()
end

function var_0_0.onClose(arg_18_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_help_close)
end

function var_0_0.onDestroyView(arg_19_0)
	if arg_19_0._selectItems then
		for iter_19_0, iter_19_1 in pairs(arg_19_0._selectItems) do
			iter_19_1:destroy()
		end

		arg_19_0._selectItems = nil
	end

	arg_19_0._scroll:RemoveDragBeginListener()
	arg_19_0._scroll:RemoveDragEndListener()
end

return var_0_0
