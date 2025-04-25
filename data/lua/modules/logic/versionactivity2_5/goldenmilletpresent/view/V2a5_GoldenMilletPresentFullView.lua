module("modules.logic.versionactivity2_5.goldenmilletpresent.view.V2a5_GoldenMilletPresentFullView", package.seeall)

slot0 = class("V2a5_GoldenMilletPresentFullView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._goReceiveView = gohelper.findChild(slot0.viewGO, "#go_ReceiveView")
	slot0._goDisplayView = gohelper.findChild(slot0.viewGO, "#go_DisplayView")

	gohelper.setActive(slot0._goReceiveView, false)
	gohelper.setActive(slot0._goDisplayView, false)
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
	slot0:switchExclusiveView(not GoldenMilletPresentModel.instance:isShowRedDot())
end

function slot0.switchExclusiveView(slot0, slot1)
	slot0._showingReceiveView = true
	slot2 = slot0.viewContainer.ExclusiveView.ReceiveView
	slot3 = V2a5_GoldenMilletPresentReceiveFullView
	slot4 = slot0._goReceiveView

	if slot1 then
		slot2 = slot0.viewContainer.ExclusiveView.DisplayView
		slot3 = V2a5_GoldenMilletPresentDisplayView
		slot4 = slot0._goDisplayView
		slot0._showingReceiveView = false
	end

	slot0:openExclusiveView(nil, slot2, slot3, slot4)
end

function slot0.onClickModalMask(slot0)
	if slot0._showingReceiveView then
		slot0:switchExclusiveView(true)
	else
		slot0:closeThis()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

return slot0
