module("modules.logic.versionactivity2_5.decalogpresent.view.V2a5DecalogPresentFullView", package.seeall)

slot0 = class("V2a5DecalogPresentFullView", V1a9DecalogPresentFullView)

function slot0.refreshRemainTime(slot0)
	slot0._txtremainTime.text = ActivityModel.instance:getActMO(DecalogPresentModel.instance:getDecalogPresentActId()):getRemainTimeStr3(false, true)
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
	slot0:refresh()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shuori_qiyuan_unlock_2)
end

return slot0
