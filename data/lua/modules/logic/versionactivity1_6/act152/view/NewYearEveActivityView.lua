module("modules.logic.versionactivity1_6.act152.view.NewYearEveActivityView", package.seeall)

slot0 = class("NewYearEveActivityView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG1")
	slot0._simageFullBG2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG2")
	slot0._simageLogo = gohelper.findChildSingleImage(slot0.viewGO, "#simage_Logo")
	slot0._gorole3 = gohelper.findChild(slot0.viewGO, "Role/#go_role3")
	slot0._simageRole3 = gohelper.findChildSingleImage(slot0.viewGO, "Role/#go_role3/#simage_Role3")
	slot0._goBG3 = gohelper.findChild(slot0.viewGO, "Role/#go_role3/Prop/#go_BG3")
	slot0._gorole5 = gohelper.findChild(slot0.viewGO, "Role/#go_role5")
	slot0._simageRole5 = gohelper.findChildSingleImage(slot0.viewGO, "Role/#go_role5/#simage_Role5")
	slot0._goBG5 = gohelper.findChild(slot0.viewGO, "Role/#go_role5/Prop/#go_BG5")
	slot0._gorole1 = gohelper.findChild(slot0.viewGO, "Role/#go_role1")
	slot0._simageRole1 = gohelper.findChildSingleImage(slot0.viewGO, "Role/#go_role1/#simage_Role1")
	slot0._goBG1 = gohelper.findChild(slot0.viewGO, "Role/#go_role1/Prop/#go_BG1")
	slot0._gorole4 = gohelper.findChild(slot0.viewGO, "Role/#go_role4")
	slot0._simageRole4 = gohelper.findChildSingleImage(slot0.viewGO, "Role/#go_role4/#simage_Role4")
	slot0._goBG4 = gohelper.findChild(slot0.viewGO, "Role/#go_role4/Prop/#go_BG4")
	slot0._gorole2 = gohelper.findChild(slot0.viewGO, "Role/#go_role2")
	slot0._simageRole2 = gohelper.findChildSingleImage(slot0.viewGO, "Role/#go_role2/#simage_Role2")
	slot0._goBG2 = gohelper.findChild(slot0.viewGO, "Role/#go_role2/Prop/#go_BG2")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Right/#simage_Title")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Right/LimitTime/#txt_LimitTime")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Right/#txt_Descr")
	slot0._btnenter = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_enter")
	slot0._imagereddot = gohelper.findChildImage(slot0.viewGO, "Right/#btn_enter/#image_reddot")
	slot0._simageFullBG3 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG3")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnenter:AddClickListener(slot0._btnenterOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnenter:RemoveClickListener()
end

function slot0._btnenterOnClick(slot0)
	BackpackController.instance:enterItemBackpack(ItemEnum.CategoryType.Antique)
end

slot1 = {
	2,
	1,
	5,
	3,
	4
}

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)

	slot0._roleItems = {}

	for slot5, slot6 in ipairs(uv0) do
		slot7 = {
			gorole = slot0["_gorole" .. slot5],
			simgrole = slot0["_simageRole" .. slot5],
			gobg = slot0["_goBG" .. slot5],
			id = slot6
		}
		slot7.click = gohelper.findChildButtonWithAudio(slot7.gorole, "Click")

		slot7.click:AddClickListener(slot0._giftClick, slot0, slot7.id)
		table.insert(slot0._roleItems, slot7)
	end

	AudioMgr.instance:trigger(AudioEnum.NewYearEve.play_ui_shuori_evegift_open)
	slot0:_refreshItems()
	slot0:_refreshTimeTick()
	TaskDispatcher.runRepeat(slot0._refreshTimeTick, slot0, 1)
end

function slot0._giftClick(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.NewYearEve.play_ui_shuori_evegift_click)
	Activity152Controller.instance:openNewYearGiftView(slot1)
end

function slot0._refreshItems(slot0)
	for slot4, slot5 in pairs(slot0._roleItems) do
		slot6 = Activity152Model.instance:isPresentAccepted(slot5.id)

		gohelper.setActive(slot5.gorole, slot6)
		gohelper.setActive(slot5.gobg, slot6)
		gohelper.setActive(slot5.simgrole.gameObject, slot6)
	end

	gohelper.setActive(slot0._btnenter.gameObject, Activity152Model.instance:hasPresentAccepted())

	slot0._txtDescr.text = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.NewYearEve).actDesc
end

function slot0._refreshTimeTick(slot0)
	slot0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(ActivityEnum.Activity.NewYearEve)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._roleItems then
		for slot4, slot5 in pairs(slot0._roleItems) do
			slot5.click:RemoveClickListener()
		end

		slot0._roleItems = nil
	end
end

return slot0
