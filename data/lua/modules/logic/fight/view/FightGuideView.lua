module("modules.logic.fight.view.FightGuideView", package.seeall)

local var_0_0 = class("FightGuideView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goslider = gohelper.findChild(arg_1_0.viewGO, "#go_slider")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "mask/#go_content")
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "#go_scroll")
	arg_1_0._btnleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_left")
	arg_1_0._btnright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_right")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnleft:AddClickListener(arg_2_0._btnleftOnClick, arg_2_0)
	arg_2_0._btnright:AddClickListener(arg_2_0._btnrightOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnleft:RemoveClickListener()
	arg_3_0._btnright:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	if arg_4_0._btnright.gameObject.activeInHierarchy then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
		arg_4_0:_setSelect(arg_4_0._index + 1)
	else
		arg_4_0:closeThis()
	end
end

function var_0_0._btnleftOnClick(arg_5_0)
	arg_5_0:_setSelect(arg_5_0._index - 1)
end

function var_0_0._btnrightOnClick(arg_6_0)
	arg_6_0:_setSelect(arg_6_0._index + 1)
end

function var_0_0._editableInitView(arg_7_0)
	gohelper.addUIClickAudio(arg_7_0._btnleft.gameObject, AudioEnum.UI.Play_UI_help_switch)
	gohelper.addUIClickAudio(arg_7_0._btnright.gameObject, AudioEnum.UI.Play_UI_help_switch)

	arg_7_0._selectItems = {}
	arg_7_0._contentItems = {}
	arg_7_0._space = recthelper.getWidth(arg_7_0._gocontent.transform)
	arg_7_0._scroll = SLFramework.UGUI.UIDragListener.Get(arg_7_0._goscroll)

	arg_7_0._scroll:AddDragBeginListener(arg_7_0._onScrollDragBegin, arg_7_0)
	arg_7_0._scroll:AddDragEndListener(arg_7_0._onScrollDragEnd, arg_7_0)
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0._scroll:RemoveDragBeginListener()
	arg_8_0._scroll:RemoveDragEndListener()
end

function var_0_0._onScrollDragBegin(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._scrollStartPos = arg_9_2.position
end

function var_0_0._onScrollDragEnd(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_2.position
	local var_10_1 = var_10_0.x - arg_10_0._scrollStartPos.x
	local var_10_2 = var_10_0.y - arg_10_0._scrollStartPos.y

	if math.abs(var_10_1) < math.abs(var_10_2) then
		return
	end

	if var_10_1 > 100 and arg_10_0._btnleft.gameObject.activeInHierarchy then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
		arg_10_0:_setSelect(arg_10_0._index - 1)
	elseif var_10_1 < -100 and arg_10_0._btnright.gameObject.activeInHierarchy then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
		arg_10_0:_setSelect(arg_10_0._index + 1)
	end
end

function var_0_0.onUpdateParam(arg_11_0)
	if arg_11_0._contentItems then
		for iter_11_0, iter_11_1 in pairs(arg_11_0._contentItems) do
			gohelper.destroy(iter_11_1.go)
		end
	end

	arg_11_0._contentItems = {}

	arg_11_0:_refreshView()
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:_refreshView()
end

function var_0_0._refreshView(arg_13_0)
	if arg_13_0.viewParam then
		arg_13_0._list = arg_13_0.viewParam.viewParam
	else
		arg_13_0._list = {
			1,
			2,
			3,
			4,
			5
		}
	end

	arg_13_0:_setSelectItems()
	arg_13_0:_setContentItems()
	arg_13_0:_setSelect(1)
	gohelper.setActive(arg_13_0._goslider, #arg_13_0._list > 1)
end

function var_0_0._setSelectItems(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.viewContainer:getSetting().otherRes[1]

	for iter_14_0 = 1, #arg_14_0._list do
		local var_14_1 = arg_14_0:getResInst(var_14_0, arg_14_0._goslider, "SelectItem" .. iter_14_0)
		local var_14_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_14_1, FightTechniqueSelectItem)

		var_14_2:updateItem({
			index = iter_14_0,
			pos = 55 * (iter_14_0 - 0.5 * (#arg_14_0._list + 1))
		})
		var_14_2:setView(arg_14_0)
		table.insert(arg_14_0._selectItems, var_14_2)
	end
end

function var_0_0._setContentItems(arg_15_0)
	local var_15_0 = arg_15_0.viewContainer:getSetting().otherRes[2]
	local var_15_1 = #arg_15_0._list

	for iter_15_0 = var_15_1, 1, -1 do
		local var_15_2 = arg_15_0:getResInst(var_15_0, arg_15_0._gocontent, "ContentItem" .. iter_15_0)
		local var_15_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_2, FightGuideItem)

		var_15_3:updateItem({
			index = iter_15_0,
			maxIndex = var_15_1,
			id = arg_15_0._list[iter_15_0],
			pos = arg_15_0._space * (iter_15_0 - 1)
		})

		arg_15_0._contentItems[iter_15_0] = var_15_3
	end
end

function var_0_0._updateBtns(arg_16_0)
	gohelper.setActive(arg_16_0._btnright.gameObject, arg_16_0._index < #arg_16_0._list)
	gohelper.setActive(arg_16_0._btnleft.gameObject, arg_16_0._index > 1)
end

function var_0_0.setSelect(arg_17_0, arg_17_1)
	arg_17_0:_setSelect(arg_17_1)
end

function var_0_0._setSelect(arg_18_0, arg_18_1)
	arg_18_0._index = arg_18_1

	for iter_18_0, iter_18_1 in pairs(arg_18_0._selectItems) do
		iter_18_1:setSelect(arg_18_1)
	end

	for iter_18_2, iter_18_3 in pairs(arg_18_0._contentItems) do
		iter_18_3:setSelect(arg_18_1)
	end

	local var_18_0 = (1 - arg_18_0._index) * arg_18_0._space

	ZProj.TweenHelper.DOAnchorPosX(arg_18_0._gocontent.transform, var_18_0, 0.25)
	arg_18_0:_updateBtns()
end

function var_0_0.onClose(arg_19_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_help_close)
end

return var_0_0
