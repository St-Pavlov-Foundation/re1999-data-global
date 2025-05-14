module("modules.logic.versionactivity1_6.act152.view.NewYearEveActivityView", package.seeall)

local var_0_0 = class("NewYearEveActivityView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG1")
	arg_1_0._simageFullBG2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG2")
	arg_1_0._simageLogo = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Logo")
	arg_1_0._gorole3 = gohelper.findChild(arg_1_0.viewGO, "Role/#go_role3")
	arg_1_0._simageRole3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Role/#go_role3/#simage_Role3")
	arg_1_0._goBG3 = gohelper.findChild(arg_1_0.viewGO, "Role/#go_role3/Prop/#go_BG3")
	arg_1_0._gorole5 = gohelper.findChild(arg_1_0.viewGO, "Role/#go_role5")
	arg_1_0._simageRole5 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Role/#go_role5/#simage_Role5")
	arg_1_0._goBG5 = gohelper.findChild(arg_1_0.viewGO, "Role/#go_role5/Prop/#go_BG5")
	arg_1_0._gorole1 = gohelper.findChild(arg_1_0.viewGO, "Role/#go_role1")
	arg_1_0._simageRole1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Role/#go_role1/#simage_Role1")
	arg_1_0._goBG1 = gohelper.findChild(arg_1_0.viewGO, "Role/#go_role1/Prop/#go_BG1")
	arg_1_0._gorole4 = gohelper.findChild(arg_1_0.viewGO, "Role/#go_role4")
	arg_1_0._simageRole4 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Role/#go_role4/#simage_Role4")
	arg_1_0._goBG4 = gohelper.findChild(arg_1_0.viewGO, "Role/#go_role4/Prop/#go_BG4")
	arg_1_0._gorole2 = gohelper.findChild(arg_1_0.viewGO, "Role/#go_role2")
	arg_1_0._simageRole2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Role/#go_role2/#simage_Role2")
	arg_1_0._goBG2 = gohelper.findChild(arg_1_0.viewGO, "Role/#go_role2/Prop/#go_BG2")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Right/LimitTime/#txt_LimitTime")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_Descr")
	arg_1_0._btnenter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_enter")
	arg_1_0._imagereddot = gohelper.findChildImage(arg_1_0.viewGO, "Right/#btn_enter/#image_reddot")
	arg_1_0._simageFullBG3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG3")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnenter:AddClickListener(arg_2_0._btnenterOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnenter:RemoveClickListener()
end

function var_0_0._btnenterOnClick(arg_4_0)
	BackpackController.instance:enterItemBackpack(ItemEnum.CategoryType.Antique)
end

local var_0_1 = {
	2,
	1,
	5,
	3,
	4
}

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam.parent

	gohelper.addChild(var_7_0, arg_7_0.viewGO)

	arg_7_0._roleItems = {}

	for iter_7_0, iter_7_1 in ipairs(var_0_1) do
		local var_7_1 = {
			gorole = arg_7_0["_gorole" .. iter_7_0],
			simgrole = arg_7_0["_simageRole" .. iter_7_0],
			gobg = arg_7_0["_goBG" .. iter_7_0],
			id = iter_7_1
		}

		var_7_1.click = gohelper.findChildButtonWithAudio(var_7_1.gorole, "Click")

		var_7_1.click:AddClickListener(arg_7_0._giftClick, arg_7_0, var_7_1.id)
		table.insert(arg_7_0._roleItems, var_7_1)
	end

	AudioMgr.instance:trigger(AudioEnum.NewYearEve.play_ui_shuori_evegift_open)
	arg_7_0:_refreshItems()
	arg_7_0:_refreshTimeTick()
	TaskDispatcher.runRepeat(arg_7_0._refreshTimeTick, arg_7_0, 1)
end

function var_0_0._giftClick(arg_8_0, arg_8_1)
	AudioMgr.instance:trigger(AudioEnum.NewYearEve.play_ui_shuori_evegift_click)
	Activity152Controller.instance:openNewYearGiftView(arg_8_1)
end

function var_0_0._refreshItems(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._roleItems) do
		local var_9_0 = Activity152Model.instance:isPresentAccepted(iter_9_1.id)

		gohelper.setActive(iter_9_1.gorole, var_9_0)
		gohelper.setActive(iter_9_1.gobg, var_9_0)
		gohelper.setActive(iter_9_1.simgrole.gameObject, var_9_0)
	end

	local var_9_1 = Activity152Model.instance:hasPresentAccepted()

	gohelper.setActive(arg_9_0._btnenter.gameObject, var_9_1)

	local var_9_2 = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.NewYearEve)

	arg_9_0._txtDescr.text = var_9_2.actDesc
end

function var_0_0._refreshTimeTick(arg_10_0)
	local var_10_0 = ActivityEnum.Activity.NewYearEve

	arg_10_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(var_10_0)
end

function var_0_0.onClose(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._refreshTimeTick, arg_11_0)
end

function var_0_0.onDestroyView(arg_12_0)
	if arg_12_0._roleItems then
		for iter_12_0, iter_12_1 in pairs(arg_12_0._roleItems) do
			iter_12_1.click:RemoveClickListener()
		end

		arg_12_0._roleItems = nil
	end
end

return var_0_0
