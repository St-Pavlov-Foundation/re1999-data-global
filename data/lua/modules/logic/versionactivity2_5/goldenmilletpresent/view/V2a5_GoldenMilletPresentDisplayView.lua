module("modules.logic.versionactivity2_5.goldenmilletpresent.view.V2a5_GoldenMilletPresentDisplayView", package.seeall)

slot0 = class("V2a5_GoldenMilletPresentDisplayView", BaseViewExtended)

function slot0.onInitView(slot0)
	gohelper.setActive(slot0.viewGO, true)

	slot0._btnPresentList = slot0:getUserDataTb_()

	for slot4 = 1, GoldenMilletEnum.DISPLAY_SKIN_COUNT do
		if gohelper.findChildButtonWithAudio(slot0.viewGO, string.format("present%s/#btn_Present", slot4)) then
			slot0._btnPresentList[#slot0._btnPresentList + 1] = slot6
		end
	end

	slot0._goHasReceiveTip = gohelper.findChild(slot0.viewGO, "#go_ReceiveTip")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")
	slot0._btnBgClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "close")
end

function slot0.addEvents(slot0)
	for slot4, slot5 in ipairs(slot0._btnPresentList) do
		slot5:AddClickListener(slot0._btnPresentOnClick, slot0, slot4)
	end

	if slot0._btnClose then
		slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
	end

	if slot0._btnBgClose then
		slot0._btnBgClose:AddClickListener(slot0._btnCloseOnClick, slot0)
	end
end

function slot0.removeEvents(slot0)
	for slot4, slot5 in ipairs(slot0._btnPresentList) do
		slot5:RemoveClickListener()
	end

	if slot0._btnClose then
		slot0._btnClose:RemoveClickListener()
	end

	if slot0._btnBgClose then
		slot0._btnBgClose:RemoveClickListener()
	end
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

function slot0.onDestroy(slot0)
	for slot4, slot5 in ipairs(slot0._btnPresentList) do
		slot5:RemoveClickListener()
	end
end

return slot0
