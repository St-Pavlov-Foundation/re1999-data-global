module("modules.logic.weekwalk_2.view.WeekWalk_2HeartLayerPage", package.seeall)

local var_0_0 = class("WeekWalk_2HeartLayerPage", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebgimg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bgimg")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_view")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content")
	arg_1_0._gopos = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content/#go_pos")
	arg_1_0._gopos1 = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content/#go_pos/#go_pos1")
	arg_1_0._gopos2 = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content/#go_pos/#go_pos2")
	arg_1_0._gopos3 = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content/#go_pos/#go_pos3")
	arg_1_0._gopos4 = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content/#go_pos/#go_pos4")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content/#go_line")
	arg_1_0._golight1 = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content/#go_line/line1/#go_light1")
	arg_1_0._golight2 = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content/#go_line/line2/#go_light2")
	arg_1_0._golight3 = gohelper.findChild(arg_1_0.viewGO, "#scroll_view/Viewport/#go_content/#go_line/line3/#go_light3")
	arg_1_0._gotopblock = gohelper.findChild(arg_1_0.viewGO, "#go_topblock")

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

function var_0_0.ctor(arg_4_0, arg_4_1)
	arg_4_0._layerView = arg_4_1
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._lineCtrl = arg_5_0._goline:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	arg_5_0._lineValueVec4 = Vector4.New(1, 1, 1, 0)

	arg_5_0:_initItems()
end

function var_0_0._initItems(arg_6_0)
	local var_6_0

	arg_6_0._itemList = arg_6_0:getUserDataTb_()

	for iter_6_0 = 1, WeekWalk_2Enum.MaxLayer do
		local var_6_1 = arg_6_0["_gopos" .. iter_6_0]
		local var_6_2 = arg_6_0._layerView:getResInst(arg_6_0._layerView.viewContainer._viewSetting.otherRes[2], var_6_1)
		local var_6_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_2, WeekWalk_2HeartLayerPageItem)

		table.insert(arg_6_0._itemList, var_6_3)
		var_6_3:onUpdateMO({
			index = iter_6_0,
			layerView = arg_6_0._layerView
		})

		local var_6_4 = WeekWalk_2Model.instance:getLayerInfoByLayerIndex(iter_6_0)

		if var_6_4 and var_6_4.unlock then
			var_6_0 = var_6_3

			arg_6_0:_setLineValue(WeekWalk_2Enum.LineValue[iter_6_0])
		end
	end

	arg_6_0:_checkUnlockAnim(var_6_0)
end

function var_0_0._setLineValue(arg_7_0, arg_7_1)
	arg_7_0._lineValueVec4.z = arg_7_1
	arg_7_0._lineCtrl.vector_01 = arg_7_0._lineValueVec4

	arg_7_0._lineCtrl:SetProps()
end

function var_0_0._checkUnlockAnim(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return
	end

	local var_8_0 = arg_8_1:getLayerId()

	if not var_8_0 then
		return
	end

	if WeekWalk_2Controller.hasOnceActionKey(WeekWalk_2Enum.OnceAnimType.UnlockEpisode, var_8_0) then
		return
	end

	WeekWalk_2Controller.setOnceActionKey(WeekWalk_2Enum.OnceAnimType.UnlockEpisode, var_8_0)

	arg_8_0._unlockPageItem = arg_8_1

	local var_8_1 = arg_8_1:getIndex()

	arg_8_0._startValue = WeekWalk_2Enum.LineValue[var_8_1 - 1]
	arg_8_0._endValue = WeekWalk_2Enum.LineValue[var_8_1]

	if not arg_8_0._startValue or not arg_8_0._endValue then
		return
	end

	arg_8_0._unlockPageItem:setFakeUnlock(false)
	arg_8_0:_setLineValue(arg_8_0._startValue)
	TaskDispatcher.cancelTask(arg_8_0._delayStartUnlockAnim, arg_8_0)
	TaskDispatcher.runDelay(arg_8_0._delayStartUnlockAnim, arg_8_0, 0.6)
end

function var_0_0._delayStartUnlockAnim(arg_9_0)
	arg_9_0:_startUnlockAnim()
end

function var_0_0._startUnlockAnim(arg_10_0)
	local var_10_0 = 0.3

	arg_10_0._dotweenId = ZProj.TweenHelper.DOTweenFloat(arg_10_0._startValue, arg_10_0._endValue, var_10_0, arg_10_0._everyFrame, arg_10_0._animFinish, arg_10_0)
end

function var_0_0._everyFrame(arg_11_0, arg_11_1)
	arg_11_0:_setLineValue(arg_11_1)
end

function var_0_0._animFinish(arg_12_0)
	arg_12_0:_setLineValue(arg_12_0._endValue)
	arg_12_0._unlockPageItem:setFakeUnlock(true)
	arg_12_0._unlockPageItem:playUnlockAnim()
end

function var_0_0._editableAddEvents(arg_13_0)
	return
end

function var_0_0._editableRemoveEvents(arg_14_0)
	return
end

function var_0_0.onUpdateMO(arg_15_0, arg_15_1)
	return
end

function var_0_0.onSelect(arg_16_0, arg_16_1)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._delayStartUnlockAnim, arg_17_0)

	if arg_17_0._dotweenId then
		ZProj.TweenHelper.KillById(arg_17_0._dotweenId)

		arg_17_0._dotweenId = nil
	end
end

return var_0_0
