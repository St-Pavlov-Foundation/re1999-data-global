module("modules.logic.versionactivity2_5.reactivity.V2a5_v1a6_ReactivityEnterview", package.seeall)

slot0 = class("V2a5_v1a6_ReactivityEnterview", ReactivityEnterview)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "img/#simage_bg")
	slot0._gospine = gohelper.findChild(slot0.viewGO, "#go_spine")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "logo/#txt_dec")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "logo/#txt_time")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_enter")
	slot0._btnEnd = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_End")
	slot0._btnLock = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_Locked")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "entrance/#btn_enter/normal/#go_reddot")
	slot0._txtlockedtips = gohelper.findChildText(slot0.viewGO, "entrance/#btn_enter/locked/#txt_lockedtips")
	slot0._btnstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_store")
	slot0._txtNum = gohelper.findChildText(slot0.viewGO, "entrance/#btn_store/normal/#txt_num")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "entrance/#btn_store/#go_time")
	slot0._txtstoretime = gohelper.findChildText(slot0.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	slot0._btnreplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_replay")
	slot0._btnAchevement = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_achievement_normal")
	slot0._btnExchange = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_Exchange")
	slot0.rewardItems = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._onClickEnter(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(slot0.actId)

	if slot1 ~= ActivityEnum.ActivityStatus.Normal then
		if slot2 then
			GameFacade.showToastWithTableParam(slot2, slot3)
		end

		return
	end

	VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView()
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6EnterViewMainActTabSelect)
end

return slot0
