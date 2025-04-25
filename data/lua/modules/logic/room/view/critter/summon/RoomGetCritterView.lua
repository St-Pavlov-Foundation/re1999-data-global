module("modules.logic.room.view.critter.summon.RoomGetCritterView", package.seeall)

slot0 = class("RoomGetCritterView", BaseView)

function slot0.onInitView(slot0)
	slot0._goegg = gohelper.findChild(slot0.viewGO, "#go_egg")
	slot0._btnegg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_egg/#btn_egg")
	slot0._gocritter = gohelper.findChild(slot0.viewGO, "#go_critter")
	slot0._gotip = gohelper.findChild(slot0.viewGO, "#go_critter/txt_tips")
	slot0._simagefullbg1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_critter/#simage_fullbg1")
	slot0._simagefullbg2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_critter/#simage_fullbg2")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_critter/#btn_close")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#go_critter/#simage_title")
	slot0._simagecard = gohelper.findChildSingleImage(slot0.viewGO, "#go_critter/#simage_card")
	slot0._simagecritter = gohelper.findChildSingleImage(slot0.viewGO, "#go_critter/#simage_critter")
	slot0._gospine = gohelper.findChild(slot0.viewGO, "#go_critter/#simage_critter/#go_spine")
	slot0._gostarList = gohelper.findChild(slot0.viewGO, "#go_critter/#go_starList")
	slot0._goagain = gohelper.findChild(slot0.viewGO, "#go_critter/#go_again")
	slot0._btnsummon = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_critter/#go_again/#btn_summon")
	slot0._simagecurrency = gohelper.findChildSingleImage(slot0.viewGO, "#go_critter/#go_again/currency/#simage_currency")
	slot0._txtcurrency = gohelper.findChildText(slot0.viewGO, "#go_critter/#go_again/currency/#txt_currency")
	slot0._btnskip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_skip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnegg:AddClickListener(slot0._btnEggOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnsummon:AddClickListener(slot0._btnsummonOnClick, slot0)
	slot0._btnskip:AddClickListener(slot0._btnskipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnegg:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btnsummon:RemoveClickListener()
	slot0._btnskip:RemoveClickListener()
end

function slot0._addEvents(slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummon, slot0._onStartSummon, slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onSummonSkip, slot0._onSummonSkip, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onCloseRoomCriiterDetailSimpleView, slot0._onCloseRoomCriiterDetailSimpleView, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummon, slot0._onStartSummon, slot0)
	slot0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onSummonSkip, slot0._onSummonSkip, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onCloseRoomCriiterDetailSimpleView, slot0._onCloseRoomCriiterDetailSimpleView, slot0)
	slot0._critterAnimEvent:RemoveEventListener("closeEgg")
end

function slot0._btnEggOnClick(slot0)
	if slot0.isOpeningEgg then
		return
	end

	slot0.isOpeningEgg = true

	if slot0._egg then
		slot0._egg:playOpenAnim(slot0.playerEggAnimFinish, slot0)
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_open)
	end

	slot0:showCritter(true)
end

function slot0._btncloseOnClick(slot0)
	if slot0._critterMOList and #slot0._critterMOList > 0 then
		slot0._critterMo = slot0._critterMOList[1]

		table.remove(slot0._critterMOList, 1)
		slot0:_showGetCritter()

		return
	end

	if slot0._mode ~= RoomSummonEnum.SummonType.ItemGet and not ViewMgr.instance:isOpen(ViewName.RoomCritterSummonResultView) then
		CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingViewRefreshCamera)
		CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onCloseGetCritter)
	end

	slot0:closeThis()
end

function slot0._btnsummonOnClick(slot0)
	slot1, slot2 = CritterSummonModel.instance:notSummonToast(slot0._poolId)

	if string.nilorempty(slot1) then
		CritterRpc.instance:sendSummonCritterRequest(slot0._poolId, slot0._summonCount)
	else
		GameFacade.showToast(slot1, slot2)
	end
end

function slot0._btncardOnClick(slot0)
	CritterController.instance:openCriiterDetailSimpleView(slot0._critterMo)
end

function slot0._btnskipOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_critter/txt_crittername")
	slot4 = "#go_egg/bg/ssr"
	slot0._eggRareVX = {
		[3] = gohelper.findChild(slot0.viewGO, "#go_egg/bg/r"),
		[4] = gohelper.findChild(slot0.viewGO, "#go_egg/bg/sr"),
		[5] = gohelper.findChild(slot0.viewGO, slot4)
	}
	slot0._star = slot0:getUserDataTb_()

	for slot4 = 1, slot0._gostarList.transform.childCount do
		table.insert(slot0._star, gohelper.findChild(slot0._gostarList, "star" .. slot4))
	end

	slot0._critterAnim = SLFramework.AnimatorPlayer.Get(slot0._gocritter)
	slot0._critterAnimEvent = slot0._gocritter:GetComponent(gohelper.Type_AnimationEventWrap)

	slot0._critterAnimEvent:AddEventListener("closeEgg", slot0.closeEggCallback, slot0)
end

function slot0.closeEggCallback(slot0)
	gohelper.setActive(slot0._goegg.gameObject, false)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_show)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:_btncloseOnClick()
end

function slot0._onSummonSkip(slot0)
	slot0:showCritter(true)
	slot0:playCritterSkipAnim()
end

function slot0.onOpen(slot0)
	slot0:_addEvents()

	slot0._summonCount = 1
	slot0._mode = slot0.viewParam.mode
	slot0._critterMOList = {}

	if slot0._mode == RoomSummonEnum.SummonType.Summon then
		slot0._poolId = slot0.viewParam.poolId
		slot0._critterMo = slot0.viewParam.critterMo

		if slot0.viewParam and slot0.viewParam.critterMOList then
			tabletool.addValues(slot0._critterMOList, slot0.viewParam.critterMOList)
			tabletool.removeValue(slot0._critterMOList, slot0._critterMo)
		end
	elseif slot0._mode == RoomSummonEnum.SummonType.ItemGet then
		slot0._critterMOList = slot0.viewParam.critterMOList
		slot0._critterMo = slot0._critterMOList[1]

		table.remove(slot0._critterMOList, 1)
	else
		slot0._critterMo = slot0.viewParam.critterMo

		if CritterIncubateController.instance:checkHasChildCritter() then
			table.insert(slot0._critterMOList, slot1)
		end
	end

	gohelper.setActive(slot0._btnskip, slot0._critterMOList and #slot0._critterMOList > 1)
	slot0:_showGetCritter()
end

function slot0._showGetCritter(slot0)
	slot0.isOpeningEgg = false

	gohelper.setActive(slot0._simagecard.gameObject, true)

	slot0._rare = slot0._critterMo:getDefineCfg().rare
	slot0._rareCo = CritterConfig.instance:getCritterRareCfg(slot0._rare)

	for slot5, slot6 in pairs(slot0._eggRareVX) do
		gohelper.setActive(slot6, slot5 == slot0._rare)
	end

	if slot0._critterMo then
		slot0:refreshCritter()
	end

	gohelper.setActive(slot0._btnclose.gameObject, false)
	gohelper.setActive(slot0._gotip.gameObject, false)
	slot0:_refreshSingleCost()

	slot0._cardBtn = SLFramework.UGUI.UIClickListener.Get(gohelper.findChild(slot0.viewGO, "#go_critter/#simage_card"))

	slot0._cardBtn:AddClickListener(slot0._btncardOnClick, slot0)
	slot0:_onRefreshBtn()
	slot0:critterSpine()

	slot3 = slot0.viewParam.isSkip

	slot0:showCritter(slot3)
	gohelper.setActive(slot0._goegg.gameObject, not slot3)

	if slot3 then
		slot0:playCritterSkipAnim()
	else
		if not slot0._egg then
			slot0._egg = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(ResUrl.getRoomCritterEggPrefab(slot0._rareCo.eggRes), gohelper.findChild(slot0.viewGO, "#go_egg/egg")), RoomGetCritterEgg)
		end

		slot0:playerEggAnim()
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_obtain)
	end
end

function slot0.playCritterSkipAnim(slot0)
	slot0._critterAnim:Play("skip", slot0.showCloseBtn, slot0)
end

function slot0.playCritterOpenAnim(slot0)
	slot0._critterAnim:Play("open", slot0.showCloseBtn, slot0)
end

function slot0.showCloseBtn(slot0)
	gohelper.setActive(slot0._btnclose.gameObject, true)
	gohelper.setActive(slot0._gotip.gameObject, true)
end

function slot0.onClose(slot0)
	slot0:_removeEvents()

	slot0.isOpeningEgg = false
end

function slot0._onRefreshBtn(slot0)
	if slot0._mode == RoomSummonEnum.SummonType.Summon then
		ZProj.UGUIHelper.SetGrayscale(slot0._btnsummon.gameObject, not string.nilorempty(CritterSummonModel.instance:notSummonToast(slot0._poolId)))
	end

	gohelper.setActive(slot0._goagain.gameObject, slot0._mode == RoomSummonEnum.SummonType.Summon and slot0._poolId ~= nil)
end

function slot0.onDestroyView(slot0)
	slot0._simagecard:UnLoadImage()
	slot0._simagecurrency:UnLoadImage()
	slot0._cardBtn:RemoveClickListener()
end

function slot0.playerEggAnim(slot0)
	slot0._egg:playIdleAnim(slot0.playerEggIdleAnimFinish, slot0)
end

function slot0.playerEggIdleAnimFinish(slot0)
end

function slot0.playerEggAnimFinish(slot0)
	slot0.isOpeningEgg = false

	CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onOpenEgg)
end

function slot0.refreshIcon(slot0)
end

function slot0.refreshCritter(slot0)
	slot0._simagecard:LoadImage(ResUrl.getRoomCritterIcon(slot0._rareCo.cardRes))

	slot0._txtname.text = slot0._critterMo:getName()

	for slot5 = 1, #slot0._star do
		gohelper.setActive(slot0._star[slot5].gameObject, slot5 <= slot0._rare + 1)
	end

	slot0:refreshIcon()
end

function slot0.showCritter(slot0, slot1)
	gohelper.setActive(slot0._gocritter, slot1)

	if slot1 then
		slot0:playCritterOpenAnim()
	end
end

function slot0._refreshSingleCost(slot0)
	slot1, slot0._txtcurrency.text, slot3 = CritterSummonModel.instance:getPoolCurrency(slot0._poolId)

	if not string.nilorempty(slot1) then
		slot0._simagecurrency:LoadImage(slot1)
	end
end

function slot0._onStartSummon(slot0, slot1)
	slot0:closeThis()
	CritterSummonController.instance:openSummonView(nil, slot1)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.RoomCriiterDetailSimpleView then
		gohelper.setActive(slot0._simagecard.gameObject, false)
	end
end

function slot0._onCloseRoomCriiterDetailSimpleView(slot0)
	gohelper.setActive(slot0._simagecard.gameObject, true)
end

function slot0.critterSpine(slot0)
	if not slot0.bigSpine then
		slot0.bigSpine = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gospine, RoomCritterUISpine)
	end

	slot0.bigSpine:stopVoice()
	slot0.bigSpine:setResPath(slot0._critterMo)
end

return slot0
