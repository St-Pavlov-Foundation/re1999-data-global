module("modules.logic.weekwalk_2.view.WeekWalk_2ResetBattleItem", package.seeall)

local var_0_0 = class("WeekWalk_2ResetBattleItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "#go_finish")
	arg_1_0._gounfinish = gohelper.findChild(arg_1_0.viewGO, "#go_unfinish")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_selected")
	arg_1_0._godisable = gohelper.findChild(arg_1_0.viewGO, "#go_disable")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_0.viewGO, "#txt_index")
	arg_1_0._gostars2 = gohelper.findChild(arg_1_0.viewGO, "#go_stars2")
	arg_1_0._go2star1 = gohelper.findChild(arg_1_0.viewGO, "#go_stars2/#go_2star1")
	arg_1_0._go2star2 = gohelper.findChild(arg_1_0.viewGO, "#go_stars2/#go_2star2")
	arg_1_0._gostars3 = gohelper.findChild(arg_1_0.viewGO, "#go_stars3")
	arg_1_0._go3star1 = gohelper.findChild(arg_1_0.viewGO, "#go_stars3/#go_3star1")
	arg_1_0._go3star2 = gohelper.findChild(arg_1_0.viewGO, "#go_stars3/#go_3star2")
	arg_1_0._go3star3 = gohelper.findChild(arg_1_0.viewGO, "#go_stars3/#go_3star3")
	arg_1_0._goconnectline = gohelper.findChild(arg_1_0.viewGO, "#go_connectline")
	arg_1_0._gofinishline = gohelper.findChild(arg_1_0.viewGO, "#go_connectline/#go_finishline")
	arg_1_0._gounfinishline = gohelper.findChild(arg_1_0.viewGO, "#go_connectline/#go_unfinishline")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._battleInfo.star <= 0 then
		return
	end

	arg_4_0._resetView:selectBattleItem(arg_4_0)
end

function var_0_0.setSelect(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._goselected, arg_5_1)
end

function var_0_0.ctor(arg_6_0, arg_6_1)
	arg_6_0._resetView = arg_6_1[1]
	arg_6_0._battleInfo = arg_6_1[2]
	arg_6_0._index = arg_6_1[3]
	arg_6_0._battleInfos = arg_6_1[4]
	arg_6_0._maxNum = #arg_6_0._battleInfos
	arg_6_0._mapInfo = WeekWalk_2Model.instance:getCurMapInfo()
end

function var_0_0.getBattleInfo(arg_7_0)
	return arg_7_0._battleInfo
end

function var_0_0.getPrevBattleInfo(arg_8_0)
	return arg_8_0._battleInfos[arg_8_0._index - 1]
end

function var_0_0._editableInitView(arg_9_0)
	gohelper.addUIClickAudio(arg_9_0._btnclick.gameObject, AudioEnum.UI.Play_UI_Copies)

	arg_9_0._stars2CanvasGroup = gohelper.onceAddComponent(arg_9_0._gostars2, typeof(UnityEngine.CanvasGroup))
	arg_9_0._stars3CanvasGroup = gohelper.onceAddComponent(arg_9_0._gostars3, typeof(UnityEngine.CanvasGroup))
	arg_9_0._txtindex.text = string.format("0%s", arg_9_0._index)

	arg_9_0:setSelect(false)
	arg_9_0:_setNormalStatus()
end

function var_0_0._setStarStatus(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = WeekWalk_2Enum.MaxStar

	gohelper.setActive(arg_10_0._gostars2, var_10_0 == 2)
	gohelper.setActive(arg_10_0._gostars3, var_10_0 == 3)

	for iter_10_0 = 1, var_10_0 do
		local var_10_1 = arg_10_0[string.format("_go%sstar%s", var_10_0, iter_10_0)]
		local var_10_2 = iter_10_0 <= arg_10_1
		local var_10_3 = gohelper.findChild(var_10_1, "full")

		gohelper.setActive(var_10_3, var_10_2)

		if var_10_2 then
			local var_10_4 = var_10_3:GetComponent(gohelper.Type_Image)

			var_10_4.enabled = false

			local var_10_5 = arg_10_0._resetView:getResInst(arg_10_0._resetView.viewContainer._viewSetting.otherRes.weekwalkheart_star, var_10_4.gameObject)

			WeekWalk_2Helper.setCupEffect(var_10_5, arg_10_2:getCupInfo(iter_10_0))
		end
	end
end

function var_0_0._setNormalStatus(arg_11_0)
	local var_11_0 = arg_11_0:_getPrevFinish()
	local var_11_1 = arg_11_0._battleInfo.star > 0

	arg_11_0:_updateFinishLine(var_11_1)
	arg_11_0:_initBattleStatus(var_11_0, var_11_1)
	arg_11_0:_setStarStatus(arg_11_0._battleInfo.star, arg_11_0._battleInfo)
end

function var_0_0._setFakedStatus(arg_12_0, arg_12_1)
	arg_12_0:_updateFinishLine(false)

	local var_12_0 = arg_12_0._battleInfo.star > 0
	local var_12_1 = arg_12_0:_getPrevFinish()

	if not var_12_0 and var_12_1 then
		arg_12_0:_initBattleStatus(false, var_12_0)

		return
	end

	if not arg_12_1 then
		var_12_0 = false
	end

	arg_12_0:_initBattleStatus(var_12_1, var_12_0)
end

function var_0_0.setFakedReset(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 then
		arg_13_0:_setFakedStatus(arg_13_2)
	else
		arg_13_0:_setNormalStatus()
	end
end

function var_0_0._updateFinishLine(arg_14_0, arg_14_1)
	if arg_14_0._index < arg_14_0._maxNum then
		gohelper.setActive(arg_14_0._gofinishline, arg_14_1)
		gohelper.setActive(arg_14_0._gounfinishline, not arg_14_1)
	else
		gohelper.setActive(arg_14_0._gofinishline, false)
		gohelper.setActive(arg_14_0._gounfinishline, false)
	end
end

function var_0_0._initBattleStatus(arg_15_0, arg_15_1, arg_15_2)
	gohelper.setActive(arg_15_0._godisable, false)
	gohelper.setActive(arg_15_0._gofinish, false)
	gohelper.setActive(arg_15_0._gounfinish, false)

	arg_15_0._stars2CanvasGroup.alpha = arg_15_2 and 1 or 0.2
	arg_15_0._stars3CanvasGroup.alpha = arg_15_2 and 1 or 0.2

	ZProj.UGUIHelper.SetColorAlpha(arg_15_0._txtindex, arg_15_2 and 1 or 0.3)

	local var_15_0 = arg_15_0._battleInfo.star <= 0 or not arg_15_1

	gohelper.setActive(arg_15_0._godisable, var_15_0)

	if var_15_0 then
		return
	end

	gohelper.setActive(arg_15_0._gofinish, arg_15_2)
	gohelper.setActive(arg_15_0._gounfinish, not arg_15_2)
end

function var_0_0._getPrevFinish(arg_16_0)
	local var_16_0 = arg_16_0._battleInfos[arg_16_0._index - 1]

	return not var_16_0 or var_16_0.star > 0
end

function var_0_0._editableAddEvents(arg_17_0)
	return
end

function var_0_0._editableRemoveEvents(arg_18_0)
	return
end

function var_0_0.onDestroyView(arg_19_0)
	return
end

return var_0_0
