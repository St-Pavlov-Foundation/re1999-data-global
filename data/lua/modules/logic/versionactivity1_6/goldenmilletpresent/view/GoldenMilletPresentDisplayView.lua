module("modules.logic.versionactivity1_6.goldenmilletpresent.view.GoldenMilletPresentDisplayView", package.seeall)

slot0 = class("GoldenMilletPresentDisplayView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot4 = true

	gohelper.setActive(slot0.viewGO, slot4)

	slot0._btnPresentList = slot0:getUserDataTb_()

	for slot4 = 1, GoldenMilletEnum.DISPLAY_SKIN_COUNT do
		if gohelper.findChildButtonWithAudio(slot0.viewGO, string.format("present%s/#btn_Present", slot4)) then
			slot0._btnPresentList[#slot0._btnPresentList + 1] = slot6
		end
	end

	slot0._goHasReceiveTip = gohelper.findChild(slot0.viewGO, "#go_ReceiveTip")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")
end

function slot0.addEvents(slot0)
	for slot4, slot5 in ipairs(slot0._btnPresentList) do
		slot5:AddClickListener(slot0._btnPresentOnClick, slot0, slot4)
	end

	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	for slot4, slot5 in ipairs(slot0._btnPresentList) do
		slot5:RemoveClickListener()
	end

	slot0._btnClose:RemoveClickListener()
end

function slot0._btnPresentOnClick(slot0, slot1)
	if not GoldenMilletPresentModel.instance:isGoldenMilletPresentOpen(true) then
		return
	end

	if GoldenMilletEnum.Index2Skin[slot1] then
		CharacterController.instance:openCharacterSkinTipView({
			isShowHomeBtn = false,
			skinId = slot3
		})
	end
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._goHasReceiveTip, GoldenMilletPresentModel.instance:haveReceivedSkin())
	AudioMgr.instance:trigger(AudioEnum.UI.GoldenMilletDisplayViewOpen)
end

return slot0
