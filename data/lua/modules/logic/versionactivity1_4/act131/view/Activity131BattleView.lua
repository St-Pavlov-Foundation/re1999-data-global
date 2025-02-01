module("modules.logic.versionactivity1_4.act131.view.Activity131BattleView", package.seeall)

slot0 = class("Activity131BattleView", BaseView)

function slot0.onInitView(slot0)
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "rotate/layout/top/title/#txt_title")
	slot0._gobg = gohelper.findChild(slot0.viewGO, "rotate/#go_bg")
	slot0._txtinfo = gohelper.findChildText(slot0.viewGO, "rotate/#go_bg/#txt_info")
	slot0._btnclosetip = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/#btn_closetip")
	slot0._btnfight = gohelper.findChildButtonWithAudio(slot0.viewGO, "rotate/right/go_fight/#btn_fight")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclosetip:AddClickListener(slot0._btnclosetipOnClick, slot0)
	slot0._btnfight:AddClickListener(slot0._btnfightOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclosetip:RemoveClickListener()
	slot0._btnfight:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btnclosetipOnClick(slot0)
end

function slot0._btnfightOnClick(slot0)
	Activity131Controller.instance:enterFight(slot0.episodeCfg)
end

function slot0._btncloseOnClick(slot0)
	slot0._viewAnim:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(slot0._doClose, slot0, 0.233)
end

function slot0._doClose(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.main_ui.play_ui_task_page)

	slot0.episodeCfg = DungeonConfig.instance:getEpisodeCO(tonumber(slot0.viewContainer.viewParam))

	if slot0.episodeCfg then
		slot0._txttitle.text = slot0.episodeCfg.name
		slot0._txtinfo.text = slot0.episodeCfg.desc
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
