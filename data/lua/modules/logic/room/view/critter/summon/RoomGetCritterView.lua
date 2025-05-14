module("modules.logic.room.view.critter.summon.RoomGetCritterView", package.seeall)

local var_0_0 = class("RoomGetCritterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goegg = gohelper.findChild(arg_1_0.viewGO, "#go_egg")
	arg_1_0._btnegg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_egg/#btn_egg")
	arg_1_0._gocritter = gohelper.findChild(arg_1_0.viewGO, "#go_critter")
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "#go_critter/txt_tips")
	arg_1_0._simagefullbg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_critter/#simage_fullbg1")
	arg_1_0._simagefullbg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_critter/#simage_fullbg2")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_critter/#btn_close")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_critter/#simage_title")
	arg_1_0._simagecard = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_critter/#simage_card")
	arg_1_0._simagecritter = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_critter/#simage_critter")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "#go_critter/#simage_critter/#go_spine")
	arg_1_0._gostarList = gohelper.findChild(arg_1_0.viewGO, "#go_critter/#go_starList")
	arg_1_0._goagain = gohelper.findChild(arg_1_0.viewGO, "#go_critter/#go_again")
	arg_1_0._btnsummon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_critter/#go_again/#btn_summon")
	arg_1_0._simagecurrency = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_critter/#go_again/currency/#simage_currency")
	arg_1_0._txtcurrency = gohelper.findChildText(arg_1_0.viewGO, "#go_critter/#go_again/currency/#txt_currency")
	arg_1_0._btnskip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_skip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnegg:AddClickListener(arg_2_0._btnEggOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnsummon:AddClickListener(arg_2_0._btnsummonOnClick, arg_2_0)
	arg_2_0._btnskip:AddClickListener(arg_2_0._btnskipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnegg:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnsummon:RemoveClickListener()
	arg_3_0._btnskip:RemoveClickListener()
end

function var_0_0._addEvents(arg_4_0)
	arg_4_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummon, arg_4_0._onStartSummon, arg_4_0)
	arg_4_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onSummonSkip, arg_4_0._onSummonSkip, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_4_0._onOpenView, arg_4_0)
	arg_4_0:addEventCb(CritterSummonController.instance, CritterSummonEvent.onCloseRoomCriiterDetailSimpleView, arg_4_0._onCloseRoomCriiterDetailSimpleView, arg_4_0)
end

function var_0_0._removeEvents(arg_5_0)
	arg_5_0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onStartSummon, arg_5_0._onStartSummon, arg_5_0)
	arg_5_0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onSummonSkip, arg_5_0._onSummonSkip, arg_5_0)
	arg_5_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_5_0._onOpenView, arg_5_0)
	arg_5_0:removeEventCb(CritterSummonController.instance, CritterSummonEvent.onCloseRoomCriiterDetailSimpleView, arg_5_0._onCloseRoomCriiterDetailSimpleView, arg_5_0)
	arg_5_0._critterAnimEvent:RemoveEventListener("closeEgg")
end

function var_0_0._btnEggOnClick(arg_6_0)
	if arg_6_0.isOpeningEgg then
		return
	end

	arg_6_0.isOpeningEgg = true

	if arg_6_0._egg then
		arg_6_0._egg:playOpenAnim(arg_6_0.playerEggAnimFinish, arg_6_0)
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_open)
	end

	arg_6_0:showCritter(true)
end

function var_0_0._btncloseOnClick(arg_7_0)
	if arg_7_0._critterMOList and #arg_7_0._critterMOList > 0 then
		arg_7_0._critterMo = arg_7_0._critterMOList[1]

		table.remove(arg_7_0._critterMOList, 1)
		arg_7_0:_showGetCritter()

		return
	end

	if arg_7_0._mode ~= RoomSummonEnum.SummonType.ItemGet and not ViewMgr.instance:isOpen(ViewName.RoomCritterSummonResultView) then
		CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingViewRefreshCamera)
		CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onCloseGetCritter)
	end

	arg_7_0:closeThis()
end

function var_0_0._btnsummonOnClick(arg_8_0)
	local var_8_0, var_8_1 = CritterSummonModel.instance:notSummonToast(arg_8_0._poolId)

	if string.nilorempty(var_8_0) then
		CritterRpc.instance:sendSummonCritterRequest(arg_8_0._poolId, arg_8_0._summonCount)
	else
		GameFacade.showToast(var_8_0, var_8_1)
	end
end

function var_0_0._btncardOnClick(arg_9_0)
	CritterController.instance:openCriiterDetailSimpleView(arg_9_0._critterMo)
end

function var_0_0._btnskipOnClick(arg_10_0)
	arg_10_0:closeThis()
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0._txtname = gohelper.findChildText(arg_11_0.viewGO, "#go_critter/txt_crittername")
	arg_11_0._eggRareVX = {
		[3] = gohelper.findChild(arg_11_0.viewGO, "#go_egg/bg/r"),
		[4] = gohelper.findChild(arg_11_0.viewGO, "#go_egg/bg/sr"),
		[5] = gohelper.findChild(arg_11_0.viewGO, "#go_egg/bg/ssr")
	}
	arg_11_0._star = arg_11_0:getUserDataTb_()

	for iter_11_0 = 1, arg_11_0._gostarList.transform.childCount do
		local var_11_0 = gohelper.findChild(arg_11_0._gostarList, "star" .. iter_11_0)

		table.insert(arg_11_0._star, var_11_0)
	end

	arg_11_0._critterAnim = SLFramework.AnimatorPlayer.Get(arg_11_0._gocritter)
	arg_11_0._critterAnimEvent = arg_11_0._gocritter:GetComponent(gohelper.Type_AnimationEventWrap)

	arg_11_0._critterAnimEvent:AddEventListener("closeEgg", arg_11_0.closeEggCallback, arg_11_0)
end

function var_0_0.closeEggCallback(arg_12_0)
	gohelper.setActive(arg_12_0._goegg.gameObject, false)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_show)
end

function var_0_0.onUpdateParam(arg_13_0)
	return
end

function var_0_0.onClickModalMask(arg_14_0)
	arg_14_0:_btncloseOnClick()
end

function var_0_0._onSummonSkip(arg_15_0)
	arg_15_0:showCritter(true)
	arg_15_0:playCritterSkipAnim()
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0:_addEvents()

	arg_16_0._summonCount = 1
	arg_16_0._mode = arg_16_0.viewParam.mode
	arg_16_0._critterMOList = {}

	if arg_16_0._mode == RoomSummonEnum.SummonType.Summon then
		arg_16_0._poolId = arg_16_0.viewParam.poolId
		arg_16_0._critterMo = arg_16_0.viewParam.critterMo

		if arg_16_0.viewParam and arg_16_0.viewParam.critterMOList then
			tabletool.addValues(arg_16_0._critterMOList, arg_16_0.viewParam.critterMOList)
			tabletool.removeValue(arg_16_0._critterMOList, arg_16_0._critterMo)
		end
	elseif arg_16_0._mode == RoomSummonEnum.SummonType.ItemGet then
		arg_16_0._critterMOList = arg_16_0.viewParam.critterMOList
		arg_16_0._critterMo = arg_16_0._critterMOList[1]

		table.remove(arg_16_0._critterMOList, 1)
	else
		arg_16_0._critterMo = arg_16_0.viewParam.critterMo

		local var_16_0 = CritterIncubateController.instance:checkHasChildCritter()

		if var_16_0 then
			table.insert(arg_16_0._critterMOList, var_16_0)
		end
	end

	gohelper.setActive(arg_16_0._btnskip, arg_16_0._critterMOList and #arg_16_0._critterMOList > 1)
	arg_16_0:_showGetCritter()
end

function var_0_0._showGetCritter(arg_17_0)
	arg_17_0.isOpeningEgg = false

	gohelper.setActive(arg_17_0._simagecard.gameObject, true)

	arg_17_0._rare = arg_17_0._critterMo:getDefineCfg().rare
	arg_17_0._rareCo = CritterConfig.instance:getCritterRareCfg(arg_17_0._rare)

	for iter_17_0, iter_17_1 in pairs(arg_17_0._eggRareVX) do
		gohelper.setActive(iter_17_1, iter_17_0 == arg_17_0._rare)
	end

	if arg_17_0._critterMo then
		arg_17_0:refreshCritter()
	end

	gohelper.setActive(arg_17_0._btnclose.gameObject, false)
	gohelper.setActive(arg_17_0._gotip.gameObject, false)
	arg_17_0:_refreshSingleCost()

	local var_17_0 = gohelper.findChild(arg_17_0.viewGO, "#go_critter/#simage_card")

	arg_17_0._cardBtn = SLFramework.UGUI.UIClickListener.Get(var_17_0)

	arg_17_0._cardBtn:AddClickListener(arg_17_0._btncardOnClick, arg_17_0)
	arg_17_0:_onRefreshBtn()
	arg_17_0:critterSpine()

	local var_17_1 = arg_17_0.viewParam.isSkip

	arg_17_0:showCritter(var_17_1)
	gohelper.setActive(arg_17_0._goegg.gameObject, not var_17_1)

	if var_17_1 then
		arg_17_0:playCritterSkipAnim()
	else
		if not arg_17_0._egg then
			local var_17_2 = ResUrl.getRoomCritterEggPrefab(arg_17_0._rareCo.eggRes)
			local var_17_3 = gohelper.findChild(arg_17_0.viewGO, "#go_egg/egg")
			local var_17_4 = arg_17_0:getResInst(var_17_2, var_17_3)

			arg_17_0._egg = MonoHelper.addNoUpdateLuaComOnceToGo(var_17_4, RoomGetCritterEgg)
		end

		arg_17_0:playerEggAnim()
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_obtain)
	end
end

function var_0_0.playCritterSkipAnim(arg_18_0)
	arg_18_0._critterAnim:Play("skip", arg_18_0.showCloseBtn, arg_18_0)
end

function var_0_0.playCritterOpenAnim(arg_19_0)
	arg_19_0._critterAnim:Play("open", arg_19_0.showCloseBtn, arg_19_0)
end

function var_0_0.showCloseBtn(arg_20_0)
	gohelper.setActive(arg_20_0._btnclose.gameObject, true)
	gohelper.setActive(arg_20_0._gotip.gameObject, true)
end

function var_0_0.onClose(arg_21_0)
	arg_21_0:_removeEvents()

	arg_21_0.isOpeningEgg = false
end

function var_0_0._onRefreshBtn(arg_22_0)
	if arg_22_0._mode == RoomSummonEnum.SummonType.Summon then
		local var_22_0 = CritterSummonModel.instance:notSummonToast(arg_22_0._poolId)
		local var_22_1 = string.nilorempty(var_22_0)

		ZProj.UGUIHelper.SetGrayscale(arg_22_0._btnsummon.gameObject, not var_22_1)
	end

	gohelper.setActive(arg_22_0._goagain.gameObject, arg_22_0._mode == RoomSummonEnum.SummonType.Summon and arg_22_0._poolId ~= nil)
end

function var_0_0.onDestroyView(arg_23_0)
	arg_23_0._simagecard:UnLoadImage()
	arg_23_0._simagecurrency:UnLoadImage()
	arg_23_0._cardBtn:RemoveClickListener()
end

function var_0_0.playerEggAnim(arg_24_0)
	arg_24_0._egg:playIdleAnim(arg_24_0.playerEggIdleAnimFinish, arg_24_0)
end

function var_0_0.playerEggIdleAnimFinish(arg_25_0)
	return
end

function var_0_0.playerEggAnimFinish(arg_26_0)
	arg_26_0.isOpeningEgg = false

	CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onOpenEgg)
end

function var_0_0.refreshIcon(arg_27_0)
	return
end

function var_0_0.refreshCritter(arg_28_0)
	local var_28_0 = ResUrl.getRoomCritterIcon(arg_28_0._rareCo.cardRes)

	arg_28_0._simagecard:LoadImage(var_28_0)

	arg_28_0._txtname.text = arg_28_0._critterMo:getName()

	for iter_28_0 = 1, #arg_28_0._star do
		gohelper.setActive(arg_28_0._star[iter_28_0].gameObject, iter_28_0 <= arg_28_0._rare + 1)
	end

	arg_28_0:refreshIcon()
end

function var_0_0.showCritter(arg_29_0, arg_29_1)
	gohelper.setActive(arg_29_0._gocritter, arg_29_1)

	if arg_29_1 then
		arg_29_0:playCritterOpenAnim()
	end
end

function var_0_0._refreshSingleCost(arg_30_0)
	local var_30_0, var_30_1, var_30_2 = CritterSummonModel.instance:getPoolCurrency(arg_30_0._poolId)

	if not string.nilorempty(var_30_0) then
		arg_30_0._simagecurrency:LoadImage(var_30_0)

		arg_30_0._txtcurrency.text = var_30_1
	end
end

function var_0_0._onStartSummon(arg_31_0, arg_31_1)
	arg_31_0:closeThis()
	CritterSummonController.instance:openSummonView(nil, arg_31_1)
end

function var_0_0._onOpenView(arg_32_0, arg_32_1)
	if arg_32_1 == ViewName.RoomCriiterDetailSimpleView then
		gohelper.setActive(arg_32_0._simagecard.gameObject, false)
	end
end

function var_0_0._onCloseRoomCriiterDetailSimpleView(arg_33_0)
	gohelper.setActive(arg_33_0._simagecard.gameObject, true)
end

function var_0_0.critterSpine(arg_34_0)
	if not arg_34_0.bigSpine then
		arg_34_0.bigSpine = MonoHelper.addNoUpdateLuaComOnceToGo(arg_34_0._gospine, RoomCritterUISpine)
	end

	arg_34_0.bigSpine:stopVoice()
	arg_34_0.bigSpine:setResPath(arg_34_0._critterMo)
end

return var_0_0
