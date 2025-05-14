module("modules.logic.activity.view.V1a6_Spring_PanelSignView", package.seeall)

local var_0_0 = class("V1a6_Spring_PanelSignView", Activity101SignViewBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_PanelBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._scrollItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/#scroll_ItemList")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Root/#btn_Close")
	arg_1_0._txtDate = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_Date")
	arg_1_0._txtgoodDesc = gohelper.findChildText(arg_1_0.viewGO, "Root/image_yi/image_Mood/#txt_goodDesc")
	arg_1_0._txtbadDesc = gohelper.findChildText(arg_1_0.viewGO, "Root/image_ji/image_Mood/#txt_badDesc")
	arg_1_0._txtSmallTitle = gohelper.findChildText(arg_1_0.viewGO, "Root/image_SmallTitle/#txt_SmallTitle")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "Root/ScrollView/Viewport/#txt_Desc")
	arg_1_0._btnemptyTop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyTop")
	arg_1_0._btnemptyBottom = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyBottom")
	arg_1_0._btnemptyLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyLeft")
	arg_1_0._btnemptyRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyRight")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	Activity101SignViewBase.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0._btnemptyTop:AddClickListener(arg_2_0._btnemptyTopOnClick, arg_2_0)
	arg_2_0._btnemptyBottom:AddClickListener(arg_2_0._btnemptyBottomOnClick, arg_2_0)
	arg_2_0._btnemptyLeft:AddClickListener(arg_2_0._btnemptyLeftOnClick, arg_2_0)
	arg_2_0._btnemptyRight:AddClickListener(arg_2_0._btnemptyRightOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	Activity101SignViewBase.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnemptyTop:RemoveClickListener()
	arg_3_0._btnemptyBottom:RemoveClickListener()
	arg_3_0._btnemptyLeft:RemoveClickListener()
	arg_3_0._btnemptyRight:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnemptyTopOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnemptyBottomOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._btnemptyLeftOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._btnemptyRightOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._anims = arg_9_0:getUserDataTb_()

	table.insert(arg_9_0._anims, arg_9_0:_findAnimCmp("Root/image_yi/image_Mood"))
	table.insert(arg_9_0._anims, arg_9_0:_findAnimCmp("Root/image_ji/image_Mood"))
end

function var_0_0._findAnimCmp(arg_10_0, arg_10_1)
	return gohelper.findChild(arg_10_0.viewGO, arg_10_1):GetComponent(gohelper.Type_Animator)
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0._txtLimitTime.text = ""
	arg_11_0._txtDate.text = ""
	arg_11_0._txtSmallTitle.text = ""
	arg_11_0._txtDesc.text = ""
	arg_11_0._txtgoodDesc.text = ""
	arg_11_0._txtbadDesc.text = ""

	arg_11_0:internal_set_actId(arg_11_0.viewParam.actId)
	arg_11_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
	arg_11_0:internal_onOpen()
	TaskDispatcher.runRepeat(arg_11_0._refreshTimeTick, arg_11_0, 1)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_11_0._onDailyRefresh, arg_11_0)
end

local var_0_1 = "Key_V1a6_Spring_PanelSignView"

function var_0_0.onOpenFinish(arg_12_0)
	local var_12_0 = arg_12_0:_getCurrentDayCO()

	if not var_12_0 then
		return
	end

	local var_12_1 = var_12_0.day

	if GameUtil.playerPrefsGetNumberByUserId(var_0_1, -1) ~= var_12_1 then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0._anims or {}) do
			iter_12_1:Play(UIAnimationName.Open, 0, 0)
		end

		GameUtil.playerPrefsSetNumberByUserId(var_0_1, var_12_1)
	end
end

function var_0_0.onClose(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._refreshTimeTick, arg_13_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_13_0._onDailyRefresh, arg_13_0)
end

function var_0_0.onDestroyView(arg_14_0)
	Activity101SignViewBase._internal_onDestroy(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._refreshTimeTick, arg_14_0)
end

function var_0_0.onRefresh(arg_15_0)
	arg_15_0:_refreshList()
	arg_15_0:_refreshTimeTick()
	arg_15_0:_refreshDesc()
end

function var_0_0._refreshDesc(arg_16_0)
	local var_16_0 = arg_16_0:_getCurrentDayCO()

	if not var_16_0 then
		return
	end

	arg_16_0._txtDate.text = var_16_0.name
	arg_16_0._txtSmallTitle.text = var_16_0.simpleDesc
	arg_16_0._txtDesc.text = var_16_0.detailDesc
	arg_16_0._txtgoodDesc.text = var_16_0.goodDesc
	arg_16_0._txtbadDesc.text = var_16_0.badDesc
end

function var_0_0._refreshTimeTick(arg_17_0)
	arg_17_0._txtLimitTime.text = arg_17_0:getRemainTimeStr()
end

function var_0_0._getCurrentDayCO(arg_18_0)
	local var_18_0 = arg_18_0:actId()
	local var_18_1 = ActivityModel.instance:getActMO(var_18_0)

	if not var_18_1 then
		return
	end

	local var_18_2 = ActivityType101Config.instance:getSpringSignMaxDay(var_18_0)

	if not var_18_2 or var_18_2 <= 0 then
		return
	end

	local var_18_3 = var_18_1.startTime / 1000
	local var_18_4 = var_18_1.endTime / 1000
	local var_18_5 = ServerTime.now()

	if var_18_5 < var_18_3 or var_18_4 < var_18_5 then
		return
	end

	local var_18_6 = var_18_5 - var_18_3
	local var_18_7 = TimeUtil.secondsToDDHHMMSS(var_18_6)

	if var_18_2 <= var_18_7 then
		var_18_7 = var_18_7 % var_18_2
	end

	local var_18_8 = var_18_7 + 1

	return ActivityType101Config.instance:getSpringSignByDay(var_18_0, var_18_8)
end

function var_0_0._onDailyRefresh(arg_19_0)
	arg_19_0:_refreshDesc()
end

return var_0_0
